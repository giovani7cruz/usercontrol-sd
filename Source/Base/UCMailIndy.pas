unit UCMailIndy;

interface

uses
  UCMailTransport;

type
  TUCIndyMailSender = class(TInterfacedObject, IUCMailSender)
  public
    procedure Send(const Request: TUCMailRequest;
      const OnStatus: TUCMailStatusEvent);
  end;

implementation

uses
  SysUtils,
  IdExplicitTLSClientServerBase,
  IdMessage,
  IdSMTP,
  IdSSLOpenSSL;

procedure NotifyStatus(const OnStatus: TUCMailStatusEvent;
  const Status: string);
begin
  if Assigned(OnStatus) then
    OnStatus(Status);
end;

procedure TUCIndyMailSender.Send(const Request: TUCMailRequest;
  const OnStatus: TUCMailStatusEvent);
var
  SMTP: TIdSMTP;
  MessageData: TIdMessage;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  if Request = nil then
    raise Exception.Create('Requisicao de e-mail nao informada');
  if Trim(Request.Host) = '' then
    raise Exception.Create('Servidor SMTP nao informado');
  if Trim(Request.FromAddress) = '' then
    raise Exception.Create('E-mail do remetente nao informado');
  if Trim(Request.ToAddress) = '' then
    raise Exception.Create('E-mail do destinatario nao informado');

  SMTP := TIdSMTP.Create(nil);
  MessageData := TIdMessage.Create(nil);
  SSLHandler := nil;
  try
    SMTP.Host := Request.Host;
    SMTP.Port := Request.Port;
    SMTP.ConnectTimeout := Request.ConnectTimeout;
    SMTP.ReadTimeout := Request.ReadTimeout;
    SMTP.Username := Request.UserName;
    SMTP.Password := Request.Password;
    if Request.AuthType = AlsmtpClientAuthNone then
      SMTP.AuthType := satNone
    else
      SMTP.AuthType := satDefault;

    if Request.TLSMode <> ucTLSNone then
    begin
      SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      SMTP.IOHandler := SSLHandler;
      case Request.TLSMode of
        ucTLSExplicit: SMTP.UseTLS := utUseExplicitTLS;
        ucTLSImplicit: SMTP.UseTLS := utUseImplicitTLS;
      end;
    end
    else
      SMTP.UseTLS := utNoTLSSupport;

    MessageData.From.Address := Request.FromAddress;
    MessageData.From.Name := Request.FromName;
    MessageData.Recipients.Add.Address := Request.ToAddress;
    MessageData.Subject := Request.Subject;
    MessageData.ContentType := 'text/html';
    MessageData.CharSet := 'utf-8';
    MessageData.Body.Text := Request.Body;

    NotifyStatus(OnStatus, 'Conectando ao servidor SMTP...');
    SMTP.Connect;
    try
      NotifyStatus(OnStatus, 'Enviando e-mail...');
      SMTP.Send(MessageData);
      NotifyStatus(OnStatus, 'E-mail enviado.');
    finally
      if SMTP.Connected then
        SMTP.Disconnect;
    end;
  finally
    SMTP.Free;
    SSLHandler.Free;
    MessageData.Free;
  end;
end;

end.
