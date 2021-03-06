unit ViaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, XMLDoc, XMLIntf, Envio.Mail,
  Vcl.Mask;

type
  TfrmViaCliente = class(TForm)
    pblCadastro: TPanel;
    gbDadosdoCadastro: TGroupBox;
    gbEndereco: TGroupBox;
    lblCep: TLabel;
    lblLogradouro: TLabel;
    lblComplemento: TLabel;
    lblBairro: TLabel;
    lblCidade: TLabel;
    lblUF: TLabel;
    lblPais: TLabel;
    lblNumero: TLabel;
    edtConsultarCEP: TEdit;
    edtCEP: TEdit;
    edtLogradouro: TEdit;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtUF: TEdit;
    edtPais: TEdit;
    edtNumero: TEdit;
    lblNome: TLabel;
    edtNome: TEdit;
    lblIdentidade: TLabel;
    edtIdentidade: TEdit;
    lblCpf: TLabel;
    lblTelefone: TLabel;
    edtEmail: TEdit;
    lblEmail: TLabel;
    btnConsultarCep: TSpeedButton;
    btnSalvar: TSpeedButton;
    edtCpf: TMaskEdit;
    edtTelefone: TMaskEdit;
    procedure btnConsultarCepClick(Sender: TObject);
    procedure edtConsultarCEPKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure CriarXML;
    procedure Envio;
    procedure LimparEdit;
  public
    { Public declarations }
  end;

const FileXML = 'D:\PROJETO\INFO\xml\Cliente.xml';   //caminho onde o arquivo XML foi criado.

var
  frmViaCliente: TfrmViaCliente;

implementation

{$R *.dfm}

uses
ViaCliente.Model, ViaCliente.Intf, ViaCliente.Core;



procedure TfrmViaCliente.btnConsultarCepClick(Sender: TObject);
var
  ViaCEP: IViaCliente;
  CEP: TViaClienteClass;
begin
  ViaCEP := TViaCliente.Create;

  if ViaCEP.ValidarEmail(edtConsultarCEP.Text) then
  begin
    CEP := ViaCEP.PassarDados(edtConsultarCEP.Text);
    if not Assigned(CEP) then
      Exit;
    try
      edtCEP.Text := CEP.CEP;
      edtLogradouro.Text := CEP.Logradouro;
      edtComplemento.Text := CEP.Complemento;
      edtBairro.Text := CEP.Bairro;
      edtCidade.Text := CEP.Localidade;
      edtUF.Text := CEP.UF;
      edtPais.Text := 'Brasil';
      edtNumero.Text := CEP.Numero;
      gbEndereco.Height := 282;
    finally
      CEP.Free;
    end;
  end else
  begin
    ShowMessage('CEP inv?lido');
  end;

end;

procedure TfrmViaCliente.btnSalvarClick(Sender: TObject);
begin
  CriarXML;
  Envio;
  LimparEdit;
  gbEndereco.Height := 66;
end;

procedure TfrmViaCliente.CriarXML;
var
  XMLDocument: TXMLDocument;
  NodeTabela, NodeRegistro: IXMLNode;
begin
  XMLDocument := TXMLDocument.Create(Self);
  try
     XMLDocument.FileName := '';
     XMLDocument.XML.Text := '';
     XMLDocument.Active := True;
     XMLDocument.Version := '1.0';
     XMLDocument.Encoding := 'UTF-8';
     NodeTabela := XMLDocument.AddChild('Cliente');
    begin
      NodeRegistro := NodeTabela.AddChild('Registro');
      NodeRegistro.ChildValues['Nome'] := edtNome.Text;
      NodeRegistro.ChildValues['Identidade'] := edtIdentidade.Text;
      NodeRegistro.ChildValues['CPF'] := edtCpf.Text;
      NodeRegistro.ChildValues['Telefone'] := edtTelefone.Text;
      NodeRegistro.ChildValues['Email'] := edtEmail.Text;
      NodeRegistro.ChildValues['CEP'] := edtCEP.Text;
      NodeRegistro.ChildValues['Logradouto'] := edtLogradouro.Text;
      NodeRegistro.ChildValues['Numero'] := edtNumero.Text;
      NodeRegistro.ChildValues['Complemento'] := edtComplemento.Text;
      NodeRegistro.ChildValues['Bairro'] := edtBairro.Text;
      NodeRegistro.ChildValues['Cidade'] := edtCidade.Text;
      NodeRegistro.ChildValues['UF'] := edtUF.Text;
      NodeRegistro.ChildValues['Pais'] := edtPais.Text;
    end;
    XMLDocument.SaveToFile(FileXML);
  finally
    XMLDocument.Free;
  end;
end;

procedure TfrmViaCliente.edtConsultarCEPKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
     btnConsultarCep.OnClick(Sender);
end;

procedure TfrmViaCliente.Envio;
var
  email: novoEmail;
  Remetente: string;
begin
  Remetente := edtEmail.Text;
  email := novoEmail.Create;
  email.msgRecipient := Remetente;
  email.msgSubject := 'XML do Cadastro de Cliente';
  email.msgFromAddress := 'xxx@hotmail.com';
  email.msgBodyAdd := 'Segue documento conforme solicitado.';
  email.msgAttachment := FileXML;

  if email.enviarEmail then
  begin
    email.Destroy;
  end;
end;

procedure TfrmViaCliente.FormCreate(Sender: TObject);
begin
  gbEndereco.Height := 66;
end;

procedure TfrmViaCliente.LimparEdit;
var
  i: Integer;
begin
  for i := 0 to ComponentCount -1 do
  begin
    if Components[i] is TEdit then
      TEdit(Components[i]).Clear;

    if Components[i] is TMaskEdit then
      TMaskEdit(Components[i]).Clear;
  end;
end;
end.
