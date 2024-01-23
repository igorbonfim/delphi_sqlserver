unit uProVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, uDTMVenda, uDTMConexao,
  RxToolEdit, RxCurrEdit, uEnum, cProVenda, DBEditClickKey, EditClickKey,
  SearchMore;

type
  TfrmProVenda = class(TfrmTelaHeranca)
    QryListagemVENDAID: TIntegerField;
    QryListagemCLIENTEID: TIntegerField;
    QryListagemNOME: TWideStringField;
    QryListagemDATAVENDA: TDateTimeField;
    QryListagemTOTALVENDA: TFloatField;
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    Label4: TLabel;
    edtDataVenda: TDateEdit;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    edtValorTotal: TCurrencyEdit;
    Label2: TLabel;
    dgGridItensVenda: TDBGrid;
    Label1: TLabel;
    edtValorUnitario: TCurrencyEdit;
    edtQuantidade: TCurrencyEdit;
    edtValorTotalProduto: TCurrencyEdit;
    btnAdicionarProduto: TBitBtn;
    btnRemoverProduto: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SearchMore1: TSearchMore;
    edtSearchIdProduto: TEditClickKey;
    edtSearchNomeProduto: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dgGridItensVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAdicionarProdutoClick(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtQuantidadeEnter(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnRemoverProdutoClick(Sender: TObject);
    procedure dgGridItensVendaDblClick(Sender: TObject);
    procedure edtSearchIdProdutoExit(Sender: TObject);
  private
    { Private declarations }
    dtmVenda: TdtmVenda;
    oVenda: TVenda;
    function Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean; override;
    function Apagar: Boolean; override;
    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    procedure LimparComponenteItem;
    procedure LimparCds;
    procedure CarregarRegistroSelecionado;
    function TotalizarVenda: Double;
    procedure GerarRelatorioVenda;
    procedure GetDescricaoProduto;
  public
    { Public declarations }
  end;

var
  frmProVenda: TfrmProVenda;

implementation

{$R *.dfm}

uses uRelProVenda;

procedure TfrmProVenda.GerarRelatorioVenda;
begin
  frmRelProVenda := TfrmRelProVenda.Create(Self);
  frmRelProVenda.QryVenda.Close;
  frmRelProVenda.QryVenda.ParamByName('VendaId').AsInteger := oVenda.VendaId;
  frmRelProVenda.QryVenda.Open;

  frmRelProVenda.QryVendaItens.Close;
  frmRelProVenda.QryVendaItens.ParamByName('VendaId').AsInteger := oVenda.VendaId;
  frmRelProVenda.QryVendaItens.Open;

  frmRelProVenda.Relatorio.PreviewModal;
  frmRelProVenda.Release;
end;

{$region 'Override'}
function TfrmProVenda.Apagar: Boolean;
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then
  begin
    Result := oVenda.Apagar;
  end;
end;

function TfrmProVenda.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
  if edtVendaId.Text <> EmptyStr then
    oVenda.VendaId := StrToInt(edtVendaId.Text)
  else
    oVenda.VendaId := 0;

  oVenda.ClienteId  := lkpCliente.KeyValue;
  oVenda.DataVenda  := edtDataVenda.Date;
  oVenda.TotalVenda := edtValorTotal.Value;

  if (EstadoDoCadastro = ecInserir) then
    oVenda.VendaId := oVenda.Inserir(dtmVenda.cdsItensVenda)
  else if (EstadoDoCadastro = ecAlterar) then
    oVenda.Atualizar(dtmVenda.cdsItensVenda);

  GerarRelatorioVenda;

  Result := True;
end;

{$endregion}

procedure TfrmProVenda.btnAdicionarProdutoClick(Sender: TObject);
begin
  inherited;

  if edtSearchIdProduto.Text = EmptyStr then
  begin
    MessageDlg('Produto é um campo obrigatório', mtInformation, [mbOk], 0);
    edtSearchIdProduto.SetFocus;
    abort;
  end;

  if edtValorUnitario.Value <= 0 then
  begin
    MessageDlg('Valor unitário não pode ser zero', mtInformation, [mbOk], 0);
    edtValorUnitario.SetFocus;
    abort;
  end;

  if edtQuantidade.Value <= 0 then
  begin
    MessageDlg('Quantidade não pode ser zero', mtInformation, [mbOk], 0);
    edtQuantidade.SetFocus;
    abort;
  end;

  edtValorTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

  dtmVenda.cdsItensVenda.Append;
  dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString := edtSearchIdProduto.Text;
  dtmVenda.cdsItensVenda.FieldByName('nomeProduto').AsString := edtSearchNomeProduto.Text;
  dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat := edtQuantidade.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat := edtValorUnitario.Value;
  dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat := edtValorTotalProduto.Value;
  dtmVenda.cdsItensVenda.Post;
  edtValorTotal.Value := TotalizarVenda;
  LimparComponenteItem;

  edtSearchIdProduto.SetFocus;
end;

procedure TfrmProVenda.LimparComponenteItem;
begin
  edtSearchIdProduto.Text       := EmptyStr;
  edtSearchNomeProduto.Text     := EmptyStr;
  edtQuantidade.Value           := 0;
  edtValorUnitario.Value        := 0;
  edtValorTotalProduto.Value    := 0;
end;

function TfrmProVenda.TotalizarProduto(valorUnitario, Quantidade: Double): Double;
begin
  Result := valorUnitario * Quantidade;
end;

procedure TfrmProVenda.LimparCds;
begin
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do
    dtmVenda.cdsItensVenda.Delete;
end;

procedure TfrmProVenda.btnAlterarClick(Sender: TObject);
begin
  if oVenda.Selecionar(QryListagem.FieldByName('vendaId').AsInteger, dtmVenda.cdsItensVenda) then
  begin
    edtVendaId.Text     := IntToStr(oVenda.VendaId);
    lkpCliente.KeyValue := oVenda.ClienteId;
    edtDataVenda.Date   := oVenda.DataVenda;
    edtValorTotal.Value := oVenda.TotalVenda;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;

  inherited;
end;

procedure TfrmProVenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  LimparCds;
end;

procedure TfrmProVenda.btnNovoClick(Sender: TObject);
begin
  inherited;
  edtDataVenda.Date := Date;
  lkpCliente.SetFocus;
  LimparCds;
end;

procedure TfrmProVenda.btnRemoverProdutoClick(Sender: TObject);
begin
  inherited;
  if edtSearchIdProduto.Text = EmptyStr then
  begin
    MessageDlg('Selecione o produto a ser excluído', mtInformation, [mbOk], 0);
    dgGridItensVenda.SetFocus;
    abort;
  end;

  if dtmVenda.cdsItensVenda.Locate('produtoId', edtSearchIdProduto.Text, []) then
  begin
    dtmVenda.cdsItensVenda.Delete;
    edtValorTotal.Value := TotalizarVenda;
    LimparComponenteItem;
  end;
end;

procedure TfrmProVenda.dgGridItensVendaDblClick(Sender: TObject);
begin
  inherited;
  CarregarRegistroSelecionado;
end;

procedure TfrmProVenda.dgGridItensVendaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  BloqueiaCTRL_DEL_DBGrid(Key, Shift);
end;

procedure TfrmProVenda.edtQuantidadeEnter(Sender: TObject);
begin
  inherited;
  edtValorTotal.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.edtQuantidadeExit(Sender: TObject);
begin
  inherited;
  edtValorTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);
end;

procedure TfrmProVenda.edtSearchIdProdutoExit(Sender: TObject);
begin
  inherited;

  if edtSearchIdProduto.Text <> EmptyStr then
    GetDescricaoProduto
  else
    edtSearchNomeProduto.Clear;
end;

procedure TfrmProVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(dtmVenda) then
    FreeAndNil(dtmVenda);

  if Assigned(oVenda) then
    FreeAndNil(oVenda);
end;

procedure TfrmProVenda.FormCreate(Sender: TObject);
begin
  inherited;
  dtmVenda := TdtmVenda.Create(Self);

  oVenda := TVenda.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'clienteId';
end;

procedure  TfrmProVenda.CarregarRegistroSelecionado;
begin
  edtSearchIdProduto.Text     := dtmVenda.cdsItensVenda.FieldByName('produtoId').AsString;
  edtSearchNomeProduto.Text   := dtmVenda.cdsItensVenda.FieldByName('NomeProduto').AsString;
  edtQuantidade.Value         := dtmVenda.cdsItensVenda.FieldByName('quantidade').AsFloat;
  edtValorUnitario.Value      := dtmVenda.cdsItensVenda.FieldByName('valorUnitario').AsFloat;
  edtValorTotalProduto.Value  := dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
end;

function TfrmProVenda.TotalizarVenda: Double;
begin
  Result := 0;
  dtmVenda.cdsItensVenda.First;
  while not dtmVenda.cdsItensVenda.Eof do
  begin
    Result := Result + dtmVenda.cdsItensVenda.FieldByName('valorTotalProduto').AsFloat;
    dtmVenda.cdsItensVenda.Next;
  end;
end;

procedure TfrmProVenda.GetDescricaoProduto;
var
  Qry: TZQuery;
begin
  Try
    Qry := TZQuery.Create(nil);
    Qry.Connection := dtmPrincipal.ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT * FROM PRODUTOS WHERE PRODUTOID = :PRODUTOID');
    Qry.ParamByName('PRODUTOID').AsInteger := StrToInt(edtSearchIdProduto.Text);
    Qry.Open;

    edtValorUnitario.Value := Qry.FieldByName('valor').AsFloat;
    edtQuantidade.Value := 1;
    edtValorTotalProduto.Value := TotalizarProduto(edtValorUnitario.Value, edtQuantidade.Value);

    edtSearchNomeProduto.Text := Qry.FieldByName('nome').AsString;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

end.
