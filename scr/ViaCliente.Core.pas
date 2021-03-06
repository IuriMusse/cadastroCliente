unit ViaCliente.Core;

interface

uses IdHTTP, IdSSLOpenSSL, ViaCliente.Intf, ViaCliente.Model, System.Classes;

type
  TViaCliente = class(TInterfacedObject, IViaCliente)
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;

    function PassarDados(const ACep: string): TViaClienteClass;
    function ValidarEmail(const ACep: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses REST.Json, System.SysUtils;

constructor TViaCliente.Create;
begin
  FIdHTTP := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
end;

function TViaCliente.PassarDados(const ACep: string): TViaClienteClass;
const
  URL = 'https://viacep.com.br/ws/%s/json';
  INVALID_CEP = '{'#$A'  "erro": true'#$A'}';
var
  LResponse: TStringStream;
begin
  Result := nil;
  LResponse := TStringStream.Create;
  try
    FIdHTTP.Get(Format(URL, [ACep.Trim]), LResponse);
    if (FIdHTTP.ResponseCode = 200) and (not (LResponse.DataString).Equals(INVALID_CEP)) then
      Result := TJson.JsonToObject<TViaClienteClass>(UTF8ToString(PAnsiChar(AnsiString(LResponse.DataString))));
  finally
    LResponse.Free;
  end;
end;

function TViaCliente.ValidarEmail(const ACep: string): Boolean;
const
  INVALID_CHARACTER = -1;
begin
  Result := True;
  if ACep.Trim.Length <> 8 then
    Exit(False);
  if StrToIntDef(ACep, INVALID_CHARACTER) = INVALID_CHARACTER then
    Exit(False);
end;

destructor TViaCliente.Destroy;
begin
  FIdSSLIOHandlerSocketOpenSSL.Free;
  FIdHTTP.Free;
  inherited;
end;

end.
