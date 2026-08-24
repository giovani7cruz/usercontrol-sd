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
  |* 19/03/2018: Giovani Da Cruz
  |*  - Criação do Connector
  |*
  |* 05/04/2018: Giovani Da Cruz
  |*  - Melhoria para a atualização de dados
  |*
  ******************************************************************************* }
unit UCRestDWConn;

interface

uses
  System.Classes,
  System.SysUtils,
  Data.DB,

  UCDataConnector,

  uRestPoolerDB;

type
  TUCRestDWConn = class(TUCDataConnector)
  private
    FSchema: String;
    FDataBase: TRESTDataBase;
    procedure CheckDataBase;
    procedure SetDataBase(const Value: TRESTDataBase);
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
    property DataBase : TRESTDataBase read FDataBase write SetDataBase;
    property SchemaName: String read FSchema write FSchema;

  end;

implementation

{ TUCRestDWConn }

procedure TUCRestDWConn.CloseDataSet(DataSet: TDataSet);
begin
  ValidateDataSet(DataSet, 'CloseDataSet');
  (DataSet as TRESTClientSQL).Close;
end;

procedure TUCRestDWConn.CheckDataBase;
begin
  if not Assigned(FDataBase) then
    raise Exception.Create('DataBase do connector RESTDataWare nao informado');
end;

constructor TUCRestDWConn.Create(AOwner: TComponent);
begin
  inherited;
  FSchema := '';
end;

destructor TUCRestDWConn.Destroy;
begin
  SetDataBase(nil);
  inherited;
end;

function TUCRestDWConn.GetDBObjectName: String;
begin
  if Assigned(FDataBase) then
  begin
    if (not Assigned(FDataBase.Owner)) or (Owner = FDataBase.Owner) then
      Result := FDataBase.Name
    else
      Result := FDataBase.Owner.Name + '.' + FDataBase.Name;
  end
  else
    Result := '';
end;

function TUCRestDWConn.GetTransObjectName: String;
begin
  Result := '';
end;

procedure TUCRestDWConn.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = DataBase) then
    FDataBase := nil;
  inherited Notification(AComponent, Operation);
end;

procedure TUCRestDWConn.OpenDataSet(DataSet: TDataSet);
begin
  ValidateDataSet(DataSet, 'OpenDataSet');
  (DataSet as TRESTClientSQL).Open;
end;

procedure TUCRestDWConn.SetDataBase(const Value: TRESTDataBase);
begin
  if FDataBase = Value then
    Exit;
  if Assigned(FDataBase) then
    FDataBase.RemoveFreeNotification(Self);
  FDataBase := Value;
  if Assigned(FDataBase) then
    FDataBase.FreeNotification(Self);
end;

procedure TUCRestDWConn.OrderBy(const DataSet: TDataSet;
  const FieldName: string);
var
  IndexName: string;
  Index: TIndexDef;
  Found: Boolean;
begin
  inherited;
  if TRESTClientSQL(DataSet).IndexFieldNames = FieldName then
  begin
    IndexName := FieldName + ' Desc';

    try
      TRESTClientSQL(DataSet).IndexDefs.Find(IndexName);
      Found := True;
    except
      Found := False;
    end;

    if not Found then
    begin
      Index := TRESTClientSQL(DataSet).IndexDefs.AddIndexDef;
      Index.Name := IndexName;
      Index.Fields := FieldName;
      Index.Options := [ixDescending];
    end;
    TRESTClientSQL(DataSet).IndexName := IndexName;
  end
  else
    TRESTClientSQL(DataSet).IndexFieldNames := FieldName;
end;

procedure TUCRestDWConn.UCExecSQL(FSQL: String);
var
  vDataSet : TRESTClientSQL;
  vError : string;
begin
  CheckDataBase;
  vError := EmptyStr;
  vDataSet := TRESTClientSQL.Create(Self);

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

function TUCRestDWConn.UCFindDataConnection: Boolean;
begin
  Result := Assigned(FDataBase) and (FDataBase.Connected);
end;

function TUCRestDWConn.UCFindFieldTable(const Tablename,
  FieldName: string): Boolean;
begin
  Result := True; // ver macanismo
end;

function TUCRestDWConn.UCFindTable(const Tablename: String): Boolean;
begin
  Result := True; // ver macanismo
end;

function TUCRestDWConn.UCGetSQLDataset(FSQL: String): TDataset;
var
  vDataSet : TRESTClientSQL;
begin
  CheckDataBase;
  vDataSet := TRESTClientSQL.Create(Self);

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
