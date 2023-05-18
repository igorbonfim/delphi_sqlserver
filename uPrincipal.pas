unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter, uFrmAtualizaDB, cUsuarioLogado,
  Vcl.ComCtrls, ZDbcIntfs, cAtualizacaoBancoDeDados, RLReport, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.StdCtrls, Vcl.ExtCtrls,
  VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.TeeProcs, VCLTee.Chart,
  VCLTee.DBChart, VCLTee.Series, cFuncao;

type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    CADA1: TMenuItem;
    MOVIMENTAO1: TMenuItem;
    RELATRIOS1: TMenuItem;
    CLIENTE1: TMenuItem;
    N1: TMenuItem;
    CATEGORIA1: TMenuItem;
    PRODUTO1: TMenuItem;
    N2: TMenuItem;
    mnuFechar: TMenuItem;
    VENDAS1: TMenuItem;
    CLIENTE2: TMenuItem;
    N3: TMenuItem;
    PRODUTO2: TMenuItem;
    N4: TMenuItem;
    VENDAPORDATA1: TMenuItem;
    Categoria2: TMenuItem;
    FICHADECLIENTE1: TMenuItem;
    PRODUTOPORCATEGORIA1: TMenuItem;
    USUARIO1: TMenuItem;
    N5: TMenuItem;
    ALTERARSENHA1: TMenuItem;
    StbPrincipal: TStatusBar;
    AOACESSO1: TMenuItem;
    N6: TMenuItem;
    USUARIOSVSAES1: TMenuItem;
    pnlDashboard: TPanel;
    Label1: TLabel;
    tmrAtualizacaoDashboard: TTimer;
    GridPanel1: TGridPanel;
    pnlProdutoEmEstoque: TPanel;
    pnlValorVendaPorClienteUltimaSemana: TPanel;
    pnlVendasUltimaSemana: TPanel;
    pnl10ProdutosMaisVendidos: TPanel;
    DBChart2: TDBChart;
    Series2: TPieSeries;
    DBChart1: TDBChart;
    FastLineSeries1: TFastLineSeries;
    DBChart3: TDBChart;
    PieSeries1: TPieSeries;
    DBChart4: TDBChart;
    Series1: TBarSeries;
    procedure mnuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CATEGORIA1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CLIENTE1Click(Sender: TObject);
    procedure PRODUTO1Click(Sender: TObject);
    procedure VENDAS1Click(Sender: TObject);
    procedure Categoria2Click(Sender: TObject);
    procedure CLIENTE2Click(Sender: TObject);
    procedure FICHADECLIENTE1Click(Sender: TObject);
    procedure PRODUTO2Click(Sender: TObject);
    procedure PRODUTOPORCATEGORIA1Click(Sender: TObject);
    procedure VENDAPORDATA1Click(Sender: TObject);
    procedure USUARIO1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ALTERARSENHA1Click(Sender: TObject);
    procedure AOACESSO1Click(Sender: TObject);
    procedure USUARIOSVSAES1Click(Sender: TObject);
    procedure pnlDashboardClick(Sender: TObject);
    procedure tmrAtualizacaoDashboardTimer(Sender: TObject);
  private
    { Private declarations }
    TeclaEnter : TMREnter;
    procedure AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
    procedure AtualizarDashboard;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  oUsuarioLogado: TUsuarioLogado;

implementation

{$R *.dfm}

uses uCadCategoria, uCadCliente, cCadProduto, uCadProduto, uProVenda, uRelCategoria, uRelCadCliente, uRelCadClienteFicha, uRelCadProduto,
  uRelCadProdutoPorCategoria, uSelecionarData, uRelVendaPorData, uCadUsuario,
  uLogin, uAlterarSenha, cArquivoIni, uCadAcaoAcesso, cAcaoAcesso, uTelaHeranca,
  uUsuariosVsAcoes, uDTMGrafico;

procedure TfrmPrincipal.CATEGORIA1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.Categoria2Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CLIENTE1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadCliente, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.CLIENTE2Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadCliente, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.FICHADECLIENTE1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadClienteFicha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmPrincipal);
  FreeAndNil(dtmGrafico);

  if Assigned(oUsuarioLogado) then
    FreeAndNil(oUsuarioLogado);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  if not FileExists(TArquivoIni.ArquivoIni) then
  begin
    TArquivoIni.AtualizarIni('SERVER', 'TipoDatabase', 'MSSQL');
    TArquivoIni.AtualizarIni('SERVER', 'Hostname', '.');
    TArquivoIni.AtualizarIni('SERVER', 'Port', 'NUMERO_PORTA');
    TArquivoIni.AtualizarIni('SERVER', 'User', 'USUARIO');
    TArquivoIni.AtualizarIni('SERVER', 'Password', 'SENHA_BANCO');
    TArquivoIni.AtualizarIni('SERVER', 'Database', 'NOME_DATABASE');

    MessageDlg('Arquivo ' +TArquivoIni.ArquivoIni+ ' Criado com sucesso' +#13+
               'Configure o arquivo antes de inicializar a aplicação', MtInformation, [mbOK], 0);

    Application.Terminate;
  end
  else
  begin
    frmAtualizaDB := TfrmAtualizaDB.Create(Self);
    frmAtualizaDB.Show;
    frmAtualizaDB.Refresh;

    dtmPrincipal := TdtmPrincipal.Create(Self);

    with dtmPrincipal.ConexaoDB do
    begin
        Connected               := False;
        SQLHourGlass            := False;

        if TArquivoIni.LerIni('SERVER', 'TipoDatabase') = 'MSSQL' then
          Protocol := 'mssql';

        LibraryLocation         := 'C:\Projetos\Curso Delphi com SQL Server Udemy\ntwdblib.dll';
        HostName                := TArquivoIni.LerIni('SERVER', 'Hostname');
        Port                    := StrToInt(TArquivoIni.LerIni('SERVER', 'Port'));
        User                    := TArquivoIni.LerIni('SERVER', 'User');
        Password                := TArquivoIni.LerIni('SERVER', 'Password');
        Database                := TArquivoIni.LerIni('SERVER', 'Database');
        AutoCommit              := True;
        TransactIsolationLevel  := tiReadCommitted;
        Connected               := true;
    end;

    AtualizacaoBancoDados(frmAtualizaDB);

    TAcaoAcesso.CriarAcoes(TfrmCadCategoria, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadProduto, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadCliente, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadUsuario, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmCadAcaoAcesso, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmAlterarSenha, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmProVenda, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelProVendaPorData, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadProduto, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadProdutoPorCategoria, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadClienteFicha, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCadCliente, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmRelCategoria, dtmPrincipal.ConexaoDB);
    TAcaoAcesso.CriarAcoes(TfrmUsuariosVsAcoes, dtmPrincipal.ConexaoDB);

    TAcaoAcesso.PreencherUsuariosVsAcoes(dtmPrincipal.ConexaoDB);

    DTMGrafico := TDTMGrafico.Create(Self);
    AtualizarDashboard;

    frmAtualizaDB.Free;

    TeclaEnter := TMREnter.Create(Self);
    TeclaEnter.FocusEnabled := true;
    TeclaEnter.FocusColor := clInfoBk;
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  try
    oUsuarioLogado := TUsuarioLogado.Create;

    frmLogin := TfrmLogin.Create(Self);
    frmLogin.ShowModal;
  finally
    frmLogin.Release;
    StbPrincipal.Panels[0].Text := 'USUÁRIO: ' +oUsuarioLogado.nome;
  end;
end;

procedure TfrmPrincipal.mnuFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.pnlDashboardClick(Sender: TObject);
begin
  AtualizarDashboard;
end;

procedure TfrmPrincipal.PRODUTO1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.PRODUTO2Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadProduto, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.PRODUTOPORCATEGORIA1Click(Sender: TObject);
begin
  TFuncao.CriarRelatorio(TfrmRelCadProdutoPorCategoria, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.tmrAtualizacaoDashboardTimer(Sender: TObject);
begin
  AtualizarDashboard;
end;

procedure TfrmPrincipal.USUARIO1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadUsuario, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.USUARIOSVSAES1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmUsuariosVsAcoes, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.VENDAPORDATA1Click(Sender: TObject);
begin
  Try
    frmSelecionarData := TfrmSelecionarData.Create(Self);
    if TUsuarioLogado.TenhoAcesso(oUsuarioLogado.codigo, frmSelecionarData.Name, DtmPrincipal.ConexaoDB) then
    begin
      frmSelecionarData.ShowModal;
      frmRelProVendaPorData := TfrmRelProVendaPorData.Create(Self);
      frmRelProVendaPorData.QryVenda.Close;
      frmRelProVendaPorData.QryVenda.ParamByName('DataInicio').AsDate := frmSelecionarData.edtDataInicio.Date;
      frmRelProVendaPorData.QryVenda.ParamByName('DataFim').AsDate    := frmSelecionarData.edtDataFinal.Date;
      frmRelProVendaPorData.QryVenda.Open;
      frmRelProVendaPorData.Relatorio.PreviewModal;
    end
    else
    begin
      MessageDlg('Usuário: ' +oUsuarioLogado.nome+ ' não tem permissão de acesso', mtWarning, [mbOk], 0);
    end;

  Finally
    if Assigned(frmSelecionarData) then
      frmSelecionarData.Release;

    if Assigned(frmRelProVendaPorData) then
      frmRelProVendaPorData.Release;
  End;
end;

procedure TfrmPrincipal.VENDAS1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmProVenda, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.ALTERARSENHA1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmAlterarSenha, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.AOACESSO1Click(Sender: TObject);
begin
  TFuncao.CriarForm(TfrmCadAcaoAcesso, oUsuarioLogado, dtmPrincipal.ConexaoDB);
end;

procedure TfrmPrincipal.AtualizacaoBancoDados(aForm: TfrmAtualizaDB);
var
  oAtualizarMSSQL: TAtualizaBancoDeDadosMSSQL;
begin
  aForm.Refresh;

  Try
    oAtualizarMSSQL := TAtualizaBancoDeDadosMSSQL.Create(dtmPrincipal.ConexaoDB);
    oAtualizarMSSQL.AtualizarBancoDeDadosMSSQL;
  Finally
    if Assigned(oAtualizarMSSQL) then
      FreeAndNil(oAtualizarMSSQL);
  End;
end;

procedure TfrmPrincipal.AtualizarDashboard;
begin
  Try
    Screen.Cursor := crSQLWait;
    if DTMGrafico.QryProdutoEstoque.Active then
      DTMGrafico.QryProdutoEstoque.Close;

    if DTMGrafico.QryValorVendaPorCliente.Active then
      DTMGrafico.QryValorVendaPorCliente.Close;

    if DTMGrafico.Qry10ProdutosMaisVendidos.Active then
      DTMGrafico.Qry10ProdutosMaisVendidos.Close;

    if DTMGrafico.QryVendasUltimaSemana.Active then
      DTMGrafico.QryVendasUltimaSemana.Close;

    DTMGrafico.QryValorVendaPorCliente.Open;
    DTMGrafico.QryProdutoEstoque.Open;
    DTMGrafico.Qry10ProdutosMaisVendidos.Open;
    DTMGrafico.QryVendasUltimaSemana.Open;
  Finally
    Screen.Cursor := crDefault;
  End;
end;

end.
