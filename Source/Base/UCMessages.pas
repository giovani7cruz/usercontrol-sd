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
unit UCMessages;

interface

{$I 'UserControl.inc'}

uses
  Classes, Dialogs, Forms, Graphics, SysUtils, UCConsts_language;

type
  TUCAppMessagesMSG = class(TPersistent)
  private
    FMsgRec_LabelDate: String;
    FMsgsForm_BtBtForward: String;
    Fmsgsform_btnew: String;
    FMsgSend_GroupTo: String;
    FMsgSend_WindowCaption: String;
    FMsgSend_GroupMessage: String;
    FMsgsForm_ColFrom: String;
    FMsgsForm_BtDelete: String;
    FMsgsForm_BtClose: String; // added by fduenas
    FMsgRec_LabelMessage: String;
    FMsgRec_Title: String;
    FMsgSend_RadioAll: String;
    FMsgSend_RadioUser: String;
    FMsgSend_Title: String;
    FMsgsForm_ColSubject: String;
    FMsgRec_LabelFrom: String;
    FMsgsForm_WindowCaption: String;
    FMsgRec_LabelSubject: String;
    FMsgRec_WindowCaption: String;
    FMsgSend_BtSend: String;
    FMsgSend_BtCancel: String;
    FMsgsForm_BtReplay: String;
    FMsgRec_BtClose: String;
    FMsgSend_LabelSubject: String; // added by fduenas
    FMsgSend_LabelMessageText: String; // added by fduenas
    FMsgsForm_PromptDelete: String;
    FMsgsForm_PromptDelete_WindowCaption: String; // added by fduenas
    FMsgsForm_ColDate: String;
    FMsgsForm_NoMessagesSelected: String; // added by fduenas
    FMsgsForm_NoMessagesSelected_WindowCaption: String; // added by fduenas
  protected
  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property MsgsForm_BtNew: String read Fmsgsform_btnew write Fmsgsform_btnew;
    property MsgsForm_BtReplay: String read FMsgsForm_BtReplay
      write FMsgsForm_BtReplay;
    property MsgsForm_BtForward: String read FMsgsForm_BtBtForward
      write FMsgsForm_BtBtForward;
    property MsgsForm_BtDelete: String read FMsgsForm_BtDelete
      write FMsgsForm_BtDelete;
    property MsgsForm_BtClose: String read FMsgsForm_BtClose
      write FMsgsForm_BtClose; // added By fduenas
    property MsgsForm_WindowCaption: String read FMsgsForm_WindowCaption
      write FMsgsForm_WindowCaption;
    property MsgsForm_ColFrom: String read FMsgsForm_ColFrom
      write FMsgsForm_ColFrom;
    property MsgsForm_ColSubject: String read FMsgsForm_ColSubject
      write FMsgsForm_ColSubject;
    property MsgsForm_ColDate: String read FMsgsForm_ColDate
      write FMsgsForm_ColDate;
    property MsgsForm_PromptDelete: String read FMsgsForm_PromptDelete
      write FMsgsForm_PromptDelete;
    property MsgsForm_PromptDelete_WindowCaption: String
      read FMsgsForm_PromptDelete_WindowCaption
      write FMsgsForm_PromptDelete_WindowCaption; // added by fduenas
    property MsgsForm_NoMessagesSelected: String
      read FMsgsForm_NoMessagesSelected write FMsgsForm_NoMessagesSelected;
    // added by fduenas
    property MsgsForm_NoMessagesSelected_WindowCaption: String
      read FMsgsForm_NoMessagesSelected_WindowCaption
      write FMsgsForm_NoMessagesSelected_WindowCaption; // added by fduenas

    property MsgRec_BtClose: String read FMsgRec_BtClose write FMsgRec_BtClose;
    property MsgRec_WindowCaption: String read FMsgRec_WindowCaption
      write FMsgRec_WindowCaption;
    property MsgRec_Title: String read FMsgRec_Title write FMsgRec_Title;
    property MsgRec_LabelFrom: String read FMsgRec_LabelFrom
      write FMsgRec_LabelFrom;
    property MsgRec_LabelDate: String read FMsgRec_LabelDate
      write FMsgRec_LabelDate;
    property MsgRec_LabelSubject: String read FMsgRec_LabelSubject
      write FMsgRec_LabelSubject;
    property MsgRec_LabelMessage: String read FMsgRec_LabelMessage
      write FMsgRec_LabelMessage;

    property MsgSend_BtSend: String read FMsgSend_BtSend write FMsgSend_BtSend;
    property MsgSend_BtCancel: String read FMsgSend_BtCancel
      write FMsgSend_BtCancel;
    property MsgSend_WindowCaption: String read FMsgSend_WindowCaption
      write FMsgSend_WindowCaption;
    property MsgSend_Title: String read FMsgSend_Title write FMsgSend_Title;
    property MsgSend_GroupTo: String read FMsgSend_GroupTo
      write FMsgSend_GroupTo;
    property MsgSend_RadioUser: String read FMsgSend_RadioUser
      write FMsgSend_RadioUser;
    property MsgSend_RadioAll: String read FMsgSend_RadioAll
      write FMsgSend_RadioAll;
    property MsgSend_GroupMessage: String read FMsgSend_GroupMessage
      write FMsgSend_GroupMessage;
    property MsgSend_LabelSubject: String read FMsgSend_LabelSubject
      write FMsgSend_LabelSubject; // added by fduenas
    property MsgSend_LabelMessageText: String read FMsgSend_LabelMessageText
      write FMsgSend_LabelMessageText; // added by fduenas
  end;

  TUCChangePassError = class(TPersistent)
  private
    FInvalidCurrentPassword: String;
    FNewPasswordError: String;
    FNewEqualCurrent: String;
    FPasswordRequired: String;
    FMinPasswordLength: String;
    FInvalidNewPassword: String;
  protected
  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property InvalidCurrentPassword: String read FInvalidCurrentPassword
      write FInvalidCurrentPassword;
    property NewPasswordError: String read FNewPasswordError
      write FNewPasswordError;
    property NewEqualCurrent: String read FNewEqualCurrent
      write FNewEqualCurrent;
    property PasswordRequired: String read FPasswordRequired
      write FPasswordRequired;
    property MinPasswordLength: String read FMinPasswordLength
      write FMinPasswordLength;
    property InvalidNewPassword: String read FInvalidNewPassword
      write FInvalidNewPassword;
  end;

  TUCUserCommonMSG = class(TPersistent)
  private
    FPasswordOFF: String;
    FPasswordChanged: String;
    FInvalidUserPass: String;
    FMaxLoginTry: String;
    FAutoLogonError: String;
    FFirstMSG: TStrings;
    FChangePasswordError: TUCChangePassError;
    FUsuarioExiste: String;
    fPasswordExpired: String;
    fForcaTrocaSenha: String;
    fInactiveLogin: String;
    FCanNotDeleteUserLogon: String;
    FImageTooLarge: String;
    FInvalidProfile: String;
	procedure SetFErroTrocaSenha(const Value: TUCChangePassError);
    procedure SetFFirstMSG(const Value: TStrings);
  protected
  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property AutoLogonError: String read FAutoLogonError write FAutoLogonError;
    property ChangePasswordError: TUCChangePassError read FChangePasswordError write SetFErroTrocaSenha;
    property InvalidLogin: String read FInvalidUserPass write FInvalidUserPass;
    property InactiveLogin: String read fInactiveLogin write fInactiveLogin;
    property InitialMessage: TStrings read FFirstMSG write SetFFirstMSG;
    property MaxLoginAttemptsError: String read FMaxLoginTry write FMaxLoginTry;
    property PasswordChanged: String read FPasswordChanged write FPasswordChanged;
    property BlankPassword: String read FPasswordOFF write FPasswordOFF;
    property UsuarioExiste: String read FUsuarioExiste write FUsuarioExiste;
    property PasswordExpired: String read fPasswordExpired write fPasswordExpired;
    property ForcaTrocaSenha: String read fForcaTrocaSenha write fForcaTrocaSenha;
    property InvalidProfile: String read FInvalidProfile write FInvalidProfile;
    property CanNotDeleteUserLogon: String read FCanNotDeleteUserLogon write FCanNotDeleteUserLogon;
    property ImageTooLarge: String read FImageTooLarge write FImageTooLarge;
  end;

  TUCLoginFormMSG = class(TPersistent)
  private
    FWindowCaption: String;
    FLabelUser: String;
    FLabelPassword: String;
    FBtOk: String;
    FBtCancel: String;
    FBottomImage: TPicture;
    FLeftImage: TPicture;
    FTopImage: TPicture;
    fLabelTentativas: String;
    fLabelTentativa: String;
    procedure SetFBottomImage(const Value: TPicture);
    procedure SetFLeftImage(const Value: TPicture);
    procedure SetFTopImage(const Value: TPicture);
  protected

  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property WindowCaption: String read FWindowCaption write FWindowCaption;
    property LabelUser: String read FLabelUser write FLabelUser;
    property LabelPassword: String read FLabelPassword write FLabelPassword;
    property BtOk: String read FBtOk write FBtOk;
    property BtCancel: String read FBtCancel write FBtCancel;
    property TopImage: TPicture read FTopImage write SetFTopImage;
    property LeftImage: TPicture read FLeftImage write SetFLeftImage;
    property BottomImage: TPicture read FBottomImage write SetFBottomImage;
    property LabelTentativa: String read fLabelTentativa write fLabelTentativa;
    // by vicente barros leonel
    property LabelTentativas: String read fLabelTentativas
      write fLabelTentativas; // by vicente barros leonel
  end;

  TUCCadUserFormMSG = class(TPersistent)
  private
    FWindowCaption: String;
    FLabelDescricao: String;
    FColNome: String;
    FColLogin: String;
    FColEmail: String;
    FBtAdic: String;
    FBtAlt: String;
    FBtExc: String;
    FBtAccess: String;
    FBtPass: String;
    FBtClose: String;
    FConfExc: String;
    FPromptDelete_WindowCaption: String;
    FBtApplyFilter: String; // added by fduenas
    FBtRemoveFilter: String;
    FShowInactive: String;
  protected

  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property WindowCaption: String read FWindowCaption write FWindowCaption;
    property LabelDescription: String read FLabelDescricao write FLabelDescricao;
    property ColName: String read FColNome write FColNome;
    property ColLogin: String read FColLogin write FColLogin;
    property ColEmail: String read FColEmail write FColEmail;
    property BtAdd: String read FBtAdic write FBtAdic;
    property BtChange: String read FBtAlt write FBtAlt;
    property BtDelete: String read FBtExc write FBtExc;
    property PromptDelete: String read FConfExc write FConfExc;
    property PromptDelete_WindowCaption: String read FPromptDelete_WindowCaption write FPromptDelete_WindowCaption; // added by fduenas
    property BtRights: String read FBtAccess write FBtAccess;
    property BtPassword: String read FBtPass write FBtPass;
    property BtClose: String read FBtClose write FBtClose;
    property BtApplyFilter: String read FBtApplyFilter write FBtApplyFilter;
    property BtRemoveFilter: String read FBtRemoveFilter write FBtRemoveFilter;
    property ShowInactive: String read FShowInactive write FShowInactive;
  end;

  TUCLogControlFormMSG = class(TPersistent)
  private
    FColAppID: String;
    FColData: String;
    FColNivel: String;
    FColUsuario: String;
    FColMensagem: String;
    FLabelDescription: String;
    FWindowCaption: String;
    FLabelLevel: String;
    FBtClose: String;
    FConfExc: String;
    FLabelUser: String;
    FBtFilt: String;
    FLabelDate: String;
    FBtExc: String;
    FOptionUserAll: String; // added by fduenas
    FOptionLevelLow: String; // added by fduenas
    FOptionLevelNormal: String; // added by fduenas
    FOptionLevelHigh: String; // added by fduenas
    FOptionLevelCritic: String; // added by fduenas
    FPromptDelete_WindowCaption: String; // added by fduenas
    FDeletePerformed: String;
    FLabelDetail: String;
    FBtCopy: String;
  protected

  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property WindowCaption: String read FWindowCaption write FWindowCaption;
    property LabelDescription: String read FLabelDescription
      write FLabelDescription;
    property LabelUser: String read FLabelUser write FLabelUser;
    property LabelDate: String read FLabelDate write FLabelDate;
    property LabelLevel: String read FLabelLevel write FLabelLevel;
    property ColAppID: String read FColAppID write FColAppID;
    property ColLevel: String read FColNivel write FColNivel;
    property ColMessage: String read FColMensagem write FColMensagem;
    property ColUser: String read FColUsuario write FColUsuario;
    property ColDate: String read FColData write FColData;
    property BtFilter: String read FBtFilt write FBtFilt;
    property BtDelete: String read FBtExc write FBtExc;
    property BtClose: String read FBtClose write FBtClose;
    property PromptDelete: String read FConfExc write FConfExc;
    property PromptDelete_WindowCaption: String read FPromptDelete_WindowCaption
      write FPromptDelete_WindowCaption; // added by fduenas
    property OptionUserAll: String read FOptionUserAll write FOptionUserAll;
    // added by fduenas
    property OptionLevelLow: String read FOptionLevelLow write FOptionLevelLow;
    // added by fduenas
    property OptionLevelNormal: String read FOptionLevelNormal
      write FOptionLevelNormal; // added by fduenas
    property OptionLevelHigh: String read FOptionLevelHigh
      write FOptionLevelHigh; // added by fduenas
    property OptionLevelCritic: String read FOptionLevelCritic
      write FOptionLevelCritic; // added by fduenas
    property DeletePerformed: String read FDeletePerformed
      write FDeletePerformed; // added by fduenas
    property LabelDetail: String read FLabelDetail write FLabelDetail;
    property BtCopy: String read FBtCopy write FBtCopy;
  end;

  TUCProfileUserFormMSG = class(TPersistent)
  private
    FWindowCaption: String;
    FLabelDescription: String;
    FColPerfil: String;
    FBtAdic: String;
    FBtAlt: String;
    FBtExc: String;
    FBtAcess: String;
    FBtClose: String;
    FConfExc: String;
    FPromptDelete_WindowCaption: String; // added by fduenas
  protected

  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property WindowCaption: String read FWindowCaption write FWindowCaption;
    property LabelDescription: String read FLabelDescription
      write FLabelDescription;
    property ColProfile: String read FColPerfil write FColPerfil;
    property BtAdd: String read FBtAdic write FBtAdic;
    property BtChange: String read FBtAlt write FBtAlt;
    property BtDelete: String read FBtExc write FBtExc;
    property BtRights: String read FBtAcess write FBtAcess; // BGM
    property PromptDelete: String read FConfExc write FConfExc;
    property PromptDelete_WindowCaption: String read FPromptDelete_WindowCaption
      write FPromptDelete_WindowCaption; // added by fduenas
    property BtClose: String read FBtClose write FBtClose;
  end;

  TUCAddUserFormMSG = class(TPersistent)
  private
    FWindowCaption: String;
    FLabelAdd: String;
    FLabelChange: String;
    FLabelNome: String;
    FLabelLogin: String;
    FLabelEmail: String;
    FCheckPriv: String;
    FBtSave: String;
    FBtCancelar: String;
    FLabelPerfil: String;
    fCheckExpira: String;
    fExpiredIn: string;
    fDay: String;
    fLabelStatus: String;
    fStatusDisabled: string;
    fStatusActive: String;
    FLabelImage: string;
    FBtLoadImage: string;
    FBtRemoveImage: string;
  protected

  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property WindowCaption: String read FWindowCaption write FWindowCaption;
    property LabelAdd: String read FLabelAdd write FLabelAdd;
    property LabelChange: String read FLabelChange write FLabelChange;
    property LabelName: String read FLabelNome write FLabelNome;
    property LabelLogin: String read FLabelLogin write FLabelLogin;
    property LabelEmail: String read FLabelEmail write FLabelEmail;
    property LabelPerfil: String read FLabelPerfil write FLabelPerfil;
    property CheckPrivileged: String read FCheckPriv write FCheckPriv;
    property BtSave: String read FBtSave write FBtSave;
    property BtCancel: String read FBtCancelar write FBtCancelar;
    property CheckExpira: String read fCheckExpira write fCheckExpira;
    property Day: String read fDay write fDay;
    property ExpiredIn: string read fExpiredIn write fExpiredIn;
    property LabelStatus: String read fLabelStatus write fLabelStatus;
    property StatusActive: String read fStatusActive write fStatusActive;
    property StatusDisabled: string read fStatusDisabled write fStatusDisabled;
    property LabelImage: string read FLabelImage write FLabelImage;
    property BtLoadImage: string read FBtLoadImage write FBtLoadImage;
    property BtRemoveImage: string read FBtRemoveImage write FBtRemoveImage;
  end;

  TUCAddProfileFormMSG = class(TPersistent)
  private
    FWindowCaption, FLabelAdd, FLabelChange, FLabelName, FBtGravar,
      FBtCancel: String;
  protected

  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property WindowCaption: String read FWindowCaption write FWindowCaption;
    property LabelAdd: String read FLabelAdd write FLabelAdd;
    property LabelChange: String read FLabelChange write FLabelChange;
    property LabelName: String read FLabelName write FLabelName;
    property BtSave: String read FBtGravar write FBtGravar;
    property BtCancel: String read FBtCancel write FBtCancel;
  end;

  TUCPermissFormMSG = class(TPersistent)
  private
    FWindowCaption: String;
    FBtCancela: String;
    FBtGrava: String;
    FBtLock: String;
    FBtUnlock: String;
    FPageActions: String;
    FPageMenu: String;
    FLabelProfile: String;
    FLabelUser: String;
    fPageControls: string;
    FSearchLabel: String;
    FSearchNext: String;
    FSearchNoResults: String;
    FSearchInherited: String;
  protected
  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property WindowCaption: String read FWindowCaption write FWindowCaption;
    property LabelUser: String read FLabelUser write FLabelUser;
    property LabelProfile: String read FLabelProfile write FLabelProfile;
    property PageMenu: String read FPageMenu write FPageMenu;
    property PageActions: String read FPageActions write FPageActions;
    property PageControls: string read fPageControls write fPageControls;
    property SearchLabel: String read FSearchLabel write FSearchLabel;
    property SearchNext: String read FSearchNext write FSearchNext;
    property SearchNoResults: String read FSearchNoResults write FSearchNoResults;
    property SearchInherited: String read FSearchInherited write FSearchInherited;
    property BtUnlock: String read FBtUnlock write FBtUnlock;
    property BtLock: String read FBtLock write FBtLock;
    property BtSave: String read FBtGrava write FBtGrava;
    property BtCancel: String read FBtCancela write FBtCancela;
  end;

  TUCTrocaSenhaFormMSG = class(TPersistent)
  private
    FWindowCaption: String;
    FBtCancel: String;
    FBtSave: String;
    FLabelConfirm: String;
    FLabelNewPassword: String;
    FLabelCurrentPassword: String;
    FLabelDescription: String;
  protected

  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property WindowCaption: String read FWindowCaption write FWindowCaption;
    property LabelDescription: String read FLabelDescription
      write FLabelDescription;
    property LabelCurrentPassword: String read FLabelCurrentPassword
      write FLabelCurrentPassword;
    property LabelNewPassword: String read FLabelNewPassword
      write FLabelNewPassword;
    property LabelConfirm: String read FLabelConfirm write FLabelConfirm;
    property BtSave: String read FBtSave write FBtSave;
    property BtCancel: String read FBtCancel write FBtCancel;
  end;

  TUCResetPassword = class(TPersistent)
  private
    FWindowCaption: String;
    FLabelPassword: String;
  protected
  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property WindowCaption: String read FWindowCaption write FWindowCaption;
    property LabelPassword: String read FLabelPassword write FLabelPassword;
  end;

  TUCCadUserLoggedMSG = Class(TPersistent)
  private
    fBtnMessage: String;
    fBtnRefresh: String;
    fBtnClose: String;
    FLabelDescricao: String;
    fLabelCaption: String;
    FColLogin: String;
    FColData: String;
    FColNome: String;
    FColComputer: String;
    fInputCaption: String;
    fInputText: String;
    fMsgSystem: String;
  public
    constructor Create(Aowner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property BtnMessage: String read fBtnMessage write fBtnMessage;
    property BtnRefresh: String read fBtnRefresh write fBtnRefresh;
    property BtnClose: String read fBtnClose write fBtnClose;
    property LabelDescricao: String read FLabelDescricao write FLabelDescricao;
    property LabelCaption: String read fLabelCaption write fLabelCaption;
    property ColName: String read FColNome write FColNome;
    property ColLogin: String read FColLogin write FColLogin;
    property ColComputer: String read FColComputer write FColComputer;
    property ColData: String read FColData write FColData;

    property InputCaption: String read fInputCaption write fInputCaption;
    property InputText: String read fInputText write fInputText;
    property MsgSystem: String read fMsgSystem write fMsgSystem;
  End;

  TUCTypeBancoDados = (Interbase, Firebird, MySql, PARADOX, Oracle, SqlServer, PostgreSQL);

implementation

{ TUserCommonMSG }

procedure TUCUserCommonMSG.Assign(Source: TPersistent);
begin
  if Source is TUCUserCommonMSG then
  begin
    Self.BlankPassword := TUCUserCommonMSG(Source).BlankPassword;
    Self.PasswordChanged := TUCUserCommonMSG(Source).PasswordChanged;
    Self.InitialMessage := TUCUserCommonMSG(Source).InitialMessage;
    Self.InvalidLogin := TUCUserCommonMSG(Source).InvalidLogin;
    Self.InactiveLogin := TUCUserCommonMSG(Source).InactiveLogin;
    Self.MaxLoginAttemptsError := TUCUserCommonMSG(Source)
      .MaxLoginAttemptsError;
    Self.ChangePasswordError := TUCUserCommonMSG(Source).ChangePasswordError;
    Self.UsuarioExiste := TUCUserCommonMSG(Source).UsuarioExiste;
    Self.PasswordExpired := TUCUserCommonMSG(Source).PasswordExpired;
    Self.ForcaTrocaSenha := TUCUserCommonMSG(Source).ForcaTrocaSenha;
  end
  else
    inherited;
end;

constructor TUCUserCommonMSG.Create(Aowner: TComponent);
begin
  inherited Create;
  ChangePasswordError := TUCChangePassError.Create(nil);
  FFirstMSG := TStringList.Create;
end;

destructor TUCUserCommonMSG.Destroy;
begin
  SysUtils.FreeAndNil(FChangePasswordError);
  SysUtils.FreeAndNil(FFirstMSG);
  inherited;
end;

procedure TUCUserCommonMSG.SetFErroTrocaSenha(const Value: TUCChangePassError);
begin
  FChangePasswordError := Value;
end;

procedure TUCUserCommonMSG.SetFFirstMSG(const Value: TStrings);
begin
  FFirstMSG.Assign(Value);
end;

{ TLoginFormMSG }

procedure TUCLoginFormMSG.Assign(Source: TPersistent);
begin
  if Source is TUCLoginFormMSG then
    with Source as TUCLoginFormMSG do
    begin
      Self.WindowCaption := WindowCaption;
      Self.LabelUser := LabelUser;
      Self.LabelPassword := LabelPassword;
      Self.BtOk := BtOk;
      Self.BtCancel := BtCancel;
    end
  else
    inherited;
end;

constructor TUCLoginFormMSG.Create(Aowner: TComponent);
begin
  inherited Create;
  FTopImage := TPicture.Create;
  FLeftImage := TPicture.Create;
  FBottomImage := TPicture.Create;
end;

destructor TUCLoginFormMSG.Destroy;
begin
  SysUtils.FreeAndNil(FTopImage);
  SysUtils.FreeAndNil(FLeftImage);
  SysUtils.FreeAndNil(FBottomImage);
  inherited;
end;

procedure TUCLoginFormMSG.SetFBottomImage(const Value: TPicture);
begin
  FBottomImage.Assign(Value);
end;

procedure TUCLoginFormMSG.SetFLeftImage(const Value: TPicture);
begin
  FLeftImage.Assign(Value);
end;

procedure TUCLoginFormMSG.SetFTopImage(const Value: TPicture);
begin
  FTopImage.Assign(Value);
end;

{ TCadUserFormMSG }

procedure TUCCadUserFormMSG.Assign(Source: TPersistent);
begin
  if Source is TUCCadUserFormMSG then
    with Source as TUCCadUserFormMSG do
    begin
      Self.WindowCaption := WindowCaption;
      Self.LabelDescription := LabelDescription;
      Self.ColName := ColName;
      Self.ColLogin := ColLogin;
      Self.ColEmail := ColEmail;
      Self.BtAdd := BtAdd;
      Self.BtChange := BtChange;
      Self.BtDelete := BtDelete;
      Self.BtRights := BtRights;
      Self.BtPassword := BtPassword;
      Self.BtClose := BtClose;
      Self.PromptDelete := PromptDelete;
      Self.PromptDelete_WindowCaption := PromptDelete_WindowCaption;
      Self.BtApplyFilter := BtApplyFilter;
      Self.BtRemoveFilter := BtRemoveFilter;
      Self.ShowInactive := ShowInactive;
      // added by fduenas
    end
  else
    inherited;
end;

constructor TUCCadUserFormMSG.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCCadUserFormMSG.Destroy;
begin
  inherited;
end;

{ TAddUserFormMSG }

procedure TUCAddUserFormMSG.Assign(Source: TPersistent);
begin
  if Source is TUCAddUserFormMSG then
    with Source as TUCAddUserFormMSG do
    begin
      Self.WindowCaption := WindowCaption;
      Self.LabelAdd := LabelAdd;
      Self.LabelChange := LabelChange;
      Self.LabelName := LabelName;
      Self.LabelLogin := LabelLogin;
      Self.LabelEmail := LabelEmail;
      Self.LabelPerfil := LabelPerfil;
      Self.CheckPrivileged := CheckPrivileged;
      Self.BtSave := BtSave;
      Self.BtCancel := BtCancel;
      Self.CheckExpira := CheckExpira;
      Self.Day := Day;
      Self.ExpiredIn := ExpiredIn;
      Self.LabelStatus := LabelStatus;
      Self.StatusDisabled := StatusDisabled;
      Self.StatusActive := StatusActive;
      Self.LabelImage := LabelImage;
      Self.BtLoadImage := BtLoadImage;
      Self.BtRemoveImage := BtRemoveImage;
    end
  else
    inherited;
end;

constructor TUCAddUserFormMSG.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCAddUserFormMSG.Destroy;
begin
  inherited;
end;

{ TPermissFormMSG }

procedure TUCPermissFormMSG.Assign(Source: TPersistent);
begin
  if Source is TUCPermissFormMSG then
    with Source as TUCPermissFormMSG do
    begin
      Self.WindowCaption := WindowCaption;
      Self.LabelUser := LabelUser;
      Self.LabelProfile := LabelProfile;
      Self.PageMenu := PageMenu;
      Self.PageActions := PageActions;
      Self.BtUnlock := BtUnlock;
      Self.BtLock := BtLock;
      Self.BtSave := BtSave;
      Self.BtCancel := BtCancel;
      Self.PageControls := PageControls;
      Self.SearchLabel := SearchLabel;
      Self.SearchNext := SearchNext;
      Self.SearchNoResults := SearchNoResults;
      Self.SearchInherited := SearchInherited;
    end
  else
    inherited;
end;

constructor TUCPermissFormMSG.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCPermissFormMSG.Destroy;
begin
  inherited;
end;

{ TTrocaSenhaFormMSG }

procedure TUCTrocaSenhaFormMSG.Assign(Source: TPersistent);
begin
  if Source is TUCTrocaSenhaFormMSG then
    with Source as TUCTrocaSenhaFormMSG do
    begin
      Self.WindowCaption := WindowCaption;
      Self.LabelDescription := LabelDescription;
      Self.LabelCurrentPassword := LabelCurrentPassword;
      Self.LabelNewPassword := LabelNewPassword;
      Self.LabelConfirm := LabelConfirm;
      Self.BtSave := BtSave;
      Self.BtCancel := BtCancel;
    end
  else
    inherited;
end;

constructor TUCTrocaSenhaFormMSG.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCTrocaSenhaFormMSG.Destroy;
begin
  inherited;
end;

{ TChangePassError }

procedure TUCChangePassError.Assign(Source: TPersistent);
begin
  if Source is TUCChangePassError then
    with Source as TUCChangePassError do
    begin
      Self.InvalidCurrentPassword := InvalidCurrentPassword;
      Self.NewPasswordError := NewPasswordError;
      Self.NewEqualCurrent := NewEqualCurrent;
      Self.PasswordRequired := PasswordRequired;
      Self.MinPasswordLength := MinPasswordLength;
    end
  else
    inherited;
end;

constructor TUCChangePassError.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCChangePassError.Destroy;
begin
  inherited;
end;

{ TResetPassword }

procedure TUCResetPassword.Assign(Source: TPersistent);
begin
  if Source is TUCResetPassword then
  begin
    Self.WindowCaption := TUCResetPassword(Source).WindowCaption;
    Self.LabelPassword := TUCResetPassword(Source).LabelPassword;
  end
  else
    inherited;
end;

constructor TUCResetPassword.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCResetPassword.Destroy;
begin
  inherited;
end;

{ TProfileUserFormMSG }

procedure TUCProfileUserFormMSG.Assign(Source: TPersistent);
begin
  if Source is TUCProfileUserFormMSG then
    with Source as TUCProfileUserFormMSG do
    begin
      Self.WindowCaption := WindowCaption;
      Self.LabelDescription := LabelDescription;
      Self.ColProfile := ColProfile;
      Self.BtAdd := BtAdd;
      Self.BtChange := BtChange;
      Self.BtDelete := BtDelete;
      Self.BtRights := BtRights; // BGM
      Self.BtClose := BtClose;
      Self.PromptDelete := PromptDelete;
      Self.PromptDelete_WindowCaption := PromptDelete_WindowCaption;
      // added by fduenas
    end
  else
    inherited;
end;

constructor TUCProfileUserFormMSG.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCProfileUserFormMSG.Destroy;
begin
  inherited;
end;

{ TAddProfileFormMSG }

procedure TUCAddProfileFormMSG.Assign(Source: TPersistent);
begin
  if Source is TUCAddProfileFormMSG then
    with Source as TUCAddProfileFormMSG do
    begin
      Self.WindowCaption := WindowCaption;
      Self.LabelAdd := LabelAdd;
      Self.LabelChange := LabelChange;
      Self.LabelName := LabelName;
      Self.BtSave := BtSave;
      Self.BtCancel := BtCancel;
    end
  else
    inherited;
end;

constructor TUCAddProfileFormMSG.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCAddProfileFormMSG.Destroy;
begin
  inherited;
end;

{ TLogControlFormMSG }

procedure TUCLogControlFormMSG.Assign(Source: TPersistent);
begin
  if Source is TUCLogControlFormMSG then
    with Source as TUCLogControlFormMSG do
    begin
      Self.WindowCaption := WindowCaption;
      Self.LabelDescription := LabelDescription;
      Self.LabelUser := LabelUser;
      Self.LabelDate := LabelDate;
      Self.LabelLevel := LabelLevel;
      Self.ColLevel := ColLevel;
      Self.ColAppID := ColAppID;
      Self.ColMessage := ColMessage;
      Self.ColUser := ColUser;
      Self.ColDate := ColDate;
      Self.BtFilter := BtFilter;
      Self.BtDelete := BtDelete;
      Self.BtClose := BtClose;
      Self.PromptDelete := PromptDelete;
      Self.PromptDelete_WindowCaption := PromptDelete_WindowCaption; // added by fduenas
      Self.OptionUserAll := OptionUserAll; // added by fduenas
      Self.OptionLevelLow := OptionLevelLow; // added by fduenas
      Self.OptionLevelNormal := OptionLevelNormal; // added by fduenas
      Self.OptionLevelHigh := OptionLevelHigh; // added by fduenas
      Self.OptionLevelCritic := OptionLevelCritic; // added by fduenas
      Self.DeletePerformed := DeletePerformed; // added by fduenas
      Self.LabelDetail := LabelDetail;
      Self.BtCopy := BtCopy;
    end
  else
    inherited;
end;

constructor TUCLogControlFormMSG.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCLogControlFormMSG.Destroy;
begin
  inherited;
end;

{ TAppMessagesMSG }

procedure TUCAppMessagesMSG.Assign(Source: TPersistent);
begin
  if Source is TUCAppMessagesMSG then
    with Source as TUCAppMessagesMSG do
    begin
      Self.MsgsForm_BtNew := MsgsForm_BtNew;
      Self.MsgsForm_BtReplay := MsgsForm_BtReplay;
      Self.MsgsForm_BtForward := MsgsForm_BtForward;
      Self.MsgsForm_BtDelete := MsgsForm_BtDelete;
      Self.MsgsForm_WindowCaption := MsgsForm_WindowCaption;
      Self.MsgsForm_ColFrom := MsgsForm_ColFrom;
      Self.MsgsForm_ColSubject := MsgsForm_ColSubject;
      Self.MsgsForm_ColDate := MsgsForm_ColDate;
      Self.MsgsForm_PromptDelete := MsgsForm_PromptDelete;
      Self.MsgsForm_PromptDelete_WindowCaption :=
        MsgsForm_PromptDelete_WindowCaption; // added by fduenas
      Self.MsgsForm_BtClose := MsgsForm_BtClose; // added by fduenas
      Self.MsgsForm_NoMessagesSelected := MsgsForm_NoMessagesSelected;
      // added by fduenas
      Self.MsgsForm_NoMessagesSelected_WindowCaption :=
        MsgsForm_NoMessagesSelected_WindowCaption; // added by fduenas

      Self.MsgRec_BtClose := MsgRec_BtClose;
      Self.MsgRec_WindowCaption := MsgRec_WindowCaption;
      Self.MsgRec_Title := MsgRec_Title;
      Self.MsgRec_LabelFrom := MsgRec_LabelFrom;
      Self.MsgRec_LabelDate := MsgRec_LabelDate;
      Self.MsgRec_LabelSubject := MsgRec_LabelSubject;
      Self.MsgRec_LabelMessage := MsgRec_LabelMessage;

      Self.MsgSend_BtSend := MsgSend_BtSend;
      Self.MsgSend_BtCancel := MsgSend_BtCancel;
      Self.MsgSend_WindowCaption := MsgSend_WindowCaption;
      Self.MsgSend_Title := MsgSend_Title;
      Self.MsgSend_GroupTo := MsgSend_GroupTo;
      Self.MsgSend_RadioUser := MsgSend_RadioUser;
      Self.MsgSend_RadioAll := MsgSend_RadioAll;
      Self.MsgSend_GroupMessage := MsgSend_GroupMessage;
      Self.MsgSend_LabelSubject := MsgSend_LabelSubject;
      Self.MsgSend_LabelMessageText := MsgSend_LabelMessageText;
    end
  else
    inherited;
end;

constructor TUCAppMessagesMSG.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCAppMessagesMSG.Destroy;
begin
  inherited;
end;

{ TUCHistoryMSG }

{ TUCFieldType }
{
  procedure TUCFieldType.Assign(Source: TPersistent);
  begin
  if Source is TUCFieldType then
  Begin
  Self.Type_VarChar   := TUCFieldType(Source).Type_VarChar;
  Self.Type_Char      := TUCFieldType(Source).Type_Char;
  Self.Type_Int       := TUCFieldType(Source).Type_Int;
  end
  else
  inherited;
  end;

  constructor TUCFieldType.Create(AOwner: TComponent);
  begin
  inherited Create;
  end;

  destructor TUCFieldType.Destroy;
  begin

  inherited;
  end; }

{ TUCCadUserLoggedMSG }

procedure TUCCadUserLoggedMSG.Assign(Source: TPersistent);
begin
  if Source is TUCCadUserLoggedMSG then
  Begin
    BtnMessage := TUCCadUserLoggedMSG(Source).BtnMessage;
    BtnRefresh := TUCCadUserLoggedMSG(Source).BtnRefresh;
    BtnClose := TUCCadUserLoggedMSG(Source).BtnClose;
    LabelDescricao := TUCCadUserLoggedMSG(Source).LabelDescricao;
    LabelCaption := TUCCadUserLoggedMSG(Source).LabelCaption;
    ColName := TUCCadUserLoggedMSG(Source).ColName;
    ColLogin := TUCCadUserLoggedMSG(Source).ColLogin;
    ColComputer := TUCCadUserLoggedMSG(Source).ColComputer;
    ColData := TUCCadUserLoggedMSG(Source).ColData;
    InputCaption := TUCCadUserLoggedMSG(Source).InputCaption;
    InputText := TUCCadUserLoggedMSG(Source).InputText;
    MsgSystem := TUCCadUserLoggedMSG(Source).MsgSystem
  End
  else
    inherited;
end;

constructor TUCCadUserLoggedMSG.Create(Aowner: TComponent);
begin
  inherited Create;
end;

destructor TUCCadUserLoggedMSG.Destroy;
begin
  inherited;
end;

end.
