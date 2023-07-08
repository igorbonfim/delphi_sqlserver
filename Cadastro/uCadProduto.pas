unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  cCadProduto, uEnum, uDTMConexao, RxToolEdit, RxCurrEdit, cFuncao, Vcl.Menus,
  SearchMore, EditClickKey, cCadCategoria;

type
  TfrmCadProduto = class(TfrmTelaHeranca)
    QryListagemprodutoId: TIntegerField;
    QryListagemnome: TWideStringField;
    QryListagemdescricao: TWideStringField;
    QryListagemvalor: TFloatField;
    QryListagemquantidade: TFloatField;
    QryListagemcategoriaId: TIntegerField;
    QryListagemDescricaoCategoria: TWideStringField;
    edtProdutoId: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtDescricao: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    QryCategoria: TZQuery;
    dtsCategoria: TDataSource;
    QryCategoriacategoriaId: TIntegerField;
    QryCategoriadescricao: TWideStringField;
    Label4: TLabel;
    edtValor: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    pnlImagemProduto: TPanel;
    imgImagemProduto: TImage;
    popMenuImagem: TPopupMenu;
    CarregarImagem1: TMenuItem;
    LimparImagem1: TMenuItem;
    edtSearchCategoriaId: TEditClickKey;
    SearchMore1: TSearchMore;
    edtSearchCategoriaDescricao: TEdit;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabManutencaoContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure spbIncluirCategoriaClick(Sender: TObject);
    procedure LimparImagem1Click(Sender: TObject);
    procedure CarregarImagem1Click(Sender: TObject);
    procedure edtSearchCategoriaIdExit(Sender: TObject);
  private
    { Private declarations }
    oProduto: TProduto;
    oCategoria: TCategoria;
    function Apagar : Boolean; override;
    function Gravar(EstadoDoCadastro : TEstadoDoCadastro) : Boolean; override;
    procedure GetDescricaoCategoria;
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

{$R *.dfm}

uses uCadCategoria, uPrincipal, uConsultaCategoria;

{$region 'Override'}
function TfrmCadProduto.Apagar : Boolean;
begin
  if oProduto.Selecionar(QryListagem.FieldByName('produtoId').AsInteger) then
  begin
    Result := oProduto.Apagar;
  end;
end;

function TfrmCadProduto.Gravar(EstadoDoCadastro: TEstadoDoCadastro) : Boolean;
begin
  if edtProdutoId.Text <> EmptyStr then
    oProduto.codigo := StrToInt(edtProdutoId.Text)
  else
    oProduto.codigo := 0;

  oProduto.nome         := edtNome.Text;
  oProduto.descricao    := edtDescricao.Text;
  oProduto.categoriaId  := StrToInt(edtSearchCategoriaId.Text);
  oProduto.valor        := edtValor.Value;
  oProduto.quantidade   := edtQuantidade.Value;

  if imgImagemProduto.Picture.Bitmap.Empty then
    oProduto.foto.Assign(nil)
  else
    oProduto.foto.Assign(imgImagemProduto.Picture);

  if (EstadoDoCadastro = ecInserir) then
     Result := oProduto.Inserir
  else if (EstadoDoCadastro = ecAlterar) then
     Result := oProduto.Atualizar;
end;

procedure TfrmCadProduto.LimparImagem1Click(Sender: TObject);
begin
  inherited;
  TFuncao.LimparImagem(imgImagemProduto);
end;

procedure TfrmCadProduto.spbIncluirCategoriaClick(Sender: TObject);
begin
  inherited;
  TFuncao.CriarForm(TfrmCadCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
  QryCategoria.Refresh;
end;

procedure TfrmCadProduto.tabManutencaoContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  inherited;

end;

{$endRegion}

procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
  if oProduto.Selecionar(QryListagem.FieldByName('produtoId').AsInteger) then
  begin
     edtProdutoId.Text      := IntToStr(oProduto.codigo);
     edtNome.Text           := oProduto.nome;
     edtDescricao.Text      := oProduto.descricao;
     edtSearchCategoriaId.Text  := IntToStr(oProduto.categoriaId);
     GetDescricaoCategoria;
     edtValor.Value         := oProduto.valor;
     edtQuantidade.Value    := oProduto.quantidade;
     imgImagemProduto.Picture.Assign(oProduto.foto);
  end
  else
  begin
    btnCancelar.Click;
    abort;
  end;

  inherited;
end;

procedure TfrmCadProduto.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtNome.SetFocus;
end;

procedure TfrmCadProduto.CarregarImagem1Click(Sender: TObject);
begin
  inherited;
  TFuncao.CarregarImagem(imgImagemProduto);
end;

procedure TfrmCadProduto.edtSearchCategoriaIdExit(Sender: TObject);
begin
  inherited;

  if edtSearchCategoriaId.Text <> EmptyStr then
    GetDescricaoCategoria
  else
    edtSearchCategoriaDescricao.Clear;
end;

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  QryCategoria.Close;
  if Assigned(oProduto) then
      FreeAndNil(oProduto);
end;

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  oProduto := TProduto.Create(dtmPrincipal.ConexaoDB);

  IndiceAtual := 'nome';
end;

procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
  QryCategoria.Open;
end;

procedure TfrmCadProduto.GetDescricaoCategoria;
var
  Qry: TZQuery;
begin
  Try
    Qry := TZQuery.Create(nil);
    Qry.Connection := dtmPrincipal.ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT * FROM CATEGORIAS WHERE CATEGORIAID = :CATEGORIAID');
    Qry.ParamByName('CATEGORIAID').AsInteger := StrToInt(edtSearchCategoriaId.Text);
    Qry.Open;

    edtSearchCategoriaDescricao.Text := Qry.FieldByName('descricao').AsString;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

end.
