# Sessoes de usuarios logados

`TUCUsersLogged` registra cada login com um GUID e mantem a sessao ativa por
heartbeat. O campo de data da tabela existente armazena UTC no formato
`yyyymmddhhnnss`, que pode ser comparado e ordenado sem depender da configuracao
regional do cliente ou do servidor.

As propriedades disponiveis em `UserControl.UsersLogged` sao:

- `Active`: habilita o controle de sessoes;
- `HeartbeatInterval`: intervalo do heartbeat em milissegundos, com padrao de
  30.000;
- `SessionTimeout`: tempo sem heartbeat para expirar uma sessao, em segundos,
  com padrao de 120;
- `LastError`: ultimo erro ocorrido no heartbeat. Um heartbeat com sucesso
  limpa esse valor.

Ao iniciar uma sessao, o UserControl remove registros expirados e registros do
formato antigo (`dd/mm/yy hh:mm`). Durante a execucao, atualiza somente a sessao
corrente e executa a limpeza global no maximo uma vez por periodo de expiracao.

Se a aplicacao for encerrada sem executar o logoff, a linha deixa de receber
heartbeats e sera removida por outra instancia depois de `SessionTimeout`.

O intervalo deve ser significativamente menor que o timeout. Os setters
impedem configuracoes em que a sessao possa expirar entre dois heartbeats.
