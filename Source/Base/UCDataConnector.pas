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
  |*
  |* 05/04/2018: Giovani Da Cruz
  |*  - Adição de Metodos DataSetClose e DataSetOpen para permitir melhor
  |*  compatibilidade entre os conectors.
  |*
  ******************************************************************************* }
unit UCDataConnector;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

{$I 'UserControl.inc'}

uses
  Classes,
  DB,
  SysUtils;

type
  TUCDataConnector = class(TComponent)
  protected
    procedure ValidateDataSet(DataSet: TDataSet; const OperationName: String);
  public
    procedure UCExecSQL(FSQL: String); virtual; abstract;
    function UCGetSQLDataset(FSQL: String): TDataset; dynamic; abstract;
    function UCFindTable(const Tablename: String): Boolean; virtual; abstract;
    function UCFindFieldTable(const Tablename, FieldName: String): Boolean; virtual; abstract;
    function UCFindDataConnection: Boolean; virtual; abstract;
    function GetDBObjectName: String; virtual; abstract;
    function GetTransObjectName: String; virtual; abstract;
    procedure OrderBy(const DataSet: TDataSet; const FieldName: string); virtual;
    procedure CloseDataSet(DataSet : TDataSet); virtual;
    procedure OpenDataSet(DataSet : TDataSet); virtual;
  end;

implementation

{ TUCDataConnector }

procedure TUCDataConnector.CloseDataSet(DataSet: TDataSet);
begin
  ValidateDataSet(DataSet, 'CloseDataSet');
  DataSet.Close;
end;

procedure TUCDataConnector.OpenDataSet(DataSet: TDataSet);
begin
  ValidateDataSet(DataSet, 'OpenDataSet');
  DataSet.Open;
end;

procedure TUCDataConnector.OrderBy(const DataSet: TDataSet; const FieldName: string);
begin
  ValidateDataSet(DataSet, 'OrderBy');
  if Trim(FieldName) = '' then
    raise Exception.Create('OrderBy: nome do campo nao informado');
end;

procedure TUCDataConnector.ValidateDataSet(DataSet: TDataSet;
  const OperationName: String);
begin
  if not Assigned(DataSet) then
    raise Exception.Create(OperationName + ': DataSet nao informado');
end;

end.
