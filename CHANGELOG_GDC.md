# Alterações do fork GDC

## Em desenvolvimento

### Conexao independente de driver

- Adicionado `IUCDataConnection`, contrato sem dependencia de REST, FireDAC ou
  outro driver de acesso a dados.
- Adicionado `TUCConnectionAdapter`, classe de runtime que integra uma conexao
  da aplicacao ao `TUCDataConnector` sem registrar componente na paleta.
- Padronizado que o chamador e responsavel por liberar o dataset retornado por
  `UCGetSQLDataset`; os connectors Midas, DataSnap e REST agora criam esses
  datasets com `Owner = nil`.
- Adicionado teste com conexao falsa para validar delegacao, erros de
  configuracao e propriedade do dataset.
- Adicionada a extensao opcional `IUCDataConnectionRefresh` para conexoes que
  materializam dados por REST/RPC sem depender do ciclo `Close/Open`.
- Os fluxos de usuarios e perfis agora usam `RefreshDataSet`, preservando a
  estrategia de recarga definida pela conexao da aplicacao.

### Instalador em unidades de rede mapeadas

- O manifesto do `UCSWInstall` deixou de exigir elevação administrativa para
  preservar o acesso a unidades de rede mapeadas, como `Y:`.
- Removida a rotina legada e não utilizada de autoelevação com `runas`.
- O instalador agora registra automaticamente fontes e bibliotecas nos Library
  Paths Win32 e Win64, mantendo o PATH da IDE restrito aos BPLs Win32.
- Corrigido o vínculo entre os itens do combo de versões e os índices reais das
  instalações detectadas pela JCL.
- A compilação dos pacotes em modo Release agora habilita otimização e desabilita
  stack frames.
- Cópias para a pasta `Lib` passam a sobrescrever arquivos antigos e propagar
  falhas; pacotes ausentes também interrompem a instalação com erro explícito.
- Logs do instalador passam a ser gravados em UTF-8.
- Removidas do `.dproj` listas de runtime packages específicas da máquina que
  originalmente gerou o projeto.
- Corrigida a validação do diretório-fonte, da versão do Delphi e da plataforma
  antes de persistir as configurações.

### Estabilização

- Corrigidas validações de configuração que instanciavam exceções sem lançá-las.
- Corrigido o ciclo de vida das threads de inicialização e mensagens.
- A thread de mensagens agora executa periodicamente e responde ao encerramento.
- Corrigidos vazamentos no fluxo de recuperação de senha e no cliente SMTP.
- Removida exceção silenciosamente descartada no envio de nova senha.
- Removidas chamadas a métodos abstratos herdados nos conectores REST.
- Removida chamada duplicada a `Notification` no connector DataSnap REST.
- Senhas temporárias deixam de reinicializar o gerador pseudoaleatório a cada
  caractere.
- Corrigida a remoção de `TUCControls` do monitor, agora feita em ordem inversa
  e sem exceções silenciosamente descartadas.
- A janela de mensagens e seus datasets passam a ser liberados mesmo quando a
  montagem da tela falha.
- `TUCIdle` restaura o handler anterior de `Application.OnMessage`, encerra sua
  thread explicitamente e trata `Timeout = 0` como desativado.
- O contrato base dos connectors agora rejeita datasets nulos e ordenação sem
  nome de campo com mensagens de erro claras.
- Os connectors RESTDataWare acompanham a destruição do database por
  `FreeNotification` e validam sua configuração antes de executar comandos.
- `TUCCurrentUser` passa a liberar os datasets de perfil ao substituí-los,
  evitando vazamentos a cada login ou reabertura do cadastro de usuários.
- Corrigida a identificação de erros `TABLE UNKNOWN`/`COLUMN UNKNOWN` em
  `pUCGeral`; demais falhas deixam de ser descartadas por engano.
- Removida a criacao direta da classe abstrata `TDataSet` no editor de perfis;
  datasets opcionais de perfil agora sao verificados antes do acesso.
- Substituidas as chamadas depreciadas de `TThread.Resume` por `Start`.
- Corrigidos vazamentos de datasets nas consultas de usuarios, alteracao de
  senha, mensagens, usuarios conectados e copia/exclusao de perfis.
- A validacao anterior a exclusao agora consulta o usuario selecionado, em vez
  do usuario que esta executando o cadastro.
- Consultas temporarias passam a liberar seus datasets tambem quando ocorre
  uma excecao durante leitura, descriptografia ou atualizacao da interface.
- `TUCUsersLogged` passa a manter sessoes por heartbeat, com data UTC e
  expiracao automatica de registros abandonados.
- A verificacao e a listagem de sessoes agora consideram o `ApplicationID` e
  removem registros do formato legado.
- A tela de usuarios logados apresenta o timestamp UTC convertido para o
  horario local e removeu um `JOIN` de perfil que nao era utilizado.
- A lista de usuarios agora oculta inativos por padrao e oferece uma opcao para
  exibi-los, combinavel com os filtros de nome, login e e-mail.
- A tela de logs agora exibe a mensagem completa da linha selecionada em um
  painel redimensionavel e permite copiar o conteudo para a area de transferencia.
- Imagens de usuarios deixam de ser incorporadas ao SQL principal; o adapter
  passa a ler e gravar o BLOB como bytes por dataset e `ApplyDataLog`.
- O cadastro passa a exibir botoes para carregar e remover a imagem, envia a foto
  apenas quando alterada e normaliza novas imagens para JPEG de ate 256 pixels.
- Removido o formato legado Base64/ZLib: novas fotos sao persistidas como JPEG
  bruto no BLOB e valores antigos deixam de ser carregados.
- A edicao de permissoes ganhou uma busca global por descricao e identificadores
  internos, cobrindo menus, acoes e permissoes estendidas sem alterar marcacoes.
- A carga de permissoes passa a usar indices em memoria em vez de executar um
  `Locate` para cada item; a gravacao envia somente inclusoes e remocoes reais.
- Novas permissoes sao inseridas antes das remocoes, evitando revogar direitos
  existentes quando um conector sem suporte transacional falha na inclusao.
- A listagem de usuarios deixa de transportar todas as imagens; a foto passa a
  ser consultada somente ao abrir o cadastro para alteracao.
- Adicionadas extensoes opcionais para leitura e gravacao de campos binarios,
  permitindo que cada conexao transporte BLOBs sem conversao para texto.
- Iniciada a modernizacao visual com uma classe de estilo sem componente de
  paleta, fonte Segoe UI e convencoes comuns para botoes, paineis e grades.
- A lista de usuarios passa a usar acoes e filtros no topo, pesquisa por Enter,
  colunas responsivas e exibicao traduzida do status ativo/inativo.
- O cadastro de usuarios passa a ser redimensionavel, com campos ancorados,
  area de imagem mais clara e acoes principais posicionadas no rodape.

### Segurança

- Adicionada a unit `UCPasswordHash` com PBKDF2-HMAC-SHA-256, salt aleatório,
  600.000 iterações e verificação em tempo constante.
- A nova API é opt-in e não modifica credenciais existentes automaticamente.
- Adicionado guia de migração e requisitos de schema/deploy.

### Transporte de e-mail

- Removida a dependência legada do Alcinoe e o pacote `pckAlcinoe`.
- Adicionado o contrato `IUCMailSender`, permitindo injetar um transporte da
  aplicação sem instalar um novo componente visual.
- Adicionado o transporte padrão baseado em Indy, com TLS explícito/implícito,
  timeout de conexão e timeout de leitura.
- Mantidos os nomes e a ordem dos valores de `AuthType` para compatibilidade
  com formulários existentes.
- O corpo HTML deixa de ser convertido para `AnsiString` antes do envio.
