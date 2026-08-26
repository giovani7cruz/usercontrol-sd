program UCConnectionAdapterTests;

{$APPTYPE CONSOLE}

uses
  Data.DB,
  System.SysUtils,
  Datasnap.DBClient,
  UCDataConnector in '..\..\Source\Base\UCDataConnector.pas',
  UCConnectionAdapter in '..\..\Source\Base\UCConnectionAdapter.pas';

type
  TFakeDataConnection = class(TInterfacedObject, IUCDataConnection,
    IUCDataConnectionRefresh)
  private
    FExecutedSQL: string;
    FRefreshCount: Integer;
  public
    procedure Execute(const SQL: string);
    function CreateDataSet(const SQL: string): TDataSet;
    function IsConnected: Boolean;
    function TableExists(const TableName: string): Boolean;
    function FieldExists(const TableName, FieldName: string): Boolean;
    function DatabaseObjectName: string;
    function TransactionObjectName: string;
    procedure RefreshDataSet(DataSet: TDataSet);
    property ExecutedSQL: string read FExecutedSQL;
    property RefreshCount: Integer read FRefreshCount;
  end;

procedure Check(Condition: Boolean; const MessageText: string);
begin
  if not Condition then
    raise Exception.Create(MessageText);
end;

procedure TFakeDataConnection.Execute(const SQL: string);
begin
  FExecutedSQL := SQL;
end;

function TFakeDataConnection.CreateDataSet(const SQL: string): TDataSet;
var
  DataSet: TClientDataSet;
begin
  DataSet := TClientDataSet.Create(nil);
  try
    DataSet.FieldDefs.Add('SQL', ftString, 200);
    DataSet.CreateDataSet;
    DataSet.AppendRecord([SQL]);
    Result := DataSet;
  except
    DataSet.Free;
    raise;
  end;
end;

function TFakeDataConnection.IsConnected: Boolean;
begin
  Result := True;
end;

procedure TFakeDataConnection.RefreshDataSet(DataSet: TDataSet);
begin
  Inc(FRefreshCount);
end;

function TFakeDataConnection.TableExists(const TableName: string): Boolean;
begin
  Result := SameText(TableName, 'UCUSERS');
end;

function TFakeDataConnection.FieldExists(const TableName,
  FieldName: string): Boolean;
begin
  Result := SameText(TableName, 'UCUSERS') and SameText(FieldName, 'LOGIN');
end;

function TFakeDataConnection.DatabaseObjectName: string;
begin
  Result := 'FakeConnection';
end;

function TFakeDataConnection.TransactionObjectName: string;
begin
  Result := 'FakeTransaction';
end;

var
  Adapter: TUCConnectionAdapter;
  ConnectionObject: TFakeDataConnection;
  Connection: IUCDataConnection;
  DataSet: TDataSet;
  RaisedExpectedException: Boolean;
begin
  try
    Adapter := TUCConnectionAdapter.Create(nil);
    try
      RaisedExpectedException := False;
      try
        Adapter.UCExecSQL('sem conexao');
      except
        on EUCConnectionAdapter do
          RaisedExpectedException := True;
      end;
      Check(RaisedExpectedException, 'Ausencia de conexao nao foi detectada');

      ConnectionObject := TFakeDataConnection.Create;
      Connection := ConnectionObject;
      Adapter.Connection := Connection;

      Check(Adapter.UCFindDataConnection, 'Conexao valida nao foi detectada');
      Adapter.UCExecSQL('update ucusers set login = login');
      Check(ConnectionObject.ExecutedSQL = 'update ucusers set login = login',
        'Execute nao foi delegado');
      Check(Adapter.UCFindTable('UCUSERS'), 'TableExists nao foi delegado');
      Check(Adapter.UCFindFieldTable('UCUSERS', 'LOGIN'),
        'FieldExists nao foi delegado');
      Check(Adapter.GetDBObjectName = 'FakeConnection',
        'Nome da conexao incorreto');
      Check(Adapter.GetTransObjectName = 'FakeTransaction',
        'Nome da transacao incorreto');

      DataSet := Adapter.UCGetSQLDataset('select * from ucusers');
      try
        Check(DataSet.Owner = nil, 'DataSet deve pertencer ao chamador');
        Check(DataSet.FieldByName('SQL').AsString = 'select * from ucusers',
          'CreateDataSet nao foi delegado');
        Adapter.RefreshDataSet(DataSet);
        Check(ConnectionObject.RefreshCount = 1,
          'RefreshDataSet nao foi delegado');
      finally
        DataSet.Free;
      end;
    finally
      Adapter.Free;
    end;

    Writeln('UCConnectionAdapter: OK');
  except
    on E: Exception do
    begin
      Writeln(E.ClassName + ': ' + E.Message);
      Halt(1);
    end;
  end;
end.
