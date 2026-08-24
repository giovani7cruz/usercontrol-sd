{ -----------------------------------------------------------------------------
  Unit Name: UCDataSnapConn
  Author   : Giovani Da Cruz
  Date     : 31/07/2005
  Purpose  : DataSnap Suporte
  E-mail   : giovani@infus.inf.br
  URL      : www.infus.inf.br
  UC SW    : http://infussolucoes.github.io/usercontrol-sd/

  registered in UCDataSnapConnReg.pas
  ----------------------------------------------------------------------------- }

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
{ **************************************************************************** }

{ ******************************************************************************
  |* Historico
  |*
  |* 17/07/2015: Giovani Da Cruz
  |*  - Criação e distribuição da Primeira deste connector
  |*
  **************************************************************************** }
unit UCDataSnapConn;

interface

uses
  Classes,
  DB,
  SysUtils, SqlExpr, UCDataSnapProxy, DBClient,
  UCDataConnector;

const
  CONNECTION_ERROR = 'UC: Operação não realizada por falta de conexão!';

type
  TClientDataSet = class(DBClient.TClientDataSet)
  private
    FSQL: TStrings;  public
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SQL : TStrings read FSQL write FSQL;
  end;

  TUCDataSnapConn = class(TUCDataConnector)
  private
    FConnection: TSQLConnection;
    FInstanceOwner: Boolean;
    FDSClient: TDSUserRemote;
    FSchema: String;
    FProviderName: string;
    FRemoteServer: TCustomRemoteServer;
    procedure SetSQLConnection(const Value: TSQLConnection);
    function GetRemoteServer: TCustomRemoteServer;
    procedure SetProviderName(const Value: string);
    procedure SetRemoteServer(const Value: TCustomRemoteServer);
  protected
    procedure DataSetBeforeOpen(DataSet: TDataSet);
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
  published
    property Connection: TSQLConnection read FConnection write SetSQLConnection;
    property DSClient: TDSUserRemote read FDSClient write FDSClient;
    property SchemaName: String read FSchema write FSchema;
    property ProviderName: string read FProviderName write SetProviderName;
    property RemoteServer: TCustomRemoteServer read GetRemoteServer write SetRemoteServer;
  end;

implementation

{ TUCDataSnapConn }

constructor TUCDataSnapConn.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
  FSchema := '';
end;

procedure TUCDataSnapConn.DataSetBeforeOpen(DataSet: TDataSet);
begin
  if not (Connection.Connected) then
    Connection.Open;

  DSClient.GetDataSet((DataSet as TClientDataSet).SQL.Text);
end;

destructor TUCDataSnapConn.Destroy;
begin

  inherited;
end;

function TUCDataSnapConn.GetDBObjectName: String;
begin
  if Assigned(FConnection) then
  begin
    if Owner = FConnection.Owner then
      Result := FConnection.Name
    else
      Result := FConnection.Owner.Name + '.' + FConnection.Name;
  end
  else
    Result := '';
end;

function TUCDataSnapConn.GetRemoteServer: TCustomRemoteServer;
begin
  Result := FRemoteServer;
end;

function TUCDataSnapConn.GetTransObjectName: String;
begin
  Result := '';
end;

procedure TUCDataSnapConn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FConnection) then
    FConnection := nil;
  inherited Notification(AComponent, Operation);
end;

procedure TUCDataSnapConn.OrderBy(const DataSet: TDataSet; const FieldName: string);
var
  IndexName: string;
  Index: TIndexDef;
  Found: Boolean;
begin
  inherited;
  if TClientDataSet(DataSet).IndexFieldNames = FieldName then
  begin
    IndexName := FieldName + ' Desc';

    try
      TClientDataSet(DataSet).IndexDefs.Find(IndexName);
      Found := True;
    except
      Found := False;
    end;

    if not Found then
    begin
      Index := TClientDataSet(DataSet).IndexDefs.AddIndexDef;
      Index.Name := IndexName;
      Index.Fields := FieldName;
      Index.Options := [ixDescending];
    end;
    TClientDataSet(DataSet).IndexName := IndexName;
  end
  else
    TClientDataSet(DataSet).IndexFieldNames := FieldName;
end;

procedure TUCDataSnapConn.SetProviderName(const Value: string);
begin
  if (Value = FProviderName) then
    Exit;

  FProviderName := Value;
end;

procedure TUCDataSnapConn.SetRemoteServer(const Value: TCustomRemoteServer);
begin
  if (Value = FRemoteServer) then
    Exit;

  FRemoteServer := Value;
end;

procedure TUCDataSnapConn.SetSQLConnection(const Value: TSQLConnection);
begin
  if FConnection <> Value then
    FConnection := Value;
  if FConnection <> nil then
    FConnection.FreeNotification(Self);
end;

procedure TUCDataSnapConn.UCExecSQL(FSQL: String);
begin
  if not (Connection.Connected) then
    Connection.Open;

  if (Connection.Connected) then
  begin
    DSClient.ExecuteSQL(FSQL);
  end
  else
  begin
    raise Exception.Create(CONNECTION_ERROR);
  end;
end;

function TUCDataSnapConn.UCFindDataConnection: Boolean;
begin
  Result := Assigned(FConnection) and (FConnection.Connected);
end;

function TUCDataSnapConn.UCFindFieldTable(const Tablename, FieldName: string): Boolean;
begin
  Result := True;//DSClient.FindFieldTable(Tablename, FieldName);
end;

function TUCDataSnapConn.UCFindTable(const Tablename: String): Boolean;
begin
  Result := True;//DSClient.FindTable(Tablename, Self.SchemaName);
end;

function TUCDataSnapConn.UCGetSQLDataset(FSQL: String): TDataset;
begin
  if not (Connection.Connected) then
    Connection.Open;

  if (Connection.Connected) then
  begin
    Result := TClientDataSet.Create(nil);
    (Result as TClientDataSet).SQL.Text := FSQL;

    TClientDataSet(Result).RemoteServer := Self.RemoteServer;
    TClientDataSet(Result).ProviderName := Self.ProviderName;

    Result.BeforeOpen := DataSetBeforeOpen;
    Result.Open;
  end
  else
  begin
    raise Exception.Create(CONNECTION_ERROR);
  end;
end;

{ TClientDataSet }

constructor TClientDataSet.Create(AOwner: TComponent);
begin
  inherited;
  FSQL := TStringList.Create;
end;

destructor TClientDataSet.Destroy;
begin
  FSQL.Destroy;
  inherited;
end;

end.
