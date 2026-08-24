# Migração de segurança de senhas

Esta versão adiciona `UCPasswordHash`, uma API opt-in para armazenamento de
senhas com PBKDF2-HMAC-SHA-256. O comportamento legado de `TUserControl` não é
alterado automaticamente.

## Requisitos

- Delphi 2009 ou posterior.
- Windows 7 ou posterior, com `bcrypt.dll` e `BCryptDeriveKeyPBKDF2`.
- Campo de senha com pelo menos 128 caracteres. O formato atual ocupa cerca de
  121 caracteres.
- Validação de desempenho no servidor. O padrão é 600.000 iterações.

## Uso da API

```pascal
uses
  UCPasswordHash;

StoredHash := TUCPasswordHash.HashPassword(Password);

if not TUCPasswordHash.VerifyPassword(Password, StoredHash) then
  raise Exception.Create('Senha inválida');

if TUCPasswordHash.NeedsRehash(StoredHash) then
  StoredHash := TUCPasswordHash.HashPassword(Password);
```

Cada hash contém algoritmo, quantidade de iterações, salt aleatório e chave
derivada. A comparação da chave derivada é feita em tempo constante.

## Sequência recomendada

1. Aumentar o campo de senha para `VARCHAR(128)` ou maior e testar a alteração
   em uma cópia da base.
2. Publicar primeiro uma versão da aplicação capaz de reconhecer tanto o
   formato legado quanto o formato `uc$pbkdf2-sha256$...`.
3. Somente após todos os clientes estarem atualizados, habilitar a gravação de
   hashes fortes.
4. Migrar cada senha depois de uma autenticação legada bem-sucedida, dentro de
   uma transação explícita. Não é possível converter MD5 ou senha cifrada sem
   conhecer a senha original.
5. Manter telemetria de falhas e uma forma administrativa de redefinição de
   senha durante o período de transição.

O componente não executa essa migração automaticamente. Isso evita alteração
silenciosa de credenciais, truncamento do hash e bloqueio em ambientes com
clientes de versões diferentes.

## Pontos ainda legados

- `cPadrao` é cifra reversível e `cMD5` é hash rápido sem salt. Ambos permanecem
  apenas por compatibilidade.
- O fluxo "esqueci minha senha" ainda envia uma senha temporária por e-mail.
  A evolução recomendada é enviar um token aleatório, de uso único e com prazo
  curto, e permitir que o próprio usuário escolha a nova senha.
- `AutoLogin.Password` e `InitialLogin.Password` ainda podem ser persistidos no
  formulário. Novos projetos devem obter esses segredos de configuração
  protegida ou de um serviço de autenticação.

No Águia, a ativação deve ser feita no serviço de autenticação/conexão, e não no
connector visual. O `UCAguiaConn` pode continuar derivando de
`TUCDataConnector` sem instalação de componente adicional.
