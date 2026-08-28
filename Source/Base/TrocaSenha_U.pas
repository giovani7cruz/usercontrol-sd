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
unit TrocaSenha_U;

interface

{$I 'UserControl.inc'}

uses
  {$IFDEF DELPHIXE2_UP}
  System.UITypes,
  {$ENDIF}

  Variants,
  Buttons,
  Classes,
  Controls,
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

  UCBase,
  UCVisualStyle; { Por Vicente Barros Leonel }

type
  TTrocaSenha = class(TForm)
    Panel1: TPanel;
    lbDescricao: TLabel;
    Image1: TImage;
    Panel3: TPanel;
    btGrava: TBitBtn;
    btCancel: TBitBtn;
    Panel2: TPanel;
    lbSenhaAtu: TLabel;
    lbNovaSenha: TLabel;
    lbConfirma: TLabel;
    EditAtu: TEdit;
    EditNova: TEdit;
    EditConfirma: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    fUsercontrol: TUserControl; { Por Vicente Barros Leonel }
    ForcarTroca: Boolean;
    { Public declarations }
  end;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TTrocaSenha.FormCreate(Sender: TObject);
begin
  TUCVisualStyle.ApplyForm(Self);
  TUCVisualStyle.StyleHeader(Panel1, lbDescricao);
  TUCVisualStyle.StyleActionPanel(Panel2);
  TUCVisualStyle.StyleActionPanel(Panel3);
  TUCVisualStyle.StyleEdit(EditAtu);
  TUCVisualStyle.StyleEdit(EditNova);
  TUCVisualStyle.StyleEdit(EditConfirma);
  TUCVisualStyle.StylePrimaryButton(btGrava);
  TUCVisualStyle.StyleSecondaryButton(btCancel);
end;

procedure TTrocaSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTrocaSenha.btCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TTrocaSenha.FormActivate(Sender: TObject);
begin
  EditAtu.CharCase := Self.fUsercontrol.Login.CharCasePass;
  EditNova.CharCase := Self.fUsercontrol.Login.CharCasePass;
  EditConfirma.CharCase := Self.fUsercontrol.Login.CharCasePass;
  TUCVisualStyle.FitButtonWidth(btGrava, 100);
  TUCVisualStyle.FitButtonWidth(btCancel, 100);
  btCancel.Left := Panel3.ClientWidth - btCancel.Width - 12;
  btGrava.Left := btCancel.Left - btGrava.Width - 8;
  { Por Vicente Barros Leonel }
end;

procedure TTrocaSenha.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ForcarTroca = True then
  begin
    CanClose := False;
    MessageDlg(fUsercontrol.UserSettings.CommonMessages.ForcaTrocaSenha,
      mtWarning, [mbOK], 0);
  end;
end;

end.
