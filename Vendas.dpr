program Vendas;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uDTMConexao in 'DataModule\uDTMConexao.pas' {dtmPrincipal: TDataModule},
  uCadCategoria in 'Cadastro\uCadCategoria.pas' {frmCadCategoria},
  Enter in 'terceiros\Enter.pas',
  uEnum in 'Heranca\uEnum.pas',
  uTelaHeranca in 'Heranca\uTelaHeranca.pas' {frmTelaHeranca},
  cCadCategoria in 'Classes\cCadCategoria.pas',
  uCadCliente in 'Cadastro\uCadCliente.pas' {frmCadCliente},
  cCadCliente in 'Classes\cCadCliente.pas',
  uCadProduto in 'Cadastro\uCadProduto.pas' {frmCadProduto},
  cCadProduto in 'Classes\cCadProduto.pas',
  uFrmAtualizaDB in 'DataModule\uFrmAtualizaDB.pas' {frmAtualizaDB},
  uDTMVenda in 'DataModule\uDTMVenda.pas' {dtmVenda: TDataModule},
  uProVenda in 'Processo\uProVenda.pas' {frmProVenda},
  cProVenda in 'Classes\cProVenda.pas',
  cControleEstoque in 'Classes\cControleEstoque.pas',
  uRelCadClienteFicha in 'Relatorio\uRelCadClienteFicha.pas' {frmRelCadClienteFicha},
  uRelCadCliente in 'Relatorio\uRelCadCliente.pas' {frmRelCadCliente},
  uRelCategoria in 'Relatorio\uRelCategoria.pas' {frmRelCategoria},
  uRelProVenda in 'Relatorio\uRelProVenda.pas' {frmRelProVenda},
  uRelCadProduto in 'Relatorio\uRelCadProduto.pas' {frmRelCadProduto},
  uSelecionarData in 'Cadastro\uSelecionarData.pas' {frmSelecionarData},
  uRelCadProdutoPorCategoria in 'Relatorio\uRelCadProdutoPorCategoria.pas' {frmRelCadProdutoPorCategoria},
  uRelVendaPorData in 'Relatorio\uRelVendaPorData.pas' {frmRelProVendaPorData},
  uFuncaoCriptografia in 'Heranca\uFuncaoCriptografia.pas',
  uCadUsuario in 'Cadastro\uCadUsuario.pas' {frmCadUsuario},
  cCadUsuario in 'Classes\cCadUsuario.pas',
  uLogin in 'Login\uLogin.pas' {frmLogin},
  uAlterarSenha in 'Login\uAlterarSenha.pas' {frmAlterarSenha},
  cUsuarioLogado in 'Login\cUsuarioLogado.pas',
  cAtualizacaoBancoDeDados in 'Classes\cAtualizacaoBancoDeDados.pas',
  cAtualizacaoTabelaMSSQL in 'Classes\cAtualizacaoTabelaMSSQL.pas',
  cBancoDeDados in 'cBancoDeDados.pas',
  cAtualizacaoCamposMSSQL in 'Classes\cAtualizacaoCamposMSSQL.pas',
  cArquivoIni in 'Classes\cArquivoIni.pas',
  cAcaoAcesso in 'Classes\cAcaoAcesso.pas',
  uCadAcaoAcesso in 'Cadastro\uCadAcaoAcesso.pas' {frmCadAcaoAcesso},
  uUsuariosVsAcoes in 'Login\uUsuariosVsAcoes.pas' {frmUsuariosVsAcoes},
  uDTMGrafico in 'DataModule\uDTMGrafico.pas' {DTMGrafico: TDataModule},
  cFuncao in 'Classes\cFuncao.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
