# Transporte de e-mail

O `TMailUserControl` não depende mais do Alcinoe. No Delphi, o transporte
padrão é `TUCIndyMailSender`, usando o Indy que já faz parte das dependências do
pacote de runtime.

## Configuração

As propriedades existentes foram preservadas. Para servidores atuais, configure
também:

```pascal
MailUserControl.ServidorSMTP := 'smtp.exemplo.com';
MailUserControl.Porta := 587;
MailUserControl.TLSMode := ucTLSExplicit;
MailUserControl.ConnectTimeout := 30000;
MailUserControl.ReadTimeout := 30000;
```

Use `ucTLSImplicit` normalmente com a porta 465. Ao habilitar TLS, distribua com
a aplicação as bibliotecas OpenSSL compatíveis com a versão do Indy usada pelo
seu Delphi.

Os identificadores antigos de `AuthType` continuam válidos para não quebrar
DFMs. No transporte Indy, `AlsmtpClientAuthNone` desabilita autenticação e os
demais valores permitem que o Indy faça a autenticação com usuário e senha.

## Transporte próprio

Para usar as classes de conexão da aplicação, implemente `IUCMailSender` em uma
classe comum e injete a instância. Não é necessário criar nem instalar um
componente visual:

```pascal
type
  TMeuMailSender = class(TInterfacedObject, IUCMailSender)
  public
    procedure Send(const Request: TUCMailRequest;
      const OnStatus: TUCMailStatusEvent);
  end;

MailUserControl.MailSender := TMeuMailSender.Create;
```

`Send` é síncrono e deve concluir o uso de `Request` antes de retornar. O objeto
de requisição pertence ao `TMailUserControl`; a implementação não deve guardá-lo
nem liberá-lo. O callback `OnStatus` é opcional.

No Lazarus não é criado transporte padrão. A aplicação deve atribuir uma
implementação a `MailSender` antes do primeiro envio.
