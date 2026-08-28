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
unit pUcFrame_UserLogged;

interface

{$I 'UserControl.inc'}

uses
  Variants, Buttons, Classes,
  Controls, DB, DBCtrls, Dialogs, ExtCtrls,
  Forms, Graphics, Messages, Spin, StdCtrls,
  SysUtils,
  {$IFDEF FPC}
  {$IFDEF WINDOWS}Windows,{$ELSE}LCLType,{$ENDIF}
  {$ELSE}
  Windows,
  {$ENDIF}
  DBGrids, Grids, Menus,


  IncUser_U, UCBase;

type
  TUCFrame_UsersLogged = class(TFrame)
    dsDados: TDataSource;
    DBGrid: TDBGrid;
    Panel3: TPanel;
    BitMsg: TBitBtn;
    BitRefresh: TBitBtn;
    BitRemove: TBitBtn;
    PopupMenu1: TPopupMenu;
    miDeleteSelected: TMenuItem;
    miDeleteAll: TMenuItem;
    procedure BitRefreshClick(Sender: TObject);
    procedure BitMsgClick(Sender: TObject);
    procedure miDeleteSelectedClick(Sender: TObject);
    procedure miDeleteAllClick(Sender: TObject);
    procedure BitRemoveClick(Sender: TObject);
    procedure dsDadosDataChange(Sender: TObject; Field: TField);
    procedure FrameResize(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  private
    DSUserLogados: TDataset;
    UCMes: TUCApplicationMessage;
    procedure ConfigureSessionFields;
    procedure SessionDateGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure ApplyVisualStyle;
    procedure ResizeGridColumns;
    function SelectedLogonID: String;
    procedure UpdateActionState;
  public
    FUserControl: TUserControl;
    procedure SetWindow;
    destructor Destroy; override;
  end;

implementation

uses
  UCMessages, DateUtils, UCVisualStyle;

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TUCFrame_UsersLogged.ConfigureSessionFields;
var
  Field: TField;
begin
  if not Assigned(DSUserLogados) then
    Exit;

  Field := DSUserLogados.FindField('DATA');
  if Assigned(Field) then
    Field.OnGetText := SessionDateGetText;
end;

procedure TUCFrame_UsersLogged.SessionDateGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
var
  RawValue: String;
  DatePart: TDateTime;
  TimePart: TDateTime;
  Value: TDateTime;
begin
  RawValue := Sender.AsString;
  if not DisplayText then
  begin
    Text := RawValue;
    Exit;
  end;

  if (Length(RawValue) = 14) and
    TryEncodeDate(StrToIntDef(Copy(RawValue, 1, 4), 0),
      StrToIntDef(Copy(RawValue, 5, 2), 0),
      StrToIntDef(Copy(RawValue, 7, 2), 0), DatePart) and
    TryEncodeTime(StrToIntDef(Copy(RawValue, 9, 2), 0),
      StrToIntDef(Copy(RawValue, 11, 2), 0),
      StrToIntDef(Copy(RawValue, 13, 2), 0), 0, TimePart) then
  begin
    Value := DatePart + TimePart;
    {$IFNDEF FPC}
    Value := TTimeZone.Local.ToLocalTime(Value);
    {$ENDIF}
    Text := FormatDateTime('dd/mm/yyyy hh:nn:ss', Value);
  end
  else
    Text := RawValue;
end;

procedure TUCFrame_UsersLogged.SetWindow;
const
  PreSQLStmt =
    'select ' +
    '  L.%s as LogonID, ' +
    '  U.%s as UserName, ' +
    '  U.%s as id, ' +
    '  U.%s as Login, ' +
    '  L.%s as MachineName, ' +
    '  L.%s as DATA ' +
    'from ' +
    '  %s L inner join ' +
    '  %s U on U.%s = L.%s ' +
    'where ' +
    '  L.%s = %s ' +
    'order by U.%s, L.%s desc';
var
  SQLStmt: String;
  I: Integer;
  Form: TForm;
begin
  UCMes := nil;
  Form := Application.MainForm;
  if Assigned(Form) then
    for I := 0 to Form.ComponentCount - 1 do
      if Form.Components[I] is TUCApplicationMessage then
      begin
        UCMes := TUCApplicationMessage(Form.Components[I]);
        Break;
      end;
  BitMsg.Visible := UCMes <> nil;

  FUserControl.UsersLogged.RemoveExpiredSessions;
  with FUserControl do
  begin
    SQLStmt := Format(PreSQLStmt, [
      TableUsersLogged.FieldLogonID, TableUsers.FieldUserName, TableUsers.FieldUserId, TableUsers.FieldLogin,
      TableUsersLogged.FieldMachineName, TableUsersLogged.FieldData, TableUsersLogged.TableName, TableUsers.TableName,
      TableUsers.FieldUserId, TableUsersLogged.FieldUserId,
      TableUsersLogged.FieldApplicationID, QuotedStr(ApplicationID),
      TableUsers.FieldUserName, TableUsersLogged.FieldData
    ]);

    dsDados.DataSet := nil;
    FreeAndNil(DSUserLogados);
    DSUserLogados := DataConnector.UCGetSQLDataset(SQLStmt);

    with UserSettings.UsersLogged do
    begin
      Caption := LabelCaption;
      BitMsg.Caption := BtnMessage;
      BitRefresh.Caption := BtnRefresh;
      BitRemove.Caption := BtnRemove;
      miDeleteSelected.Caption := BtnRemove;
      miDeleteAll.Caption := MenuRemoveAll;

      DBGrid.Columns[0].Title.Caption := ColName;
      DBGrid.Columns[1].Title.Caption := ColLogin;
      DBGrid.Columns[2].Title.Caption := ColComputer;
      DBGrid.Columns[3].Title.Caption := ColData;
    end;

  end;
  dsDados.Dataset := DSUserLogados;
  ConfigureSessionFields;
  ApplyVisualStyle;
  ResizeGridColumns;
  UpdateActionState;
end;

procedure TUCFrame_UsersLogged.BitRefreshClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;

    FUserControl.UsersLogged.RemoveExpiredSessions;
    FUserControl.DataConnector.RefreshDataSet(dsDados.Dataset);
    ConfigureSessionFields;
    UpdateActionState;
  finally
    Screen.Cursor := crDefault;
  end;
end;

destructor TUCFrame_UsersLogged.Destroy;
begin
  dsDados.DataSet := nil;
  FreeAndNil(DSUserLogados);
//  FreeAndNil(UCMes); Comentado propositalmente, pois este componente pertence ao form principal e não desta tela, então não deve se dar free;
  inherited;
end;

procedure TUCFrame_UsersLogged.miDeleteAllClick(Sender: TObject);
const
  sql = 'delete from %s L where L.%s = %s and L.%s <> %s';
begin
  if SelectedLogonID = '' then
    Exit;
  if MessageDlg(FUserControl.UserSettings.UsersLogged.PromptRemoveAll,
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  FUserControl.DataConnector.UCExecSQL(Format(sql, [
    FUserControl.TableUsersLogged.TableName,
    FUserControl.TableUsersLogged.FieldApplicationID,
    QuotedStr(FUserControl.ApplicationID),
    FUserControl.TableUsersLogged.FieldLogonID,
    QuotedStr(FUserControl.CurrentUser.IdLogon)
  ]));
  BitRefresh.Click;
end;

procedure TUCFrame_UsersLogged.miDeleteSelectedClick(Sender: TObject);
const
  sql = 'delete from %s L where L.%s = %s and L.%s = %s and L.%s <> %s';
begin
  if SelectedLogonID = '' then
    Exit;
  if SameText(SelectedLogonID, FUserControl.CurrentUser.IdLogon) then
    Exit;
  if MessageDlg(FUserControl.UserSettings.UsersLogged.PromptRemove,
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  FUserControl.DataConnector.UCExecSQL(Format(sql, [
    FUserControl.TableUsersLogged.TableName,
    FUserControl.TableUsersLogged.FieldApplicationID,
    QuotedStr(FUserControl.ApplicationID),
    FUserControl.TableUsersLogged.FieldLogonID,
    QuotedStr(SelectedLogonID),
    FUserControl.TableUsersLogged.FieldLogonID,
    QuotedStr(FUserControl.CurrentUser.IdLogon)
  ]));
  BitRefresh.Click;
end;

procedure TUCFrame_UsersLogged.BitMsgClick(Sender: TObject);
var
  Msg: String;
begin
  if Assigned(UCMes) and (SelectedLogonID <> '') then
    if InputQuery(FUserControl.UserSettings.UsersLogged.InputText,
      FUserControl.UserSettings.UsersLogged.InputCaption, Msg) = True then
      UCMes.SendAppMessage(dsDados.Dataset.FieldValues['id'],
        FUserControl.UserSettings.UsersLogged.MsgSystem, Msg);
end;

procedure TUCFrame_UsersLogged.ApplyVisualStyle;
begin
  TUCVisualStyle.ApplyFrame(Self);
  TUCVisualStyle.StyleGrid(DBGrid);
  TUCVisualStyle.StyleActionPanel(Panel3);
  TUCVisualStyle.StyleActionButton(BitMsg);
  TUCVisualStyle.StyleActionButton(BitRemove);
  TUCVisualStyle.StyleActionButton(BitRefresh);
  TUCVisualStyle.FitButtonWidth(BitMsg, 112);
  TUCVisualStyle.FitButtonWidth(BitRemove, 128);
  TUCVisualStyle.FitButtonWidth(BitRefresh, 112);
end;

procedure TUCFrame_UsersLogged.BitRemoveClick(Sender: TObject);
begin
  miDeleteSelectedClick(Sender);
end;

procedure TUCFrame_UsersLogged.dsDadosDataChange(Sender: TObject; Field: TField);
begin
  UpdateActionState;
end;

procedure TUCFrame_UsersLogged.FrameResize(Sender: TObject);
begin
  ResizeGridColumns;
end;

procedure TUCFrame_UsersLogged.PopupMenu1Popup(Sender: TObject);
begin
  UpdateActionState;
end;

procedure TUCFrame_UsersLogged.ResizeGridColumns;
var
  AvailableWidth: Integer;
begin
  if not Assigned(DBGrid) or (DBGrid.Columns.Count < 4) then
    Exit;

  AvailableWidth := DBGrid.ClientWidth - GetSystemMetrics(SM_CXVSCROLL) - 28;
  if AvailableWidth <= 0 then
    Exit;

  DBGrid.Columns[0].Width := AvailableWidth * 30 div 100;
  DBGrid.Columns[1].Width := AvailableWidth * 20 div 100;
  DBGrid.Columns[2].Width := AvailableWidth * 25 div 100;
  DBGrid.Columns[3].Width := AvailableWidth - DBGrid.Columns[0].Width -
    DBGrid.Columns[1].Width - DBGrid.Columns[2].Width;
end;

function TUCFrame_UsersLogged.SelectedLogonID: String;
var
  DataSet: TDataSet;
  Field: TField;
begin
  Result := '';
  DataSet := dsDados.DataSet;
  if not Assigned(DataSet) or not DataSet.Active or DataSet.IsEmpty then
    Exit;

  Field := DataSet.FindField('LogonID');
  if Assigned(Field) then
    Result := Field.AsString;
end;

procedure TUCFrame_UsersLogged.UpdateActionState;
var
  HasSelection: Boolean;
  CanRemove: Boolean;
begin
  if not Assigned(FUserControl) then
  begin
    BitMsg.Enabled := False;
    BitRemove.Enabled := False;
    miDeleteSelected.Enabled := False;
    miDeleteAll.Enabled := False;
    Exit;
  end;

  HasSelection := SelectedLogonID <> '';
  CanRemove := HasSelection and not SameText(SelectedLogonID,
    FUserControl.CurrentUser.IdLogon);
  BitMsg.Enabled := BitMsg.Visible and HasSelection;
  BitRemove.Enabled := CanRemove;
  miDeleteSelected.Enabled := CanRemove;
  miDeleteAll.Enabled := HasSelection;
end;

end.
