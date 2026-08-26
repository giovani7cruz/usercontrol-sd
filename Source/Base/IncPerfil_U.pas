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

unit IncPerfil_U;

interface

{$I 'UserControl.inc'}

uses
  Variants,
  Buttons,
  Classes,
  Controls,
  DB,
  Dialogs,
  ExtCtrls,
  Forms,
  Graphics,
  Messages,
  StdCtrls,
  SysUtils,
  {$IFDEF FPC}
  {$IFDEF WINDOWS}Windows,{$ELSE}LCLType,{$ENDIF}
  {$ELSE}
  Windows,
  {$ENDIF}

  UCBase;

type
  TfrmIncluirPerfil = class(TForm)
    PanelTitulo: TPanel;
    LbDescricao: TLabel;
    Image1: TImage;
    PanelButao: TPanel;
    btGravar: TBitBtn;
    btCancela: TBitBtn;
    PanelAddPerfil: TPanel;
    lbNome: TLabel;
    EditDescricao: TEdit;
    ComboBoxPerfil: TComboBox;
    procedure btCancelaClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    IDPerfilNovo: Integer;
    PerfilDs: TDataset;
    function GetNewIdUser: Integer;
    procedure IncluiPerfil();
    procedure AlteraPerfil();
    procedure CopiaPerfil();
    { Private declarations }
  public
    FAltera: Boolean;
    FUserControl: TUserControl;
    FNewIdUser: Integer;
    FDataSetPerfilUsuario: TDataset;
  end;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TfrmIncluirPerfil.AlteraPerfil;
begin
  with FUserControl do
  begin
    DataConnector.UCExecSQL(Format('UPDATE %s SET %s = %s WHERE %s = %d',
      [TableUsers.TableName, TableUsers.FieldUserName,
      QuotedStr(EditDescricao.Text), TableUsers.FieldUserID, FNewIdUser]));
  end;
end;

procedure TfrmIncluirPerfil.btCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmIncluirPerfil.btGravarClick(Sender: TObject);
begin
  btGravar.Enabled := False;

  if LbDescricao.Caption = 'Selecione o Perfil para Copiar' then
  begin
    CopiaPerfil; { By Cleilson Sousa }
  end
  else
  begin
    if FAltera then
    begin // alterar perfil
      AlteraPerfil;
    end
    else
    begin // inclui perfil
      IncluiPerfil;
    end;
  end;

  if FDataSetPerfilUsuario <> nil then
  begin
    { Giovani da Cruz (G7) // Alteração para adequação de alguns connectores }
    FUserControl.DataConnector.RefreshDataSet(FDataSetPerfilUsuario);

    FDataSetPerfilUsuario.Locate('IDUser', FNewIdUser, []);
  end;

  Close;
end;

procedure TfrmIncluirPerfil.CopiaPerfil; { By Cleilson Sousa }
var
  IDPerfilVelho: Integer;
  DSPermiss, DSPermissEX: TDataset;
begin
  DSPermiss := nil;
  DSPermissEX := nil;
  PerfilDs.Filtered := False;
  PerfilDs.Filter := 'Upper(' + FUserControl.TableUsers.FieldUserName +
    ') like ' + AnsiUpperCase(QuotedStr(ComboBoxPerfil.Text));
  PerfilDs.Filtered := True;

  if PerfilDs.RecordCount = 1 then
  begin
    try
      with FUserControl do
      begin
        IDPerfilVelho := PerfilDs.FieldByName(TableUsers.FieldUserID).AsInteger;

        DSPermiss := DataConnector.UCGetSQLDataSet
          ('SELECT * FROM ' + TableRights.TableName + ' WHERE ' +
          TableRights.FieldUserID + ' = ' + IntToStr(IDPerfilVelho));

        DSPermissEX := DataConnector.UCGetSQLDataSet
          ('SELECT * FROM ' + TableRights.TableName + 'EX' + ' WHERE ' +
          TableRights.FieldUserID + ' = ' + IntToStr(IDPerfilVelho));

        with TableRights do
        begin
          DataConnector.UCExecSQL('Delete from ' + TableName +
            ' Where ' + FieldUserID + ' = ' + IntToStr(IDPerfilNovo) + ' and ' +
            FieldModule + ' = ' + QuotedStr(ApplicationID));
          DataConnector.UCExecSQL('Delete from ' + TableName +
            'EX Where ' + FieldUserID + ' = ' + IntToStr(IDPerfilNovo) + ' and ' +
            FieldModule + ' = ' + QuotedStr(ApplicationID));
        end;

        DSPermiss.First;
        while not DSPermiss.Eof do
        begin
          AddRight(IDPerfilNovo,
            DSPermiss.FieldByName(TableRights.FieldComponentName).AsString);
          DSPermiss.Next;
        end;

        DSPermissEX.First;
        while not DSPermissEX.Eof do
        begin
          AddRightEX(IDPerfilNovo, ApplicationID,
            DSPermissEX.FieldByName(TableRights.FieldFormName).AsString,
            DSPermissEX.FieldByName(TableRights.FieldComponentName).AsString);
          DSPermissEX.Next;
        end;
      end;
    finally
      DSPermissEX.Free;
      DSPermiss.Free;
    end;
  end
  else
    ShowMessage('Existem perfis com nomes iguais');
  Close;
end;

procedure TfrmIncluirPerfil.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(PerfilDs);
end;

procedure TfrmIncluirPerfil.FormShow(Sender: TObject);
var
  I: Integer;
begin
  if LbDescricao.Caption = 'Selecione o Perfil para Copiar'
  then { By Cleilson Sousa }
  begin
    EditDescricao.Visible := False;
    ComboBoxPerfil.Visible := True;

    with FUserControl do
    begin
      IDPerfilNovo := FDataSetPerfilUsuario.FieldByName('IdUser').AsInteger;

      PerfilDs := DataConnector.UCGetSQLDataSet
        ('SELECT ' + TableUsers.FieldUserID + ',' + TableUsers.FieldUserName +
        ' FROM ' + TableUsers.TableName + ' WHERE ' + TableUsers.FieldTypeRec +
        ' LIKE ''P''');

      PerfilDs.First;
      for I := 1 to PerfilDs.RecordCount do
      begin
        if PerfilDs.FieldByName(TableUsers.FieldUserID).AsInteger <> IDPerfilNovo
        then
          ComboBoxPerfil.Items.Add
            (PerfilDs.FieldByName(TableUsers.FieldUserName).AsString);

        PerfilDs.Next;
      end;
    end;
  end;
end;

function TfrmIncluirPerfil.GetNewIdUser: Integer;
var
  TempDs: TDataset;
begin
  with FUserControl do
    TempDs := DataConnector.UCGetSQLDataSet('SELECT ' + TableUsers.FieldUserID +
      ' as MaxUserID from ' + TableUsers.TableName + ' ORDER BY ' +
      TableUsers.FieldUserID + ' DESC');
  try
    Result := TempDs.FieldByName('MaxUserID').AsInteger + 1;
  finally
    TempDs.Free;
  end;
end;

procedure TfrmIncluirPerfil.IncluiPerfil;
var
  FProfile: String;
begin
  with FUserControl do
  begin
    FNewIdUser := GetNewIdUser;
    FProfile := EditDescricao.Text;

    if Assigned(onAddProfile) then
      onAddProfile(TObject(Self.Owner.Owner), FProfile);

    DataConnector.UCExecSQL
      (Format('INSERT INTO %s(%s, %s, %s) Values(%d,%s,%s)',
      [TableUsers.TableName, TableUsers.FieldUserID, TableUsers.FieldUserName,
      TableUsers.FieldTypeRec, FNewIdUser, QuotedStr(FProfile),
      QuotedStr('P')]));

  end;
end;

end.
