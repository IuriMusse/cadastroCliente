unit ViaCliente.Model;

interface

uses REST.Json.Types;

type

  TViaClienteClass = class
  private
    FNome: string;
    FIdentidade: string;
    FCPF: string;
    FTelefone: string;
    FEmail: string;
    FLogradouro: string;
    FNumero: string;
    FBairro: string;
    FUF: string;
    FCEP: string;
    FLocalidade: string;
    FComplemento: string;
    FPais: string;
    procedure SetNome(const Value: string);
    procedure SetIdentidade(const Value: string);
    procedure SetCPF(const Value: string);
    procedure SetTelefone(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetBairro(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetNumero(const Value: string);
    procedure SetLocalidade(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetPais(const Value: string);
  public
    property Nome: string read FNome write SetNome;
    property Identidade: string read FIdentidade write SetIdentidade;
    property CPF: string read FCPF write SetCPF;
    property Telefone: string read FTelefone write SetTelefone;
    property Email: string read FEmail write SetEmail;
    property CEP: string read FCEP write SetCEP;
    property Logradouro: string read FLogradouro write SetLogradouro;
    property Complemento: string read FComplemento write SetComplemento;
    property Bairro: string read FBairro write SetBairro;
    property Localidade: string read FLocalidade write SetLocalidade;
    property UF: string read FUF write SetUF;
    property Numero: string read FNumero write SetNumero;
    property Pais: string read FPais write SetPais;
    function ToJSONString: string;
    class function FromJSONString(const AJSONString: string): TViaClienteClass;
  end;

implementation

uses REST.Json;

class function TViaClienteClass.FromJSONString(const AJSONString: string): TViaClienteClass;
begin
  Result := TJson.JsonToObject<TViaClienteClass>(AJSONString);
end;

procedure TViaClienteClass.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TViaClienteClass.SetIdentidade(const Value: string);
begin
  FIdentidade := Value;
end;

procedure TViaClienteClass.SetCPF(const Value: string);
begin
  FCPF := Value;
end;

procedure TViaClienteClass.SetTelefone(const Value: string);
begin
  FTelefone := Value;
end;

procedure TViaClienteClass.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TViaClienteClass.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TViaClienteClass.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TViaClienteClass.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TViaClienteClass.SetPais(const Value: string);
begin
  FPais := Value;
end;

procedure TViaClienteClass.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TViaClienteClass.SetLocalidade(const Value: string);
begin
  FLocalidade := Value;
end;

procedure TViaClienteClass.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TViaClienteClass.SetUF(const Value: string);
begin
  FUF := Value;
end;

function TViaClienteClass.ToJSONString: string;
begin
  Result := TJson.ObjectToJsonString(Self, [joIgnoreEmptyStrings]);
end;

end.
