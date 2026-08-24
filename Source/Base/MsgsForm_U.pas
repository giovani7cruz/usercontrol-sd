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

unit MsgsForm_U;

interface

{$I 'UserControl.inc'}

uses
  Variants,
  Buttons,
  Classes,
  ComCtrls,
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

  ImgList,

  // Delphi XE 8 ou superior
  {$IFDEF DELPHI22_UP}
    System.ImageList,
  {$ENDIF}

  ToolWin;

type
  TPointMsg = ^PPointMsg;

  PPointMsg = record
    IdMsg: Integer;
    Msg: String;
  end;

  TMsgsForm = class(TForm)
    ImageList1: TImageList;
    ListView1: TListView;
    ToolBar1: TToolBar;
    btnova: TToolButton;
    ImageList2: TImageList;
    btResponder: TToolButton;
    btEncaminhar: TToolButton;
    btExcluir: TToolButton;
    Splitter1: TSplitter;
    btClose: TToolButton;
    MemoMsg: TMemo;
    procedure btCloseClick(Sender: TObject);
    procedure btnovaClick(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure ListView1DblClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btEncaminharClick(Sender: TObject);
    procedure btResponderClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FColuna: Integer;
    FAsc: Boolean;
    FListaTPointMsg: array of TPointMsg;
    procedure MontaTela;
    procedure ReleaseResources;
  public
    DSMsgs: TDataset;
    DSUsuarios: TDataset;
    destructor Destroy; override;
  end;

var
  MsgsForm: TMsgsForm;

implementation

uses
  EnvMsgForm_U,
  MsgRecForm_U,
  UCBase;

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TMsgsForm.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMsgsForm.btnovaClick(Sender: TObject);
begin
  EnvMsgForm := TEnvMsgForm.Create(Self.Owner);
  EnvMsgForm.DataSource1.DataSet := DSUsuarios;
  EnvMsgForm.Showmodal;
  FreeAndNil(EnvMsgForm);
end;

function FmtDtHr(dt: String): String;
begin
  Result := Copy(dt, 7, 2) + '/' + Copy(dt, 5, 2) + '/' + Copy(dt, 1, 4) + ' ' +
    Copy(dt, 9, 2) + ':' + Copy(dt, 11, 2);
end;

procedure TMsgsForm.MontaTela;
var
  TempPoint: TPointMsg;
begin
  DSMsgs.Open;
  while not DSMsgs.EOF do
  begin
    with ListView1.Items.Add do
    begin
      ImageIndex := -1;
      StateIndex := -1;
      Caption := DSMsgs.FieldByName('de').AsString;
      SubItems.Add(DSMsgs.FieldByName('Subject').AsString);
      SubItems.Add(FmtDtHr(DSMsgs.FieldByName('DtSend').AsString));
      New(TempPoint);
      SetLength(FListaTPointMsg, Length(FListaTPointMsg) + 1);
      FListaTPointMsg[High(FListaTPointMsg)] := TempPoint;
      TempPoint.IdMsg := DSMsgs.FieldByName('idMsg').AsInteger;
      TempPoint.Msg := DSMsgs.FieldByName('Msg').AsString;
      Data := TempPoint;
    end;
    DSMsgs.Next;
{$IFDEF DELPHI5}
    ListView1.Selected := nil;
{$ELSE}
    ListView1.ItemIndex := 0;
{$ENDIF}
  end;
  DSMsgs.Close;
end;

procedure TMsgsForm.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if ListView1.SelCount > 1 then
  begin
    btResponder.Enabled := False;
    btEncaminhar.Enabled := False;
  end
  else
  begin
    btResponder.Enabled := True;
    btEncaminhar.Enabled := True;
  end;
  MemoMsg.Text := TPointMsg(Item.Data).Msg;
end;

procedure TMsgsForm.ListView1ColumnClick(Sender: TObject; Column: TListColumn);
begin
  if FColuna = Column.Index then
  begin
    FAsc := not FAsc;
    ListView1.Columns[FColuna].ImageIndex := Integer(FAsc);
  end
  else
  begin
    ListView1.Columns[FColuna].ImageIndex := -1;
    FColuna := Column.Index;
    FAsc := True;
    ListView1.Columns[FColuna].ImageIndex := Integer(FAsc);
  end;
  {$IFNDEF FPC}
  (Sender as TCustomListView).AlphaSort;
  {$ENDIF}
end;

procedure TMsgsForm.ListView1Compare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  ix: Integer;
begin
  if FColuna = 0 then
  begin
    if FAsc then
      Compare := CompareText(Item1.Caption, Item2.Caption)
    else
      Compare := CompareText(Item2.Caption, Item1.Caption);
  end
  else
  begin
    ix := FColuna - 1;
    if FAsc then
      Compare := CompareText(Item1.SubItems[ix], Item2.SubItems[ix])
    else
      Compare := CompareText(Item2.SubItems[ix], Item1.SubItems[ix]);
  end;
end;

procedure TMsgsForm.ListView1DblClick(Sender: TObject);
begin
  if ListView1.Selected = nil then
    exit; // added to prevent AV error {fduenas}
  MsgRecForm := TMsgRecForm.Create(Self.Owner); // midifed by fduenas

  MsgRecForm.MemoMsg.Text := TPointMsg(ListView1.Selected.Data).Msg;
  MsgRecForm.stDe.Caption := ListView1.Selected.Caption;
  MsgRecForm.stAssunto.Caption := ListView1.Selected.SubItems[0];
  MsgRecForm.stData.Caption := ListView1.Selected.SubItems[1];

  MsgRecForm.Showmodal;
  FreeAndNil(MsgRecForm);
end;

procedure TMsgsForm.btExcluirClick(Sender: TObject);
var
  contador: Integer;
begin
{$IFDEF DELPHI5}
  if ListView1.Selected = nil then
  begin
    // Modfied by fduenas
    MessageBox(Handle, PChar(TUCApplicationMessage(Owner)
      .UserControl.Settings.AppMessages.MsgsForm_NoMessagesSelected),
      PChar(TUCApplicationMessage(Owner).UserControl.Settings.AppMessages.
      MsgsForm_NoMessagesSelected_WindowCaption), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
{$ELSE}
  if ListView1.ItemIndex = -1 then
  begin
    // Modfied by fduenas
    MessageBox(Handle, PChar(TUCApplicationMessage(Owner)
      .UserControl.UserSettings.AppMessages.MsgsForm_NoMessagesSelected),
      PChar(TUCApplicationMessage(Owner).UserControl.UserSettings.AppMessages.
      MsgsForm_NoMessagesSelected_WindowCaption), MB_ICONINFORMATION or MB_OK);
    exit;
  end;
{$ENDIF}
  if ListView1.SelCount = 1 then
  begin
    TUCApplicationMessage(Owner).DeleteAppMessage
      (TPointMsg(ListView1.Selected.Data).IdMsg);
{$IFDEF DELPHI5}
    ListView1.Selected.Delete;
{$ELSE}
  {$IFNDEF FPC}
  ListView1.DeleteSelected;
  {$ELSE}
  ListView1.Selected.Delete;
  {$ENDIF}
{$ENDIF}
  end
  else
  begin
    for contador := 0 to ListView1.Items.Count - 1 do
      if ListView1.Items[contador].Selected then
        TUCApplicationMessage(Owner).DeleteAppMessage
          (TPointMsg(ListView1.Items[contador].Data).IdMsg);
{$IFDEF DELPHI5}
    ListView1.Selected.Delete;
{$ELSE}
    {$IFNDEF FPC}
    ListView1.DeleteSelected;
    {$ELSE}
    ListView1.Selected.Delete;
    {$ENDIF}
{$ENDIF}
  end;

end;

procedure TMsgsForm.btEncaminharClick(Sender: TObject);
var
  contador: Integer;
begin
{$IFDEF DELPHI5}
  if ListView1.Selected = nil then
  begin
    // Modfied by fduenas
    MessageBox(Handle, PChar(TUCApplicationMessage(Owner)
      .UserControl.Settings.AppMessages.MsgsForm_NoMessagesSelected),
      PChar(TUCApplicationMessage(Owner).UserControl.Settings.AppMessages.
      MsgsForm_NoMessagesSelected_WindowCaption), MB_ICONINFORMATION or MB_OK);
    exit;
  end;
{$ELSE}
  if ListView1.ItemIndex = -1 then
  begin
    // Modfied by fduenas
    MessageBox(Handle, PChar(TUCApplicationMessage(Owner)
      .UserControl.UserSettings.AppMessages.MsgsForm_NoMessagesSelected),
      PChar(TUCApplicationMessage(Owner).UserControl.UserSettings.AppMessages.
      MsgsForm_NoMessagesSelected_WindowCaption), MB_ICONINFORMATION or MB_OK);
    exit;
  end;
{$ENDIF}
  try
    EnvMsgForm := TEnvMsgForm.Create(Self.Owner);
    EnvMsgForm.DataSource1.DataSet := DSUsuarios;
    if EnvMsgForm.dbUsuario.Text <> '' then
      EnvMsgForm.dbUsuario.Enabled := False;
    EnvMsgForm.EditAssunto.Text :=
      Copy('Enc: ' + ListView1.Selected.SubItems[0], 1,
      EnvMsgForm.EditAssunto.MaxLength);
    EnvMsgForm.MemoMsg.Text := TPointMsg(ListView1.Selected.Data).Msg;
    for contador := 0 to EnvMsgForm.MemoMsg.Lines.Count - 1 do
      EnvMsgForm.MemoMsg.Lines[contador] := '>' + EnvMsgForm.MemoMsg.Lines
        [contador];
    EnvMsgForm.MemoMsg.Lines.Insert(0, ListView1.Selected.Caption + ' ' +
      ListView1.Selected.SubItems[1]);
    EnvMsgForm.MemoMsg.Text := Copy(EnvMsgForm.MemoMsg.Text, 1,
      EnvMsgForm.MemoMsg.MaxLength);
    EnvMsgForm.Showmodal;
  finally
    FreeAndNil(EnvMsgForm);
  end;
end;

procedure TMsgsForm.btResponderClick(Sender: TObject);
begin
{$IFDEF DELPHI5}
  if ListView1.Selected = nil then
  begin
    // Modfied by fduenas
    MessageBox(Handle, PChar(TUCApplicationMessage(Owner)
      .UserControl.Settings.AppMessages.MsgsForm_NoMessagesSelected),
      PChar(TUCApplicationMessage(Owner).UserControl.Settings.AppMessages.
      MsgsForm_NoMessagesSelected_WindowCaption), MB_ICONINFORMATION + MB_OK);
    exit;
  end;
{$ELSE}
  if ListView1.ItemIndex = -1 then
  begin
    // Modfied by fduenas
    MessageBox(Handle, PChar(TUCApplicationMessage(Owner)
      .UserControl.UserSettings.AppMessages.MsgsForm_NoMessagesSelected),
      PChar(TUCApplicationMessage(Owner).UserControl.UserSettings.AppMessages.
      MsgsForm_NoMessagesSelected_WindowCaption), MB_ICONINFORMATION or MB_OK);
    exit;
  end;
{$ENDIF}
  try
    EnvMsgForm := TEnvMsgForm.Create(Self.Owner);
    EnvMsgForm.rbUsuario.Checked := True;
    EnvMsgForm.rbTodos.Enabled := False;
    DSMsgs.Open;
    DSMsgs.Locate('idMsg', TPointMsg(ListView1.Selected.Data).IdMsg, []);
    EnvMsgForm.DataSource1.DataSet := DSUsuarios;
    EnvMsgForm.dbUsuario.KeyValue := DSMsgs.FieldByName('UsrFrom').AsInteger;
    if EnvMsgForm.dbUsuario.Text <> '' then
      EnvMsgForm.dbUsuario.Enabled := False;
    EnvMsgForm.EditAssunto.Text := Copy('Re: ' + ListView1.Selected.SubItems[0],
      1, EnvMsgForm.EditAssunto.MaxLength);
    EnvMsgForm.Showmodal;
  finally
    DSMsgs.Close;
    FreeAndNil(EnvMsgForm);
  end;
end;

procedure TMsgsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ReleaseResources;
end;

destructor TMsgsForm.Destroy;
begin
  ReleaseResources;
  inherited;
end;

procedure TMsgsForm.ReleaseResources;
var
  I: Integer;
begin
  for I := 0 to High(FListaTPointMsg) do
    Dispose(FListaTPointMsg[I]);
  SetLength(FListaTPointMsg, 0);

  SysUtils.FreeAndNil(DSMsgs);
  SysUtils.FreeAndNil(DSUsuarios);
end;

procedure TMsgsForm.FormCreate(Sender: TObject);
begin
  SetLength(FListaTPointMsg, 0);
end;

procedure TMsgsForm.FormShow(Sender: TObject);
begin
  MontaTela;
end;

end.
