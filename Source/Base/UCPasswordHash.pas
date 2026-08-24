unit UCPasswordHash;

interface

uses
  System.SysUtils;

const
  UC_DEFAULT_PBKDF2_ITERATIONS = 600000;
  UC_MAX_PBKDF2_ITERATIONS = 10000000;
  UC_PASSWORD_HASH_FIELD_SIZE = 128;

type
  EUCPasswordHash = class(Exception);

  TUCPasswordHash = class
  public
    class function HashPassword(const Password: string;
      Iterations: Cardinal = UC_DEFAULT_PBKDF2_ITERATIONS): string; static;
    class function VerifyPassword(const Password, StoredHash: string): Boolean; static;
    class function IsStrongHash(const StoredHash: string): Boolean; static;
    class function NeedsRehash(const StoredHash: string;
      Iterations: Cardinal = UC_DEFAULT_PBKDF2_ITERATIONS): Boolean; static;
  end;

implementation

uses
  System.Classes;

const
  BCryptDll = 'bcrypt.dll';
  BCryptSha256Algorithm = 'SHA256';
  BCryptAlgHandleHmacFlag = $00000008;
  BCryptUseSystemPreferredRng = $00000002;
  SaltSize = 16;
  DerivedKeySize = 32;
  HashPrefix = 'uc$pbkdf2-sha256$';

type
  TUCBytes = array of Byte;

function BCryptOpenAlgorithmProvider(var Algorithm: Pointer;
  AlgorithmId, ProviderImplementation: PWideChar;
  Flags: Cardinal): LongInt; stdcall; external BCryptDll;
function BCryptCloseAlgorithmProvider(Algorithm: Pointer;
  Flags: Cardinal): LongInt; stdcall; external BCryptDll;
function BCryptDeriveKeyPBKDF2(Algorithm: Pointer; Password: PByte;
    PasswordSize: Cardinal; Salt: PByte; SaltSize: Cardinal;
    IterationCount: UInt64; DerivedKey: PByte; DerivedKeySize: Cardinal;
  Flags: Cardinal): LongInt; stdcall; external BCryptDll;
function BCryptGenRandom(Algorithm: Pointer; Buffer: PByte;
  BufferSize, Flags: Cardinal): LongInt; stdcall; external BCryptDll;

function BytesToHex(const Value: TUCBytes): string;
const
  HexChars: array [0 .. 15] of Char = '0123456789abcdef';
var
  I: Integer;
begin
  SetLength(Result, Length(Value) * 2);
  for I := 0 to High(Value) do
  begin
    Result[(I * 2) + 1] := HexChars[Value[I] shr 4];
    Result[(I * 2) + 2] := HexChars[Value[I] and $0F];
  end;
end;

function HexValue(Value: Char): Integer;
begin
  case Value of
    '0' .. '9': Result := Ord(Value) - Ord('0');
    'a' .. 'f': Result := Ord(Value) - Ord('a') + 10;
    'A' .. 'F': Result := Ord(Value) - Ord('A') + 10;
  else
    Result := -1;
  end;
end;

function HexToBytes(const Value: string; out Bytes: TUCBytes): Boolean;
var
  I, HighNibble, LowNibble: Integer;
begin
  Result := (Length(Value) > 0) and ((Length(Value) mod 2) = 0);
  if not Result then
    Exit;

  SetLength(Bytes, Length(Value) div 2);
  for I := 0 to High(Bytes) do
  begin
    HighNibble := HexValue(Value[(I * 2) + 1]);
    LowNibble := HexValue(Value[(I * 2) + 2]);
    if (HighNibble < 0) or (LowNibble < 0) then
    begin
      SetLength(Bytes, 0);
      Result := False;
      Exit;
    end;
    Bytes[I] := Byte((HighNibble shl 4) or LowNibble);
  end;
end;

procedure ClearBytes(var Value: TUCBytes);
begin
  if Length(Value) > 0 then
    FillChar(Value[0], Length(Value), 0);
  SetLength(Value, 0);
end;

function ConstantTimeEquals(const Left, Right: TUCBytes): Boolean;
var
  I: Integer;
  Difference: Byte;
begin
  if Length(Left) <> Length(Right) then
  begin
    Result := False;
    Exit;
  end;

  Difference := 0;
  for I := 0 to High(Left) do
    Difference := Difference or (Left[I] xor Right[I]);
  Result := Difference = 0;
end;

procedure GenerateRandom(var Buffer: TUCBytes);
begin
  if BCryptGenRandom(nil, @Buffer[0], Length(Buffer),
    BCryptUseSystemPreferredRng) <> 0 then
    raise EUCPasswordHash.Create('O Windows nao conseguiu gerar salt seguro');
end;

procedure DerivePBKDF2(const Password: string; const Salt: TUCBytes;
  Iterations: Cardinal; var DerivedKey: TUCBytes);
var
  Algorithm: Pointer;
  PasswordUtf8: UTF8String;
  PasswordPointer: PByte;
begin
  Algorithm := nil;
  PasswordUtf8 := UTF8Encode(Password);
  try
    if BCryptOpenAlgorithmProvider(Algorithm,
      PWideChar(BCryptSha256Algorithm), nil,
      BCryptAlgHandleHmacFlag) <> 0 then
      raise EUCPasswordHash.Create('Nao foi possivel inicializar HMAC-SHA-256');

    if Length(PasswordUtf8) = 0 then
      PasswordPointer := nil
    else
      PasswordPointer := @PasswordUtf8[1];

    if BCryptDeriveKeyPBKDF2(Algorithm, PasswordPointer,
      Length(PasswordUtf8), @Salt[0], Length(Salt), Iterations,
      @DerivedKey[0], Length(DerivedKey), 0) <> 0 then
      raise EUCPasswordHash.Create('Falha ao calcular PBKDF2-HMAC-SHA-256');
  finally
    if Algorithm <> nil then
      BCryptCloseAlgorithmProvider(Algorithm, 0);
    if Length(PasswordUtf8) > 0 then
      FillChar(PasswordUtf8[1], Length(PasswordUtf8), 0);
    PasswordUtf8 := '';
  end;
end;

function ParseHash(const StoredHash: string; out Iterations: Cardinal;
  out Salt, DerivedKey: TUCBytes): Boolean;
var
  Parts: TStringList;
  IterationValue: Integer;
begin
  Result := False;
  Iterations := 0;
  SetLength(Salt, 0);
  SetLength(DerivedKey, 0);
  if Copy(StoredHash, 1, Length(HashPrefix)) <> HashPrefix then
    Exit;

  Parts := TStringList.Create;
  try
    Parts.StrictDelimiter := True;
    Parts.Delimiter := '$';
    Parts.DelimitedText := StoredHash;
    if (Parts.Count <> 5) or (Parts[0] <> 'uc') or
      (Parts[1] <> 'pbkdf2-sha256') or
      (not TryStrToInt(Parts[2], IterationValue)) or (IterationValue <= 0) or
      (IterationValue > UC_MAX_PBKDF2_ITERATIONS) or
      (not HexToBytes(Parts[3], Salt)) or (Length(Salt) <> SaltSize) or
      (not HexToBytes(Parts[4], DerivedKey)) or
      (Length(DerivedKey) <> DerivedKeySize) then
      Exit;
    Iterations := Cardinal(IterationValue);
    Result := True;
  finally
    Parts.Free;
    if not Result then
    begin
      ClearBytes(Salt);
      ClearBytes(DerivedKey);
    end;
  end;
end;

class function TUCPasswordHash.HashPassword(const Password: string;
  Iterations: Cardinal): string;
var
  Salt, DerivedKey: TUCBytes;
begin
  if (Iterations = 0) or (Iterations > UC_MAX_PBKDF2_ITERATIONS) then
    raise EUCPasswordHash.CreateFmt(
      'O numero de iteracoes deve estar entre 1 e %d',
      [UC_MAX_PBKDF2_ITERATIONS]);
  SetLength(Salt, SaltSize);
  SetLength(DerivedKey, DerivedKeySize);
  try
    GenerateRandom(Salt);
    DerivePBKDF2(Password, Salt, Iterations, DerivedKey);
    Result := HashPrefix + IntToStr(Iterations) + '$' + BytesToHex(Salt) + '$' +
      BytesToHex(DerivedKey);
  finally
    ClearBytes(Salt);
    ClearBytes(DerivedKey);
  end;
end;

class function TUCPasswordHash.VerifyPassword(const Password,
  StoredHash: string): Boolean;
var
  Iterations: Cardinal;
  Salt, ExpectedKey, ActualKey: TUCBytes;
begin
  Result := False;
  if not ParseHash(StoredHash, Iterations, Salt, ExpectedKey) then
    Exit;
  SetLength(ActualKey, DerivedKeySize);
  try
    DerivePBKDF2(Password, Salt, Iterations, ActualKey);
    Result := ConstantTimeEquals(ExpectedKey, ActualKey);
  finally
    ClearBytes(Salt);
    ClearBytes(ExpectedKey);
    ClearBytes(ActualKey);
  end;
end;

class function TUCPasswordHash.IsStrongHash(const StoredHash: string): Boolean;
var
  Iterations: Cardinal;
  Salt, DerivedKey: TUCBytes;
begin
  Result := ParseHash(StoredHash, Iterations, Salt, DerivedKey);
  ClearBytes(Salt);
  ClearBytes(DerivedKey);
end;

class function TUCPasswordHash.NeedsRehash(const StoredHash: string;
  Iterations: Cardinal): Boolean;
var
  StoredIterations: Cardinal;
  Salt, DerivedKey: TUCBytes;
begin
  Result := not ParseHash(StoredHash, StoredIterations, Salt, DerivedKey) or
    (StoredIterations < Iterations);
  ClearBytes(Salt);
  ClearBytes(DerivedKey);
end;

end.
