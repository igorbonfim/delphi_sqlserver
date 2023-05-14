unit uCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, cCadUsuario, uEnum, uDtmConexao;

type
  TfrmCadUsuario = class(TfrmTelaHeranca)
    QryListagemusuarioID: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemsenha: TWideStringField;
    edtNome: TLabeledEdit;
    edtCodigo: TLabeledEdit;
    edtSenha: TLabeledEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    oUsuario: TUsuario;
    function Apagar: Boolean; override;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadUsuario: TfrmCadUsuario;

implementation

{$R *.dfm}

uses cAcaoAcesso;

{ TfrmCadUsuario }

function TfrmCadUsuario.Apagar: Boolean;
begin
  if oUsuario.Selecionar(QryListagem.FieldByName('usuarioId').AsInteger) then
    Result := oUsuario.Apagar;
end;

procedure TfrmCadUsuario.btnAlterarClick(Sender: TObject);
begin
  if oUsuario.Selecionar(QryListagem.FieldByName('usuarioId').AsInteger) then
  begin
    edtCodigo.Text  := IntToStr(oUsuario.codigo);
    edtNome.Text    := oUsuario.nome;
    edtSenha.Text   := oUsuario.senha;
  end
  else
  begin
    btnCancelar.Click;
    abort;
  end;
  inherited;
end;

procedure TfrmCadUsuario.btnGravarClick(Sender: TObject);
begin
  if oUsuario.UsuarioExiste(edtNome.Text) then
  begin
    MessageDlg('Usuário já cadastrado', mtInformation, [mbOk], 0);
    edtNome.SetFocus;
    abort;
  end;

  if edtCodigo.Text <> EmptyStr then
    oUsuario.codigo := StrToInt(edtCodigo.Text)
  else
    oUsuario.codigo := 0;

  oUsuario.nome   := edtNome.Text;
  oUsuario.senha  := edtSenha.Text;
  inherited;
end;

procedure TfrmCadUsuario.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oUsuario) then
    FreeAndNil(oUsuario);
end;

procedure TfrmCadUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  oUsuario := TUsuario.Create(DtmPrincipal.ConexaoDB);
  IndiceAtual := 'nome';
end;

function TfrmCadUsuario.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if EstadoDoCadastro = ecInserir then
    Result := oUsuario.Inserir
  else if EstadoDoCadastro = ecAlterar then
    Result := oUsuario.Atualizar;

  TAcaoAcesso.PreencherUsuariosVsAcoes(dtmPrincipal.ConexaoDB);
end;

end.
