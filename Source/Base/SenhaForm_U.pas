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

unit SenhaForm_U;

interface

{$I 'UserControl.inc'}

uses
  Variants,
  Buttons,
  Classes,
  Controls,
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

  {$IFDEF DELPHIXE2_UP}
  System.UITypes,
  {$ENDIF}

  UCBase,
  UCVisualStyle;

type
  TSenhaForm = class(TForm)
    edtSenha: TEdit;
    edtConfirmaSenha: TEdit;
    btnOK: TBitBtn;
    BtCancel: TBitBtn;
    LabelSenha: TLabel;
    LabelConfirma: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function CompararSenhas(Senha, ConfirmaSenha: String): Boolean;
  public
    fUserControl: TUserControl;
    { Public declarations }
  end;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

{ TSenhaForm }

function TSenhaForm.CompararSenhas(Senha, ConfirmaSenha: String): Boolean;
begin
  Result := False;
  With fUserControl do
  begin
    if (UserPasswordChange.ForcePassword) and (Senha = '') then
      MessageDlg(UserSettings.CommonMessages.ChangePasswordError.
        PasswordRequired, mtWarning, [mbOK], 0)
    else if Length(Senha) < UserPasswordChange.MinPasswordLength then
      MessageDlg(Format(UserSettings.CommonMessages.ChangePasswordError.
        MinPasswordLength, [UserPasswordChange.MinPasswordLength]), mtWarning,
        [mbOK], 0)
    else if Pos(LowerCase(Senha), 'abcdeasdfqwerzxcv1234567890321654987teste' +
      LowerCase(CurrentUser.UserName) + LowerCase(CurrentUser.UserLogin)) > 0
    then
      MessageDlg(UserSettings.CommonMessages.ChangePasswordError.
        InvalidNewPassword, mtWarning, [mbOK], 0)
    else if (Senha <> ConfirmaSenha) then
      MessageDlg(UserSettings.CommonMessages.ChangePasswordError.
        NewPasswordError, mtWarning, [mbOK], 0)
    else
      Result := true;
  End;
end;

procedure TSenhaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSenhaForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not(ModalResult = mrCancel) then
  begin
    CanClose := CompararSenhas(edtSenha.Text, edtConfirmaSenha.Text);
    if not CanClose then
      edtSenha.SetFocus;
  end;
end;

procedure TSenhaForm.FormCreate(Sender: TObject);
begin
  TUCVisualStyle.ApplyForm(Self);
  TUCVisualStyle.StyleEdit(edtSenha);
  TUCVisualStyle.StyleEdit(edtConfirmaSenha);
  TUCVisualStyle.StylePrimaryButton(btnOK);
  TUCVisualStyle.StyleSecondaryButton(BtCancel);
  edtSenha.Clear;
  edtConfirmaSenha.Clear;
end;

procedure TSenhaForm.FormShow(Sender: TObject);
begin
  edtSenha.CharCase := fUserControl.Login.CharCasePass;
  edtConfirmaSenha.CharCase := fUserControl.Login.CharCasePass;
  LabelSenha.Caption := fUserControl.UserSettings.Login.LabelPassword;
  LabelConfirma.Caption := fUserControl.UserSettings.ChangePassword.
    LabelConfirm;
  btnOK.Caption := fUserControl.UserSettings.Login.BtOk;
  BtCancel.Caption := fUserControl.UserSettings.Login.BtCancel;
  TUCVisualStyle.FitButtonWidth(btnOK, 88);
  TUCVisualStyle.FitButtonWidth(BtCancel, 88);
  BtCancel.Left := ClientWidth - BtCancel.Width - 12;
  btnOK.Left := BtCancel.Left - btnOK.Width - 8;
end;

end.
