program Via;

uses
  Vcl.Forms,
  ViaCliente in 'ViaCliente.pas' {frmViaCliente},
  ViaCliente.Model in 'scr\ViaCliente.Model.pas',
  ViaCliente.Intf in 'scr\ViaCliente.Intf.pas',
  ViaCliente.Core in 'scr\ViaCliente.Core.pas',
  Envio.Mail in 'scr\Envio.Mail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmViaCliente, frmViaCliente);
  Application.Run;
end.
