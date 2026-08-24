program UCMailTransportTests;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  UCMailTransport in '..\..\Source\Base\UCMailTransport.pas';

type
  TFakeMailSender = class(TInterfacedObject, IUCMailSender)
  private
    FCalled: Boolean;
  public
    procedure Send(const Request: TUCMailRequest;
      const OnStatus: TUCMailStatusEvent);
    property Called: Boolean read FCalled;
  end;

procedure Check(Condition: Boolean; const MessageText: string);
begin
  if not Condition then
    raise Exception.Create(MessageText);
end;

procedure TFakeMailSender.Send(const Request: TUCMailRequest;
  const OnStatus: TUCMailStatusEvent);
begin
  Check(Request <> nil, 'Requisicao nao informada');
  Check(Request.Host = 'smtp.exemplo.com', 'Servidor incorreto');
  Check(Request.TLSMode = ucTLSExplicit, 'Modo TLS incorreto');
  Check(Request.Body = 'Mensagem com acentuacao', 'Corpo incorreto');
  FCalled := True;
end;

var
  Request: TUCMailRequest;
  SenderObject: TFakeMailSender;
  Sender: IUCMailSender;
begin
  try
    Request := TUCMailRequest.Create;
    try
      Request.Host := 'smtp.exemplo.com';
      Request.TLSMode := ucTLSExplicit;
      Request.Body := 'Mensagem com acentuacao';

      SenderObject := TFakeMailSender.Create;
      Sender := SenderObject;
      Sender.Send(Request, nil);
      Check(SenderObject.Called, 'Transporte nao foi chamado');
    finally
      Request.Free;
    end;
    Writeln('UCMailTransport: OK');
  except
    on E: Exception do
    begin
      Writeln(E.ClassName + ': ' + E.Message);
      Halt(1);
    end;
  end;
end.
