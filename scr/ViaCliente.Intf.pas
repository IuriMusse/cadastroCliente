unit ViaCliente.Intf;

interface

uses ViaCliente.Model, System.Classes, IdExplicitTLSClientServerBase;

type
  IViaCliente = interface

    function PassarDados(const ACep: string): TViaClienteClass;
    function ValidarEmail(const ACep: string): Boolean;
  end;

implementation

end.
