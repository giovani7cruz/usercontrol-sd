# User Control ShowDelphi Edition

## Modernização do fork GDC

As alterações em andamento estão registradas em
[CHANGELOG_GDC.md](CHANGELOG_GDC.md). A nova API opt-in para hash forte e o
procedimento seguro de adoção estão descritos em
[MIGRACAO_SEGURANCA.md](MIGRACAO_SEGURANCA.md).

O envio de e-mail não depende mais do Alcinoe. A configuração do transporte
Indy e a injeção de uma implementação própria estão descritas em
[MAIL_TRANSPORT.md](MAIL_TRANSPORT.md).

Uma versão dos Componentes User Control mantido pela Comunidade Show Delphi.
A comunidade tem o objetivo de manter esta biblioteca de componentes
compatíveis com as novas versões do Delphi e Lazarus, realizando melhorias, sempre 
que possível.

Fórum oficial: https://showdelphi.com.br/forum/forum/duvidas-e-problemas-relacionados-ao-usercontrol-showdelphi-edition/

# Consultorias

Você pode contatar Giovani da Cruz para consultorias sobre o User Control e 
serviços Freelancer em Delphi pelo e-mail giovani@infus.inf.br.

# Contribuições em Código

Lembre-se que você sempre pode contribuir com melhorias nos códigos, exemplos de uso e testes nas versões de Delphi.
Caso tenha interesse em colaborar, entre em contato conosco.

# Suporte

O componente tem suporte do Delphi 7 até o Delphi 11.3 Alexandria.

A partir de 12/03/2019 foi incluso a primeira versão com suporte a Lazarus.

Versões testadas até o momento:

Delphi 7

Delphi 2010

Delphi XE 3

Delphi XE 6

Delphi XE 7

Delphi XE 8

Delphi 10 Seattle

Delphi 10.1 Berlin

Delphi 10.2 Tokyo

Delphi 10.3 Rio

Delphi 10.4 Sydney

Delphi 11.3 Alexandria

Delphi 12 Athens

-------------------------------------------------------------

Lazarus 2.0 (Beta)  

Obs: Quem estiver utilizando a versão Starter (Community) do Delphi, precisa realizar a instalação manualmente,
pois o delphi não gera as bpls se você utilizar o instalador.
Lembramos também que o Berlin Starter, por padrão, não tem componentes de conexão instalados, logo
recomendamos a instalação do Zeos que é Open Source, assim será possível de utilizar o UserControl. 

Conectors Suportados até o momento:
ADOConnector, IBXConnector, DBXConnector, FireDACConnector, ZeosConnector, DataSnapConnector,
RestConnector, RestDWConnector (Versão Datasnap), Rest Data Ware CORE Connector, SQLdb (Somente no Lazarus).

Alguns detalhes:

ZeosConnector está disponível para Delphi e Lazarus
RestConnector faz uso de funções do Firedac, logo é necessário que o FireDac esteja instalado.
RestDWConnector foi preparado para utilizar o RestWare, versão inicial do RestDataWare que utilizava o DataSnap.
Rest Data Ware CORE Connector é o connectaor indicado para a utilização com o REST DATA WARE CORE.

O Midas Connector é somente até o Delphi XE 8.

Há ainda outros connectors na pasta "conectors para testar", no entando estes connector não foram
testados pela nossa equipe.
Lista dos connectors para teste:
AboluteBase, AstaConn, BDEConn, DBISAMConn, FIBConn, IBOConn, MDOConn, MyDACConn,
NexusDBConn, ODACConn, UIBConn, UniDACConn.

O componente UserControl é compatível com a compilação em 64 bits, inclusive em Lazarus.

Para ver uma descrição completa dos componentes acesse: https://showdelphi.com.br/descricao-dos-componentes-usercontrol/

Caso queria baixar o RestWare versão Datasnap que mantemos, acesse: https://github.com/infussolucoes/Datasnap-Restware

Visite a comunidade: https://showdelphi.com.br

Visite o blog: https://giovanidacruz.com.br


