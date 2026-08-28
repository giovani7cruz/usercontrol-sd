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
unit UCSettings;

interface

uses
  Classes,
  Forms,

  UCMessages,
  UcConsts_Language,
  UCDataConnector;

type
  TUCSettings = class(TComponent)
  private
    FUserCommomMSG: TUCUserCommonMSG;
    FLoginFormMSG: TUCLoginFormMSG;
    FCadUserFormMSG: TUCCadUserFormMSG;
    FAddUserFormMSG: TUCAddUserFormMSG;
    FPermissFormMSG: TUCPermissFormMSG;
    FTrocaSenhaFormMSG: TUCTrocaSenhaFormMSG;
    FResetPassword: TUCResetPassword;
    FProfileUserFormMSG: TUCProfileUserFormMSG;
    FAddProfileFormMSG: TUCAddProfileFormMSG;
    FLogControlFormMSG: TUCLogControlFormMSG;
    FAppMessagesMSG: TUCAppMessagesMSG;
    FPosition: TPosition;
    fLanguage: TUCLanguage;
    fUsersLogged: TUCCadUserLoggedMSG;
    fBancoDados: TUCTypeBancoDados;
    procedure SetFResetPassword(const Value: TUCResetPassword);
    procedure SetFProfileUserFormMSG(const Value: TUCProfileUserFormMSG);
    procedure SetFAddProfileFormMSG(const Value: TUCAddProfileFormMSG);
    procedure SetFLogControlFormMSG(const Value: TUCLogControlFormMSG);
    procedure SetAppMessagesMSG(const Value: TUCAppMessagesMSG);
    procedure SetfLanguage(const Value: TUCLanguage);
    procedure SetfUsersLogged(const Value: TUCCadUserLoggedMSG);
    procedure SetfBancoDados(const Value: TUCTypeBancoDados);
  protected
    procedure SetFUserCommonMSG(const Value: TUCUserCommonMSG);
    procedure SetFFormLoginMSG(const Value: TUCLoginFormMSG);
    procedure SetFCadUserFormMSG(const Value: TUCCadUserFormMSG);
    procedure SetFAddUserFormMSG(const Value: TUCAddUserFormMSG);
    procedure SetFPermissFormMSG(const Value: TUCPermissFormMSG);
    procedure SetFTrocaSenhaFormMSG(const Value: TUCTrocaSenhaFormMSG);
  public
    Type_Int, Type_Char, Type_VarChar, Type_Memo, Type_Blob: String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property AppMessages: TUCAppMessagesMSG read FAppMessagesMSG write SetAppMessagesMSG;
    property CommonMessages: TUCUserCommonMSG read FUserCommomMSG write SetFUserCommonMSG;
    property Login: TUCLoginFormMSG read FLoginFormMSG write SetFFormLoginMSG;
    property Log: TUCLogControlFormMSG read FLogControlFormMSG write SetFLogControlFormMSG;
    property UsersForm: TUCCadUserFormMSG read FCadUserFormMSG write SetFCadUserFormMSG;
    property AddChangeUser: TUCAddUserFormMSG read FAddUserFormMSG write SetFAddUserFormMSG;
    property AddChangeProfile: TUCAddProfileFormMSG read FAddProfileFormMSG write SetFAddProfileFormMSG;
    property UsersProfile: TUCProfileUserFormMSG read FProfileUserFormMSG write SetFProfileUserFormMSG;
    property Rights: TUCPermissFormMSG read FPermissFormMSG write SetFPermissFormMSG;
    property ChangePassword: TUCTrocaSenhaFormMSG read FTrocaSenhaFormMSG write SetFTrocaSenhaFormMSG;
    property ResetPassword: TUCResetPassword read FResetPassword write SetFResetPassword;
    property WindowsPosition: TPosition read FPosition write FPosition default poMainFormCenter;
    property BancoDados: TUCTypeBancoDados read fBancoDados write SetfBancoDados;
    property Language: TUCLanguage read fLanguage write SetfLanguage;
    property UsersLogged: TUCCadUserLoggedMSG read fUsersLogged write SetfUsersLogged;
  end;

  TUCUserSettings = class(TUCSettings)
  public
    procedure Assign(Source: TPersistent); override;
  end;

procedure IniSettings(DestSettings: TUCSettings);

procedure AlterLanguage(DestSettings: TUCUserSettings);

procedure RetornaSqlBancoDados(fBanco: TUCTypeBancoDados; var Int, Char, VarChar, Memo, Blob: String);

implementation

uses
  Graphics,
  SysUtils,

  UCBase;


{$IFDEF DELPHI9_UP} {$REGION 'Inicializacao'} {$ENDIF}

procedure RetornaSqlBancoDados(fBanco: TUCTypeBancoDados; var Int, Char, VarChar, Memo, Blob: String);
begin
  Int := 'INT';
  Char := 'CHAR';
  VarChar := 'VARCHAR';

  case fBanco of
    Firebird:
      Memo := 'BLOB SUB_TYPE 1 SEGMENT SIZE 1024';
    Interbase:
      Memo := 'BLOB SUB_TYPE 1 SEGMENT SIZE 1024';
    MySql:
      Memo := 'MEDIUMBLOB';
    PARADOX:
      Memo := 'BLOB(1024,1)';
    Oracle:
      Memo := 'LONG RAW';
    SqlServer:
      Memo := 'NTEXT';
    PostgreSQL:
      Memo := 'TEXT';
  end;

  case fBanco of
    Firebird:
      Blob := 'BLOB SUB_TYPE 0 SEGMENT SIZE 1024';
    Interbase:
      Blob := 'BLOB SUB_TYPE 0 SEGMENT SIZE 1024';
    MySql:
      Blob := 'LONGBLOB';
    PARADOX:
      Blob := 'BLOB(1024,1)';
    Oracle:
      Blob := 'LONG RAW';
    SqlServer:
      Blob := 'binary';
    PostgreSQL:
      Blob := 'BYTEA';
  end;

end;

procedure IniSettings(DestSettings: TUCSettings);
var
  tmp: TBitmap;
begin
  with DestSettings.CommonMessages do
  begin
    BlankPassword := GetTranslate(DestSettings.Language, BlankPassword, 'Const_Men_SenhaDesabitada');
    PasswordChanged := GetTranslate(DestSettings.Language, PasswordChanged, 'Const_Men_SenhaAlterada');
    InitialMessage.Text := GetTranslate(DestSettings.Language, InitialMessage.Text, 'Const_Men_MsgInicial');
    MaxLoginAttemptsError := GetTranslate(DestSettings.Language, MaxLoginAttemptsError, 'Const_Men_MaxTentativas');
    InvalidLogin := GetTranslate(DestSettings.Language, InvalidLogin, 'Const_Men_LoginInvalido');
    InactiveLogin := GetTranslate(DestSettings.Language, InactiveLogin, 'Const_Men_LoginInativo');
    AutoLogonError := GetTranslate(DestSettings.Language, AutoLogonError, 'Const_Men_AutoLogonError');
    UsuarioExiste := GetTranslate(DestSettings.Language, UsuarioExiste, 'Const_Men_UsuarioExiste');
    PasswordExpired := GetTranslate(DestSettings.Language, PasswordExpired, 'Const_Men_PasswordExpired');
    ForcaTrocaSenha := GetTranslate(DestSettings.Language, ForcaTrocaSenha, 'Const_ErrPass_ForcaTrocaSenha');
    InvalidLogin := GetTranslate(DestSettings.Language, InvalidLogin, 'Const_Men_Select_Profile');
    CanNotDeleteUserLogon := GetTranslate(DestSettings.Language, CanNotDeleteUserLogon, 'Const_Men_Cannot_Del_User_Logon');
    ImageTooLarge := GetTranslate(DestSettings.Language, ImageTooLarge, 'Const_Err_Image_Too_Large');
  end;

  with DestSettings.Login do
  begin
    BtCancel := GetTranslate(DestSettings.Language, BtCancel, 'Const_Log_BtCancelar');
    BtOK := GetTranslate(DestSettings.Language, BtOK, 'Const_Log_BtOK');
    LabelPassword := GetTranslate(DestSettings.Language, LabelPassword, 'Const_Log_LabelSenha');
    LabelUser := GetTranslate(DestSettings.Language, LabelUser, 'Const_Log_LabelUsuario');
    WindowCaption := GetTranslate(DestSettings.Language, WindowCaption, 'Const_Log_WindowCaption');
    LabelTentativa := GetTranslate(DestSettings.Language, LabelTentativa, 'Const_Log_LabelTentativa');
    LabelTentativas := GetTranslate(DestSettings.Language, LabelTentativas, 'Const_Log_LabelTentativas');

    try
      tmp := TBitmap.Create;
      tmp.LoadFromResourceName(HInstance, 'UCLOCKLOGIN');
      LeftImage.Assign(tmp);
    finally
      FreeAndNil(tmp);
    end;
  end;

  with DestSettings.UsersForm do
  begin
    WindowCaption := GetTranslate(DestSettings.Language, WindowCaption, 'Const_Cad_WindowCaption');
    LabelDescription := GetTranslate(DestSettings.Language, LabelDescription, 'Const_Cad_LabelDescricao');
    ColName := GetTranslate(DestSettings.Language, ColName, 'Const_Cad_ColunaNome');
    ColLogin := GetTranslate(DestSettings.Language, ColLogin, 'Const_Cad_ColunaLogin');
    ColEmail := GetTranslate(DestSettings.Language, ColEmail, 'Const_Cad_ColunaEmail');
    BtAdd := GetTranslate(DestSettings.Language, BtAdd, 'Const_Cad_BtAdicionar');
    BtChange := GetTranslate(DestSettings.Language, BtChange, 'Const_Cad_BtAlterar');
    BtDelete := GetTranslate(DestSettings.Language, BtDelete, 'Const_Cad_BtExcluir');
    BtRights := GetTranslate(DestSettings.Language, BtRights, 'Const_Cad_BtPermissoes');
    BtPassword := GetTranslate(DestSettings.Language, BtPassword, 'Const_Cad_BtSenha');
    BtClose := GetTranslate(DestSettings.Language, BtClose, 'Const_Cad_BtFechar');
    PromptDelete := GetTranslate(DestSettings.Language, PromptDelete, 'Const_Cad_ConfirmaExcluir');
    PromptDelete_WindowCaption := GetTranslate(DestSettings.Language, PromptDelete_WindowCaption, 'Const_Cad_ConfirmaDelete_WindowCaption');
    BtApplyFilter := GetTranslate(DestSettings.Language, BtApplyFilter, 'Const_Cad_BtApplyFilter');
    BtRemoveFilter := GetTranslate(DestSettings.Language, BtRemoveFilter, 'Const_Cad_BtRemoveFilter');
    ShowInactive := GetTranslate(DestSettings.Language, ShowInactive, 'Const_Cad_ShowInactive');
  end;

  with DestSettings.UsersProfile do
  begin
    WindowCaption := GetTranslate(DestSettings.Language, WindowCaption, 'Const_Prof_WindowCaption');
    LabelDescription := GetTranslate(DestSettings.Language, LabelDescription, 'Const_Prof_LabelDescricao');
    ColProfile := GetTranslate(DestSettings.Language, ColProfile, 'Const_Prof_ColunaNome');
    BtAdd := GetTranslate(DestSettings.Language, BtAdd, 'Const_Prof_BtAdicionar');
    BtChange := GetTranslate(DestSettings.Language, BtChange, 'Const_Prof_BtAlterar');
    BtDelete := GetTranslate(DestSettings.Language, BtDelete, 'Const_Prof_BtExcluir');
    BtRights := GetTranslate(DestSettings.Language, BtRights, 'Const_Prof_BtPermissoes');
    BtClose := GetTranslate(DestSettings.Language, BtClose, 'Const_Prof_BtFechar');
    PromptDelete := GetTranslate(DestSettings.Language, PromptDelete, 'Const_Prof_ConfirmaExcluir');
    PromptDelete_WindowCaption := GetTranslate(DestSettings.Language, PromptDelete_WindowCaption, 'Const_Prof_ConfirmaDelete_WindowCaption');
  end;

  with DestSettings.AddChangeUser do
  begin
    WindowCaption := GetTranslate(DestSettings.Language, WindowCaption, 'Const_Inc_WindowCaption');
    LabelAdd := GetTranslate(DestSettings.Language, LabelAdd, 'Const_Inc_LabelAdicionar');
    LabelChange := GetTranslate(DestSettings.Language, LabelChange, 'Const_Inc_LabelAlterar');
    LabelName := GetTranslate(DestSettings.Language, LabelName, 'Const_Inc_LabelNome');
    LabelLogin := GetTranslate(DestSettings.Language, LabelLogin, 'Const_Inc_LabelLogin');
    LabelEmail := GetTranslate(DestSettings.Language, LabelEmail, 'Const_Inc_LabelEmail');
    LabelPerfil := GetTranslate(DestSettings.Language, LabelPerfil, 'Const_Inc_LabelPerfil');
    CheckPrivileged := GetTranslate(DestSettings.Language, CheckPrivileged, 'Const_Inc_CheckPrivilegiado');
    BtSave := GetTranslate(DestSettings.Language, BtSave, 'Const_Inc_BtGravar');
    BtCancel := GetTranslate(DestSettings.Language, BtCancel, 'Const_Inc_BtCancelar');
    CheckExpira := GetTranslate(DestSettings.Language, CheckExpira, 'Const_Inc_CheckEspira');
    Day := GetTranslate(DestSettings.Language, Day, 'Const_Inc_Dia');
    ExpiredIn := GetTranslate(DestSettings.Language, ExpiredIn, 'Const_Inc_ExpiraEm');
    LabelStatus := GetTranslate(DestSettings.Language, LabelStatus, 'Const_Inc_LabelStatus');
    StatusActive := GetTranslate(DestSettings.Language, StatusActive, 'Const_Inc_StatusActive');
    StatusDisabled := GetTranslate(DestSettings.Language, StatusDisabled, 'Const_Inc_StatusDisabled');
    LabelImage := GetTranslate(DestSettings.Language, LabelImage, 'Const_Inc_LabelImage');
    BtLoadImage := GetTranslate(DestSettings.Language, BtLoadImage, 'Const_Inc_BtLoadImage');
    BtRemoveImage := GetTranslate(DestSettings.Language, BtRemoveImage, 'Const_Inc_BtRemoveImage');
  end;

  with DestSettings.AddChangeProfile do
  begin
    WindowCaption := GetTranslate(DestSettings.Language, WindowCaption, 'Const_PInc_WindowCaption');
    LabelAdd := GetTranslate(DestSettings.Language, LabelAdd, 'Const_PInc_LabelAdicionar');
    LabelChange := GetTranslate(DestSettings.Language, LabelChange, 'Const_PInc_LabelAlterar');
    LabelName := GetTranslate(DestSettings.Language, LabelName, 'Const_PInc_LabelNome');
    BtSave := GetTranslate(DestSettings.Language, BtSave, 'Const_PInc_BtGravar');
    BtCancel := GetTranslate(DestSettings.Language, BtCancel, 'Const_PInc_BtCancelar');
  end;

  with DestSettings.Rights do
  begin
    WindowCaption := GetTranslate(DestSettings.Language, WindowCaption, 'Const_Perm_WindowCaption');
    LabelUser := GetTranslate(DestSettings.Language, LabelUser, 'Const_Perm_LabelUsuario');
    LabelProfile := GetTranslate(DestSettings.Language, LabelProfile, 'Const_Perm_LabelPerfil');
    PageMenu := GetTranslate(DestSettings.Language, PageMenu, 'Const_Perm_PageMenu');
    PageActions := GetTranslate(DestSettings.Language, PageActions, 'Const_Perm_PageActions');
    PageControls := GetTranslate(DestSettings.Language, PageControls, 'Const_Perm_PageControls');
    SearchLabel := GetTranslate(DestSettings.Language, SearchLabel, 'Const_Perm_SearchLabel');
    SearchNext := GetTranslate(DestSettings.Language, SearchNext, 'Const_Perm_SearchNext');
    SearchNoResults := GetTranslate(DestSettings.Language, SearchNoResults, 'Const_Perm_SearchNoResults');
    SearchInherited := GetTranslate(DestSettings.Language, SearchInherited, 'Const_Perm_SearchInherited');
    BtUnlock := GetTranslate(DestSettings.Language, BtUnlock, 'Const_Perm_BtLibera');
    BtLock := GetTranslate(DestSettings.Language, BtLock, 'Const_Perm_BtBloqueia');
    BtSave := GetTranslate(DestSettings.Language, BtSave, 'Const_Perm_BtGravar');
    BtCancel := GetTranslate(DestSettings.Language, BtCancel, 'Const_Perm_BtCancelar');
  end;

  with DestSettings.ChangePassword do
  begin
    WindowCaption := GetTranslate(DestSettings.Language, WindowCaption, 'Const_Troc_WindowCaption');
    LabelDescription := GetTranslate(DestSettings.Language, LabelDescription, 'Const_Troc_LabelDescricao');
    LabelCurrentPassword := GetTranslate(DestSettings.Language, LabelCurrentPassword, 'Const_Troc_LabelSenhaAtual');
    LabelNewPassword := GetTranslate(DestSettings.Language, LabelNewPassword, 'Const_Troc_LabelNovaSenha');
    LabelConfirm := GetTranslate(DestSettings.Language, LabelConfirm, 'Const_Troc_LabelConfirma');
    BtSave := GetTranslate(DestSettings.Language, BtSave, 'Const_Troc_BtGravar');
    BtCancel := GetTranslate(DestSettings.Language, BtCancel, 'Const_Troc_BtCancelar');
  end;

  with DestSettings.CommonMessages.ChangePasswordError do
  begin
    if InvalidCurrentPassword = '' then
      InvalidCurrentPassword := RetornaLingua(DestSettings.fLanguage, 'Const_ErrPass_SenhaAtualInvalida');
    if NewPasswordError = '' then
      NewPasswordError := RetornaLingua(DestSettings.fLanguage, 'Const_ErrPass_ErroNovaSenha');
    if NewEqualCurrent = '' then
      NewEqualCurrent := RetornaLingua(DestSettings.fLanguage, 'Const_ErrPass_NovaIgualAtual');
    if PasswordRequired = '' then
      PasswordRequired := RetornaLingua(DestSettings.fLanguage, 'Const_ErrPass_SenhaObrigatoria');
    if MinPasswordLength = '' then
      MinPasswordLength := RetornaLingua(DestSettings.fLanguage, 'Const_ErrPass_SenhaMinima');
    if InvalidNewPassword = '' then
      InvalidNewPassword := RetornaLingua(DestSettings.fLanguage, 'Const_ErrPass_SenhaInvalida');
  end;

  with DestSettings.ResetPassword do
  begin
    if WindowCaption = '' then
      WindowCaption := RetornaLingua(DestSettings.fLanguage, 'Const_DefPass_WindowCaption');
    if LabelPassword = '' then
      LabelPassword := RetornaLingua(DestSettings.fLanguage, 'Const_DefPass_LabelSenha');
  end;

  with DestSettings.Log do
  begin
    if WindowCaption = '' then
      WindowCaption := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_WindowCaption');
    if LabelDescription = '' then
      LabelDescription := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_LabelDescricao');
    if LabelUser = '' then
      LabelUser := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_LabelUsuario');
    if LabelDate = '' then
      LabelDate := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_LabelData');
    if LabelLevel = '' then
      LabelLevel := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_LabelNivel');
    if ColLevel = '' then
      ColLevel := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_ColunaNivel');
    if ColAppID = '' then
      ColAppID := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_ColunaAppID');
    if ColMessage = '' then
      ColMessage := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_ColunaMensagem');
    if ColUser = '' then
      ColUser := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_ColunaUsuario');
    if ColDate = '' then
      ColDate := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_ColunaData');
    if BtFilter = '' then
      BtFilter := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_BtFiltro');
    if BtDelete = '' then
      BtDelete := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_BtExcluir');
    if BtClose = '' then
      BtClose := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_BtFechar');
    if PromptDelete = '' then
      PromptDelete := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_ConfirmaExcluir');
    if PromptDelete_WindowCaption = '' then
      PromptDelete_WindowCaption := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_ConfirmaDelete_WindowCaption'); // added by fduenas
    if OptionUserAll = '' then
      OptionUserAll := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_Todos'); // added by fduenas
    if OptionLevelLow = '' then
      OptionLevelLow := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_Low');
    // added by fduenas
    if OptionLevelNormal = '' then
      OptionLevelNormal := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_Normal'); // added by fduenas
    if OptionLevelHigh = '' then
      OptionLevelHigh := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_High'); // added by fduenas
    if OptionLevelCritic = '' then
      OptionLevelCritic := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_Critic'); // added by fduenas
    if DeletePerformed = '' then
      DeletePerformed := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_ExcluirEfectuada'); // added by fduenas
    if LabelDetail = '' then
      LabelDetail := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_LabelDetail');
    if BtCopy = '' then
      BtCopy := RetornaLingua(DestSettings.fLanguage, 'Const_LogC_BtCopy');
  end;

  with DestSettings.AppMessages do
  begin
    if MsgsForm_BtNew = '' then
      MsgsForm_BtNew := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_BtNew');
    if MsgsForm_BtReplay = '' then
      MsgsForm_BtReplay := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_BtReplay');
    if MsgsForm_BtForward = '' then
      MsgsForm_BtForward := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_BtForward');
    if MsgsForm_BtDelete = '' then
      MsgsForm_BtDelete := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_BtDelete');
    if MsgsForm_BtClose = '' then
      MsgsForm_BtClose := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_BtClose'); // added by fduenas
    if MsgsForm_WindowCaption = '' then
      MsgsForm_WindowCaption := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_WindowCaption');
    if MsgsForm_ColFrom = '' then
      MsgsForm_ColFrom := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_ColFrom');
    if MsgsForm_ColSubject = '' then
      MsgsForm_ColSubject := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_ColSubject');
    if MsgsForm_ColDate = '' then
      MsgsForm_ColDate := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_ColDate');
    if MsgsForm_PromptDelete = '' then
      MsgsForm_PromptDelete := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_PromptDelete');
    if MsgsForm_PromptDelete_WindowCaption = '' then
      MsgsForm_PromptDelete_WindowCaption := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_PromptDelete_WindowCaption'); // added by fduenas
    if MsgsForm_NoMessagesSelected = '' then
      MsgsForm_NoMessagesSelected := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_NoMessagesSelected'); // added by fduenas
    if MsgsForm_NoMessagesSelected_WindowCaption = '' then
      MsgsForm_NoMessagesSelected_WindowCaption := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_NoMessagesSelected_WindowCaption'); // added by fduenas
    if MsgRec_BtClose = '' then
      MsgRec_BtClose := RetornaLingua(DestSettings.fLanguage, 'Const_MsgRec_BtClose');
    if MsgRec_WindowCaption = '' then
      MsgRec_WindowCaption := RetornaLingua(DestSettings.fLanguage, 'Const_MsgRec_WindowCaption');
    if MsgRec_Title = '' then
      MsgRec_Title := RetornaLingua(DestSettings.fLanguage, 'Const_MsgRec_Title');
    if MsgRec_LabelFrom = '' then
      MsgRec_LabelFrom := RetornaLingua(DestSettings.fLanguage, 'Const_MsgRec_LabelFrom');
    if MsgRec_LabelDate = '' then
      MsgRec_LabelDate := RetornaLingua(DestSettings.fLanguage, 'Const_MsgRec_LabelDate');
    if MsgRec_LabelSubject = '' then
      MsgRec_LabelSubject := RetornaLingua(DestSettings.fLanguage, 'Const_MsgRec_LabelSubject');
    if MsgRec_LabelMessage = '' then
      MsgRec_LabelMessage := RetornaLingua(DestSettings.fLanguage, 'Const_MsgRec_LabelMessage');
    if MsgSend_BtSend = '' then
      MsgSend_BtSend := RetornaLingua(DestSettings.fLanguage, 'Const_MsgSend_BtSend');
    if MsgSend_BtCancel = '' then
      MsgSend_BtCancel := RetornaLingua(DestSettings.fLanguage, 'Const_MsgSend_BtCancel');
    if MsgSend_WindowCaption = '' then
      MsgSend_WindowCaption := RetornaLingua(DestSettings.fLanguage, 'Const_MsgSend_WindowCaption');
    if MsgSend_Title = '' then
      MsgSend_Title := RetornaLingua(DestSettings.fLanguage, 'Const_MsgSend_Title');
    if MsgSend_GroupTo = '' then
      MsgSend_GroupTo := RetornaLingua(DestSettings.fLanguage, 'Const_MsgSend_GroupTo');
    if MsgSend_RadioUser = '' then
      MsgSend_RadioUser := RetornaLingua(DestSettings.fLanguage, 'Const_MsgSend_RadioUser');
    if MsgSend_RadioAll = '' then
      MsgSend_RadioAll := RetornaLingua(DestSettings.fLanguage, 'Const_MsgSend_RadioAll');
    if MsgSend_GroupMessage = '' then
      MsgSend_GroupMessage := RetornaLingua(DestSettings.fLanguage, 'Const_MsgSend_GroupMessage');
    if MsgSend_LabelSubject = '' then
      MsgSend_LabelSubject := RetornaLingua(DestSettings.fLanguage, 'Const_MsgSend_LabelSubject'); // added by fduenas
    if MsgSend_LabelMessageText = '' then
      MsgSend_LabelMessageText := RetornaLingua(DestSettings.fLanguage, 'Const_MsgSend_LabelMessageText'); // added by fduenas
  end;

  DestSettings.WindowsPosition := poMainFormCenter;

  with DestSettings.UsersLogged do
  Begin
    if BtnMessage = '' then
      BtnMessage := RetornaLingua(DestSettings.fLanguage, 'Const_UserLogged_BtnMsg');
    if BtnRefresh = '' then
      BtnRefresh := RetornaLingua(DestSettings.fLanguage, 'Const_UserLogged_Refresh');
    if Btnclose = '' then
      Btnclose := RetornaLingua(DestSettings.fLanguage, 'Const_Msgs_BtClose');
    if LabelDescricao = '' then
      LabelDescricao := RetornaLingua(DestSettings.fLanguage, 'Const_UserLogged_LabelDescricao');
    if LabelCaption = '' then
      LabelCaption := RetornaLingua(DestSettings.fLanguage, 'Const_UserLogged_LabelCaption');
    if ColName = '' then
      ColName := RetornaLingua(DestSettings.fLanguage, 'Const_Cad_ColunaNome');
    if ColLogin = '' then
      ColLogin := RetornaLingua(DestSettings.fLanguage, 'Const_Cad_ColunaLogin');
    if ColComputer = '' then
      ColComputer := RetornaLingua(DestSettings.fLanguage, 'Const_CadColuna_Computer');
    if ColData = '' then
      ColData := RetornaLingua(DestSettings.fLanguage, 'Const_CadColuna_Data');
    if InputCaption = '' then
      InputCaption := RetornaLingua(DestSettings.fLanguage, 'Const_UserLogged_InputCaption');
    if InputText = '' then
      InputText := RetornaLingua(DestSettings.fLanguage, 'Const_UserLogged_InputText');
    if MsgSystem = '' then
      MsgSystem := RetornaLingua(DestSettings.fLanguage, 'Const_UserLogged_MsgSystem');
    if BtnRemove = '' then
      BtnRemove := RetornaLingua(DestSettings.fLanguage,
        'Const_UserLogged_Remove');
    if MenuRemoveAll = '' then
      MenuRemoveAll := RetornaLingua(DestSettings.fLanguage,
        'Const_UserLogged_RemoveAll');
    if PromptRemove = '' then
      PromptRemove := RetornaLingua(DestSettings.fLanguage,
        'Const_UserLogged_PromptRemove');
    if PromptRemoveAll = '' then
      PromptRemoveAll := RetornaLingua(DestSettings.fLanguage,
        'Const_UserLogged_PromptRemoveAll');
  end;
end;

{ ------------------------------------------------------------------------------- }

procedure AlterLanguage(DestSettings: TUCUserSettings);
begin
  with DestSettings.CommonMessages do
  begin
    BlankPassword := GetTranslate(DestSettings.Language, '', 'Const_Men_SenhaDesabitada');
    PasswordChanged := GetTranslate(DestSettings.Language, '', 'Const_Men_SenhaAlterada');
    InitialMessage.Text := GetTranslate(DestSettings.Language, '', 'Const_Men_MsgInicial');
    MaxLoginAttemptsError := GetTranslate(DestSettings.Language, '', 'Const_Men_MaxTentativas');
    InvalidLogin := GetTranslate(DestSettings.Language, '', 'Const_Men_LoginInvalido');
    InactiveLogin := GetTranslate(DestSettings.Language, '', 'Const_Men_LoginInativo');
    AutoLogonError := GetTranslate(DestSettings.Language, '', 'Const_Men_AutoLogonError');
    UsuarioExiste := GetTranslate(DestSettings.Language, '', 'Const_Men_UsuarioExiste');
    PasswordExpired := GetTranslate(DestSettings.Language, '', 'Const_Men_PasswordExpired');
    ForcaTrocaSenha := GetTranslate(DestSettings.Language, '', 'Const_ErrPass_ForcaTrocaSenha');
    InvalidProfile := GetTranslate(DestSettings.Language, '', 'Const_Men_Select_Profile');
    CanNotDeleteUserLogon := GetTranslate(DestSettings.Language, '', 'Const_Men_Cannot_Del_User_Logon');
    ImageTooLarge := GetTranslate(DestSettings.Language, '', 'Const_Err_Image_Too_Large');
  end;

  with DestSettings.Login do
  begin
    BtCancel := GetTranslate(DestSettings.Language, '', 'Const_Log_BtCancelar');
    BtOK := GetTranslate(DestSettings.Language, '', 'Const_Log_BtOK');
    LabelPassword := GetTranslate(DestSettings.Language, '', 'Const_Log_LabelSenha');
    LabelUser := GetTranslate(DestSettings.Language, '', 'Const_Log_LabelUsuario');
    WindowCaption := GetTranslate(DestSettings.Language, '', 'Const_Log_WindowCaption');
    LabelTentativa := GetTranslate(DestSettings.Language, '', 'Const_Log_LabelTentativa');
    LabelTentativas := GetTranslate(DestSettings.Language, '', 'Const_Log_LabelTentativas');
  end;

  with DestSettings.UsersForm do
  begin
    WindowCaption := GetTranslate(DestSettings.Language, '', 'Const_Cad_WindowCaption');
    LabelDescription := GetTranslate(DestSettings.Language, '', 'Const_Cad_LabelDescricao');
    ColName := GetTranslate(DestSettings.Language, '', 'Const_Cad_ColunaNome');
    ColLogin := GetTranslate(DestSettings.Language, '', 'Const_Cad_ColunaLogin');
    ColEmail := GetTranslate(DestSettings.Language, '', 'Const_Cad_ColunaEmail');
    BtAdd := GetTranslate(DestSettings.Language, '', 'Const_Cad_BtAdicionar');
    BtChange := GetTranslate(DestSettings.Language, '', 'Const_Cad_BtAlterar');
    BtDelete := GetTranslate(DestSettings.Language, '', 'Const_Cad_BtExcluir');
    BtRights := GetTranslate(DestSettings.Language, '', 'Const_Cad_BtPermissoes');
    BtPassword := GetTranslate(DestSettings.Language, '', 'Const_Cad_BtSenha');
    BtClose := GetTranslate(DestSettings.Language, '', 'Const_Cad_BtFechar');
    PromptDelete := GetTranslate(DestSettings.Language, '', 'Const_Cad_ConfirmaExcluir');
    PromptDelete_WindowCaption := GetTranslate(DestSettings.Language, '', 'Const_Cad_ConfirmaDelete_WindowCaption');
    BtApplyFilter := GetTranslate(DestSettings.Language, '', 'Const_Cad_BtApplyFilter');
    BtRemoveFilter := GetTranslate(DestSettings.Language, '', 'Const_Cad_BtRemoveFilter');
    ShowInactive := GetTranslate(DestSettings.Language, '', 'Const_Cad_ShowInactive');
  end;

  with DestSettings.UsersProfile do
  begin
    WindowCaption := GetTranslate(DestSettings.Language, '', 'Const_Prof_WindowCaption');
    LabelDescription := GetTranslate(DestSettings.Language, '', 'Const_Prof_LabelDescricao');
    ColProfile := GetTranslate(DestSettings.Language, '', 'Const_Prof_ColunaNome');
    BtAdd := GetTranslate(DestSettings.Language, '', 'Const_Prof_BtAdicionar');
    BtChange := GetTranslate(DestSettings.Language, '', 'Const_Prof_BtAlterar');
    BtDelete := GetTranslate(DestSettings.Language, '', 'Const_Prof_BtExcluir');
    BtRights := GetTranslate(DestSettings.Language, '', 'Const_Prof_BtPermissoes');
    BtClose := GetTranslate(DestSettings.Language, '', 'Const_Prof_BtFechar');
    PromptDelete := GetTranslate(DestSettings.Language, '', 'Const_Prof_ConfirmaExcluir');
    PromptDelete_WindowCaption := GetTranslate(DestSettings.Language, '', 'Const_Prof_ConfirmaDelete_WindowCaption');
  end;

  with DestSettings.AddChangeUser do
  begin
    WindowCaption := GetTranslate(DestSettings.Language, '', 'Const_Inc_WindowCaption');
    LabelAdd := GetTranslate(DestSettings.Language, '', 'Const_Inc_LabelAdicionar');
    LabelChange := GetTranslate(DestSettings.Language, '', 'Const_Inc_LabelAlterar');
    LabelName := GetTranslate(DestSettings.Language, '', 'Const_Inc_LabelNome');
    LabelLogin := GetTranslate(DestSettings.Language, '', 'Const_Inc_LabelLogin');
    LabelEmail := GetTranslate(DestSettings.Language, '', 'Const_Inc_LabelEmail');
    LabelPerfil := GetTranslate(DestSettings.Language, '', 'Const_Inc_LabelPerfil');
    CheckPrivileged := GetTranslate(DestSettings.Language, '', 'Const_Inc_CheckPrivilegiado');
    BtSave := GetTranslate(DestSettings.Language, '', 'Const_Inc_BtGravar');
    BtCancel := GetTranslate(DestSettings.Language, '', 'Const_Inc_BtCancelar');
    CheckExpira := GetTranslate(DestSettings.Language, '', 'Const_Inc_CheckEspira');
    Day := GetTranslate(DestSettings.Language, '', 'Const_Inc_Dia');
    ExpiredIn := GetTranslate(DestSettings.Language, '', 'Const_Inc_ExpiraEm');
    LabelStatus := GetTranslate(DestSettings.Language, '', 'Const_Inc_LabelStatus');
    StatusActive := GetTranslate(DestSettings.Language, '', 'Const_Inc_StatusActive');
    StatusDisabled := GetTranslate(DestSettings.Language, '', 'Const_Inc_StatusDisabled');
    LabelImage := GetTranslate(DestSettings.Language, '', 'Const_Inc_LabelImage');
    BtLoadImage := GetTranslate(DestSettings.Language, '', 'Const_Inc_BtLoadImage');
    BtRemoveImage := GetTranslate(DestSettings.Language, '', 'Const_Inc_BtRemoveImage');
  end;

  with DestSettings.AddChangeProfile do
  begin
    WindowCaption := RetornaLingua(DestSettings.Language, 'Const_PInc_WindowCaption');
    LabelAdd := RetornaLingua(DestSettings.Language, 'Const_PInc_LabelAdicionar');
    LabelChange := RetornaLingua(DestSettings.Language, 'Const_PInc_LabelAlterar');
    LabelName := RetornaLingua(DestSettings.Language, 'Const_PInc_LabelNome');
    BtSave := RetornaLingua(DestSettings.Language, 'Const_PInc_BtGravar');
    BtCancel := RetornaLingua(DestSettings.Language, 'Const_PInc_BtCancelar');
  end;

  with DestSettings.Rights do
  begin
    WindowCaption := RetornaLingua(DestSettings.Language, 'Const_Perm_WindowCaption');
    LabelUser := RetornaLingua(DestSettings.Language, 'Const_Perm_LabelUsuario');
    LabelProfile := RetornaLingua(DestSettings.Language, 'Const_Perm_LabelPerfil');
    PageMenu := RetornaLingua(DestSettings.Language, 'Const_Perm_PageMenu');
    PageActions := RetornaLingua(DestSettings.Language, 'Const_Perm_PageActions');
    PageControls := RetornaLingua(DestSettings.Language, 'Const_Perm_PageControls');
    SearchLabel := RetornaLingua(DestSettings.Language, 'Const_Perm_SearchLabel');
    SearchNext := RetornaLingua(DestSettings.Language, 'Const_Perm_SearchNext');
    SearchNoResults := RetornaLingua(DestSettings.Language, 'Const_Perm_SearchNoResults');
    SearchInherited := RetornaLingua(DestSettings.Language, 'Const_Perm_SearchInherited');
    BtUnlock := RetornaLingua(DestSettings.Language, 'Const_Perm_BtLibera');
    BtLock := RetornaLingua(DestSettings.Language, 'Const_Perm_BtBloqueia');
    BtSave := RetornaLingua(DestSettings.Language, 'Const_Perm_BtGravar');
    BtCancel := RetornaLingua(DestSettings.Language, 'Const_Perm_BtCancelar');
  end;

  with DestSettings.ChangePassword do
  begin
    WindowCaption := RetornaLingua(DestSettings.Language, 'Const_Troc_WindowCaption');
    LabelDescription := RetornaLingua(DestSettings.Language, 'Const_Troc_LabelDescricao');
    LabelCurrentPassword := RetornaLingua(DestSettings.Language, 'Const_Troc_LabelSenhaAtual');
    LabelNewPassword := RetornaLingua(DestSettings.Language, 'Const_Troc_LabelNovaSenha');
    LabelConfirm := RetornaLingua(DestSettings.Language, 'Const_Troc_LabelConfirma');
    BtSave := RetornaLingua(DestSettings.Language, 'Const_Troc_BtGravar');
    BtCancel := RetornaLingua(DestSettings.Language, 'Const_Troc_BtCancelar');
  end;

  with DestSettings.CommonMessages.ChangePasswordError do
  begin
    InvalidCurrentPassword := RetornaLingua(DestSettings.Language,
      'Const_ErrPass_SenhaAtualInvalida');
    NewPasswordError := RetornaLingua(DestSettings.Language,
      'Const_ErrPass_ErroNovaSenha');
    NewEqualCurrent := RetornaLingua(DestSettings.Language,
      'Const_ErrPass_NovaIgualAtual');
    PasswordRequired := RetornaLingua(DestSettings.Language,
      'Const_ErrPass_SenhaObrigatoria');
    MinPasswordLength := RetornaLingua(DestSettings.Language,
      'Const_ErrPass_SenhaMinima');
    InvalidNewPassword := RetornaLingua(DestSettings.Language,
      'Const_ErrPass_SenhaInvalida');
  end;

  with DestSettings.ResetPassword do
  begin
    WindowCaption := RetornaLingua(DestSettings.Language,
      'Const_DefPass_WindowCaption');
    LabelPassword := RetornaLingua(DestSettings.Language, 'Const_DefPass_LabelSenha');
  end;

  with DestSettings.Log do
  begin
    WindowCaption := RetornaLingua(DestSettings.Language, 'Const_LogC_WindowCaption');
    LabelDescription := RetornaLingua(DestSettings.Language,
      'Const_LogC_LabelDescricao');
    LabelUser := RetornaLingua(DestSettings.Language, 'Const_LogC_LabelUsuario');
    LabelDate := RetornaLingua(DestSettings.Language, 'Const_LogC_LabelData');
    LabelLevel := RetornaLingua(DestSettings.Language, 'Const_LogC_LabelNivel');
    ColLevel := RetornaLingua(DestSettings.Language, 'Const_LogC_ColunaNivel');
    ColAppID := RetornaLingua(DestSettings.Language, 'Const_LogC_ColunaAppID');
    ColMessage := RetornaLingua(DestSettings.Language, 'Const_LogC_ColunaMensagem');
    ColUser := RetornaLingua(DestSettings.Language, 'Const_LogC_ColunaUsuario');
    ColDate := RetornaLingua(DestSettings.Language, 'Const_LogC_ColunaData');
    BtFilter := RetornaLingua(DestSettings.Language, 'Const_LogC_BtFiltro');
    BtDelete := RetornaLingua(DestSettings.Language, 'Const_LogC_BtExcluir');
    BtClose := RetornaLingua(DestSettings.Language, 'Const_LogC_BtFechar');
    PromptDelete := RetornaLingua(DestSettings.Language,
      'Const_LogC_ConfirmaExcluir');
    PromptDelete_WindowCaption := RetornaLingua(DestSettings.Language,
      'Const_LogC_ConfirmaDelete_WindowCaption');
    OptionUserAll := RetornaLingua(DestSettings.Language, 'Const_LogC_Todos');
    OptionLevelLow := RetornaLingua(DestSettings.Language, 'Const_LogC_Low');
    OptionLevelNormal := RetornaLingua(DestSettings.Language, 'Const_LogC_Normal');
    OptionLevelHigh := RetornaLingua(DestSettings.Language, 'Const_LogC_High');
    OptionLevelCritic := RetornaLingua(DestSettings.Language, 'Const_LogC_Critic');
    DeletePerformed := RetornaLingua(DestSettings.Language,
      'Const_LogC_ExcluirEfectuada');
    LabelDetail := RetornaLingua(DestSettings.Language, 'Const_LogC_LabelDetail');
    BtCopy := RetornaLingua(DestSettings.Language, 'Const_LogC_BtCopy');
  end;

  with DestSettings.AppMessages do
  begin
    MsgsForm_BtNew := RetornaLingua(DestSettings.Language, 'Const_Msgs_BtNew');
    MsgsForm_BtReplay := RetornaLingua(DestSettings.Language, 'Const_Msgs_BtReplay');
    MsgsForm_BtForward := RetornaLingua(DestSettings.Language,
      'Const_Msgs_BtForward');
    MsgsForm_BtDelete := RetornaLingua(DestSettings.Language, 'Const_Msgs_BtDelete');
    MsgsForm_BtClose := RetornaLingua(DestSettings.Language, 'Const_Msgs_BtClose'); // added by fduenas
    MsgsForm_WindowCaption := RetornaLingua(DestSettings.Language,
      'Const_Msgs_WindowCaption');
    MsgsForm_ColFrom := RetornaLingua(DestSettings.Language, 'Const_Msgs_ColFrom');
    MsgsForm_ColSubject := RetornaLingua(DestSettings.Language,
      'Const_Msgs_ColSubject');
    MsgsForm_ColDate := RetornaLingua(DestSettings.Language, 'Const_Msgs_ColDate');
    MsgsForm_PromptDelete := RetornaLingua(DestSettings.Language,
      'Const_Msgs_PromptDelete');
    MsgsForm_PromptDelete_WindowCaption := RetornaLingua(DestSettings.Language,
      'Const_Msgs_PromptDelete_WindowCaption'); // added by fduenas
    MsgsForm_NoMessagesSelected := RetornaLingua(DestSettings.Language,
      'Const_Msgs_NoMessagesSelected'); // added by fduenas
    MsgsForm_NoMessagesSelected_WindowCaption :=
      RetornaLingua(DestSettings.Language,
      'Const_Msgs_NoMessagesSelected_WindowCaption'); // added by fduenas
    MsgRec_BtClose := RetornaLingua(DestSettings.Language, 'Const_MsgRec_BtClose');
    MsgRec_WindowCaption := RetornaLingua(DestSettings.Language,
      'Const_MsgRec_WindowCaption');
    MsgRec_Title := RetornaLingua(DestSettings.Language, 'Const_MsgRec_Title');
    MsgRec_LabelFrom := RetornaLingua(DestSettings.Language,
      'Const_MsgRec_LabelFrom');
    MsgRec_LabelDate := RetornaLingua(DestSettings.Language,
      'Const_MsgRec_LabelDate');
    MsgRec_LabelSubject := RetornaLingua(DestSettings.Language,
      'Const_MsgRec_LabelSubject');
    MsgRec_LabelMessage := RetornaLingua(DestSettings.Language,
      'Const_MsgRec_LabelMessage');
    MsgSend_BtSend := RetornaLingua(DestSettings.Language, 'Const_MsgSend_BtSend');
    MsgSend_BtCancel := RetornaLingua(DestSettings.Language,
      'Const_MsgSend_BtCancel');
    MsgSend_WindowCaption := RetornaLingua(DestSettings.Language,
      'Const_MsgSend_WindowCaption');
    MsgSend_Title := RetornaLingua(DestSettings.Language, 'Const_MsgSend_Title');
    MsgSend_GroupTo := RetornaLingua(DestSettings.Language, 'Const_MsgSend_GroupTo');
    MsgSend_RadioUser := RetornaLingua(DestSettings.Language,
      'Const_MsgSend_RadioUser');
    MsgSend_RadioAll := RetornaLingua(DestSettings.Language,
      'Const_MsgSend_RadioAll');
    MsgSend_GroupMessage := RetornaLingua(DestSettings.Language,
      'Const_MsgSend_GroupMessage');
    MsgSend_LabelSubject := RetornaLingua(DestSettings.Language,
      'Const_MsgSend_LabelSubject'); // added by fduenas
    MsgSend_LabelMessageText := RetornaLingua(DestSettings.Language,
      'Const_MsgSend_LabelMessageText'); // added by fduenas
  end;

  DestSettings.WindowsPosition := poMainFormCenter;

  with DestSettings.UsersLogged do
  Begin
    BtnMessage := RetornaLingua(DestSettings.Language, 'Const_UserLogged_BtnMsg');
    BtnRefresh := RetornaLingua(DestSettings.Language, 'Const_UserLogged_Refresh');
    Btnclose := RetornaLingua(DestSettings.Language, 'Const_Msgs_BtClose');
    LabelDescricao := RetornaLingua(DestSettings.Language,
      'Const_UserLogged_LabelDescricao');
    LabelCaption := RetornaLingua(DestSettings.Language,
      'Const_UserLogged_LabelCaption');
    ColName := RetornaLingua(DestSettings.Language, 'Const_Cad_ColunaNome');
    ColLogin := RetornaLingua(DestSettings.Language, 'Const_Cad_ColunaLogin');
    ColComputer := RetornaLingua(DestSettings.Language, 'Const_CadColuna_Computer');
    ColData := RetornaLingua(DestSettings.Language, 'Const_CadColuna_Data');
    InputCaption := RetornaLingua(DestSettings.Language,
      'Const_UserLogged_InputCaption');
    InputText := RetornaLingua(DestSettings.Language, 'Const_UserLogged_InputText');
    MsgSystem := RetornaLingua(DestSettings.Language, 'Const_UserLogged_MsgSystem');
    BtnRemove := RetornaLingua(DestSettings.Language,
      'Const_UserLogged_Remove');
    MenuRemoveAll := RetornaLingua(DestSettings.Language,
      'Const_UserLogged_RemoveAll');
    PromptRemove := RetornaLingua(DestSettings.Language,
      'Const_UserLogged_PromptRemove');
    PromptRemoveAll := RetornaLingua(DestSettings.Language,
      'Const_UserLogged_PromptRemoveAll');
  end;
end;

{ ------------------------------------------------------------------------------- }

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}
{$IFDEF DELPHI9_UP} {$REGION 'TUCSettings'} {$ENDIF}
{ TUCSettings }

procedure TUCSettings.Assign(Source: TPersistent);
begin
  if Source is TUCUserSettings then
  begin
    Self.CommonMessages.Assign(TUCUserSettings(Source).CommonMessages);
    // modified by fduenas
    Self.AppMessages.Assign(TUCUserSettings(Source).AppMessages);
    // modified by fduenas
    Self.WindowsPosition := WindowsPosition;
  end
  else
    inherited;
end;

constructor TUCSettings.Create(AOwner: TComponent);
begin
  inherited;
  fLanguage := ucPortuguesBr;
  FAppMessagesMSG := TUCAppMessagesMSG.Create(nil);
  FLoginFormMSG := TUCLoginFormMSG.Create(nil);
  FUserCommomMSG := TUCUserCommonMSG.Create(nil);
  FCadUserFormMSG := TUCCadUserFormMSG.Create(nil);
  FAddUserFormMSG := TUCAddUserFormMSG.Create(nil);
  FAddProfileFormMSG := TUCAddProfileFormMSG.Create(nil);
  FPermissFormMSG := TUCPermissFormMSG.Create(nil);
  FProfileUserFormMSG := TUCProfileUserFormMSG.Create(nil);
  FTrocaSenhaFormMSG := TUCTrocaSenhaFormMSG.Create(nil);
  FResetPassword := TUCResetPassword.Create(nil);
  FLogControlFormMSG := TUCLogControlFormMSG.Create(nil);
  fBancoDados := Firebird;
  fUsersLogged := TUCCadUserLoggedMSG.Create(nil);
  FPosition := poMainFormCenter;
  RetornaSqlBancoDados(fBancoDados, Type_Int, Type_Char, Type_VarChar, Type_Memo, Type_Blob);
  if csDesigning in ComponentState then
    IniSettings(Self);
end;

destructor TUCSettings.Destroy;
begin
  SysUtils.FreeAndNil(FAppMessagesMSG);
  SysUtils.FreeAndNil(FLoginFormMSG);
  SysUtils.FreeAndNil(FUserCommomMSG);
  SysUtils.FreeAndNil(FCadUserFormMSG);
  SysUtils.FreeAndNil(FAddUserFormMSG);
  SysUtils.FreeAndNil(FAddProfileFormMSG);
  SysUtils.FreeAndNil(FPermissFormMSG);
  SysUtils.FreeAndNil(FProfileUserFormMSG);
  SysUtils.FreeAndNil(FTrocaSenhaFormMSG);
  SysUtils.FreeAndNil(FResetPassword);
  SysUtils.FreeAndNil(FLogControlFormMSG);
  SysUtils.FreeAndNil(fUsersLogged);
  inherited;
end;

procedure TUCSettings.SetAppMessagesMSG(const Value: TUCAppMessagesMSG);
begin
  FAppMessagesMSG := Value;
end;

procedure TUCSettings.SetFAddProfileFormMSG(const Value: TUCAddProfileFormMSG);
begin
  FAddProfileFormMSG := Value;
end;

procedure TUCSettings.SetFAddUserFormMSG(const Value: TUCAddUserFormMSG);
begin
  FAddUserFormMSG := Value;
end;

procedure TUCSettings.SetfBancoDados(const Value: TUCTypeBancoDados);
begin
  fBancoDados := Value;
  RetornaSqlBancoDados(fBancoDados, Type_Int, Type_Char, Type_VarChar,
    Type_Memo, Type_Blob);
end;

procedure TUCSettings.SetFCadUserFormMSG(const Value: TUCCadUserFormMSG);
begin
  FCadUserFormMSG := Value;
end;

procedure TUCSettings.SetFFormLoginMsg(const Value: TUCLoginFormMSG);
begin
  FLoginFormMSG := Value;
end;

procedure TUCSettings.SetfLanguage(const Value: TUCLanguage);
begin
  fLanguage := Value;

end;

procedure TUCSettings.SetFLogControlFormMSG(const Value: TUCLogControlFormMSG);
begin
  FLogControlFormMSG := Value;
end;

procedure TUCSettings.SetFPermissFormMSG(const Value: TUCPermissFormMSG);
begin
  FPermissFormMSG := Value;
end;

procedure TUCSettings.SetFProfileUserFormMSG(const Value: TUCProfileUserFormMSG);
begin
  FProfileUserFormMSG := Value;
end;

procedure TUCSettings.SetFResetPassword(const Value: TUCResetPassword);
begin
  FResetPassword := Value;
end;

procedure TUCSettings.SetFTrocaSenhaFormMSG(const Value: TUCTrocaSenhaFormMSG);
begin
  FTrocaSenhaFormMSG := Value;
end;

procedure TUCSettings.SetFUserCommonMSg(const Value: TUCUserCommonMSG);
begin
  FUserCommomMSG := Value;
end;

procedure TUCSettings.SetfUsersLogged(const Value: TUCCadUserLoggedMSG);
begin
  fUsersLogged := Value;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}
{$IFDEF DELPHI9_UP} {$REGION 'TUserSettings'} {$ENDIF}
{ TUserSettings }

procedure TUCUserSettings.Assign(Source: TPersistent);
begin
  if Source is TUCUserSettings then
    Self.CommonMessages.Assign(TUCUserSettings(Source).CommonMessages)
  else
    inherited;
end;

{$IFDEF DELPHI9_UP} {$ENDREGION} {$ENDIF}

end.
