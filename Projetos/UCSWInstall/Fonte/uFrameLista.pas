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

{ AJUDE O PROJETO COM UMA XÍCARA DE CAFÉ OU DUAS. CONSIDERE UMA DOAÇÃO!        }
{                                                                              }
{ VIA PAGSEGURO: https://pag.ae/7VccpnuCN                                      }
{ APOIE COM BITCOIN: 13JUHQpT7zAU7pC1q6cQBYGpq5EF8XoLcL                        }
{

{ ******************************************************************************
  |* Historico
  |*
  |* 01/07/2015: Gioavni Da Cruz
  |*  - Criação e distribuição da Primeira Versao ShowDelphi
  |*
  |* 31/08/2019: Gioavni Da Cruz
  |*  - Revisão para a instalação do DWCore Conector
  **************************************************************************** }
unit uFrameLista;

interface

uses
  Generics.Collections, Generics.Defaults,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, ComCtrls;

type
  TPacotes = TList<TCheckBox>;

  TframePacotes = class(TFrame)
    Label1: TLabel;
    pckUCDataConnector_dpk: TCheckBox;
    pckHistorico_dpk: TCheckBox;
    Label9: TLabel;
    btnPacotesDesmarcarTodos: TSpeedButton;
    btnPacotesMarcarTodos: TSpeedButton;
    pckUCADOConn_dpk: TCheckBox;
    Label5: TLabel;
    pckFireDacConn_dpk: TCheckBox;
    Label6: TLabel;
    pckUCIBXConn_dpk: TCheckBox;
    Label7: TLabel;
    pckUCMidasConn_dpk: TCheckBox;
    Label10: TLabel;
    pckmd5_dpk: TCheckBox;
    pckUserControl_RT_dpk: TCheckBox;
    pckUserControl_DT_dpk: TCheckBox;
    Label2: TLabel;
    pckUCDBXConn_dpk: TCheckBox;
    Label3: TLabel;
    pckUCDataSnapConn_dpk: TCheckBox;
    Label4: TLabel;
    pckZeosConn_dpk: TCheckBox;
    Label8: TLabel;
    pckUCRestConn_dpk: TCheckBox;
    Label11: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    PckUCRestDwConn_dpk: TCheckBox;
    Label14: TLabel;
    Label15: TLabel;
    PckUCRestDwCoreConn_dpk: TCheckBox;
    Label16: TLabel;
    procedure btnPacotesMarcarTodosClick(Sender: TObject);
    procedure btnPacotesDesmarcarTodosClick(Sender: TObject);
    procedure VerificarCheckboxes(Sender: TObject);
  private
    FPacotes: TPacotes;
    FUtilizarBotoesMarcar: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Pacotes: TPacotes read FPacotes write FPacotes;
  end;

implementation

uses
  StrUtils;

{$R *.dfm}

constructor TframePacotes.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited;

  // variavel para controle do verificar checkboxes
  // utilizada para evitar estouro de pilha por conta da redundância
  // e também para que pacotes dependentes não atrapalhem a rotina
  FUtilizarBotoesMarcar := False;

  // lista de pacotes (checkboxes) disponiveis
  FPacotes := TPacotes.Create;

  // popular a lista de pacotes com os pacotes disponíveis
  // colocar todos os checkboxes disponíveis na lista
  FPacotes.Clear;
  for I := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[I] is TCheckBox then
      FPacotes.Add(TCheckBox(Self.Components[I]));
  end;
  FPacotes.Sort(TComparer<TCheckBox>.Construct(
    function(const Dpk1, Dpk2: TCheckBox): Integer
    begin
      Result := CompareStr(FormatFloat('0000', Dpk1.TabOrder),
        FormatFloat('0000', Dpk2.TabOrder));
    end));
end;

destructor TframePacotes.Destroy;
begin
  FreeAndNil(FPacotes);

  inherited;
end;

// botão para marcar todos os checkboxes
procedure TframePacotes.btnPacotesMarcarTodosClick(Sender: TObject);
var
  I: Integer;
begin
  FUtilizarBotoesMarcar := True;
  try
    for I := 0 to Self.ComponentCount - 1 do
    begin
      if Self.Components[I] is TCheckBox then
      begin
        if TCheckBox(Self.Components[I]).Enabled then
          TCheckBox(Self.Components[I]).Checked := True;
      end;
    end;
  finally
    FUtilizarBotoesMarcar := False;
    VerificarCheckboxes(Sender);
  end;
end;

// botão para desmarcar todos os checkboxes
procedure TframePacotes.btnPacotesDesmarcarTodosClick(Sender: TObject);
var
  I: Integer;
begin
  FUtilizarBotoesMarcar := True;
  try
    for I := 0 to Self.ComponentCount - 1 do
    begin
      if Self.Components[I] is TCheckBox then
      begin
        if TCheckBox(Self.Components[I]).Enabled then
          TCheckBox(Self.Components[I]).Checked := False;
      end;
    end;
  finally
    FUtilizarBotoesMarcar := False;
    VerificarCheckboxes(Sender);
  end;
end;

// rotina de verificação de dependência e marcação dos pacotes base
procedure TframePacotes.VerificarCheckboxes(Sender: TObject);
begin
  // pacotes base não podem ser desmarcados
  // instalação mínima do ACBr
   pckUCDataConnector_dpk.Checked := True;
   pckmd5_dpk.Checked    := True;

   pckUserControl_RT_dpk.Checked := True;
   pckUserControl_DT_dpk.Checked := True;

   { Obrigatório somente para versão XE 2 ou superior }

  // if not FUtilizarBotoesMarcar then
  // begin
  // FUtilizarBotoesMarcar := True;/// caso algum evento abaixo dispare novamente
  // try
  //
  //
  //
  // finally
  // FUtilizarBotoesMarcar := false;
  // end;
  // end;
end;

end.
