# Adaptador de conexao do UserControl

`TUCConnectionAdapter` liga o UserControl a qualquer classe de conexao que
implemente `IUCDataConnection`. Ele nao depende de REST.Client, FireDAC ou de
outro driver e nao e registrado na paleta de componentes.

O contrato fica em `Source\Base\UCConnectionAdapter.pas`. A aplicacao deve:

1. implementar `IUCDataConnection` em uma classe propria;
2. criar `TUCConnectionAdapter` em tempo de execucao;
3. atribuir a implementacao a `Connection`;
4. atribuir o adapter a propriedade `DataConnector` do UserControl.

Exemplo reduzido:

```pascal
FUCConnector := TUCConnectionAdapter.Create(Self);
FUCConnector.Connection := TMinhaConexaoUC.Create(MinhaConexao);
UserControl.DataConnector := FUCConnector;
```

## Regra de propriedade dos datasets

`IUCDataConnection.CreateDataSet` deve devolver um dataset novo. O chamador
passa a ser responsavel por libera-lo. Por isso, a implementacao deve criar o
dataset com `Owner = nil` e libera-lo internamente se ocorrer erro antes do
retorno.

O teste executavel em
`Testes\ConnectionAdapter\UCConnectionAdapterTests.dpr` demonstra o contrato
com uma conexao falsa, sem acessar banco ou rede.
