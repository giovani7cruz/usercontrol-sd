unit UCMailTransport;

interface

uses
  Classes;

type
  { Mantem os nomes e a ordem do tipo publicado pelo transporte legado. }
  TAlSmtpClientAuthType = (
    AlsmtpClientAuthNone,
    alsmtpClientAuthPlain,
    AlsmtpClientAuthLogin,
    AlsmtpClientAuthCramMD5,
    AlsmtpClientAuthCramSha1,
    AlsmtpClientAuthAutoSelect
  );

  TUCMailTLSMode = (
    ucTLSNone,
    ucTLSExplicit,
    ucTLSImplicit
  );

  TUCMailStatusEvent = procedure(const Status: string) of object;

  TUCMailRequest = class
  public
    Host: string;
    Port: Integer;
    UserName: string;
    Password: string;
    AuthType: TAlSmtpClientAuthType;
    TLSMode: TUCMailTLSMode;
    ConnectTimeout: Integer;
    ReadTimeout: Integer;
    FromAddress: string;
    FromName: string;
    ToAddress: string;
    Subject: string;
    Body: string;
  end;

  IUCMailSender = interface
    ['{88C09D5A-D2C1-4BD7-A935-42E11BC4B311}']
    procedure Send(const Request: TUCMailRequest;
      const OnStatus: TUCMailStatusEvent);
  end;

implementation

end.
