program UCPasswordHashTests;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  UCPasswordHash in '..\..\Source\Base\UCPasswordHash.pas';

procedure Check(Condition: Boolean; const MessageText: string);
begin
  if not Condition then
    raise Exception.Create(MessageText);
end;

var
  Hash: string;
  TamperedHash: string;
begin
  try
    Hash := TUCPasswordHash.HashPassword('Senha de teste 123!');
    Check(TUCPasswordHash.IsStrongHash(Hash), 'Formato de hash invalido');
    Check(TUCPasswordHash.VerifyPassword('Senha de teste 123!', Hash),
      'Senha correta nao foi aceita');
    Check(not TUCPasswordHash.VerifyPassword('senha incorreta', Hash),
      'Senha incorreta foi aceita');
    Check(not TUCPasswordHash.NeedsRehash(Hash),
      'Hash novo foi marcado para rehash');

    TamperedHash := Hash;
    TamperedHash[Length(TamperedHash)] :=
      Char(Ord(TamperedHash[Length(TamperedHash)]) xor 1);
    Check(not TUCPasswordHash.VerifyPassword('Senha de teste 123!',
      TamperedHash), 'Hash adulterado foi aceito');

    Writeln('UCPasswordHash: OK');
  except
    on E: Exception do
    begin
      Writeln(E.ClassName + ': ' + E.Message);
      Halt(1);
    end;
  end;
end.
