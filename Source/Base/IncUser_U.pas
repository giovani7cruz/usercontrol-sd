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
  ExtDlgs,
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
  Vcl.Imaging.jpeg,
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
    btLoadImage: TBitBtn;
    btClearImage: TBitBtn;
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
    FImageChanged: Boolean;
    procedure UpdateImageActions;
    
	{$IFDEF DELPHI2006_UP}
    function ImageToBytes(Graphic: TGraphic): TBytes;
    function GetImagePath: string;
	{$ENDIF}
  public
    FAltera: Boolean;
    FUserControl: TUserControl;
    FDataSetCadastroUsuario: TDataSet;
    vNovoIDUsuario: Integer;
	{$IFDEF DELPHI2006_UP}
    procedure SetImage(const Image: TBytes);
	{$ENDIF}
  end;

implementation

uses
  SenhaForm_U,
  UCVisualStyle;

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
  Self.BorderIcons := [biSystemMenu];
  Constraints.MinWidth := 560;
  Constraints.MinHeight := 380;
  TUCVisualStyle.ApplyForm(Self);
  TUCVisualStyle.StyleHeader(Panel1, LbDescricao);
  TUCVisualStyle.StyleActionPanel(Panel2);
  TUCVisualStyle.StyleActionPanel(Panel3);
  TUCVisualStyle.StylePrimaryButton(btGravar);
  TUCVisualStyle.StyleSecondaryButton(btCancela);
  TUCVisualStyle.StyleActionButton(btLoadImage);
  TUCVisualStyle.StyleActionButton(btClearImage);
  TUCVisualStyle.StyleEdit(EditNome);
  TUCVisualStyle.StyleEdit(EditLogin);
  TUCVisualStyle.StyleEdit(EditEmail);
  FImageChanged := False;
  UpdateImageActions;
end;

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
  vImage: TBytes;

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
        if FImageChanged then
          {$IFDEF DELPHI2006_UP}
          vImage := ImageToBytes(iUserImage.Picture.Graphic)
          {$ELSE}
          vImage := nil
          {$ENDIF}
        else
          vImage := nil;

        FUserControl.ChangeUser(vNovoIDUsuario, vLogin, vNome, vEmail, vPerfil, vUserExpired, SpinExpira.Value,
          ComboStatus.ItemIndex, vPrivilegiado, 
		  {$IFDEF DELPHI2006_UP}
		  vImage, FImageChanged
		  {$ELSE}
		  nil, False
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
			  ImageToBytes(iUserImage.Picture.Graphic)
			  {$ELSE}
			  nil
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
  FOpenDialog: TOpenPictureDialog;
begin
  Result := '';
  FOpenDialog := TOpenPictureDialog.Create(nil);
  try
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
function TfrmIncluirUsuario.ImageToBytes(Graphic: TGraphic): TBytes;
var
  Stream: TMemoryStream;
begin
  SetLength(Result, 0);
  if (Graphic = nil) or Graphic.Empty then
    Exit;

  Stream := TMemoryStream.Create;
  try
    Graphic.SaveToStream(Stream);
    SetLength(Result, Stream.Size);
    if Stream.Size > 0 then
    begin
      Stream.Position := 0;
      Stream.ReadBuffer(Result[0], Stream.Size);
    end;
  finally
    Stream.Free;
  end;
end;
{$ENDIF}

procedure TfrmIncluirUsuario.miClearClick(Sender: TObject);
begin
  iUserImage.Picture := nil;
  FImageChanged := True;
  UpdateImageActions;
end;

procedure TfrmIncluirUsuario.miLoadClick(Sender: TObject);
{$IFNDEF FPC}
var
  ms: TMemoryStream;
  og: TOleGraphic;
  Bitmap: Graphics.TBitmap;
  JpegImage: TJPEGImage;
  FilePath: string;
  NewWidth: Integer;
  NewHeight: Integer;

  function GetSize: Int64;
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
  MaxSourceImageSize = 5 * 1024 * 1024;
  MaxImageDimension = 256;
begin
  {$IFDEF DELPHI2006_UP}
  FilePath := GetImagePath;
  {$ELSE}
  FilePath := '';
  {$ENDIF}
  if Length(Trim(FilePath)) > 0 then
  begin
    if GetSize > MaxSourceImageSize then
      raise Exception.Create(Format(
        FUserControl.UserSettings.CommonMessages.ImageTooLarge,
        [IntToStr(MaxSourceImageSize)]));

    ms := TMemoryStream.Create;
    try
      og := TOleGraphic.Create;
      try
        ms.LoadFromFile(FilePath);
        ms.Position := 0;
        og.LoadFromStream(ms);

        if (og.Width <= 0) or (og.Height <= 0) then
          raise Exception.Create('Imagem inválida');

        if (og.Width <= MaxImageDimension) and
          (og.Height <= MaxImageDimension) then
        begin
          NewWidth := og.Width;
          NewHeight := og.Height;
        end
        else if og.Width >= og.Height then
        begin
          NewWidth := MaxImageDimension;
          NewHeight := Integer((Int64(og.Height) * NewWidth) div og.Width);
        end
        else
        begin
          NewHeight := MaxImageDimension;
          NewWidth := Integer((Int64(og.Width) * NewHeight) div og.Height);
        end;

        if NewWidth < 1 then
          NewWidth := 1;
        if NewHeight < 1 then
          NewHeight := 1;

        Bitmap := Graphics.TBitmap.Create;
        try
          Bitmap.PixelFormat := pf24bit;
          Bitmap.SetSize(NewWidth, NewHeight);
          Bitmap.Canvas.Brush.Color := clWhite;
          Bitmap.Canvas.FillRect(Rect(0, 0, NewWidth, NewHeight));
          Bitmap.Canvas.StretchDraw(Rect(0, 0, NewWidth, NewHeight), og);

          JpegImage := TJPEGImage.Create;
          try
            JpegImage.Assign(Bitmap);
            JpegImage.CompressionQuality := 85;
            JpegImage.Compress;
            iUserImage.Picture.Assign(JpegImage);
          finally
            JpegImage.Free;
          end;
        finally
          Bitmap.Free;
        end;

        FImageChanged := True;
        UpdateImageActions;
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
procedure TfrmIncluirUsuario.SetImage(const Image: TBytes);
var
  JpegImage: TJPEGImage;
  Stream: TMemoryStream;
  ValidImage: Boolean;
begin
  iUserImage.Picture := nil;
  ValidImage := False;

  { Only the new raw-JPEG format is accepted. Legacy Base64/ZLib values are
    intentionally ignored. }
  if (Length(Image) >= 2) and (Image[0] = $FF) and (Image[1] = $D8) then
  begin
    Stream := TMemoryStream.Create;
    try
      try
        Stream.WriteBuffer(Image[0], Length(Image));
        Stream.Position := 0;
        JpegImage := TJPEGImage.Create;
        try
          JpegImage.LoadFromStream(Stream);
          iUserImage.Picture.Assign(JpegImage);
          ValidImage := True;
        finally
          JpegImage.Free;
        end;
      except
        iUserImage.Picture := nil;
      end;
    finally
      Stream.Free;
    end;
  end;
  { A legacy or corrupt value is cleared the next time the user is saved. }
  FImageChanged := (Length(Image) > 0) and not ValidImage;
  UpdateImageActions;
end;
{$ENDIF}

procedure TfrmIncluirUsuario.UpdateImageActions;
var
  HasImage: Boolean;
begin
  HasImage := Assigned(iUserImage.Picture.Graphic);
  if HasImage then
    HasImage := not iUserImage.Picture.Graphic.Empty;
  btClearImage.Enabled := HasImage;
  miClear.Enabled := HasImage;
end;

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

end.
