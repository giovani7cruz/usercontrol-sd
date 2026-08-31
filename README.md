# UserControl GDC

Fork do User Control ShowDelphi Edition voltado à modernização do código, da
interface e da integração com aplicações Delphi atuais.

O histórico das alterações deste fork está em
[CHANGELOG_GDC.md](CHANGELOG_GDC.md).

## Status do projeto e compatibilidade

O ambiente de desenvolvimento atual é o **Delphi 12 Athens**, no Windows. Isso
indica o alvo das melhorias em andamento, mas **não representa uma matriz de
compatibilidade certificada**.

Neste momento:

- não há uma suíte que valide automaticamente todas as versões do Delphi;
- versões antigas do Delphi não são prioridade e podem deixar de compilar após
  modernizações necessárias;
- a compatibilidade com Lazarus/FPC e com conectores legados não está sendo
  testada regularmente;
- Win32 e Win64 devem ser validados pela aplicação que consumir a biblioteca;
- cada atualização deve ser testada no ambiente do projeto antes de ir para
  produção.

Contribuições que acrescentem testes ou confirmem o funcionamento em outros
ambientes são bem-vindas, mas uma compilação isolada não será anunciada como
suporte oficial sem manutenção contínua.

## Objetivos do fork

- modernizar o código para as práticas e APIs atuais do Delphi;
- reduzir dependências antigas e remover integrações sem manutenção;
- permitir conexão por classes da própria aplicação, sem exigir um componente
  visual ou dependência direta de `TRESTClient`;
- respeitar o ciclo de vida de datasets materializados por REST/RPC, evitando
  recargas baseadas obrigatoriamente em `Close`/`Open`;
- melhorar segurança, tratamento de erros, gerenciamento de memória e clareza
  dos contratos;
- atualizar as telas VCL para DPI, redimensionamento, teclado e melhor
  usabilidade;
- manter o instalador e os caminhos de biblioteca adequados ao Delphi atual.

Compatibilidade retroativa será preservada quando tiver baixo custo e não
impedir essas melhorias, mas não é o objetivo principal deste fork.

## Integração com dados

A integração recomendada para novas aplicações é feita por
`IUCDataConnection` e `TUCConnectionAdapter`. Assim, o UserControl pode delegar
consultas, comandos, atualizações e transporte de BLOBs às classes de conexão da
própria aplicação.

Consulte [CONNECTION_ADAPTER.md](CONNECTION_ADAPTER.md) para o contrato e um
exemplo de uso.

Os conectores antigos permanecem no repositório por enquanto, mas não existe
garantia de que todos estejam funcionais ou compatíveis com o Delphi 12.

## Segurança e serviços externos

- [MIGRACAO_SEGURANCA.md](MIGRACAO_SEGURANCA.md) descreve a API opt-in de hash
  forte e o procedimento de migração de senhas.
- [MAIL_TRANSPORT.md](MAIL_TRANSPORT.md) descreve o transporte de e-mail por
  Indy e a injeção de uma implementação própria.
- [USERS_LOGGED.md](USERS_LOGGED.md) documenta o controle de sessões por
  heartbeat.

## Instalação

O repositório inclui o `UCSWInstall.exe`. Para recompilar o instalador no
ambiente configurado, use um dos scripts da raiz:

- `Compilar-UCSWInstall.bat`
- `Compilar-UCSWInstall.ps1`

O instalador configura os caminhos de biblioteca Win32 e Win64. A instalação e
a compilação dos pacotes devem ser verificadas no Delphi 12 antes de utilizar o
componente em uma aplicação.

## Contribuições

Contribuições podem incluir correções, modernização, documentação, exemplos e
testes reproduzíveis. Ao relatar compatibilidade, informe pelo menos:

- versão e edição do Delphi;
- plataforma alvo;
- connector ou adapter utilizado;
- banco de dados;
- pacotes e fluxos efetivamente testados.

## Suporte e comunidade

- Fórum: <https://showdelphi.com.br/forum/forum/duvidas-e-problemas-relacionados-ao-usercontrol-showdelphi-edition/>
- Comunidade: <https://showdelphi.com.br>
- Consultoria Delphi: Giovani da Cruz — <giovani@infus.inf.br>

O projeto é distribuído nos termos da licença presente em
[licenca.txt](licenca.txt).
