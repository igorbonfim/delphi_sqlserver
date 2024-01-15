unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, cCadCliente, uEnum, ACBrBase, ACBrSocket, ACBrCEP;

type
  TfrmCadCliente = class(TfrmTelaHeranca)
    edtClienteId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCEP: TMaskEdit;
    Label1: TLabel;
    edtEndereco: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtTelefone: TMaskEdit;
    Label2: TLabel;
    edtEmail: TLabeledEdit;
    edtDataNascimento: TDateEdit;
    Label3: TLabel;
    QryListagemclienteId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemendereco: TWideStringField;
    QryListagemcidade: TWideStringField;
    QryListagembairro: TWideStringField;
    QryListagemestado: TWideStringField;
    QryListagemcep: TWideStringField;
    QryListagemtelefone: TWideStringField;
    QryListagememail: TWideStringField;
    QryListagemdatanascimento: TDateTimeField;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    Label4: TLabel;
    dbcEstado: TDBComboBox;
    btnPesquisarCEP: TButton;
    ACBrCEP1: TACBrCEP;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisarCEPClick(Sender: TObject);
  private
    { Private declarations }
    oCliente:TCliente;
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

uses uDTMConexao;



{ TfrmCadCliente }
{$region 'Métodos override'}
function TfrmCadCliente.Apagar: Boolean;
begin
  if oCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then
  begin
    Result := oCliente.Apagar;
  end;
end;

function TfrmCadCliente.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtClienteId.Text <> EmptyStr then
    oCliente.codigo := StrToInt(edtClienteId.Text)
  else
    oCliente.codigo := 0;

  oCliente.nome           := edtNome.Text;
  oCliente.cep            := edtCEP.Text;
  oCliente.endereco       := edtEndereco.Text;
  oCliente.numero         := edtNumero.Text;
  oCliente.complemento    := edtComplemento.Text;
  oCliente.bairro         := edtBairro.Text;
  oCliente.cidade         := edtCidade.Text;
  oCliente.estado         := dbcEstado.Text;
  oCliente.telefone       := edtTelefone.Text;
  oCliente.email          := edtEmail.Text;
  oCliente.dataNascimento := edtDataNascimento.Date;

  if (EstadoDoCadastro = ecInserir) then
    Result := oCliente.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
    Result := oCliente.Atualizar;
end;
{$endRegion}

procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin
  if oCliente.Selecionar(QryListagem.FieldByName('clienteId').AsInteger) then
  begin
    edtClienteId.Text       := IntToStr(oCliente.codigo);
    edtNome.Text            := oCliente.nome;
    edtCEP.Text             := oCliente.cep;
    edtEndereco.Text        := oCliente.endereco;
    edtNumero.Text          := oCliente.numero;
    edtComplemento.Text     := oCliente.complemento;
    edtBairro.Text          := oCliente.bairro;
    edtCidade.Text          := oCliente.cidade;
    dbcEstado.Text          := oCliente.estado;
    edtTelefone.Text        := oCliente.telefone;
    edtEmail.Text           := oCliente.email;
    edtDataNascimento.Date  := oCliente.dataNascimento;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmCadCliente.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataNascimento.Date := Date;
  edtNome.SetFocus;
end;

procedure TfrmCadCliente.btnPesquisarCEPClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;

  ACBrCEP1.BuscarPorCEP(edtCEP.Text);
  for i := 0 to ACBrCEP1.Enderecos.Count - 1 do
  begin
    edtEndereco.Text      := ACBrCEP1.Enderecos[i].Logradouro;
    edtComplemento.Text   := ACBrCEP1.Enderecos[i].Complemento;
    edtBairro.Text        := ACBrCEP1.Enderecos[i].Bairro;
    edtCidade.Text        := ACBrCEP1.Enderecos[i].Municipio;
    dbcEstado.ItemIndex   := dbcEstado.Items.IndexOf(ACBrCEP1.Enderecos[i].UF);
  end;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCliente) then
    FreeAndNil(oCliente);
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  oCliente := TCliente.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual := 'nome';
end;

end.
