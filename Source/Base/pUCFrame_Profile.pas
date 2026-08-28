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

unit pUCFrame_Profile;

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
  DBGrids,
  Grids,


  FMTBcd,

  {$IFDEF DELPHIXE2_UP}
  System.UITypes,
  {$ENDIF}

  IncPerfil_U,
  UcBase,
  UCVisualStyle,
  UserPermis_U,
  pUCGeral;

type
  TFrame_Profile = class(TFrame)
    DbGridPerf: TDBGrid;
    Panel2: TPanel;
    BtnAddPer: TBitBtn;
    BtnAltPer: TBitBtn;
    BtnExcPer: TBitBtn;
    BtnAcePer: TBitBtn;
    DataPerfil: TDataSource;
    BtnCopiaPer: TBitBtn;
    procedure BtnAddPerClick(Sender: TObject);
    procedure BtnAltPerClick(Sender: TObject);
    procedure BtnExcPerClick(Sender: TObject);
    procedure BtnAcePerClick(Sender: TObject);
    procedure BtnCopiaPerClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
  protected
    FIncluirPerfil: TfrmIncluirPerfil;
    procedure ActionBtPermissProfileDefault;
    procedure SetWindowPerfil(Adicionar: Boolean);
    procedure SetWindowProfile;
  private
    { Private declarations }
    CopiaPerfil: Boolean;
  public
    { Public declarations }
    fUserControl: TUserControl;
    FDataSetPerfilUsuario: TDataset;
    procedure ApplyVisualStyle;
    destructor Destroy; override;
  end;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TFrame_Profile.ApplyVisualStyle;
var
  I: Integer;
begin
  TUCVisualStyle.ApplyFrame(Self);
  TUCVisualStyle.StyleActionPanel(Panel2);
  TUCVisualStyle.StyleGrid(DbGridPerf);

  for I := 0 to Panel2.ControlCount - 1 do
    if Panel2.Controls[I] is TBitBtn then
    begin
      TUCVisualStyle.StyleActionButton(TBitBtn(Panel2.Controls[I]));
      TUCVisualStyle.FitButtonWidth(TBitBtn(Panel2.Controls[I]), 96);
    end;

  BtnAddPer.Left := 8;
  BtnCopiaPer.Left := BtnAddPer.Left + BtnAddPer.Width + 8;
  BtnAltPer.Left := BtnCopiaPer.Left + BtnCopiaPer.Width + 8;
  BtnExcPer.Left := BtnAltPer.Left + BtnAltPer.Width + 8;
  BtnAcePer.Left := BtnExcPer.Left + BtnExcPer.Width + 8;

  FrameResize(Self);
end;

procedure TFrame_Profile.FrameResize(Sender: TObject);
var
  AvailableWidth: Integer;
begin
  if DbGridPerf.Columns.Count = 0 then
    Exit;

  AvailableWidth := DbGridPerf.ClientWidth - 28;
  if AvailableWidth < 120 then
    AvailableWidth := 120;
  DbGridPerf.Columns[0].Width := AvailableWidth;
end;

procedure TFrame_Profile.SetWindowPerfil(Adicionar: Boolean);
begin
  with fUserControl.UserSettings.AddChangeProfile do
  begin
    FIncluirPerfil.Caption := WindowCaption;
    if Adicionar then
      FIncluirPerfil.LbDescricao.Caption := LabelAdd
    else
      FIncluirPerfil.LbDescricao.Caption := LabelChange;

    // FIncluirPerfil.lbNome.Caption        := LabelName;
    FIncluirPerfil.btGravar.Caption := BtSave;
    FIncluirPerfil.btCancela.Caption := BtCancel;
    FIncluirPerfil.Position := fUserControl.UserSettings.WindowsPosition;
    FIncluirPerfil.FDataSetPerfilUsuario := FDataSetPerfilUsuario;
  end;
end;
{$WARNINGS OFF}

procedure TFrame_Profile.ActionBtPermissProfileDefault;
var
  TempCampos, TempCamposEX: String;
begin
  UserPermis.FTempIdUser := FDataSetPerfilUsuario.FieldByName('IdUser')
    .AsInteger;
  with fUserControl do
  begin
    TempCampos :=
      Format(' %s as IdUser, %s as Modulo, %s as ObjName, %s as UCKey ',
      [TableRights.FieldUserID, TableRights.FieldModule,
      TableRights.FieldComponentName, TableRights.FieldKey]);
    TempCamposEX := Format('%s, %s as FormName ',
      [TempCampos, TableRights.FieldFormName]);

    UserPermis.DSPermiss := DataConnector.UCGetSQLDataset
      (Format('Select %s from %s tab Where tab.%s = %s and tab.%s = %s',
      [TempCampos, TableRights.TableName, TableRights.FieldUserID,
      FDataSetPerfilUsuario.FieldByName('IdUser').AsString,
      TableRights.FieldModule, QuotedStr(ApplicationID)]));

    UserPermis.DSPermiss.Open;

    UserPermis.DSPermissEX := DataConnector.UCGetSQLDataset
      (Format('Select %s from %s tab1 Where tab1.%s = %s and tab1.%s = %s',
      [TempCamposEX, TableRights.TableName + 'EX', TableRights.FieldUserID,
      FDataSetPerfilUsuario.FieldByName('IdUser').AsString,
      TableRights.FieldModule, QuotedStr(ApplicationID)]));

    UserPermis.DSPermissEX.Open;

    UserPermis.Show;

    { Giovani da Cruz (G7) // Alteração para adequação de alguns connectores }
    FUserControl.DataConnector.RefreshDataSet(FDataSetPerfilUsuario);

    FDataSetPerfilUsuario.Locate('idUser', UserPermis.FTempIdUser, []);
  end;
end;
{$WARNINGS ON}

procedure TFrame_Profile.SetWindowProfile;
begin
  with fUserControl.UserSettings.Rights do
  begin
    UserPermis.Caption := WindowCaption;
    UserPermis.LbDescricao.Caption := LabelProfile;
    UserPermis.lbUser.Left := UserPermis.LbDescricao.Left +
      UserPermis.LbDescricao.Width + 5;
    UserPermis.PageMenu.Caption := PageMenu;
    UserPermis.PageAction.Caption := PageActions;
    UserPermis.PageControls.Caption := PageControls; // By Vicente Barros Leonel
    UserPermis.lbSearch.Caption := SearchLabel;
    UserPermis.btSearchNext.Caption := SearchNext;
    UserPermis.BtLibera.Caption := BtUnlock;
    UserPermis.BtBloqueia.Caption := BtLock;
    UserPermis.BtGrava.Caption := BtSave;
    UserPermis.BtCancel.Caption := BtCancel;
    UserPermis.Position := fUserControl.UserSettings.WindowsPosition;
  end;
end;

procedure TFrame_Profile.BtnAcePerClick(Sender: TObject);
var
  formHandle: THandle;
begin
  formHandle := FindWindow('TUserPermis', nil);
  if formHandle = 0 then { By Cleilson Sousa }
  begin
    if FDataSetPerfilUsuario.IsEmpty then
      Exit;
    UserPermis := TUserPermis.Create(self);
    UserPermis.fUserControl := fUserControl;
    SetWindowProfile;
    UserPermis.lbUser.Caption := FDataSetPerfilUsuario.FieldByName
      ('Nome').AsString;
    ActionBtPermissProfileDefault;
  end
  else
  begin
    ShowWindow(formHandle, SW_SHOWNORMAL);
    SetForegroundWindow(formHandle);
  end;

end;

procedure TFrame_Profile.BtnAddPerClick(Sender: TObject);
begin
  try
    FIncluirPerfil := TfrmIncluirPerfil.Create(self);
    FIncluirPerfil.fUserControl := self.fUserControl;
    SetWindowPerfil(True);
    if CopiaPerfil then { By Cleilson Sousa }
      FIncluirPerfil.LbDescricao.Caption := 'Selecione o Perfil para Copiar';
    FIncluirPerfil.ShowModal;
  finally
    FreeAndNil(FIncluirPerfil);
  end;
end;

procedure TFrame_Profile.BtnAltPerClick(Sender: TObject);
begin
  if FDataSetPerfilUsuario.IsEmpty then
    Exit;
  try
    FIncluirPerfil := TfrmIncluirPerfil.Create(self);
    FIncluirPerfil.fUserControl := self.fUserControl;
    FIncluirPerfil.FNewIdUser := FDataSetPerfilUsuario.FieldByName('IdUser')
      .AsInteger;
    SetWindowPerfil(False);
    with FIncluirPerfil do
    begin
      EditDescricao.Text := FDataSetPerfilUsuario.FieldByName('Nome').AsString;
      FAltera := True;
      ShowModal;
    end;
  finally
    FreeAndNil(FIncluirPerfil);
  end;
end;

procedure TFrame_Profile.BtnCopiaPerClick(Sender: TObject);
begin { By Cleilson Sousa }
  CopiaPerfil := True;
  BtnAddPerClick(Sender);
  CopiaPerfil := False;
end;

procedure TFrame_Profile.BtnExcPerClick(Sender: TObject);
var
  TempID: Integer;
  CanDelete: Boolean;
  HasUsers: Boolean;
  ErrorMsg: String;
  TempDS: TDataset;
begin
  if FDataSetPerfilUsuario.IsEmpty then
    Exit;
  TempID := FDataSetPerfilUsuario.FieldByName('IDUser').AsInteger;
  TempDS := fUserControl.DataConnector.UCGetSQLDataset
    ('Select ' + fUserControl.TableUsers.FieldUserID + ' as IdUser from ' +
    fUserControl.TableUsers.TableName + ' Where ' +
    fUserControl.TableUsers.FieldTypeRec + ' = ' + QuotedStr('U') + ' AND ' +
    fUserControl.TableUsers.FieldProfile + ' = ' + IntToStr(TempID));
  try
    HasUsers := not TempDS.IsEmpty;
  finally
    TempDS.Free;
  end;

  if HasUsers then
  begin
    // changed by fduenas: PromptDelete_WindowCaption
    if MessageBox(handle,
      PChar(Format(fUserControl.UserSettings.UsersProfile.PromptDelete,
      [FDataSetPerfilUsuario.FieldByName('Nome').AsString])),
      PChar(fUserControl.UserSettings.UsersProfile.PromptDelete_WindowCaption),
      MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2) <> idYes then
      Exit;
  end;

  CanDelete := True;
  if Assigned(fUserControl.onDeleteProfile) then
    fUserControl.onDeleteProfile(TObject(Owner), TempID, CanDelete, ErrorMsg);
  if not CanDelete then
  begin
    MessageDlg(ErrorMsg, mtWarning, [mbOK], 0);
    Exit;
  end;

  with fUserControl do
  begin
    DataConnector.UCExecSQL('Delete from ' + TableUsers.TableName + ' where ' +
      TableUsers.FieldUserID + ' = ' + IntToStr(TempID));
    DataConnector.UCExecSQL('Delete from ' + TableRights.TableName + ' where ' +
      TableRights.FieldUserID + ' = ' + IntToStr(TempID));
    DataConnector.UCExecSQL('Delete from ' + TableRights.TableName + 'EX where '
      + TableRights.FieldUserID + ' = ' + IntToStr(TempID));
    DataConnector.UCExecSQL('Update ' + TableUsers.TableName + ' Set ' +
      TableUsers.FieldProfile + ' = null where ' + TableUsers.FieldUserID +
      ' = ' + IntToStr(TempID));
  end;

  { Giovani da Cruz (G7) // Alteração para adequação de alguns connectores }
  FUsercontrol.DataConnector.RefreshDataSet(FDataSetPerfilUsuario);
end;

destructor TFrame_Profile.Destroy;
begin
  // nada a destruir
  // não destruir o FDataSetPerfilUsuario o USERCONTROL toma conta dele
  inherited;
end;

end.
