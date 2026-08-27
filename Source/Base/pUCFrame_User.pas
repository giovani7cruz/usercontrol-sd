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
  ******************************************************************************* }

unit pUCFrame_User;

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
  StrUtils,
  SysUtils,
  {$IFDEF FPC}
  {$IFDEF WINDOWS}Windows,{$ELSE}LCLType,{$ENDIF}
  {$ELSE}
  Windows,
  {$ENDIF}
  DBGrids,
  Grids,
  ImgList,
  
  {$IFDEF DELPHIXE8_UP}
  System.UITypes,
  ImageList,
  {$ENDIF}

  IncUser_U,
  SenhaForm_U,
  UcBase,
  UserPermis_U;

type
  TUCFrame_User = class(TFrame)
    Panel3: TPanel;
    btAdic: TBitBtn;
    BtAlt: TBitBtn;
    BtExclui: TBitBtn;
    BtAcess: TBitBtn;
    BtPass: TBitBtn;
    DbGridUser: TDBGrid;
    DataUser: TDataSource;
    DataPerfil: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Nome: TEdit;
    Login: TEdit;
    Email: TEdit;
    btApplyFilter: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ImageList1: TImageList;
    Shape1: TShape;
    ckShowInactive: TCheckBox;
    procedure btAdicClick(Sender: TObject);
    procedure BtAltClick(Sender: TObject);
    procedure BtAcessClick(Sender: TObject);
    procedure BtPassClick(Sender: TObject);
    procedure BtExcluiClick(Sender: TObject);
    procedure DbGridUserDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DbGridUserTitleClick(Column: TColumn);
    procedure btApplyFilterClick(Sender: TObject);
    procedure ckShowInactiveClick(Sender: TObject);
    procedure FilterEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FrameResize(Sender: TObject);
  private
    FTextFilterActive: Boolean;
    procedure ApplyUserFilter;
    procedure ChangeButtonFilter;
    procedure DataSetFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    function LoadUserImage(IdUser: Integer): TBytes;
    procedure ResizeGridColumns;
    procedure UpdateFilterControls;
  protected
    FormSenha: TCustomForm;
    FfrmIncluirUsuario: TfrmIncluirUsuario;
    procedure SetWindowUserProfile;
    procedure SetWindowUser(Adicionar: Boolean);
    procedure ActionBtPermissUserDefault;
    procedure FDataSetCadastroUsuarioAfterScroll(DataSet: TDataSet);
  public
    FUsercontrol: TUserControl;
    FDataSetCadastroUsuario: TDataSet;
    procedure SetWindow;
    destructor Destroy; override;
    { Public declarations }
  end;

implementation

uses
  UCMessages, UCDataInfo, UCVisualStyle;

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TUCFrame_User.btAdicClick(Sender: TObject);
begin
  FfrmIncluirUsuario := TfrmIncluirUsuario.Create(Self);
  FfrmIncluirUsuario.FUsercontrol := Self.FUsercontrol;
  SetWindowUser(True);

  {$IFNDEF FPC}
  Application.NormalizeTopMosts;
  Application.RestoreTopMosts;
  {$ENDIF}

  FfrmIncluirUsuario.ShowModal;
  FreeAndNil(FfrmIncluirUsuario);
  ApplyUserFilter;
end;

procedure TUCFrame_User.BtAltClick(Sender: TObject);
begin
  if FDataSetCadastroUsuario.IsEmpty then
    Exit;
  FfrmIncluirUsuario := TfrmIncluirUsuario.Create(Self);
  FfrmIncluirUsuario.FUsercontrol := Self.FUsercontrol;
  SetWindowUser(False);
  with FfrmIncluirUsuario do
  begin
    FAltera := True;
    vNovoIDUsuario := FDataSetCadastroUsuario.FieldByName('IdUser').AsInteger;
    EditNome.Text := FDataSetCadastroUsuario.FieldByName('Nome').AsString;
    EditLogin.Text := FDataSetCadastroUsuario.FieldByName('Login').AsString;
    EditEmail.Text := FDataSetCadastroUsuario.FieldByName('Email').AsString;
    ComboPerfil.KeyValue := FDataSetCadastroUsuario.FieldByName('Perfil').AsInteger;
    ckPrivilegiado.Checked := StrToBool(FDataSetCadastroUsuario.FieldByName('Privilegiado').AsString);
    ckUserExpired.Checked := StrToBool(FDataSetCadastroUsuario.FieldByName('UserNaoExpira').AsString);
    SpinExpira.Value := FDataSetCadastroUsuario.FieldByName('DaysOfExpire').AsInteger;
	{$IFDEF DELPHI2006_UP}
    SetImage(Self.LoadUserImage(vNovoIDUsuario));
	{$ENDIF}
    ComboStatus.ItemIndex := FDataSetCadastroUsuario.FieldByName('UserInative').AsInteger;
    FfrmIncluirUsuario.ComboStatus.Enabled :=
      FfrmIncluirUsuario.ComboStatus.Enabled and
      not (
        (FUsercontrol.User.ProtectAdministrator) and
        (FDataSetCadastroUsuario.FieldByName('Login').AsString = FUsercontrol.Login.InitialLogin.User)
      );
    ShowModal;
  end;
  FreeAndNil(FfrmIncluirUsuario);
  ApplyUserFilter;
end;

function TUCFrame_User.LoadUserImage(IdUser: Integer): TBytes;
begin
  with FUsercontrol.TableUsers do
    Result := FUsercontrol.DataConnector.UCReadBinaryField(TableName,
      FieldUserID, IdUser, FieldImage);
end;

procedure TUCFrame_User.btApplyFilterClick(Sender: TObject);
begin
  ChangeButtonFilter;
end;

procedure TUCFrame_User.ckShowInactiveClick(Sender: TObject);
begin
  ApplyUserFilter;
end;

procedure TUCFrame_User.BtExcluiClick(Sender: TObject);
var
  TempID: Integer;
  CanDelete: Boolean;
  ErrorMsg: String;
  DataSetTemp: TDataSet;
begin
  if FDataSetCadastroUsuario.IsEmpty then
    Exit;
  TempID := FDataSetCadastroUsuario.FieldByName('IDUser').AsInteger;
  if MessageBox(Handle,
    PChar(Format(FUsercontrol.UserSettings.UsersForm.PromptDelete,
      [FDataSetCadastroUsuario.FieldByName('Login').AsString])),
    PChar(FUsercontrol.UserSettings.UsersForm.PromptDelete_WindowCaption),
    MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2) = idYes then
  begin
    CanDelete := True;
    if Assigned(FUsercontrol.onDeleteUser) then
      FUsercontrol.onDeleteUser(TObject(Owner), TempID, CanDelete, ErrorMsg);
    if not CanDelete then
    begin
      MessageDlg(ErrorMsg, mtWarning, [mbOK], 0);
      Exit;
    end;

    //Cassiano 31/01/2018
    DataSetTemp := FUsercontrol.DataConnector.UCGetSQLDataset(Format(
      'select * from %s where %s = %s',
      [
        FUsercontrol.TableUsersLogged.TableName,
        FUsercontrol.TableUsersLogged.FieldUserID,
        IntToStr(TempID)
      ]
    ));
    try
      if not DataSetTemp.IsEmpty then
      begin
        MessageDlg(FUserControl.UserSettings.CommonMessages.CanNotDeleteUserLogon,
          mtWarning, [mbOK], 0);
        Exit;
      end;
    finally
      DataSetTemp.Free;
    end;

    FUsercontrol.DataConnector.UCExecSQL
      ('Delete from ' + FUsercontrol.TableRights.TableName + ' where ' +
      FUsercontrol.TableRights.FieldUserID + ' = ' + IntToStr(TempID));
    FUsercontrol.DataConnector.UCExecSQL
      ('Delete from ' + FUsercontrol.TableUsers.TableName + ' where ' +
      FUsercontrol.TableUsers.FieldUserID + ' = ' + IntToStr(TempID));

    { Giovani da Cruz (G7) // Alteração para adequação de alguns connectores }
    FUsercontrol.DataConnector.RefreshDataSet(FDataSetCadastroUsuario);
    ApplyUserFilter;
  end;
end;

procedure TUCFrame_User.BtPassClick(Sender: TObject);
begin
  if FDataSetCadastroUsuario.IsEmpty then
    Exit;

  FormSenha := TSenhaForm.Create(Self);
  TSenhaForm(FormSenha).Position := FUsercontrol.UserSettings.WindowsPosition;
  TSenhaForm(FormSenha).FUsercontrol := FUsercontrol;
  TSenhaForm(FormSenha).Caption :=
    Format(FUsercontrol.UserSettings.ResetPassword.WindowCaption,
    [FDataSetCadastroUsuario.FieldByName('Login').AsString]);
  if TSenhaForm(FormSenha).ShowModal = mrOk then
  Begin

    (*
      if (Assigned(FUsercontrol.MailUserControl)) and (FUsercontrol.MailUserControl.SenhaForcada.Ativo ) then
      try
      FUsercontrol.MailUserControl.EnviaEmailSenhaForcada(
      FDataSetCadastroUsuario.FieldByName('NOME').AsString ,
      FDataSetCadastroUsuario.FieldByName('LOGIN').AsString,
      TSenhaForm(FormSenha).edtSenha.Text ,
      FDataSetCadastroUsuario.FieldByName('EMAIL').AsString,
      '');

      except
      on E : Exception do FUsercontrol.Log(e.Message, 0);
      end;

    *)
    FUsercontrol.ChangePassword(FDataSetCadastroUsuario.FieldByName('IDUser')
      .AsInteger, TSenhaForm(FormSenha).edtSenha.Text);
  End;
  FreeAndNil(FormSenha);
end;

procedure TUCFrame_User.ApplyUserFilter;
begin
  if not Assigned(DataUser.DataSet) then
    Exit;
  if not DataUser.DataSet.Active then
    Exit;

  DataUser.DataSet.DisableControls;
  try
    DataUser.DataSet.Filtered := False;
    DataUser.DataSet.OnFilterRecord := DataSetFilterRecord;
    DataUser.DataSet.Filtered := True;
  finally
    DataUser.DataSet.EnableControls;
  end;

  FDataSetCadastroUsuarioAfterScroll(DataUser.DataSet);
end;

procedure TUCFrame_User.ChangeButtonFilter;
begin
  if FTextFilterActive then
  begin
    Nome.Clear;
    Login.Clear;
    Email.Clear;
    FTextFilterActive := False;
  end
  else
    FTextFilterActive := (Trim(Nome.Text) <> '') or
      (Trim(Login.Text) <> '') or (Trim(Email.Text) <> '');

  UpdateFilterControls;
  ApplyUserFilter;
end;

procedure TUCFrame_User.FilterEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_RETURN then
    Exit;

  Key := 0;
  FTextFilterActive := (Trim(Nome.Text) <> '') or
    (Trim(Login.Text) <> '') or (Trim(Email.Text) <> '');
  UpdateFilterControls;
  ApplyUserFilter;
end;

procedure TUCFrame_User.FrameResize(Sender: TObject);
begin
  ResizeGridColumns;
end;

procedure TUCFrame_User.DataSetFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  Field: TField;
begin
  Accept := True;

  if not ckShowInactive.Checked then
  begin
    Field := DataSet.FindField('UserInative');
    if Assigned(Field) and not Field.IsNull then
      Accept := Field.AsInteger = 0;
  end;

  if not Accept or not FTextFilterActive then
    Exit;

  if Trim(Nome.Text) <> '' then
  begin
    Field := DataSet.FindField('Nome');
    Accept := Assigned(Field) and ContainsText(Field.AsString, Trim(Nome.Text));
  end;

  if Accept and (Trim(Login.Text) <> '') then
  begin
    Field := DataSet.FindField('Login');
    Accept := Assigned(Field) and ContainsText(Field.AsString, Trim(Login.Text));
  end;

  if Accept and (Trim(Email.Text) <> '') then
  begin
    Field := DataSet.FindField('Email');
    Accept := Assigned(Field) and ContainsText(Field.AsString, Trim(Email.Text));
  end;
end;

procedure TUCFrame_User.DbGridUserTitleClick(Column: TColumn);
begin
  FUsercontrol.DataConnector.OrderBy(Column.Field.DataSet, Column.FieldName);
end;

procedure TUCFrame_User.DbGridUserDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  StatusText: String;
  TextRect: TRect;
begin
  if not SameText(Column.FieldName, 'UserInative') then
    Exit;

  if Column.Field.AsInteger = 0 then
    StatusText := FUsercontrol.UserSettings.AddChangeUser.StatusActive
  else
    StatusText := FUsercontrol.UserSettings.AddChangeUser.StatusDisabled;

  DbGridUser.Canvas.FillRect(Rect);
  TextRect := Rect;
  Inc(TextRect.Left, 6);
  DrawText(DbGridUser.Canvas.Handle, PChar(StatusText), Length(StatusText),
    TextRect, DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS);
end;

destructor TUCFrame_User.Destroy;
begin
  // nada a destruir
  // não destruir o FDataSetCadastroUsuario o USERCONTROL toma conta dele
  inherited;
end;

procedure TUCFrame_User.BtAcessClick(Sender: TObject);
var
  formHandle: THandle;
begin
  formHandle := FindWindow('TUserPermis', nil);
  if formHandle = 0 then { By Cleilson Sousa }
  begin
    if FDataSetCadastroUsuario.IsEmpty then
      Exit;
    UserPermis := TUserPermis.Create(Self);
    UserPermis.FUsercontrol := FUsercontrol;
    SetWindowUserProfile;
    UserPermis.lbUser.Caption := FDataSetCadastroUsuario.FieldByName('Login').AsString;
    ActionBtPermissUserDefault;
  end
  else
  begin
    ShowWindow(formHandle, SW_SHOWNORMAL);
    SetForegroundWindow(formHandle);
  end;

end;

procedure TUCFrame_User.SetWindowUserProfile;
begin
  with FUsercontrol.UserSettings.Rights do
  begin
    UserPermis.Caption := WindowCaption;
    UserPermis.LbDescricao.Caption := LabelUser;
    UserPermis.lbUser.Left := UserPermis.LbDescricao.Left +
      UserPermis.LbDescricao.Width + 5;
    UserPermis.PageMenu.Caption := PageMenu;
    UserPermis.PageAction.Caption := PageActions;
    UserPermis.PageControls.Caption := PageControls; // By Vicente Barros Leonel
    UserPermis.BtLibera.Caption := BtUnlock;
    UserPermis.BtBloqueia.Caption := BtLOck;
    UserPermis.BtGrava.Caption := BtSave;
    UserPermis.BtCancel.Caption := BtCancel;
    UserPermis.Position := FUsercontrol.UserSettings.WindowsPosition;
  end;
end;

procedure TUCFrame_User.ActionBtPermissUserDefault;
var
  TempCampos, TempCamposEX: String;
begin
  UserPermis.FTempIdUser := FDataSetCadastroUsuario.FieldByName('IdUser').AsInteger;
  with FUsercontrol do
  begin
    TempCampos :=
      Format(' %s as IdUser, %s as Modulo, %s as ObjName, %s as UCKey ',
      [TableRights.FieldUserID, TableRights.FieldModule,
      TableRights.FieldComponentName, TableRights.FieldKey]);
    TempCamposEX := Format(' %s, %s as FormName ',
      [TempCampos, TableRights.FieldFormName]);

    UserPermis.DSPermiss := DataConnector.UCGetSQLDataset
      (Format('SELECT %s FROM %s TAB WHERE TAB.%s = %s AND TAB.%s = %s',
      [TempCampos, TableRights.TableName, TableRights.FieldUserID,
      FDataSetCadastroUsuario.FieldByName('IdUser').AsString,
      TableRights.FieldModule, QuotedStr(ApplicationID)]));
    UserPermis.DSPermiss.Open;

    UserPermis.DSPermissEX := DataConnector.UCGetSQLDataset
      (Format('SELECT %s FROM %s TAB1 WHERE TAB1.%s = %s AND TAB1.%s = %s',
      [TempCamposEX, TableRights.TableName + 'EX', TableRights.FieldUserID,
      FDataSetCadastroUsuario.FieldByName('IdUser').AsString,
      TableRights.FieldModule, QuotedStr(ApplicationID)]));
    UserPermis.DSPermissEX.Open;

    UserPermis.DSPerfil := DataConnector.UCGetSQLDataset
      (Format('Select %s from %s tab Where tab.%s = %s and tab.%s = %s',
      [TempCampos, TableRights.TableName, TableRights.FieldUserID,
      FDataSetCadastroUsuario.FieldByName('Perfil').AsString,
      TableRights.FieldModule, QuotedStr(ApplicationID)]));
    UserPermis.DSPerfil.Open;

    UserPermis.DSPerfilEX := DataConnector.UCGetSQLDataset
      (Format('Select %s from %s tab1 Where tab1.%s = %s and tab1.%s = %s',
      [TempCamposEX, TableRights.TableName + 'EX', TableRights.FieldUserID,
      FDataSetCadastroUsuario.FieldByName('Perfil').AsString,
      TableRights.FieldModule, QuotedStr(ApplicationID)]));

    UserPermis.DSPerfilEX.Open;

    UserPermis.Show;

    { Giovani da Cruz (G7) // Alteração para adequação de alguns connectores }
    FUsercontrol.DataConnector.RefreshDataSet(FDataSetCadastroUsuario);
    ApplyUserFilter;

    FDataSetCadastroUsuario.Locate('idUser', UserPermis.FTempIdUser, []);
  end;
end;

procedure TUCFrame_User.FDataSetCadastroUsuarioAfterScroll(DataSet: TDataSet);
begin
  if not Assigned(DataSet) then
    Exit;

  if not DataSet.Active or DataSet.IsEmpty then
  begin
    BtAlt.Enabled := False;
    BtExclui.Enabled := False;
    BtPass.Enabled := False;
    BtAcess.Enabled := False;
    Exit;
  end;

  BtAlt.Enabled := True;
  if (FUsercontrol.User.ProtectAdministrator) and
    (DataSet.FieldByName('Login').AsString = FUsercontrol.Login.
    InitialLogin.User) then
  begin
    BtExclui.Enabled := False;
    BtPass.Enabled := False;
    BtAcess.Enabled := FUsercontrol.CurrentUser.Username =
      FUsercontrol.Login.InitialLogin.User;
  end
  else
  begin
    BtExclui.Enabled := True;
    BtPass.Enabled := True;
    BtAcess.Enabled := True;
  end;
end;

procedure TUCFrame_User.SetWindow;
begin
  TUCVisualStyle.ApplyFrame(Self);
  TUCVisualStyle.StyleActionPanel(Panel3);
  TUCVisualStyle.StyleActionPanel(Panel2);
  TUCVisualStyle.StyleGrid(DbGridUser);
  TUCVisualStyle.StyleActionButton(btAdic);
  TUCVisualStyle.StyleActionButton(BtAlt);
  TUCVisualStyle.StyleActionButton(BtExclui);
  TUCVisualStyle.StyleActionButton(BtAcess);
  TUCVisualStyle.StyleActionButton(BtPass);
  TUCVisualStyle.StyleActionButton(btApplyFilter);
  TUCVisualStyle.StyleEdit(Nome);
  TUCVisualStyle.StyleEdit(Login);
  TUCVisualStyle.StyleEdit(Email);

  FDataSetCadastroUsuario.AfterScroll := FDataSetCadastroUsuarioAfterScroll;
  FTextFilterActive := False;
  ckShowInactive.Checked := False;
  with FUsercontrol.UserSettings.UsersForm do
  begin
    DbGridUser.Columns[0].Title.Caption := ColName;
    DbGridUser.Columns[1].Title.Caption := ColLogin;
    DbGridUser.Columns[2].Title.Caption := ColEmail;

    btAdic.Caption := BtAdd;
    BtAlt.Caption := BtChange;
    BtExclui.Caption := BtDelete;
    BtAcess.Caption := BtRights;
    BtPass.Caption := BtPassword;
    Self.btApplyFilter.Caption := btApplyFilter;
    ckShowInactive.Caption := ShowInactive;
  end;

  TUCVisualStyle.FitButtonWidth(btAdic);
  TUCVisualStyle.FitButtonWidth(BtAlt);
  TUCVisualStyle.FitButtonWidth(BtExclui);
  TUCVisualStyle.FitButtonWidth(BtPass);
  TUCVisualStyle.FitButtonWidth(BtAcess);

  DbGridUser.Columns[3].Title.Caption :=
    FUsercontrol.UserSettings.AddChangeUser.LabelStatus;

  UpdateFilterControls;
  ResizeGridColumns;
  ApplyUserFilter;
end;

procedure TUCFrame_User.ResizeGridColumns;
var
  AvailableWidth: Integer;
begin
  if DbGridUser.Columns.Count < 4 then
    Exit;

  AvailableWidth := DbGridUser.ClientWidth - 34;
  if AvailableWidth < 300 then
    Exit;

  DbGridUser.Columns[0].Width := (AvailableWidth * 36) div 100;
  DbGridUser.Columns[1].Width := (AvailableWidth * 20) div 100;
  DbGridUser.Columns[2].Width := (AvailableWidth * 32) div 100;
  DbGridUser.Columns[3].Width := AvailableWidth -
    DbGridUser.Columns[0].Width - DbGridUser.Columns[1].Width -
    DbGridUser.Columns[2].Width;
end;

procedure TUCFrame_User.UpdateFilterControls;
var
  IndexImage: Integer;
begin
  if FTextFilterActive then
  begin
    IndexImage := 1;
    btApplyFilter.Caption := FUsercontrol.UserSettings.UsersForm.BtRemoveFilter;
  end
  else
  begin
    IndexImage := 0;
    btApplyFilter.Caption := FUsercontrol.UserSettings.UsersForm.BtApplyFilter;
  end;

  btApplyFilter.Glyph := nil;
  ImageList1.GetBitmap(IndexImage, btApplyFilter.Glyph);
end;

procedure TUCFrame_User.SetWindowUser(Adicionar: Boolean);
begin
  with FUsercontrol.UserSettings.AddChangeUser do
  begin
    FfrmIncluirUsuario.Caption := WindowCaption;
    if Adicionar then
      FfrmIncluirUsuario.LbDescricao.Caption := LabelAdd
    else
    begin
      FfrmIncluirUsuario.LbDescricao.Caption := LabelChange;
      FfrmIncluirUsuario.LbDescricao.Tag := FDataSetCadastroUsuario.FieldByName('IdUser').AsInteger;
    end;

    FfrmIncluirUsuario.FDataSetCadastroUsuario := DataUser.DataSet;
    FfrmIncluirUsuario.Label1.Caption := LabelStatus;
    FfrmIncluirUsuario.lbNome.Caption := LabelName;
    FfrmIncluirUsuario.lbLogin.Caption := LabelLogin;
    FfrmIncluirUsuario.lbEmail.Caption := LabelEmail;
    FfrmIncluirUsuario.ckPrivilegiado.Caption := CheckPrivileged;
    FfrmIncluirUsuario.lbPerfil.Caption := LabelPerfil;
    FfrmIncluirUsuario.btGravar.Caption := BtSave;
    FfrmIncluirUsuario.btCancela.Caption := BtCancel;
    FfrmIncluirUsuario.Position := Self.FUsercontrol.UserSettings.WindowsPosition;
    FfrmIncluirUsuario.LabelExpira.Caption := ExpiredIn;
    FfrmIncluirUsuario.ckUserExpired.Caption := CheckExpira;
    FfrmIncluirUsuario.ComboPerfil.ListSource := DataPerfil;
    FfrmIncluirUsuario.ComboStatus.Enabled := not Adicionar;
    with FfrmIncluirUsuario.ComboStatus.Items do
    begin
      Clear;
      Add(StatusActive);
      Add(StatusDisabled);
    end;
    FfrmIncluirUsuario.ComboStatus.ItemIndex := 0;
    FfrmIncluirUsuario.lImagem.Caption := LabelImage;
    FfrmIncluirUsuario.btLoadImage.Caption := BtLoadImage;
    FfrmIncluirUsuario.btClearImage.Caption := BtRemoveImage;
    FfrmIncluirUsuario.miLoad.Caption := BtLoadImage;
    FfrmIncluirUsuario.miClear.Caption := BtRemoveImage;
  end;

  TUCVisualStyle.FitButtonWidth(FfrmIncluirUsuario.btGravar);
  TUCVisualStyle.FitButtonWidth(FfrmIncluirUsuario.btCancela);
end;

end.
