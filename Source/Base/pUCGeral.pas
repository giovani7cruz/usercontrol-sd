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
unit pUCGeral;

interface

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
  StdCtrls,
  SysUtils,
  {$IFDEF FPC}
  {$IFDEF WINDOWS}Windows,{$ELSE}LCLType,{$ENDIF}
  {$ELSE}
  Windows,
  {$ENDIF}

  UcBase;

type
  TFormUserPerf = class(TForm)
    Panel1: TPanel;
    LbDescricao: TLabel;
    Image1: TImage;
    Panel2: TPanel;
    SpeedUser: TSpeedButton;
    SpeedPerfil: TSpeedButton;
    Panel3: TPanel;
    SpeedLog: TSpeedButton;
    SpeedUserLog: TSpeedButton;
    SBSair: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedUserClick(Sender: TObject);
    procedure SpeedPerfilClick(Sender: TObject);
    procedure SpeedLogClick(Sender: TObject);
    procedure SpeedUserLogClick(Sender: TObject);
    procedure SpeedUserMouseEnter(Sender: TObject);
    procedure SpeedUserMouseLeave(Sender: TObject);
    procedure SBSairClick(Sender: TObject);
  protected
    FrmFrame: TCustomFrame;
  private
    procedure GetUser;
    procedure GetGroup;
  public
    FUsercontrol: TUserControl;
    { Public declarations }
  end;

var
  FormUserPerf: TFormUserPerf;

implementation

uses
  pUCFrame_Log,
  pUcFrame_Profile,
  pUcFrame_User,
  pUcFrame_UserLogged,
  UCMessages;

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TFormUserPerf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Self.Release;
end;

procedure TFormUserPerf.FormShow(Sender: TObject);
begin
  GetUser;
  GetGroup;
  if FUsercontrol.CurrentUser.PerfilUsuario <> nil then
  begin
    SpeedPerfil.Visible := FUsercontrol.UserProfile.Active;
    SpeedLog.Visible := FUsercontrol.LogControl.Active;
    SpeedUserLog.Visible := FUsercontrol.UsersLogged.Active;

    SpeedUserClick(Sender);
    Caption := FUsercontrol.UserSettings.UsersForm.WindowCaption;

    SpeedUser.Caption := FUsercontrol.UserSettings.Log.ColUser;
    SpeedPerfil.Caption := FUsercontrol.UserSettings.UsersProfile.ColProfile;
    SpeedUserLog.Caption := FUsercontrol.UserSettings.UsersLogged.LabelDescricao;
  end;
end;

procedure TFormUserPerf.GetGroup;
begin
  FUsercontrol.CurrentUser.PerfilGrupo := nil;
  FUsercontrol.CurrentUser.PerfilGrupo := FUsercontrol.DataConnector.UCGetSQLDataset
    (Format('Select %s as IdUser, %s as Login, %s as Nome, %s as Tipo from %s Where %s  = %s ORDER BY %s',
    [FUsercontrol.TableUsers.FieldUserID, FUsercontrol.TableUsers.FieldLogin, FUsercontrol.TableUsers.FieldUserName,
    FUsercontrol.TableUsers.FieldTypeRec, FUsercontrol.TableUsers.TableName, FUsercontrol.TableUsers.FieldTypeRec,
    QuotedStr('P'), FUsercontrol.TableUsers.FieldUserName]));
end;

procedure TFormUserPerf.GetUser;
begin
  FUsercontrol.CurrentUser.PerfilUsuario := nil;
  try
    FUsercontrol.CurrentUser.PerfilUsuario := FUsercontrol.DataConnector.UCGetSQLDataset(Format(
      ' select ' +
      '   %s as IdUser, %s as Login, %s as Nome, %s as Email, ' +
      '   %s as Perfil, %s as Privilegiado, %s as Tipo, %s as Senha, ' +
      '   %s as UserNaoExpira, %s as DaysOfExpire , %s as UserInative, %s as Image ' +
      ' from ' +
      '   %s ' +
      ' where ' +
      '   %s  = %s ' +
      ' order by ' +
      '   %s',
      [
        FUsercontrol.TableUsers.FieldUserID, FUsercontrol.TableUsers.FieldLogin, FUsercontrol.TableUsers.FieldUserName, FUsercontrol.TableUsers.FieldEmail,
        FUsercontrol.TableUsers.FieldProfile, FUsercontrol.TableUsers.FieldPrivileged, FUsercontrol.TableUsers.FieldTypeRec, FUsercontrol.TableUsers.FieldPassword,
        FUsercontrol.TableUsers.FieldUserExpired, FUsercontrol.TableUsers.FieldUserDaysSun, FUsercontrol.TableUsers.FieldUserInative, FUsercontrol.TableUsers.FieldImage,
        FUsercontrol.TableUsers.TableName,
        FUsercontrol.TableUsers.FieldTypeRec, QuotedStr('U'),
        FUsercontrol.TableUsers.FieldLogin
      ]
    ));
  except
    on E: Exception do
    begin
      if (Pos('TABLE UNKNOWN', UpperCase(E.Message)) = 0) and
        (Pos('COLUMN UNKNOWN', UpperCase(E.Message)) = 0) then
        raise;
    end;
  end;
end;

procedure TFormUserPerf.SpeedPerfilClick(Sender: TObject);
begin
  if FrmFrame is TFrame_Profile then
    Exit;
  if Assigned(FrmFrame) then
    FreeAndNil(FrmFrame);

  GetGroup;

  FrmFrame := TFrame_Profile.Create(Self);
  TFrame_Profile(FrmFrame).DataPerfil.DataSet := FUsercontrol.CurrentUser.PerfilGrupo;
  TFrame_Profile(FrmFrame).Height := Panel3.Height;
  TFrame_Profile(FrmFrame).Width := Panel3.Width;
  TFrame_Profile(FrmFrame).FDataSetPerfilUsuario := FUsercontrol.CurrentUser.PerfilGrupo;
  TFrame_Profile(FrmFrame).FUsercontrol := FUsercontrol;
  TFrame_Profile(FrmFrame).DbGridPerf.Columns[0].Title.Caption := FUsercontrol.UserSettings.UsersProfile.ColProfile;

  with FUsercontrol.UserSettings.UsersProfile, TFrame_Profile(FrmFrame) do
  begin
    LbDescricao.Caption := LabelDescription;
    BtnAddPer.Caption := BtAdd;
    BtnAltPer.Caption := BtChange;
    BtnExcPer.Caption := BtDelete;
    BtnAcePer.Caption := BtRights;
  end;
  FrmFrame.Parent := Panel3;

end;

procedure TFormUserPerf.SpeedUserClick(Sender: TObject);
begin
  if FrmFrame is TUCFrame_User then
    Exit;

  if Assigned(FrmFrame) then
    FreeAndNil(FrmFrame);

  GetUser;
  GetGroup;

  FrmFrame := TUCFrame_User.Create(Self);
  TUCFrame_User(FrmFrame).FDataSetCadastroUsuario := FUsercontrol.CurrentUser.PerfilUsuario;
  TUCFrame_User(FrmFrame).DataUser.DataSet := TUCFrame_User(FrmFrame).FDataSetCadastroUsuario;
  TUCFrame_User(FrmFrame).DataPerfil.DataSet := FUsercontrol.CurrentUser.PerfilGrupo;
  TUCFrame_User(FrmFrame).FUsercontrol := FUsercontrol;
  TUCFrame_User(FrmFrame).Height := Panel3.Height;
  TUCFrame_User(FrmFrame).Width := Panel3.Width;
  TUCFrame_User(FrmFrame).SetWindow;
  LbDescricao.Caption := FUsercontrol.UserSettings.UsersForm.LabelDescription;

  FrmFrame.Parent := Panel3;
end;

procedure TFormUserPerf.SpeedUserLogClick(Sender: TObject);
begin
  if FrmFrame is TUCFrame_UsersLogged then
    Exit;

  if Assigned(FrmFrame) then
    FreeAndNil(FrmFrame);

  FrmFrame := TUCFrame_UsersLogged.Create(Self);
  LbDescricao.Caption := FUsercontrol.UserSettings.UsersLogged.LabelDescricao;
  TUCFrame_UsersLogged(FrmFrame).FUsercontrol := FUsercontrol;
  TUCFrame_UsersLogged(FrmFrame).SetWindow;
  TUCFrame_UsersLogged(FrmFrame).Height := Panel3.Height;
  TUCFrame_UsersLogged(FrmFrame).Width := Panel3.Width;
  FrmFrame.Parent := Panel3;
end;

procedure TFormUserPerf.SpeedUserMouseEnter(Sender: TObject);
begin
  with TSpeedButton(Sender) do
  begin
    Font.Style := [fsUnderline];
    Cursor := crHandPoint;
  end;
end;

procedure TFormUserPerf.SpeedUserMouseLeave(Sender: TObject);
begin
  with TSpeedButton(Sender) do
  begin
    Font.Style := [];
    Cursor := crDefault;
  end;
end;

procedure TFormUserPerf.SBSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFormUserPerf.SpeedLogClick(Sender: TObject);
begin
  if FrmFrame is TUCFrame_Log then
    Exit;

  if Assigned(FrmFrame) then
    FreeAndNil(FrmFrame);

  FrmFrame := TUCFrame_Log.Create(Self);
  LbDescricao.Caption := FUsercontrol.UserSettings.Log.LabelDescription;
  TUCFrame_Log(FrmFrame).FUsercontrol := FUsercontrol;
  TUCFrame_Log(FrmFrame).SetWindow;
  TUCFrame_Log(FrmFrame).Height := Panel3.Height;
  TUCFrame_Log(FrmFrame).Width := Panel3.Width;
  FrmFrame.Parent := Panel3;

end;

end.
