{ **************************************************************************** }
{ Projeto: Componentes User Control ShowDelphi Edition                         }
{ Biblioteca multiplataforma de componentes Delphi para o controle de usuários }
{                                                                              }
{ Baseado nos pacotes Open Source User Control 2.31 RC1                        }
{
Autor da versão Original: Rodrigo Alves Cordeiro

Colaboradores da versão original
Alexandre Oliveira Campioni - alexandre.rural@netsite.com.br
Bernard Grandmougin
Carlos Guerra
Daniel Wszelaki
Everton Ramos [BS2 Internet]
Francisco Dueñas - fduenas@flashmail.com
Germán H. Cravero
Luciano Almeida Pimenta [ClubeDelphi.net]
Luiz Benevenuto - luiz@siffra.com
Luiz Fernando Severnini
Peter van Mierlo
Rodolfo Ferezin Moreira - rodolfo.fm@bol.com.br
Rodrigo Palhano (WertherOO)
Ronald Marconi
Sergiy Sekela (Dr.Web)
Stefan Nawrath
Vicente Barros Leonel [ Fknyght ]

*******************************************************************************}
{ Versão ShowDelphi Edition                                                    }
{                                                                              }
{ Direitos Autorais Reservados (c) 2015   Giovani Da Cruz                      }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{ Você pode obter a última versão desse arquivo na pagina do projeto           }
{ User Control ShowDelphi Edition                                              }
{ Componentes localizado em http://infussolucoes.github.io/usercontrol-sd/     }
{                                                                              }
{ Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la  }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{ Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM    }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{ Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto }
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{                                                                              }
{ Comunidade Show Delphi - www.showdelphi.com.br                               }
{                                                                              }
{ Giovani Da Cruz  -  giovani@infus.inf.br  -  www.infus.inf.br                }
{                                                                              }
{ ****************************************************************************** }

{ ******************************************************************************
  |* Historico
  |*
  |* 01/07/2015: Giovani Da Cruz
  |*  - Criação e distribuição da Primeira Versao ShowDelphi
  |
  |* 21/09/2020: Giovani Da Cruz
  |*  - Melhoria para obrigar a informar o campo login
  ******************************************************************************* }

unit IncUser_U;

interface

{$I 'UserControl.inc'}

uses
  Variants,
  Buttons,
  Classes,
  Controls,
  DB,
  DBCtrls,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Messages,
  Spin,
  StdCtrls,
  SysUtils,
  {$IFDEF FPC}
  {$IFDEF WINDOWS}Windows,{$ELSE}LCLType,{$ENDIF}
  {$ELSE}
  Windows,
  {$ENDIF}
  {$IFNDEF FPC}
  AxCtrls,
  {$ENDIF}
  Menus,

  {$IFDEF DELPHIXE2_UP}
  System.UITypes,
  {$ENDIF}

  UCBase;

type
  TfrmIncluirUsuario = class(TForm)
    Panel1: TPanel;
    LbDescricao: TLabel;
    Image1: TImage;
    Panel3: TPanel;
    btGravar: TBitBtn;
    btCancela: TBitBtn;
    Panel2: TPanel;
    lbNome: TLabel;
    EditNome: TEdit;
    lbLogin: TLabel;
    EditLogin: TEdit;
    lbEmail: TLabel;
    EditEmail: TEdit;
    ckPrivilegiado: TCheckBox;
    lbPerfil: TLabel;
    ComboPerfil: TDBLookupComboBox;
    btlimpa: TSpeedButton;
    ckUserExpired: TCheckBox;
    LabelExpira: TLabel;
    SpinExpira: TSpinEdit;
    ComboStatus: TComboBox;
    Label1: TLabel;
    iUserImage: TImage;
    lImagem: TLabel;
    pImage: TPanel;
    pmImage: TPopupMenu;
    miLoad: TMenuItem;
    miClear: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelaClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    function GetNewIdUser: Integer;
    procedure btlimpaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ckUserExpiredClick(Sender: TObject);
    procedure miLoadClick(Sender: TObject);
    procedure miClearClick(Sender: TObject);
  private
    FormSenha: TCustomForm;
    
	{$IFDEF DELPHI2006_UP}
	function ImageToBase64(Graphic: TGraphic): string;
    function Base64ToImage(Base64: string): TOleGraphic;
    function GetImagePath: string;

    function StreamToBase64(Value: TMemoryStream): string;
    function Base64ToStream(Value: String): TBytesStream;
    
	function CompactStream(Value: TMemoryStream): TMemoryStream;
    function UnpackStream(Value: TMemoryStream): TMemoryStream;
	{$ENDIF}
  public
    FAltera: Boolean;
    FUserControl: TUserControl;
    FDataSetCadastroUsuario: TDataSet;
    vNovoIDUsuario: Integer;
	{$IFDEF DELPHI2006_UP}
    procedure SetImage(Image: string);
	{$ENDIF}
  end;

implementation

uses
  SenhaForm_U,
  {$IFNDEF FPC}
  IdCoderMIME,
  {$ENDIF}
  ZLib;

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TfrmIncluirUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmIncluirUsuario.FormCreate(Sender: TObject);
begin
  Self.BorderIcons := [];
  Self.BorderStyle := bsDialog;
end;

{$IFDEF DELPHI2006_UP}
function TfrmIncluirUsuario.Base64ToImage(Base64: string): TOleGraphic;
var
  bs: TBytesStream;
  ms: TMemoryStream; 
begin
  Result := nil;
  
  if Base64 = '' then
    Result := nil
  else
  begin
    bs := Base64ToStream(Base64);
    try
      bs.Position := 0;
      ms := UnpackStream(bs);
      try
        Result := TOleGraphic.Create;
        Result.LoadFromStream(ms);
      finally
        ms.Free;
      end;
    finally
      bs.Free;
    end;
  end;
end;
{$ENDIF}

{$IFDEF DELPHI2006_UP}
function TfrmIncluirUsuario.Base64ToStream(Value: String): TBytesStream;
var
  dm: TIdDecoderMIME;
begin
  Result := TBytesStream.Create;
  dm := TIdDecoderMIME.Create(nil);
  try
    dm.DecodeBegin(Result);
    dm.Decode(Value);
    dm.DecodeEnd;
    Result.Position := 0;
  finally
    dm.Free;
  end;
end;
{$ENDIF}

procedure TfrmIncluirUsuario.btCancelaClick(Sender: TObject);
begin
  Close;
end;
{$WARNINGS OFF}

procedure TfrmIncluirUsuario.btGravarClick(Sender: TObject);
var
  vNovaSenha: String;
  vNome: String;
  vLogin: String;
  vEmail: String;
  vUserExpired: Integer;
  vPerfil: Integer;
  vPrivilegiado: Boolean;

  procedure SendEmail;
  var
    ErrorLevel: Integer;
  begin
    ErrorLevel := 1;
    if (Assigned(FUserControl.MailUserControl)) then
    begin
      try
        if (FUserControl.MailUserControl.AdicionaUsuario.Ativo) then
        begin
          ErrorLevel := 0;
          FUserControl.MailUserControl.EnviaEmailAdicionaUsuario(vNome, vLogin,
            Encrypt(vNovaSenha, FUserControl.EncryptKey), vEmail, IntToStr(vPerfil), FUserControl.EncryptKey);
        end
        else if (FUserControl.MailUserControl.AlteraUsuario.Ativo) then
        begin
          ErrorLevel := 2;
          FUserControl.MailUserControl.EnviaEmailAdicionaUsuario(vNome, vLogin,
            Encrypt(vNovaSenha, FUserControl.EncryptKey), vEmail, IntToStr(vPerfil), FUserControl.EncryptKey);
        end;
      except
        on E: Exception do
          FUserControl.Log(E.Message, ErrorLevel);
      end;
    end;
  end;
begin
  btGravar.Enabled := False;
  try
    if ((ComboPerfil.ListSource.DataSet.RecordCount > 0) and VarIsNull(ComboPerfil.KeyValue)) then
      MessageDlg(FUserControl.UserSettings.CommonMessages.InvalidProfile, mtWarning, [mbOK], 0)
    else
    begin
      vNome := EditNome.Text;
      vLogin := EditLogin.Text;
      vEmail := EditEmail.Text;
      if VarIsNull(ComboPerfil.KeyValue) then
        vPerfil := 0
      else
        vPerfil := ComboPerfil.KeyValue;

      vUserExpired := StrToInt(BoolToStr(ckUserExpired.Checked));
      vPrivilegiado := ckPrivilegiado.Checked;

      if FAltera then
      begin // alterar user
        FUserControl.ChangeUser(vNovoIDUsuario, vLogin, vNome, vEmail, vPerfil, vUserExpired, SpinExpira.Value,
          ComboStatus.ItemIndex, vPrivilegiado, 
		  {$IFDEF DELPHI2006_UP}
		  ImageToBase64(iUserImage.Picture.Graphic)
		  {$ELSE}
		  ''
		  {$ENDIF}
		  
		  );

        SendEmail;
      end
      else
      begin // inclui user
        if Trim(EditLogin.Text) = '' then
        begin
		  EditLogin.Clear;
		  
		  // provisório, pois é necessário incluir a mensagem no controle da UcConsts_Language.pas 
		  MessageDlg('Atenção, o campo login é obrigatório!', mtWarning, [mbOK], 0);
		  
		  Exit;
		end;
		
		if FUserControl.ExisteUsuario(EditLogin.Text) then
		begin
          MessageDlg(Format(FUserControl.UserSettings.CommonMessages.UsuarioExiste, [EditLogin.Text]), mtWarning, [mbOK], 0);
		end  
        else
        begin
          FormSenha := TSenhaForm.Create(Self);
          TSenhaForm(FormSenha).Position := FUserControl.UserSettings.WindowsPosition;
          TSenhaForm(FormSenha).FUserControl := FUserControl;
          TSenhaForm(FormSenha).Caption := Format(FUserControl.UserSettings.ResetPassword.WindowCaption, [EditLogin.Text]);

          if TSenhaForm(FormSenha).ShowModal = mrOk then
          begin
            vNovaSenha := TSenhaForm(FormSenha).edtSenha.Text;
            vNovoIDUsuario := GetNewIdUser;
            FreeAndNil(FormSenha);

            FUserControl.AddUser(vLogin, vNovaSenha, vNome, vEmail, vPerfil, vUserExpired, SpinExpira.Value,
              vPrivilegiado, 
			  {$IFDEF DELPHI2006_UP}
			  ImageToBase64(iUserImage.Picture.Graphic)
			  {$ELSE}
			  ''
			  {$ENDIF}
			  );

            SendEmail;
          end;
        end;
      end;

      FUserControl.DataConnector.RefreshDataSet(FDataSetCadastroUsuario);

      FDataSetCadastroUsuario.Locate('idUser', vNovoIDUsuario, []);
      Close;
    end;
  finally
    btGravar.Enabled := True;
  end;
end;
{$WARNINGS ON}

{$IFDEF DELPHI2006_UP}
function TfrmIncluirUsuario.GetImagePath: string;
var
  FOpenDialog: TOpenDialog;
begin
  Result := '';
  FOpenDialog := TOpenDialog.Create(nil);
  try
    FOpenDialog.Filter := 'All|*.jpg; *.jpeg; *.gif; *.png|JPG|*.jpg; *.jpeg|GIF|*.gif';
    FOpenDialog.Options := [ofHideReadOnly,ofPathMustExist,ofFileMustExist,ofEnableSizing];
    if FOpenDialog.Execute then
      Result := FOpenDialog.FileName;
  finally
    FOpenDialog.Free;
  end;
end;
{$ENDIF}

function TfrmIncluirUsuario.GetNewIdUser: Integer;
var
  DataSet: TDataSet;
  SQLStmt: String;
begin
  with FUserControl do
  begin
    SQLStmt := Format('SELECT %s.%s FROM %s ORDER BY %s DESC',
      [TableUsers.TableName, TableUsers.FieldUserID, TableUsers.TableName,
      TableUsers.FieldUserID]);
    try
      DataSet := DataConnector.UCGetSQLDataSet(SQLStmt);
      Result := DataSet.Fields[0].AsInteger + 1;
      DataSet.Close;
    finally
      SysUtils.FreeAndNil(DataSet);
    end;
  end;
end;

{$IFDEF DELPHI2006_UP}
function TfrmIncluirUsuario.ImageToBase64(Graphic: TGraphic): string;
var
  ms, msCompact: TMemoryStream;
begin
  Result := '';
  if Graphic <> nil then
  begin
    ms := TMemoryStream.Create;
    try
      Graphic.SaveToStream(ms);
      ms.Position := 0;
      msCompact := CompactStream(ms);
      try
        Result := StreamToBase64(msCompact);
      finally
        msCompact.Free;
      end;
    finally
      ms.Free;
    end;
  end;
end;
{$ENDIF}

procedure TfrmIncluirUsuario.miClearClick(Sender: TObject);
begin
  iUserImage.Picture := nil;
end;

procedure TfrmIncluirUsuario.miLoadClick(Sender: TObject);
{$IFNDEF FPC}
var
  ms: TMemoryStream;
  og: TOleGraphic;
  FilePath: string;

  function GetSize: Real;
  var
    SearchRec: TSearchRec;
  begin
    Result := 0;
    try
      if FindFirst(ExpandFileName(FilePath), faAnyFile, SearchRec) = 0 then
        Result := SearchRec.Size;
    finally
      SysUtils.FindClose(SearchRec);
    end;
  end;
const
  ImageMaxSize = 8100;
begin
  {$IFDEF DELPHI2006_UP}
  FilePath := GetImagePath;
  {$ELSE}
  FilePath := '';
  {$ENDIF}
  if Length(Trim(FilePath)) > 0 then
  begin
    if GetSize > ImageMaxSize then
      raise Exception.Create(Format(FUserControl.UserSettings.CommonMessages.ImageTooLarge, [IntToStr(ImageMaxSize)]));

    ms := TMemoryStream.Create;
    try
      og := TOleGraphic.Create;
      try
        ms.LoadFromFile(FilePath);
        ms.Position := 0;
        og.LoadFromStream(ms);
        iUserImage.Picture.Assign(og);
      finally
        og.Free;
      end;
    finally
      ms.Free;
    end;
  end;
{$ELSE}
begin
{$ENDIF}
end;

{$IFDEF DELPHI2006_UP}
procedure TfrmIncluirUsuario.SetImage(Image: string);
var
  og: TOleGraphic;
begin
  og := Base64ToImage(Image);
  try
    iUserImage.Picture.Assign(og);
  finally
    og.Free;
  end;
end;
{$ENDIF}

{$IFDEF DELPHI2006_UP}
function TfrmIncluirUsuario.StreamToBase64(Value: TMemoryStream): string;
begin
  Result := '';

  if Value <> nil then
    Result := TIdEncoderMIME.EncodeStream(Value, Value.Size);

end;
{$ENDIF}

{$IFDEF DELPHI2006_UP}
function TfrmIncluirUsuario.UnpackStream(Value: TMemoryStream): TMemoryStream;
var
  LUnZip: TZDecompressionStream;
begin
  Value.Position := 0;
  Result := TMemoryStream.Create;
  LUnZip := TZDecompressionStream.Create(Value);
  try
    { Decompress data. }
    Result.CopyFrom(LUnZip, 0);
    Result.Position := 0;
  finally
    LUnZip.Free;
  end;
end;
{$ENDIF}

procedure TfrmIncluirUsuario.btlimpaClick(Sender: TObject);
begin
  ComboPerfil.KeyValue := NULL;
end;

procedure TfrmIncluirUsuario.FormShow(Sender: TObject);
var
  vAux : Variant;
begin
  if not FUserControl.UserProfile.Active then
  begin
    lbPerfil.Visible := False;
    ComboPerfil.Visible := False;
    btlimpa.Visible := False;
  end
  else
  begin
    { Alteração necessaria para alguns conectors }
    vAux := ComboPerfil.KeyValue;

    FUserControl.DataConnector.RefreshDataSet(ComboPerfil.ListSource.DataSet);

    ComboPerfil.KeyValue := Null;
    ComboPerfil.KeyValue := vAux;
  end;

  // Opção de senha so deve aparecer qdo setada como true no componente By Vicente Barros Leonel
  ckUserExpired.Visible := FUserControl.Login.ActiveDateExpired;

  ckPrivilegiado.Visible := FUserControl.User.UsePrivilegedField;
  EditLogin.CharCase := Self.FUserControl.Login.CharCaseUser;

  SpinExpira.Visible := ckUserExpired.Visible;
  LabelExpira.Visible := ckUserExpired.Visible;

  if (FUserControl.User.ProtectAdministrator) and
    (EditLogin.Text = FUserControl.Login.InitialLogin.User) then
    EditLogin.Enabled := False;

end;

procedure TfrmIncluirUsuario.ckUserExpiredClick(Sender: TObject);
begin
  SpinExpira.Enabled := not ckUserExpired.Checked;
end;

{$IFDEF DELPHI2006_UP}
function TfrmIncluirUsuario.CompactStream(Value: TMemoryStream): TMemoryStream;
var
  LZip: TZCompressionStream;
begin
  Result := TMemoryStream.Create;
  LZip := TZCompressionStream.Create(Result, zcMax, 15);
  try
    Value.Position := 0;
    { Compress data. }
    LZip.CopyFrom(Value, Value.Size);
  finally
    LZip.Free;
  end;
  Result.Position := 0;
end;
{$ENDIF}

end.
