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

unit pUCFrame_Log;

interface

{$I 'UserControl.inc'}

uses
  {$IFDEF FPC}
  DateTimePicker,
  {$ENDIF}

  Variants,
  Buttons,
  Classes,
  Clipbrd,
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
  ComCtrls,
  DBGrids,

  UCBase,

  // Delphi XE 8 ou superior
  {$IFDEF DELPHI22_UP}
      System.ImageList,
  {$ENDIF}

  ImgList, Grids;

type
  TUCFrame_Log = class(TFrame)
    DataSource1: TDataSource;
    ImageList1: TImageList;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    lbUsuario: TLabel;
    lbData: TLabel;
    lbNivel: TLabel;
    Bevel3: TBevel;
    btfiltro: TBitBtn;
    btexclui: TBitBtn;
    ComboUsuario: TComboBox;
    Data1: TDateTimePicker;
    Data2: TDateTimePicker;
    ComboNivel: TComboBox;
    Label1: TLabel;
    Mensagem: TEdit;
    PanelLogDetail: TPanel;
    lbLogDetail: TLabel;
    DBMemoLogDetail: TDBMemo;
    btCopyLog: TBitBtn;
    SplitterLogDetail: TSplitter;
    procedure ComboNivelDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btexcluiClick(Sender: TObject);
    procedure btfiltroClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure btCopyLogClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    procedure AplicaFiltro;
    procedure UpdateLogDetailState;
  public
    ListIdUser: TStringList;
    DSLog, DSCmd: TDataset;
    FUsercontrol: TUserControl;
    procedure SetWindow;
    destructor Destroy; override;
  end;

implementation

uses
  UCDataInfo;

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

destructor TUCFrame_Log.Destroy;
begin
  DataSource1.DataSet := nil;
  FreeAndnil(DSLog);
  FreeAndnil(DSCmd);
  FreeAndnil(ListIdUser);
  inherited;
end;

procedure TUCFrame_Log.btCopyLogClick(Sender: TObject);
var
  MessageField: TField;
begin
  if not Assigned(DataSource1.DataSet) then
    Exit;
  if not DataSource1.DataSet.Active then
    Exit;
  if DataSource1.DataSet.IsEmpty then
    Exit;

  MessageField := DataSource1.DataSet.FindField('MSG');
  if Assigned(MessageField) then
    Clipboard.AsText := MessageField.AsString;
end;

procedure TUCFrame_Log.ComboNivelDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  TempImg: Graphics.TBitmap;
begin
  TempImg := Graphics.TBitmap.Create;
  ImageList1.GetBitmap(Index, TempImg);
  ComboNivel.Canvas.Draw(Rect.Left + 5, Rect.Top + 1, TempImg);
  ComboNivel.Canvas.TextRect(Rect, Rect.Left + 30, Rect.Top + 2,
    ComboNivel.items[Index]);
  ComboNivel.Canvas.Draw(Rect.Left + 5, Rect.Top + 1, TempImg);
  FreeAndnil(TempImg);
end;

procedure TUCFrame_Log.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  FData: System.TDateTime;
  TempData: String;
  img: TImage;
begin
  if not DSLog.IsEmpty then
  begin
    if UpperCase(Column.FieldName) = 'NIVEL' then
    begin
      if Column.Field.AsInteger >= 0 then
      begin
        img := TImage.Create(nil);
        try
          ImageList1.GetBitmap(Column.Field.AsInteger, img.Picture.Bitmap);
          DBGrid1.Canvas.FillRect(Rect);
          DBGrid1.Canvas.Draw((((Rect.Left + Rect.Right) - img.Picture.Bitmap.Width) div 2), Rect.Top, img.Picture.Bitmap);
        finally
          img.Free;
        end;
      end
      else
        DBGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2,
          Column.Field.AsString);
    end
    else if UpperCase(Column.FieldName) = 'DATA' then
    begin
      TempData := Column.Field.AsString;
      FData := EncodeDate(StrToInt(Copy(TempData, 1, 4)),
        StrToInt(Copy(TempData, 5, 2)), StrToInt(Copy(TempData, 7, 2))) +
        EncodeTime(StrToInt(Copy(TempData, 9, 2)), StrToInt(Copy(TempData, 11, 2)
        ), StrToInt(Copy(TempData, 13, 2)), 0);
      DBGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2,
        DateTimeToStr(FData));
    end
    else
      DBGrid1.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2,
        Column.Field.AsString);
  end;
end;

procedure TUCFrame_Log.DBGrid1TitleClick(Column: TColumn);
begin
  FUsercontrol.DataConnector.OrderBy(Column.Field.DataSet, Column.FieldName);
end;

procedure TUCFrame_Log.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  UpdateLogDetailState;
end;

procedure TUCFrame_Log.btexcluiClick(Sender: TObject);
var
  FTabLog, Temp: String;
begin
  // modified by fduenas
  if MessageBox(Handle, PChar(FUsercontrol.UserSettings.Log.PromptDelete),
    PChar(FUsercontrol.UserSettings.Log.PromptDelete_WindowCaption), mb_YesNo)
    <> mrYes then
    Exit;

  FTabLog := FUsercontrol.LogControl.TableLog;
  Temp := 'Delete from ' + FTabLog + ' Where (Data >=' +
    QuotedStr(FormatDateTime('yyyyMMddhhmmss', Data1.DateTime)) + ') ' +
    ' and (Data <=' + QuotedStr(FormatDateTime('yyyyMMddhhmmss', Data2.DateTime)
    ) + ') ' + ' and nivel >=' + IntToStr(ComboNivel.ItemIndex);

  if ComboUsuario.ItemIndex > 0 then
    Temp := Temp + ' and ' + FTabLog + '.idUser = ' + ListIdUser
      [ComboUsuario.ItemIndex];

  try
    FUsercontrol.DataConnector.UCExecSQL(Temp);
    AplicaFiltro;
    DBGrid1.Repaint;
  except
  end;

  try
    FUsercontrol.Log(Format(FUsercontrol.UserSettings.Log.DeletePerformed,
      [ComboUsuario.Text, DateTimeToStr(Data1.DateTime),
      DateTimeToStr(Data2.DateTime), ComboNivel.Text]), 2);
  except
    ;
  end;

end;

procedure TUCFrame_Log.btfiltroClick(Sender: TObject);
begin
  AplicaFiltro;
end;

procedure TUCFrame_Log.AplicaFiltro;
var
  FTabUser, FTabLog: String;
  Temp: String;
begin
  DSLog.Close;
  FTabLog := FUsercontrol.LogControl.TableLog;
  FTabUser := FUsercontrol.TableUsers.TableName;

  Temp := Format('Select TabUser.' + FUsercontrol.TableUsers.FieldUserName +
    ' as nome, ' + FTabLog + '.* ' + 'from ' + FTabLog +
    '  Left outer join %s TabUser on ' + FTabLog + '.idUser = TabUser.%s ' +
    'Where (data >= ' + QuotedStr(FormatDateTime('yyyyMMddhhmmss',
    Data1.DateTime)) + ') ' + 'and (Data <= ' +
    QuotedStr(FormatDateTime('yyyyMMddhhmmss', Data2.DateTime)) + ') ' +
    'and nivel >= ' + IntToStr(ComboNivel.ItemIndex),
    [FUsercontrol.TableUsers.TableName, FUsercontrol.TableUsers.FieldUserID]);

  if ComboUsuario.ItemIndex > 0 then
    Temp := Temp + ' and ' + FTabLog + '.idUser = ' + ListIdUser
      [ComboUsuario.ItemIndex];

  if Length(Trim(Mensagem.Text)) > 0 then
    Temp := Temp + ' and ' + FTabLog + '.MSG like ' + QuotedStr('%' + Mensagem.Text + '%');

  Temp := Temp + ' order by data desc';

  FreeAndnil(DSLog);
  DataSource1.DataSet := nil;
  DSLog := FUsercontrol.DataConnector.UCGetSQLDataset(Temp);
  DataSource1.DataSet := DSLog;
  btexclui.Enabled := not DSLog.IsEmpty;
  UpdateLogDetailState;
end;

procedure TUCFrame_Log.UpdateLogDetailState;
var
  DataSet: TDataSet;
begin
  DataSet := DataSource1.DataSet;
  btCopyLog.Enabled := False;
  if not Assigned(DataSet) then
    Exit;
  if not DataSet.Active then
    Exit;
  if DataSet.IsEmpty then
    Exit;

  btCopyLog.Enabled := Assigned(DataSet.FindField('MSG'));
end;

procedure TUCFrame_Log.SetWindow;
var
  TabelaLog: String;
  SQLStmt: String;
begin
  ComboNivel.items.Clear;
  ComboNivel.items.Append(FUsercontrol.UserSettings.Log.OptionLevelLow); // BGM
  ComboNivel.items.Append(FUsercontrol.UserSettings.Log.OptionLevelNormal);
  // BGM
  ComboNivel.items.Append(FUsercontrol.UserSettings.Log.OptionLevelHigh); // BGM
  ComboNivel.items.Append(FUsercontrol.UserSettings.Log.OptionLevelCritic);
  // BGM
  ComboNivel.ItemIndex := 0;
  ComboUsuario.items.Clear;
  Data1.Date := EncodeDate(StrToInt(FormatDateTime('yyyy', Date)), 1, 1);
  Data2.DateTime := Now;

  if Assigned(ListIdUser) = False then
    ListIdUser := TStringList.Create
  else
    ListIdUser.Clear;

  with FUsercontrol do
    if ((FUsercontrol.CurrentUser.Privileged = True) or
      (FUsercontrol.CurrentUser.UserLogin = FUsercontrol.Login.InitialLogin.
      User)) then
    begin
      DSCmd := DataConnector.UCGetSQLDataset
        (Format('SELECT %s AS IDUSER, %s AS NOME , %s AS LOGIN FROM %s WHERE %s  = %s ORDER BY %s',
        [TableUsers.FieldUserID, TableUsers.FieldUserName,
        TableUsers.FieldLogin, TableUsers.TableName, TableUsers.FieldTypeRec,
        QuotedStr('U'), TableUsers.FieldUserName]));
      ComboUsuario.items.Append(FUsercontrol.UserSettings.Log.OptionUserAll);
      ListIdUser.Append('0');
    end
    else
      DSCmd := DataConnector.UCGetSQLDataset
        (Format('SELECT %s AS IDUSER, %s AS NOME , %s AS LOGIN FROM %s WHERE %s  = %s and %s = %s ORDER BY %s',
        [TableUsers.FieldUserID, TableUsers.FieldUserName,
        TableUsers.FieldLogin, TableUsers.TableName, TableUsers.FieldTypeRec,
        QuotedStr('U'), TableUsers.FieldLogin,
        QuotedStr(FUsercontrol.CurrentUser.UserLogin),
        TableUsers.FieldUserName]));

  while not DSCmd.EOF do
  begin
    ComboUsuario.items.Append(DSCmd.FieldByName('Nome').AsString);
    ListIdUser.Append(DSCmd.FieldByName('idUser').AsString);
    DSCmd.Next;
  end;

  DSCmd.Close;
  FreeAndnil(DSCmd);

  ComboUsuario.ItemIndex := 0;

  TabelaLog := FUsercontrol.LogControl.TableLog;
  with FUsercontrol do
  begin
    SQLStmt := 'SELECT ' + TableUsers.TableName + '.' + TableUsers.FieldUserName
      + ' AS NOME, ' + TabelaLog + '.* from ' + TabelaLog + ' LEFT OUTER JOIN '
      + TableUsers.TableName + ' on ' + TabelaLog + '.idUser = ' +
      TableUsers.TableName + '.' + TableUsers.FieldUserID + ' WHERE (DATA >=' +
      QuotedStr(FormatDateTime('yyyyMMddhhmmss', Data1.DateTime)) +
      ') AND (DATA<=' + QuotedStr(FormatDateTime('yyyyMMddhhmmss',
      Data2.DateTime)) + ') ORDER BY DATA DESC';
    DSLog := DataConnector.UCGetSQLDataset(SQLStmt);
  end;
  DataSource1.DataSet := DSLog;
  btexclui.Enabled := not DSLog.IsEmpty;
  UpdateLogDetailState;

  with FUsercontrol.UserSettings.Log, DBGrid1 do
  begin
    lbUsuario.Caption := LabelUser;
    lbData.Caption := LabelDate;
    lbNivel.Caption := LabelLevel;
    btfiltro.Caption := BtFilter;
    btexclui.Caption := BtDelete;
    lbLogDetail.Caption := LabelDetail;
    btCopyLog.Caption := BtCopy;

    { Columns[0].Title.Caption := ColAppID;
      Columns[0].FieldName     := 'APPLICATIONID';
      Columns[0].Width         := 60; }
    Columns[0].Title.Caption := ColLevel;
    Columns[0].FieldName := 'NIVEL';
    Columns[0].Width := 32;
    Columns[1].Title.Caption := ColMessage;
    Columns[1].FieldName := 'MSG';
    Columns[1].Width := 290;
    Columns[2].Title.Caption := ColUser;
    Columns[2].FieldName := 'NOME';
    Columns[2].Width := 120;
    Columns[3].Title.Caption := ColDate;
    Columns[3].FieldName := 'DATA';
    Columns[3].Width := 120;
  end;

  Bevel3.Width := Panel1.Width - 32;
  Bevel3.Left := 16;
end;

end.
