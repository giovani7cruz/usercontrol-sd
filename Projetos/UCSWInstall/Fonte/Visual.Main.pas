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
  |* 01/07/2015: Giovani Da Cruz
  |*  - Criação e distribuição da Primeira Versao ShowDelphi
  |*
  |* 06/02/2016: Giovani Da Cruz
  |*  - Ajuste para a adição automática no library do delphi.
  |*
  |* 31/08/2019: Gioavni Da Cruz
  |*  - Revisão para a instalação do DWCore Conector
  **************************************************************************** }

unit Visual.Main;

interface

uses
  JclIDEUtils, JclCompilerUtils,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, JvWizard, JvWizardRouteMapNodes, ShlObj,
  JvExControls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, uFrameLista,
  Vcl.ExtCtrls, Vcl.Imaging.pngimage, JvComponentBase, JvCreateProcess,
  dxGDIPlusClasses;

type
  TDestino = (tdSystem, tdDelphi, tdNone);

  TFrmPrincipal = class(TForm)
    wizPrincipal: TJvWizard;
    wizPgConfiguracao: TJvWizardInteriorPage;
    wizMapa: TJvWizardRouteMapNodes;
    Label2: TLabel;
    edtDirDestino: TEdit;
    btnSelecDirInstall: TSpeedButton;
    Label4: TLabel;
    edtDelphiVersion: TComboBox;
    Label5: TLabel;
    edtPlatform: TComboBox;
    wizPgPacote: TJvWizardInteriorPage;
    wizPgInstalacao: TJvWizardInteriorPage;
    lstMsgInstalacao: TListBox;
    pgbInstalacao: TProgressBar;
    frameDpk: TframePacotes;
    ckbBCB: TCheckBox;
    Label8: TLabel;
    wizPgInicio: TJvWizardInteriorPage;
    Label6: TLabel;
    lblUrlForum1: TLabel;
    lblUrlUserControl1: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    wizPgFim: TJvWizardInteriorPage;
    btnVisualizarLogCompilacao: TSpeedButton;
    pnlInfoCompilador: TPanel;
    lbInfo: TListBox;
    Label20: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Image1: TImage;
    Label13: TLabel;
    Label15: TLabel;
    pnlTopo: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Image2: TImage;
    JvCreateProcess1: TJvCreateProcess;
    Label18: TLabel;
    chkDeixarSomenteLIB: TCheckBox;
    btnInstalar: TButton;
    Label3: TLabel;
    Label23: TLabel;
    Label14: TLabel;
    Label28: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDelphiVersionChange(Sender: TObject);
    procedure btnSelecDirInstallClick(Sender: TObject);
    procedure wizPgConfiguracaoNextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure wizPgInstalacaoEnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure btnInstalarClick(Sender: TObject);
    procedure btnVisualizarLogCompilacaoClick(Sender: TObject);
    procedure wizPgConfiguracaoCancelButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure wizPgConfiguracaoFinishButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure URLClick(Sender: TObject);
    procedure wizPgInstalacaoNextButtonClick(Sender: TObject;
      var Stop: Boolean);
    procedure lblUrlPIXClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    FCountErros: Integer;
    oUserControl: TJclBorRADToolInstallations;
    iVersion: Integer;
    tPlatform: TJclBDSPlatform;
    sDirRoot: string;
    sDirLibrary: string;
    sDirPackage: string;
   // sDestino   : TDestino;
    sPathBin   : String;
    procedure BeforeExecute(Sender: TJclBorlandCommandLineTool);
    procedure AddLibrarySearchPath;
    procedure OutputCallLine(const Text: string);
    procedure SetPlatformSelected;
    procedure CreateDirectoryLibrarysNotExist;
    procedure GravarConfiguracoes;
    procedure LerConfiguracoes;
    function PathApp: String;
    function PathArquivoIni: String;
    function PathArquivoLog: String;
    procedure ExtrairDiretorioPacote(NomePacote: string);
    procedure AddLibraryPathToDelphiPath(const APath: String;
      const AProcurarRemover: String);
    procedure FindDirs(ADirRoot: String; APlatform: TJclBDSPlatform;
      bAdicionar: Boolean = True);
    function LibraryDirectory(APlatform: TJclBDSPlatform): String;
    procedure DeixarSomenteLib;
    procedure WriteToTXT(const ArqTXT, AString: String;
      const AppendIfExists: Boolean = True; AddLineBreak: Boolean = True);

  public
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses
{$WARNINGS off} FileCtrl, {$WARNINGS on} ShellApi, IniFiles, StrUtils,
  System.Types, System.IOUtils, Clipbrd;

procedure TFrmPrincipal.AddLibraryPathToDelphiPath(const APath,
  AProcurarRemover: String);
const
  cs: PChar = 'Environment Variables';
var
  MessageLParam: LPARAM;
  MessageWParam: WPARAM;
  BroadcastResult: DWORD_PTR;
  ListaPaths: TStringList;
  I: Integer;
  PathsAtuais: String;
begin
  with oUserControl.Installations[iVersion] do
  begin
    // tentar ler o path configurado na ide do delphi, se não existir ler
    // a atual para complementar e fazer o override
    PathsAtuais := Trim(EnvironmentVariables.Values['PATH']);
    if PathsAtuais = '' then
      PathsAtuais := GetEnvironmentVariable('PATH');

    // manipular as strings
    ListaPaths := TStringList.Create;
    try
      ListaPaths.Clear;
      ListaPaths.Delimiter       := ';';
      ListaPaths.StrictDelimiter := True;
      ListaPaths.DelimitedText   := PathsAtuais;

      // verificar se existe algo do UserControl e remover do environment variable PATH do delphi
      if Trim(AProcurarRemover) <> '' then
      begin
        for I := ListaPaths.Count - 1 downto 0 do
        begin
         if Pos(AnsiUpperCase(AProcurarRemover), AnsiUpperCase(ListaPaths[I])) > 0 then
           ListaPaths.Delete(I);
        end;
      end;

      // adicionar o path
      ListaPaths.Add(APath);

      // escrever a variavel no override da ide
      ConfigData.WriteString(cs, 'PATH', ListaPaths.DelimitedText);

      // enviar um broadcast de atualização para o windows
      MessageWParam := 0;
      MessageLParam := LPARAM(cs);
      BroadcastResult := 0;
      // O valor em BroadcastResult pertence ao processamento da mensagem e não é
      // um código de erro do Windows. A configuração já foi persistida acima.
      SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, MessageWParam,
        MessageLParam, SMTO_ABORTIFHUNG, 4000, @BroadcastResult);
    finally
      ListaPaths.Free;
    end;
  end;
end;

procedure TFrmPrincipal.AddLibrarySearchPath;
var
  SourceDirectory: String;
  LibraryWin32: String;
  LibraryWin64: String;
  ConfigureWin64: Boolean;
begin
  SourceDirectory := IncludeTrailingPathDelimiter(sDirRoot) + 'Source';
  LibraryWin32 := LibraryDirectory(bpWin32);
  LibraryWin64 := LibraryDirectory(bpWin64);
  ConfigureWin64 := oUserControl.Installations[iVersion].VersionNumber >= 16;

  if not System.SysUtils.ForceDirectories(LibraryWin32) then
    raise Exception.CreateFmt('Não foi possível criar o diretório "%s".',
      [LibraryWin32]);

  FindDirs(SourceDirectory, bpWin32);
  with oUserControl.Installations[iVersion] do
  begin
    AddToLibraryBrowsingPath(LibraryWin32, bpWin32);
    AddToLibrarySearchPath(LibraryWin32, bpWin32);
    AddToDebugDCUPath(LibraryWin32, bpWin32);
  end;

  if ConfigureWin64 then
  begin
    if not System.SysUtils.ForceDirectories(LibraryWin64) then
      raise Exception.CreateFmt('Não foi possível criar o diretório "%s".',
        [LibraryWin64]);

    FindDirs(SourceDirectory, bpWin64);
    with oUserControl.Installations[iVersion] do
    begin
      AddToLibraryBrowsingPath(LibraryWin64, bpWin64);
      AddToLibrarySearchPath(LibraryWin64, bpWin64);
      AddToDebugDCUPath(LibraryWin64, bpWin64);
    end;
  end;

  // A IDE é Win32 e deve localizar apenas os BPLs de design-time Win32.
  AddLibraryPathToDelphiPath(LibraryWin32, 'UserControl');

  if ckbBCB.Checked and
    (oUserControl.Installations[iVersion] is TJclBDSInstallation) then
  begin
    with TJclBDSInstallation(oUserControl.Installations[iVersion]) do
    begin
      AddToCppSearchPath(LibraryWin32, bpWin32);
      AddToCppLibraryPath(LibraryWin32, bpWin32);
      AddToCppBrowsingPath(LibraryWin32, bpWin32);
      AddToCppIncludePath(LibraryWin32, bpWin32);

      if ConfigureWin64 then
      begin
        AddToCppSearchPath(LibraryWin64, bpWin64);
        AddToCppLibraryPath(LibraryWin64, bpWin64);
        AddToCppBrowsingPath(LibraryWin64, bpWin64);
        AddToCppIncludePath(LibraryWin64, bpWin64);
      end;
    end;
  end;
end;

procedure TFrmPrincipal.BeforeExecute(Sender: TJclBorlandCommandLineTool);
begin
  // limpar os parâmetros do compilador
  Sender.Options.Clear;

  // não utilizar o dcc32.cfg
  if oUserControl.Installations[iVersion].SupportsNoConfig then
    Sender.Options.Add('--no-config');

  // -B = Build all units
  Sender.Options.Add('-B');
  // O+ = Optimization
  Sender.Options.Add('-$O+');
  // W- = Generate stack frames
  Sender.Options.Add('-$W-');
  // Y+ = Symbol reference info
  Sender.Options.Add('-$Y-');
  // -M = Make modified units
  Sender.Options.Add('-M');
  // -Q = Quiet compile
  Sender.Options.Add('-Q');
  // não mostrar warnings
  Sender.Options.Add('-H-');
  // não mostrar hints
  Sender.Options.Add('-W-');
  // -D<syms> = Define conditionals
  Sender.Options.Add('-DRELEASE');
  // -U<paths> = Unit directories
  Sender.AddPathOption('U', oUserControl.Installations[iVersion].LibFolderName[tPlatform]);
  Sender.AddPathOption('U', oUserControl.Installations[iVersion].LibrarySearchPath[tPlatform]);
  Sender.AddPathOption('U', sDirLibrary);
  // -I<paths> = Include directories
  Sender.AddPathOption('I', oUserControl.Installations[iVersion].LibrarySearchPath[tPlatform]);
  // -R<paths> = Resource directories
  Sender.AddPathOption('R', oUserControl.Installations[iVersion].LibrarySearchPath[tPlatform]);
  // -N0<path> = unit .dcu output directory
  Sender.AddPathOption('N0', sDirLibrary);
  Sender.AddPathOption('LE', sDirLibrary);
  Sender.AddPathOption('LN', sDirLibrary);

  // ************ C++ Builder *************** //
  if ckbBCB.Checked then
  begin
     // -JL compila c++ builder
     Sender.AddPathOption('JL', sDirLibrary);
     // -NO compila .dpi output directory c++ builder
     Sender.AddPathOption('NO', sDirLibrary);
     // -NB compila .lib output directory c++ builder
     Sender.AddPathOption('NB', sDirLibrary);
     // -NH compila .hpp output directory c++ builder
     Sender.AddPathOption('NH', sDirLibrary);
  end;
  //
  with oUserControl.Installations[iVersion] do
  begin
     // -- Path para instalar os pacotes do Rave no D7, nas demais versões
     // -- o path existe.
     if VersionNumberStr = 'd7' then
        Sender.AddPathOption('U', oUserControl.Installations[iVersion].RootDir + '\Rave5\Lib');

     // -- Na versão XE2 por motivo da nova tecnologia FireMonkey, deve-se adicionar
     // -- os prefixos dos nomes, para identificar se será compilado para VCL ou FMX
     if VersionNumberStr = 'd16' then
        Sender.Options.Add('-NSData.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win;Bde;Vcl;Vcl.Imaging;Vcl.Touch;Vcl.Samples;Vcl.Shell;System;Xml;Data;Datasnap;Web;Soap;Winapi;System.Win');

     if MatchText(VersionNumberStr, ['d17','d18','d19','d20','d21','d22','d23','d24','d25','d26', 'd27', 'd28', 'd29']) then
     begin
       Sender.Options.Add('-NSWinapi;System.Win;Data.Win;Datasnap.Win;Web.Win;Soap.Win;Xml.Win;Bde;System;Xml;Data;Datasnap;Web;Soap;Vcl;Vcl.Imaging;Vcl.Touch;Vcl.Samples;Vcl.Shell;IBX');
     end;

  end;
end;

procedure TFrmPrincipal.btnSelecDirInstallClick(Sender: TObject);
var
  Dir: String;
begin
  if SelectDirectory('Selecione o diretório de instalação', '', Dir,
    [sdNewFolder, sdNewUI, sdValidateDir]) then
    edtDirDestino.Text := Dir;
end;

procedure TFrmPrincipal.btnVisualizarLogCompilacaoClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PWideChar(PathArquivoLog), '', '', 1);
end;

// criação dos diretórios necessários
procedure TfrmPrincipal.CreateDirectoryLibrarysNotExist;
begin
  if not System.SysUtils.ForceDirectories(sDirLibrary) then
    raise Exception.CreateFmt('Não foi possível criar o diretório "%s".',
      [sDirLibrary]);
end;

procedure TFrmPrincipal.DeixarSomenteLib;
procedure Copiar(const Extensao : string);
  var
    ListArquivos: TStringDynArray;
    Arquivo : string;
    i: integer;
  begin
    ListArquivos := TDirectory.GetFiles(IncludeTrailingPathDelimiter(sDirRoot) + 'Source', Extensao ,TSearchOption.soAllDirectories ) ;
    for i := Low(ListArquivos) to High(ListArquivos) do
    begin
      Arquivo := ExtractFileName(ListArquivos[i]);
      TFile.Copy(ListArquivos[i],
        IncludeTrailingPathDelimiter(sDirLibrary) + Arquivo, True);
    end;
  end;
begin
  // remover os path com o segundo parametro
  FindDirs(IncludeTrailingPathDelimiter(sDirRoot) + 'Source', tPlatform, False);

  Copiar('*.dcr');
  Copiar('*.res');
  Copiar('*.dfm');
  Copiar('*.ini');
	Copiar('*.inc');
end;

procedure TFrmPrincipal.btnInstalarClick(Sender: TObject);
var
  iDpk: Integer;
  bRunOnly: Boolean;
  NomePacote: String;
  Cabecalho: String;

  procedure Logar(const AString: String);
  begin
    lstMsgInstalacao.Items.Add(AString);
    lstMsgInstalacao.ItemIndex := lstMsgInstalacao.Count - 1;
    Application.ProcessMessages;

    WriteToTXT(PathArquivoLog, AString);
  end;

  procedure MostrarMensagemInstalado(const aMensagem: String; const aErro: String = '');
  var
    Msg: String;
  begin

    Msg := Format(aMensagem + ' em "%s"', [sPathBin]);

    WriteToTXT(PathArquivoLog, '');
    Logar(Msg);
  end;

  procedure IncrementaBarraProgresso;
  begin
    pgbInstalacao.Position := pgbInstalacao.Position + 1;
    Application.ProcessMessages;
  end;

begin

  FCountErros := 0;

  btnInstalar.Enabled := False;
  wizPgInstalacao.EnableButton(bkNext, False);
  wizPgInstalacao.EnableButton(bkBack, False);
  wizPgInstalacao.EnableButton(TJvWizardButtonKind(bkCancel), False);
  try
    Cabecalho := 'Caminho: ' + edtDirDestino.Text + sLineBreak +
                 'Versão do delphi: ' + edtDelphiVersion.Text + ' (' + IntToStr(iVersion)+ ')' + sLineBreak +
                 'Plataforma: ' + edtPlatform.Text + '(' + IntToStr(Integer(tPlatform)) + ')' + sLineBreak +
                 StringOfChar('=', 80);

    // limpar o log
    lstMsgInstalacao.Clear;
    WriteToTXT(PathArquivoLog, Cabecalho, False);

    // setar barra de progresso
    pgbInstalacao.Position := 0;
    pgbInstalacao.Max := (frameDpk.Pacotes.Count * 2) + 6;


    // *************************************************************************
    // removendo arquivos antigos se configurado
    // *************************************************************************
    (*if ckbRemoverArquivosAntigos.Checked then
    begin
      if Application.MessageBox(
        'você optou por limpar arquivos antigos do UserControl do seu computador, essa ação pode demorar vários minutos, deseja realmente continuar com está ação?',
        'Limpar',
        MB_YESNO + MB_DEFBUTTON2
      ) = ID_YES then
      begin
        Logar('Removendo arquivos antigos do disco...');
        RemoverArquivosAntigosDoDisco;
        IncrementaBarraProgresso;
      end;
    end; *)


    // *************************************************************************
    // Seta a plataforna selecionada
    // *************************************************************************
    Logar('Setando parâmetros de plataforma...');
    SetPlatformSelected;
    IncrementaBarraProgresso;


    // *************************************************************************
    // Cria diretório de biblioteca da versão do delphi selecionada,
    // só será criado se não existir
    // *************************************************************************
    Logar('Criando diretórios de bibliotecas...');
    CreateDirectoryLibrarysNotExist;
    IncrementaBarraProgresso;


    // *************************************************************************
    // remover paths do delphi
    // *************************************************************************
    (*Logar('Removendo diretorios e pacotes antigos instalados...');
    RemoverDiretoriosEPacotesAntigos; *)
    IncrementaBarraProgresso;


    // *************************************************************************
    // Adiciona os paths dos fontes na versão do delphi selecionada
    // *************************************************************************
    Logar('Adicionando library paths...');
    AddLibrarySearchPath;
    IncrementaBarraProgresso;


    // *************************************************************************
    // compilar os pacotes primeiramente
    // *************************************************************************
    Logar('');
    Logar('COMPILANDO OS PACOTES...');
    for iDpk := 0 to frameDpk.Pacotes.Count - 1 do
    begin
      NomePacote := frameDpk.Pacotes[iDpk].Caption;

      // Busca diretório do pacote
      ExtrairDiretorioPacote(NomePacote);

      if (IsDelphiPackage(NomePacote)) and (frameDpk.Pacotes[iDpk].Checked) then
      begin
        if sDirPackage = '' then
        begin
          Inc(FCountErros);
          Logar(Format('Pacote "%s" não foi encontrado.', [NomePacote]));
          Break;
        end;

        WriteToTXT(PathArquivoLog, '');

        if oUserControl.Installations[iVersion].CompilePackage(sDirPackage + NomePacote, sDirLibrary, sDirLibrary) then
          Logar(Format('Pacote "%s" compilado com sucesso.', [NomePacote]))
        else
        begin
          Inc(FCountErros);
          Logar(Format('Erro ao compilar o pacote "%s".', [NomePacote]));

          // parar no primeiro erro para evitar de compilar outros pacotes que
          // precisam do pacote que deu erro
          Break
        end;
      end;

      IncrementaBarraProgresso;
    end;


    // *************************************************************************
    // instalar os pacotes somente se não ocorreu erro na compilação e plataforma for Win32
    // *************************************************************************
    if (edtPlatform.ItemIndex = 0) then
    begin
      if (FCountErros <= 0) then
      begin
        Logar('');
        Logar('INSTALANDO OS PACOTES...');

        for iDpk := 0 to frameDpk.Pacotes.Count - 1 do
        begin
          NomePacote := frameDpk.Pacotes[iDpk].Caption;

          // Busca diretório do pacote
          ExtrairDiretorioPacote(NomePacote);

          if IsDelphiPackage(NomePacote) then
          begin
            if sDirPackage = '' then
            begin
              Inc(FCountErros);
              Logar(Format('Pacote "%s" não foi encontrado.', [NomePacote]));
              Break;
            end;

            // instalar somente os pacotes de designtime
            GetDPKFileInfo(sDirPackage + NomePacote, bRunOnly);
            if not bRunOnly then
            begin
              // se o pacote estiver marcado instalar, senão desinstalar
              if frameDpk.Pacotes[iDpk].Checked then
              begin
                WriteToTXT(PathArquivoLog, '');

                if oUserControl.Installations[iVersion].InstallPackage(sDirPackage + NomePacote, sDirLibrary, sDirLibrary) then
                  Logar(Format('Pacote "%s" instalado com sucesso.', [NomePacote]))
                else
                begin
                  Inc(FCountErros);
                  Logar(Format('Ocorreu um erro ao instalar o pacote "%s".', [NomePacote]));

                  Break;
                end;
              end
              else
              begin
                WriteToTXT(PathArquivoLog, '');

                if oUserControl.Installations[iVersion].UninstallPackage(
                  sDirPackage + NomePacote, sDirLibrary, sDirLibrary) then
                  Logar(Format('Pacote "%s" removido com sucesso.', [NomePacote]))
                else
                  Logar(Format(
                    'Pacote "%s" não estava instalado; nenhuma remoção necessária.',
                    [NomePacote]));
              end;
            end;
          end;

          IncrementaBarraProgresso;
        end;
      end
      else
      begin
        Logar('');
        Logar('Abortando... Ocorreram erros na compilação dos pacotes.');
      end;
    end
    else
    begin
      Logar('');
      Logar('Para a plataforma de 64 bits os pacotes são somente compilados.');
    end;


    // *************************************************************************
    // não instalar outros requisitos se ocorreu erro anteriormente
    // *************************************************************************
    if FCountErros <= 0 then
    begin
      Logar('');
      Logar('INSTALANDO OUTROS REQUISITOS...');

      // *************************************************************************
      // deixar somente a pasta lib se for configurado assim
      // *************************************************************************
      if chkDeixarSomenteLIB.Checked then
      begin
        try
          DeixarSomenteLib;

          MostrarMensagemInstalado('Limpeza library path com sucesso');
          MostrarMensagemInstalado('Copia dos arquivos necessário.');
        except
          on E: Exception do
          begin
            Inc(FCountErros);
            MostrarMensagemInstalado(
              'Erro ao limpar os paths e copiar arquivos:' + sLineBreak +
              E.Message);
          end;
        end;
      end;
    end;
  finally
    btnInstalar.Enabled := True;
    wizPgInstalacao.EnableButton(bkBack, True);
    wizPgInstalacao.EnableButton(bkNext, FCountErros = 0);
    wizPgInstalacao.EnableButton(TJvWizardButtonKind(bkCancel), True);
  end;

  if FCountErros = 0 then
  begin
    Application.MessageBox(
      PWideChar(
        'Pacotes compilados e instalados com sucesso! '+sLineBreak+
        'Clique em "Próximo" para finalizar a instalação.'
      ),
      'Instalação',
      MB_ICONINFORMATION + MB_OK
    );
  end
  else
  begin
    if Application.MessageBox(
      PWideChar(
        'Ocorreram erros durante o processo de instalação, '+sLineBreak+
        'para maiores informações verifique o arquivo de log gerado.'+sLineBreak+sLineBreak+
        'Deseja visualizar o arquivo de log gerado?'
      ),
      'Instalação',
      MB_ICONQUESTION + MB_YESNO
    ) = ID_YES then
    begin
      btnVisualizarLogCompilacao.Click;
    end;
  end;

end;

procedure TFrmPrincipal.edtDelphiVersionChange(Sender: TObject);
begin
  if edtDelphiVersion.ItemIndex < 0 then
  begin
    iVersion := -1;
    Exit;
  end;

  iVersion := NativeInt(
    edtDelphiVersion.Items.Objects[edtDelphiVersion.ItemIndex]);
  sPathBin := IncludeTrailingPathDelimiter(oUserControl.Installations[iVersion]
    .BinFolderName);
  // -- Plataforma só habilita para Delphi XE2
  // -- Desabilita para versão diferente de Delphi XE2
  edtPlatform.Enabled := oUserControl.Installations[iVersion].VersionNumber >= 16;
  if oUserControl.Installations[iVersion].VersionNumber < 16 then
    edtPlatform.ItemIndex := 0;

  // C++ Builder a partir do D2006, versões anteriores tem IDE independentes.
  ckbBCB.Enabled := MatchText(oUserControl.Installations[iVersion].VersionNumberStr,
    ['d10', 'd11', 'd12', 'd14', 'd15', 'd16', 'd17', 'd18', 'd19', 'd20',
    'd21', 'd22', 'd23', 'd24', 'd25', 'd26', 'd27', 'd28', 'd29']);
  if not ckbBCB.Enabled then
    ckbBCB.Checked := False;
end;

procedure TFrmPrincipal.ExtrairDiretorioPacote(NomePacote: string);
  procedure FindDirPackage(sDir, sPacote: String);
  var
    oDirList: TSearchRec;
  begin
    if sDirPackage <> '' then
      Exit;

    sDir := IncludeTrailingPathDelimiter(sDir);
    if not System.SysUtils.DirectoryExists(sDir) then
      Exit;

    if System.SysUtils.FindFirst(sDir + '*.*', faAnyFile, oDirList) = 0 then
    begin
      try
        repeat

          if (oDirList.Name = '.')  or (oDirList.Name = '..') or (oDirList.Name = '__history') then
            Continue;

          //if oDirList.Attr = faDirectory then
          if System.SysUtils.DirectoryExists(sDir + oDirList.Name) then
            FindDirPackage(sDir + oDirList.Name, sPacote)
          else
          begin
            if SameText(oDirList.Name, sPacote) then
            begin
              sDirPackage := IncludeTrailingPathDelimiter(sDir);
              Exit;
            end;
          end;

        until System.SysUtils.FindNext(oDirList) <> 0;
      finally
        System.SysUtils.FindClose(oDirList);
      end;
    end;
  end;

begin
  sDirPackage := '';

  FindDirPackage(sDirRoot + 'Packages\', NomePacote);
end;

procedure TFrmPrincipal.FindDirs(ADirRoot: String;
  APlatform: TJclBDSPlatform; bAdicionar: Boolean);
var
  oDirList: TSearchRec;

  function EProibido(const ADir: String): Boolean;
  const
    LISTA_PROIBIDOS: ARRAY[0..4] OF STRING = (
      'quick', 'rave', 'laz', 'VerificarNecessidade', '__history'
    );
  var
    ForbiddenName: String;
  begin
    for ForbiddenName in LISTA_PROIBIDOS do
      if ContainsText(ADir, ForbiddenName) then
        Exit(True);
    Result := False;
  end;

begin
  ADirRoot := IncludeTrailingPathDelimiter(ADirRoot);

  if FindFirst(ADirRoot + '*.*', faDirectory, oDirList) = 0 then
  begin
     try
       repeat
          if ((oDirList.Attr and faDirectory) <> 0) and
              (oDirList.Name <> '.')                and
              (oDirList.Name <> '..')               and
              (not EProibido(oDirList.Name)) then
          begin
             with oUserControl.Installations[iVersion] do
             begin
               if bAdicionar then
               begin
                  AddToLibrarySearchPath(ADirRoot + oDirList.Name, APlatform);
                  AddToLibraryBrowsingPath(ADirRoot + oDirList.Name, APlatform);
               end
               else
                  RemoveFromLibrarySearchPath(ADirRoot + oDirList.Name, APlatform);
             end;
             //-- Procura subpastas
             FindDirs(ADirRoot + oDirList.Name, APlatform, bAdicionar);
          end;
       until FindNext(oDirList) <> 0;
     finally
       System.SysUtils.FindClose(oDirList)
     end;
  end;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  oUserControl.Free;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
  iFor: Integer;
begin
  iVersion := -1;
  sDirRoot := '';
  sDirLibrary := '';
  sDirPackage := '';

  oUserControl := TJclBorRADToolInstallations.Create;

  // popular o combobox de versões do delphi instaladas na máquina
  for iFor := 0 to oUserControl.Count - 1 do
  begin
    if oUserControl.Installations[iFor].VersionNumberStr = 'd3' then
      edtDelphiVersion.Items.AddObject('Delphi 3', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd4' then
      edtDelphiVersion.Items.AddObject('Delphi 4', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd5' then
      edtDelphiVersion.Items.AddObject('Delphi 5', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd6' then
      edtDelphiVersion.Items.AddObject('Delphi 6', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd7' then
      edtDelphiVersion.Items.AddObject('Delphi 7', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd9' then
      edtDelphiVersion.Items.AddObject('Delphi 2005', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd10' then
      edtDelphiVersion.Items.AddObject('Delphi 2006', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd11' then
      edtDelphiVersion.Items.AddObject('Delphi 2007', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd12' then
      edtDelphiVersion.Items.AddObject('Delphi 2009', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd14' then
      edtDelphiVersion.Items.AddObject('Delphi 2010', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd15' then
      edtDelphiVersion.Items.AddObject('Delphi XE', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd16' then
      edtDelphiVersion.Items.AddObject('Delphi XE2', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd17' then
      edtDelphiVersion.Items.AddObject('Delphi XE3', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd18' then
      edtDelphiVersion.Items.AddObject('Delphi XE4', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd19' then
      edtDelphiVersion.Items.AddObject('Delphi XE5', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd20' then
      edtDelphiVersion.Items.AddObject('Delphi XE6', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd21' then
      edtDelphiVersion.Items.AddObject('Delphi XE7', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd22' then
      edtDelphiVersion.Items.AddObject('Delphi XE8', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd23' then
      edtDelphiVersion.Items.AddObject('Delphi 10 Seattle', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd24' then
      edtDelphiVersion.Items.AddObject('Delphi 10.1 Berlin', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd25' then
      edtDelphiVersion.Items.AddObject('Delphi 10.2 Tokyo', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd26' then
      edtDelphiVersion.Items.AddObject('Delphi 10.3 Rio', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd27' then
      edtDelphiVersion.Items.AddObject('Delphi 10.4 Sydney', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd28' then
      edtDelphiVersion.Items.AddObject('Delphi 11 Alexandria', TObject(NativeInt(iFor)))
    else if oUserControl.Installations[iFor].VersionNumberStr = 'd29' then   // 04/06/2024 - Kellson Nunes Rocha: Foi acrescentado a versão d29 athens para o matchtext
      edtDelphiVersion.Items.AddObject('Delphi 12 Athens', TObject(NativeInt(iFor)));

    // -- Evento disparado antes de iniciar a execução do processo.
    oUserControl.Installations[iFor].DCC32.OnBeforeExecute := BeforeExecute;

    // -- Evento para saidas de mensagens.
    oUserControl.Installations[iFor].OutputCallback := OutputCallLine;
  end;

  if edtDelphiVersion.Items.Count = 0 then
  begin
    btnInstalar.Enabled := False;
    Application.MessageBox(
      'Nenhuma versão compatível do Delphi foi encontrada.',
      'Instalador UserControl', MB_OK + MB_ICONERROR);
    Exit;
  end;

  edtDelphiVersion.ItemIndex := 0;
  iVersion := NativeInt(edtDelphiVersion.Items.Objects[0]);
  LerConfiguracoes;
end;

procedure TFrmPrincipal.GravarConfiguracoes;
var
  ArqIni: TIniFile;
  I: Integer;
begin
  ArqIni := TIniFile.Create(PathArquivoIni);
  try
    ArqIni.WriteString('CONFIG', 'DiretorioInstalacao', edtDirDestino.Text);
    ArqIni.WriteString('CONFIG', 'DelphiVersao', edtDelphiVersion.Text);
    ArqIni.WriteString('CONFIG', 'Plataforma', edtPlatform.Text);
    ArqIni.WriteBool('CONFIG', 'C++Builder', ckbBCB.Checked);

    for I := 0 to frameDpk.Pacotes.Count - 1 do
      ArqIni.WriteBool('PACOTES', frameDpk.Pacotes[I].Caption,
        frameDpk.Pacotes[I].Checked);
  finally
    ArqIni.Free;
  end;
end;

procedure TFrmPrincipal.Image1Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PWideChar(lblUrlUserControl1.Caption), '', '', 1);
end;

procedure TFrmPrincipal.lblUrlPIXClick(Sender: TObject);
begin
  Clipboard.asText := TLabel(Sender).Caption;

  Application.MessageBox('Chave copiada para a área de transferência!',
    'Apoio ao Projeto', MB_ICONINFORMATION + MB_OK);
end;

procedure TFrmPrincipal.wizPgConfiguracaoCancelButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  if Application.MessageBox(
    'Deseja realmente cancelar a instalação?',
    'Fechar',
    MB_ICONQUESTION + MB_YESNO
  ) = ID_YES then
  begin
    Self.Close;
  end;
end;

procedure TFrmPrincipal.wizPgConfiguracaoFinishButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  Self.Close;
end;

procedure TFrmPrincipal.wizPgConfiguracaoNextButtonClick(Sender: TObject;
  var Stop: Boolean);
var
  RootDirectory: String;
begin
  Stop := True;
  RootDirectory := IncludeTrailingPathDelimiter(Trim(edtDirDestino.Text));

  if RootDirectory = '' then
  begin
    edtDirDestino.SetFocus;
    Application.MessageBox('Diretório de instalação não foi informado.',
      'Erro.', MB_OK + MB_ICONERROR);
    Exit;
  end;

  if not System.SysUtils.DirectoryExists(RootDirectory) then
  begin
    edtDirDestino.SetFocus;
    Application.MessageBox('O diretório de instalação não existe.',
      'Erro.', MB_OK + MB_ICONERROR);
    Exit;
  end;

  if not System.SysUtils.DirectoryExists(RootDirectory + 'Source') or
    not System.SysUtils.DirectoryExists(RootDirectory + 'Packages') then
  begin
    edtDirDestino.SetFocus;
    Application.MessageBox(
      'O diretório informado não contém as pastas Source e Packages.',
      'Erro.', MB_OK + MB_ICONERROR);
    Exit;
  end;

  if (edtDelphiVersion.ItemIndex < 0) or (iVersion < 0) then
  begin
    edtDelphiVersion.SetFocus;
    Application.MessageBox('Versão do Delphi não foi informada.',
      'Erro.', MB_OK + MB_ICONERROR);
    Exit;
  end;

  if edtPlatform.ItemIndex < 0 then
  begin
    edtPlatform.SetFocus;
    Application.MessageBox('Plataforma de compilação não foi informada.',
      'Erro.', MB_OK + MB_ICONERROR);
    Exit;
  end;

  GravarConfiguracoes;
  Stop := False;
end;

procedure TFrmPrincipal.wizPgInstalacaoEnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
  SetPlatformSelected;
  lstMsgInstalacao.Clear;
  pgbInstalacao.Position := 0;

  // mostrar ao usuário as informações de compilação
  with lbInfo.Items do
  begin
    Clear;
    Add(edtDelphiVersion.Text + ' ' + edtPlatform.Text);
    Add('Dir. Instalação  : ' + edtDirDestino.Text);
    Add('Dir. Bibliotecas : ' + sDirLibrary);
  end;

  // para 64 bit somente compilar
  if tPlatform = bpWin32 then // Win32
    btnInstalar.Caption := 'Instalar'
  else // win64
    btnInstalar.Caption := 'Compilar';
end;

procedure TFrmPrincipal.wizPgInstalacaoNextButtonClick(Sender: TObject;
  var Stop: Boolean);
begin
  if (lstMsgInstalacao.Count <= 0) then
  begin
    Stop := True;
    Application.MessageBox(
      'Clique no botão instalar antes de continuar.',
      'Erro.',
      MB_OK + MB_ICONERROR
    );
  end;

  if (FCountErros > 0) then
  begin
    Stop := True;
    Application.MessageBox(
      'Ocorreram erros durante a compilação e instalação dos pacotes, verifique.',
      'Erro.',
      MB_OK + MB_ICONERROR
    );
  end;
end;

procedure TFrmPrincipal.LerConfiguracoes;
var
  ArqIni: TIniFile;
  I: Integer;
begin
  ArqIni := TIniFile.Create(PathArquivoIni);
  try
    edtDirDestino.Text := ArqIni.ReadString('CONFIG', 'DiretorioInstalacao',
      ExtractFilePath(ParamStr(0)));
    edtPlatform.ItemIndex := edtPlatform.Items.IndexOf
      (ArqIni.ReadString('CONFIG', 'Plataforma', 'Win32'));
    if edtPlatform.ItemIndex < 0 then
      edtPlatform.ItemIndex := 0;
    edtDelphiVersion.ItemIndex := edtDelphiVersion.Items.IndexOf
      (ArqIni.ReadString('CONFIG', 'DelphiVersao', ''));
    ckbBCB.Checked := ArqIni.ReadBool('CONFIG', 'C++Builder', False);

    if Trim(edtDelphiVersion.Text) = '' then
      edtDelphiVersion.ItemIndex := 0;

    edtDelphiVersionChange(edtDelphiVersion);

    for I := 0 to frameDpk.Pacotes.Count - 1 do
      frameDpk.Pacotes[I].Checked := ArqIni.ReadBool('PACOTES',
        frameDpk.Pacotes[I].Caption, False);
  finally
    ArqIni.Free;
  end;
end;

// Evento disparado a cada ação do instalador
procedure TfrmPrincipal.OutputCallLine(const Text: string);
begin
  // remover a warnings de conversão de string (delphi 2010 em diante)
  // as diretivas -W e -H não removem estas mensagens
  if (pos('Warning: W1057', Text) <= 0) and ((pos('Warning: W1058', Text) <= 0)) then
    WriteToTXT(PathArquivoLog, Text);
end;

// retornar o path do aplicativo
function TfrmPrincipal.PathApp: String;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
end;

// retornar o caminho completo para o arquivo .ini de configurações
function TfrmPrincipal.PathArquivoIni: String;
var
  NomeApp: String;
begin
  NomeApp := ExtractFileName(ParamStr(0));
  Result := PathApp + ChangeFileExt(NomeApp, '.ini');
end;

// retornar o caminho completo para o arquivo de logs
function TfrmPrincipal.PathArquivoLog: String;
begin
  Result := PathApp + 'log_' +
  StringReplace(edtDelphiVersion.Text, ' ', '_', [rfReplaceAll]) + '.txt';
end;

function TFrmPrincipal.LibraryDirectory(
  APlatform: TJclBDSPlatform): String;
var
  VersionSuffix: String;
begin
  VersionSuffix := AnsiUpperCase(
    oUserControl.Installations[iVersion].VersionNumberStr);
  Result := IncludeTrailingPathDelimiter(edtDirDestino.Text) +
    'Lib\Delphi\Lib' + VersionSuffix;
  if APlatform = bpWin64 then
    Result := Result + 'x64';
end;

procedure TFrmPrincipal.SetPlatformSelected;
begin
  if edtDelphiVersion.ItemIndex < 0 then
    raise Exception.Create('Nenhuma versão do Delphi foi selecionada.');
  iVersion := NativeInt(
    edtDelphiVersion.Items.Objects[edtDelphiVersion.ItemIndex]);
  sDirRoot := IncludeTrailingPathDelimiter(edtDirDestino.Text);

  if edtPlatform.ItemIndex = 0 then
    tPlatform := bpWin32
  else
    tPlatform := bpWin64;

  sDirLibrary := LibraryDirectory(tPlatform);
  if not System.SysUtils.ForceDirectories(sDirLibrary) then
    raise Exception.CreateFmt('Não foi possível criar o diretório "%s".',
      [sDirLibrary]);
end;

procedure TFrmPrincipal.URLClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PWideChar(TLabel(Sender).Caption), '', '', 1);
end;

procedure TFrmPrincipal.WriteToTXT(const ArqTXT, AString: String;
  const AppendIfExists: Boolean; AddLineBreak: Boolean);
var
  FS: TFileStream;
  Bytes: TBytes;
  Text: String;
  OpenMode: Word;
begin
  Text := AString;
  if AddLineBreak then
    Text := Text + sLineBreak;
  Bytes := TEncoding.UTF8.GetBytes(Text);

  if AppendIfExists and FileExists(ArqTXT) then
    OpenMode := fmOpenReadWrite
  else
    OpenMode := fmCreate;

  FS := TFileStream.Create(ArqTXT, OpenMode or fmShareDenyWrite);
  try
    if OpenMode = fmOpenReadWrite then
      FS.Seek(0, soFromEnd);
    if Length(Bytes) > 0 then
      FS.WriteBuffer(Bytes[0], Length(Bytes));
  finally
    FS.Free;
  end;
end;

end.
