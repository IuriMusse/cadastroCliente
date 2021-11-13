unit Envio.Mail;

interface

uses Dialogs, SysUtils, Variants, IdMessage, IdBaseComponent,
IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
IdMessageClient, IdSMTPBase, IdSMTP, IdServerIOHandler, IdSSL, IdSSLOpenSSL,
IdAttachment, IdMessageParts, IdEmailAddress, IdAttachmentFile;

const
    //Necessário configurar username e password | Testado com o SMTP do Hotmail
    host = 'smtp.live.com';
    port = 587;
    username = 'xxx@hotmail.com';
    password = 'xxxx';
    Dest = 'smtp.live.com';

type
   novoEmail = class
     msgRecipient: string;
     msgCC: string;
     msgSubject: string;
     msgFromAddress: string;
     msgBodyAdd: string;
     msgAttachment: string;
     function enviarEmail(): Boolean;
   end;

implementation

{ novoEmail }

function novoEmail.enviarEmail: Boolean;
var
 SMTPCon: TidSMTP;
 SMTPMsg: TidMessage;
 SMTPIOHandler: TIdSSLIOHandlerSocketOpenSSL;
 SMTPAttachment: TIdAttachment;
begin
  SMTPCon := TIdSMTP.Create();
  SMTPMsg := TIdMessage.Create();
  SMTPIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create();

  SMTPCon.Host := host;
  SMTPCon.Port := port;
  SMTPCon.Username := username;
  SMTPCon.Password := password;
  SMTPCon.IOHandler := SMTPIOHandler;
  SMTPCon.UseTLS := utUseExplicitTLS;
  SMTPCon.AuthType := satDefault;
  SMTPCon.ValidateAuthLoginCapability := False;


  with SMTPIOHandler do
  begin
    Destination := Dest;
    Host := host;
    Port := port;
    SSLOptions.Method := sslvTLSv1;
    SSLOptions.Mode := sslmUnassigned;
    SSLOptions.VerifyMode := [];
    SSLOptions.VerifyDepth := 0;
  end;

  SMTPMsg.Recipients.EMailAddresses := msgRecipient;
  if msgCC <> '' then
    SMTPMsg.BccList.EMailAddresses := msgCC;
    SMTPMsg.Subject := msgSubject;
    SMTPMsg.From.Address := msgFromAddress;
    SMTPMsg.Body.Add(msgBodyAdd);

  if FileExists(msgAttachment) then
    SMTPAttachment := TIdAttachmentFile.Create(SMTPMsg.MessageParts, msgAttachment);

  try
    SMTPCon.Connect();
    SMTPCon.Send(SMTPMsg);
    SMTPCon.Disconnect();
    SMTPMsg.Clear;
    ShowMessage('E-mail enviado com sucesso para ' + msgRecipient);
    SMTPCon.Free;
    SMTPIOHandler.Free;
    Result := True;
  except
    ShowMessage('Erro ao enviar E-mail!');
    SMTPCon.Free;
    SMTPIOHandler.Free;
    Result := False;
  end;
end;

end.
