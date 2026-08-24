{ -----------------------------------------------------------------------------
  Unit Name: UCMidasConn
  Author   : Luiz Benevenuto
  Date     : 31/07/2005
  Purpose  : Midas Suporte ( DataSnap )
  E-mail   : luiz.benevenuto@gmail.com
  URL      : www.siffra.com.br
  UC       : www.usercontrol.net

  registered in UCMidasConnReg.pas
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
{ ****************************************************************************** }

{ ******************************************************************************
  |* Historico
  |*
  |* 01/07/2015: Giovani Da Cruz
  |*  - Criação e distribuição da Primeira Versao ShowDelphi
  ******************************************************************************* }
unit UCMidasConn;

interface

//{$I 'UserControl.inc'}

uses
  Classes,
  DB,
  DBClient,
  SysUtils,
  UCDataConnector;

type
  TBancoDados = (bdFirebird, bdMSSQL, bdOracle, bdPostgreSQL, bdMySQL,
    bdParadox);

  TUCMidasConn = class(TUCDataConnector)
  private
    FResultado: OleVariant;
    FSQLStmt: String;
    FParams: OleVariant;
    FOwnerData: OleVariant;
    FRecsOut: Integer;
    FConnection: TCustomRemoteServer;
    FProviderName: String;
    FBancoDados: TBancoDados;
    procedure SetConnection(const Value: TCustomRemoteServer);
    procedure SetProviderName(const Value: String);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    function GetDBObjectName: String; override;
    function GetTransObjectName: String; override;
    function UCFindDataConnection: Boolean; override;
    function UCFindTable(const Tablename: String): Boolean; override;
    function UCFindFieldTable(const Tablename: string; const FieldName: string): Boolean; override;
    function UCGetSQLDataset(FSQL: String): TDataset; override;
    procedure UCExecSQL(FSQL: String); override;
    procedure OrderBy(const DataSet: TDataSet; const FieldName: string); override;
  published
    property Connection: TCustomRemoteServer Read FConnection
      Write SetConnection;
    property ProviderName: String Read FProviderName Write SetProviderName;
    property BancoDados: TBancoDados Read FBancoDados Write FBancoDados;
  end;

const
  // Select para as tabelas de sistema !!! Para outro tipo de banco implemente aqui !!!!!

  // Para banco novo !!!
  // Não esquecer de colocar em TBancoDados, o tipo de banco !!!!!!
  // Não esquecer de colocar no 'case' de UCFindTable

  SQL_Firebird_Table =
    ' select ' +
    '   upper(RDB$RELATIONS.RDB$RELATION_NAME) RDB$RELATION_NAME ' +
    ' from ' +
    '   RDB$RELATIONS ' +
    ' where ' +
    '   RDB$RELATIONS.RDB$FLAGS = 1 and ' +
    '   upper(RDB$RELATIONS.RDB$RELATION_NAME) = upper(%s)';

  SQL_Firebird_Field =
    ' select ' +
    '   upper(RF.RDB$FIELD_NAME) RDB$FIELD_NAME ' +
    ' from ' +
    '   RDB$RELATION_FIELDS RF ' +
    ' where ' +
    '   upper(RF.RDB$RELATION_NAME) = upper(%s) and ' +
    '   upper(RF.RDB$FIELD_NAME) = upper(%s) ';

  SQL_MSSQL_Table = '';
  SQL_MSSQL_Field = '';

  SQL_Oracle_Table = '';
  SQL_Oracle_Field = '';

  SQL_PostgreSQL_Table = 'SELECT ' + '  UPPER(PG_CLASS.RELNAME) ' + 'FROM ' +
    '  PG_CLASS ' + 'WHERE ' + '  PG_CLASS.RELKIND = ''r'' AND ' +
    '  UPPER(PG_CLASS.RELNAME) LIKE UPPER(''%s'')';

  SQL_PostgreSQL_Field = '';

  SQL_MySQL_Table = '';
  SQL_MySQL_Field = '';

  SQL_Paradox_Table = '';
  SQL_Paradox_Field = '';

implementation

uses
  Midas,
  Provider;

{ TUCMidasConn }

function TUCMidasConn.GetDBObjectName: String;
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

function TUCMidasConn.GetTransObjectName: String;
begin
  Result := '';
end;

procedure TUCMidasConn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FConnection) then
    FConnection := nil;
  inherited Notification(AComponent, Operation);
end;

procedure TUCMidasConn.OrderBy(const DataSet: TDataSet; const FieldName: string);
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

procedure TUCMidasConn.SetConnection(const Value: TCustomRemoteServer);
begin
  if FConnection <> Value then
    FConnection := Value;
  if FConnection <> nil then
    FConnection.FreeNotification(Self);
end;

procedure TUCMidasConn.SetProviderName(const Value: String);
begin
  FProviderName := Value;
end;

procedure TUCMidasConn.UCExecSQL(FSQL: String);
begin
  IAppServer(FConnection.GetServer).AS_Execute(FProviderName, FSQL, FParams,
    FOwnerData);
end;

function TUCMidasConn.UCFindDataConnection: Boolean;
begin
  Result := Assigned(FConnection) and (FConnection.Connected);
end;

function TUCMidasConn.UCFindFieldTable(const Tablename, FieldName: string): Boolean;
begin
  case FBancoDados of
    bdFirebird:
      FSQLStmt := SQL_Firebird_Field;
    bdMSSQL:
      FSQLStmt := SQL_MSSQL_Field;
    bdOracle:
      FSQLStmt := SQL_Oracle_Field;
    bdPostgreSQL:
      FSQLStmt := SQL_PostgreSQL_Field;
    bdMySQL:
      FSQLStmt := SQL_MySQL_Field;
    bdParadox:
      FSQLStmt := SQL_Paradox_Field;
  end;

  FSQLStmt := Format(FSQLStmt, [QuotedStr(Tablename), QuotedStr(FieldName)]);

  FResultado := IAppServer(FConnection.GetServer).AS_GetRecords(FProviderName,
    -1, FRecsOut, 0, FSQLStmt, FParams, FOwnerData);

  Result := FRecsOut > 0;
end;

function TUCMidasConn.UCFindTable(const Tablename: String): Boolean;
begin
  case FBancoDados of
    bdFirebird:
      FSQLStmt := SQL_Firebird_Table;
    bdMSSQL:
      FSQLStmt := SQL_MSSQL_Table;
    bdOracle:
      FSQLStmt := SQL_Oracle_Table;
    bdPostgreSQL:
      FSQLStmt := SQL_PostgreSQL_Table;
    bdMySQL:
      FSQLStmt := SQL_MySQL_Table;
    bdParadox:
      FSQLStmt := SQL_Paradox_Table;
  end;

  FSQLStmt := Format(FSQLStmt, [QuotedStr(Tablename)]);

  FResultado := IAppServer(FConnection.GetServer).AS_GetRecords(FProviderName,
    -1, FRecsOut, 0, FSQLStmt, FParams, FOwnerData);

  Result := FRecsOut > 0;
end;

function TUCMidasConn.UCGetSQLDataset(FSQL: String): TDataset;
begin
  Result := TClientDataSet.Create(nil);

  with TClientDataSet(Result) do
  begin
    if FConnection is TConnectionBroker then
      ConnectionBroker := TConnectionBroker(FConnection)
    else
      RemoteServer := FConnection;

    ProviderName := FProviderName;
    CommandText := FSQL;
    Open;
  end;
end;

end.
