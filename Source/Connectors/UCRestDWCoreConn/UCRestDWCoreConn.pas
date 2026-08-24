{ **************************************************************************** }
{ Projeto: Componentes User Control ShowDelphi Edition                         }
{ Biblioteca multiplataforma de componentes Delphi para o controle de usuários }
{                                                                              }
{ Baseado nos pacotes Open Source User Control 2.31 RC1                        }
{                                                                              }
{                                                                              }                           
{******************************************************************************}
{ Versão ShowDelphi Edition                                                    }
{                                                                              }
{ Direitos Autorais Reservados (c) 2019   Giovani Da Cruz                      }
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
{ Comunidade Show Delphi - showdelphi.com.br                                   }
{                                                                              }
{ Giovani Da Cruz  -  giovani@infus.inf.br  -  www.infus.inf.br                }
{                                                                              }
{ **************************************************************************** }

{ AJUDE O PROJETO COM UMA XÍCARA DE CAFÉ OU DUAS. CONSIDERE UMA DOAÇÃO!        }
{                                                                              }
{ VIA PAGSEGURO: https://pag.ae/7VccpnuCN                                      }
{ APOIE COM BITCOIN: 13JUHQpT7zAU7pC1q6cQBYGpq5EF8XoLcL                        }
{

{ ******************************************************************************
  |* Historico
  |*
  |* 31/08/2019: Giovani Da Cruz
  |*  - Criação do Connector
  **************************************************************************** }
unit UCRestDWCoreConn;

interface

uses
  System.Classes,
  System.SysUtils,
  Data.DB,

  uRESTDWPoolerDB,

  UCDataConnector;

type
  TUCRestDWCoreConn = class(TUCDataConnector)
  private
    FSchema: String;
    FDataBase: TRESTDWDataBase;
    procedure CheckDataBase;
    function GetAbout: string;
    procedure SetDataBase(const Value: TRESTDWDataBase);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDBObjectName: String; override;
    function GetTransObjectName: String; override;
    function UCFindDataConnection: Boolean; override;
    function UCFindTable(const Tablename: String): Boolean; override;
    function UCFindFieldTable(const Tablename: string; const FieldName: string): Boolean; override;
    function UCGetSQLDataset(FSQL: String): TDataset; override;
    procedure UCExecSQL(FSQL: String); override;
    procedure OrderBy(const DataSet: TDataSet; const FieldName: string); override;
    procedure CloseDataSet(DataSet : TDataSet); override;
    procedure OpenDataSet(DataSet : TDataSet); override;
  published
    property DataBase : TRESTDWDataBase read FDataBase write SetDataBase;
    property SchemaName: String read FSchema write FSchema;
    property About : string read GetAbout;
  end;

implementation

{ TUCRestDWConn }

procedure TUCRestDWCoreConn.CloseDataSet(DataSet: TDataSet);
begin
  ValidateDataSet(DataSet, 'CloseDataSet');
  (DataSet as TRESTDWClientSQL).Close;
end;

procedure TUCRestDWCoreConn.CheckDataBase;
begin
  if not Assigned(FDataBase) then
    raise Exception.Create('DataBase do connector RESTDataWare Core nao informado');
end;

constructor TUCRestDWCoreConn.Create(AOwner: TComponent);
begin
  inherited;

  FSchema := '';
end;

destructor TUCRestDWCoreConn.Destroy;
begin
  SetDataBase(nil);
  inherited;
end;

function TUCRestDWCoreConn.GetAbout: string;
begin
  Result := 'Criado por Giovani Da Cruz - showdelphi.com.br';
end;

function TUCRestDWCoreConn.GetDBObjectName: String;
begin
  if Assigned(FDataBase) then
  begin
    if (not Assigned(FDataBase.Owner)) or (Owner = FDataBase.Owner) then
      Result := FDataBase.Name
    else
      Result := FDataBase.Owner.Name + '.' + FDataBase.Name;
  end
  else
    Result := EmptyStr;
end;

function TUCRestDWCoreConn.GetTransObjectName: String;
begin
  Result := EmptyStr;
end;

procedure TUCRestDWCoreConn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = DataBase) then
  begin
    FDataBase := nil;
  end;

  inherited Notification(AComponent, Operation);
end;

procedure TUCRestDWCoreConn.OpenDataSet(DataSet: TDataSet);
begin
  ValidateDataSet(DataSet, 'OpenDataSet');
  (DataSet as TRESTDWClientSQL).Open;
end;

procedure TUCRestDWCoreConn.SetDataBase(const Value: TRESTDWDataBase);
begin
  if FDataBase = Value then
    Exit;
  if Assigned(FDataBase) then
    FDataBase.RemoveFreeNotification(Self);
  FDataBase := Value;
  if Assigned(FDataBase) then
    FDataBase.FreeNotification(Self);
end;

procedure TUCRestDWCoreConn.OrderBy(const DataSet: TDataSet;
  const FieldName: string);
var
  IndexName: string;
  Index: TIndexDef;
  Found: Boolean;
begin
  inherited;

  if (TRESTDWClientSQL(DataSet).IndexFieldNames = FieldName) then
  begin
    IndexName := FieldName + ' Desc';

    try
      TRESTDWClientSQL(DataSet).IndexDefs.Find(IndexName);
      Found := True;
    except
      Found := False;
    end;

    if not Found then
    begin
      Index := TRESTDWClientSQL(DataSet).IndexDefs.AddIndexDef;
      Index.Name := IndexName;
      Index.Fields := FieldName;
      Index.Options := [ixDescending];
    end;

    TRESTDWClientSQL(DataSet).IndexName := IndexName;
  end
  else
  begin
    TRESTDWClientSQL(DataSet).IndexFieldNames := FieldName;
  end;
end;

procedure TUCRestDWCoreConn.UCExecSQL(FSQL: String);
var
  vDataSet : TRESTDWClientSQL;
  vError : string;
begin
  CheckDataBase;
  vError := EmptyStr;
  vDataSet := TRESTDWClientSQL.Create(Self);

  try
    vDataSet.DataBase := Self.DataBase;
    vDataSet.SQL.Text := FSQL;
    vDataSet.ExecSQL(vError);

    if vError <> EmptyStr then
    begin
      raise Exception.Create('UserControl ExeSQL: ' + vError);
    end;
  finally
    FreeAndNil(vDataSet);
  end;
end;

function TUCRestDWCoreConn.UCFindDataConnection: Boolean;
begin
  Result := Assigned(FDataBase) and (FDataBase.Connected);
end;

function TUCRestDWCoreConn.UCFindFieldTable(const Tablename,
  FieldName: string): Boolean;
var
  vList : TStringList;
begin
  CheckDataBase;
  vList := TStringList.Create;

  try
    Result := Self.DataBase.GetFieldNames(Tablename, vList);

    { Caso tenha obtido a lista de tabelas, procure pelo nome }
    if (Result) then
    begin
      vList.Text := UpperCase(vList.Text);

      Result := vList.IndexOf(UpperCase(FieldName)) >= 0;
    end;
  finally
    FreeAndNil(vList);
  end;
end;

function TUCRestDWCoreConn.UCFindTable(const Tablename: String): Boolean;
var
  vList : TStringList;
begin
  CheckDataBase;
  vList := TStringList.Create;

  try
    Result := Self.DataBase.GetTableNames(vList);

    { Caso tenha obtido a lista de tabelas, procure pelo nome }
    if (Result) then
    begin
      vList.Text := UpperCase(vList.Text);

      Result := vList.IndexOf(UpperCase(Tablename)) >= 0;
    end;
  finally
    FreeAndNil(vList);
  end;
end;

function TUCRestDWCoreConn.UCGetSQLDataset(FSQL: String): TDataset;
var
  vDataSet : TRESTDWClientSQL;
begin
  CheckDataBase;
  vDataSet := TRESTDWClientSQL.Create(nil);

  try
    vDataSet.Close;
    vDataSet.DataBase := Self.DataBase;
    vDataSet.SQL.Text := FSQL;
    vDataSet.Open;
  except on E: Exception do
    begin
      FreeAndNil(vDataSet);
      raise Exception.Create('UserControl GetDataSet: ' + E.Message);
    end;
  end;

  Result := vDataSet;
end;

end.
