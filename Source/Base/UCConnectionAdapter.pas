unit UCConnectionAdapter;

interface

uses
  System.Classes,
  Data.DB,
  System.SysUtils,
  UCDataConnector;

type
  EUCConnectionAdapter = class(Exception);

  { Generic contract between UserControl and an application's connection layer.
    CreateDataSet transfers ownership of the returned dataset to the caller. }
  IUCDataConnection = interface
    ['{50A54DF2-4052-4CF2-A4EA-045624310CC6}']
    procedure Execute(const SQL: string);
    function CreateDataSet(const SQL: string): TDataSet;
    function IsConnected: Boolean;
    function TableExists(const TableName: string): Boolean;
    function FieldExists(const TableName, FieldName: string): Boolean;
    function DatabaseObjectName: string;
    function TransactionObjectName: string;
  end;

  { Optional extension for connections that materialize data outside the
    TDataSet.Open lifecycle (REST, RPC, cached datasets, and similar). }
  IUCDataConnectionRefresh = interface
    ['{27A1C772-E538-4A91-9FE7-C4288F5FD242}']
    procedure RefreshDataSet(DataSet: TDataSet);
  end;

  { Optional extension for values that should not be embedded in SQL text,
    such as Base64 images sent through REST/RPC transports. }
  IUCDataConnectionTextFieldWriter = interface
    ['{CFB52B39-8E4B-43E8-B88E-17F97F9FE07D}']
    procedure UpdateTextField(const TableName, KeyField: string;
      KeyValue: Int64; const FieldName, Value: string);
  end;

  { Runtime adapter. It deliberately has no Register procedure, so installing a
    new design-time component is not necessary. }
  TUCConnectionAdapter = class(TUCDataConnector)
  private
    FConnection: IUCDataConnection;
    function RequireConnection: IUCDataConnection;
  public
    procedure UCExecSQL(FSQL: String); override;
    function UCGetSQLDataset(FSQL: String): TDataSet; override;
    function UCFindTable(const TableName: String): Boolean; override;
    function UCFindFieldTable(const TableName, FieldName: String): Boolean; override;
    function UCFindDataConnection: Boolean; override;
    function GetDBObjectName: String; override;
    function GetTransObjectName: String; override;
    procedure RefreshDataSet(DataSet: TDataSet); override;
    function UCUpdateTextField(const TableName, KeyField: String;
      KeyValue: Int64; const FieldName, Value: String): Boolean; override;

    property Connection: IUCDataConnection read FConnection write FConnection;
  end;

implementation

{ TUCConnectionAdapter }

function TUCConnectionAdapter.RequireConnection: IUCDataConnection;
begin
  Result := FConnection;
  if not Assigned(Result) then
    raise EUCConnectionAdapter.Create('Conexao do UserControl nao informada');
end;

procedure TUCConnectionAdapter.RefreshDataSet(DataSet: TDataSet);
var
  Refresher: IUCDataConnectionRefresh;
begin
  ValidateDataSet(DataSet, 'RefreshDataSet');
  if Supports(RequireConnection, IUCDataConnectionRefresh, Refresher) then
    Refresher.RefreshDataSet(DataSet)
  else
    inherited RefreshDataSet(DataSet);
end;

procedure TUCConnectionAdapter.UCExecSQL(FSQL: String);
begin
  RequireConnection.Execute(FSQL);
end;

function TUCConnectionAdapter.UCGetSQLDataset(FSQL: String): TDataSet;
begin
  Result := RequireConnection.CreateDataSet(FSQL);
  if not Assigned(Result) then
    raise EUCConnectionAdapter.Create(
      'A conexao do UserControl retornou um DataSet nulo');
end;

function TUCConnectionAdapter.UCFindTable(const TableName: String): Boolean;
begin
  Result := RequireConnection.TableExists(TableName);
end;

function TUCConnectionAdapter.UCFindFieldTable(const TableName,
  FieldName: String): Boolean;
begin
  Result := RequireConnection.FieldExists(TableName, FieldName);
end;

function TUCConnectionAdapter.UCFindDataConnection: Boolean;
begin
  Result := Assigned(FConnection) and FConnection.IsConnected;
end;

function TUCConnectionAdapter.GetDBObjectName: String;
begin
  Result := RequireConnection.DatabaseObjectName;
end;

function TUCConnectionAdapter.GetTransObjectName: String;
begin
  Result := RequireConnection.TransactionObjectName;
end;

function TUCConnectionAdapter.UCUpdateTextField(const TableName,
  KeyField: String; KeyValue: Int64; const FieldName,
  Value: String): Boolean;
var
  Writer: IUCDataConnectionTextFieldWriter;
begin
  Result := Supports(RequireConnection, IUCDataConnectionTextFieldWriter,
    Writer);
  if Result then
    Writer.UpdateTextField(TableName, KeyField, KeyValue, FieldName, Value);
end;

end.
