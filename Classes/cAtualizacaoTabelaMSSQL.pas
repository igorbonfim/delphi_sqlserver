unit cAtualizacaoTabelaMSSQL;

interface

uses  System.Classes,
      Vcl.Controls,
      Vcl.ExtCtrls,
      Vcl.Dialogs,
      ZAbstractConnection,
      ZConnection,
      ZAbstractRODataset,
      ZAbstractDataset,
      ZDataset,
      System.SysUtils,
      cAtualizacaoBancoDeDados,
      cCadUsuario;

type
  TAtualizacaoTableMSSQL = class(TAtualizaBancoDeDados)

  private
    function TabelaExiste(aNomeTabela: String): Boolean;
    procedure Categoria;
    procedure Cliente;
    procedure Produto;
    procedure Venda;
    procedure VendasItens;
    procedure Usuario;
    procedure AcaoAcesso;
    procedure UsuariosAcaoAcesso;
  protected
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
  end;

implementation

{ TAtualizacaoTableMSSQL }

constructor TAtualizacaoTableMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
  Categoria;
  Cliente;
  Produto;
  Venda;
  VendasItens;
  Usuario;
  AcaoAcesso;
  UsuariosAcaoAcesso;
end;

destructor TAtualizacaoTableMSSQL.Destroy;
begin

  inherited;
end;

function TAtualizacaoTableMSSQL.TabelaExiste(aNomeTabela: String): Boolean;
var
  Qry: TZQuery;
begin
  Try
    Result := False;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT OBJECT_ID(:NomeTabela) As ID');
    Qry.ParamByName('NomeTabela').AsString := aNomeTabela;
    Qry.Open;

    if Qry.FieldByName('ID').AsInteger > 0 then
      Result := True;

  Finally
    Qry.Close;
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

procedure TAtualizacaoTableMSSQL.AcaoAcesso;
begin
  if not TabelaExiste('AcaoAcesso') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE AcaoAcesso( '+
      '  acaoAcessoId INT IDENTITY(1,1) NOT NULL, '+
      '  descricao VARCHAR(100) NOT NULL, '+
      '  chave VARCHAR(60) NOT NULL, '+
      '  PRIMARY KEY (acaoAcessoId) '+
      ') '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Categoria;
begin
  if not TabelaExiste('Categorias') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE Categorias( '+
      '  categoriaId INT IDENTITY(1,1) NOT NULL, '+
      '  descricao VARCHAR(30) NULL, '+
      '  PRIMARY KEY (categoriaId) '+
      ') '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Cliente;
begin
  if not TabelaExiste('Clientes') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE Clientes( '+
      '	 clienteId int IDENTITY(1,1) NOT NULL, '+
      '	 nome varchar(60) NULL, '+
      '	 endereco varchar(60) NULL, '+
      '	 cidade varchar(50) NULL, '+
      '	 bairro varchar(40) NULL, '+
      '	 estado varchar(2) NULL, '+
      '	 cep varchar(10) NULL, '+
      '	 telefone varchar(14) NULL, '+
      '	 email varchar(100) NULL, '+
      '	 dataNascimento datetime NULL, '+
      '	 PRIMARY KEY (clienteId) '+
      ') '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Produto;
begin
  if not TabelaExiste('Produtos') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE Produtos( '+
      '  produtoId int IDENTITY(1,1) NOT NULL, '+
      '  nome varchar(60) NULL, '+
      '  descricao varchar(255) NULL, '+
      '  valor decimal(18,5) default 0.00000 NULL, '+
      '  quantidade decimal(18,5) default 0.00000 NULL, '+
      '  categoriaId int NULL, '+
      '  PRIMARY KEY (produtoId), '+
      '  CONSTRAINT FK_ProdutosCategorias '+
      '  FOREIGN KEY (categoriaId) references categorias(categoriaId) '+
      ') '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Venda;
begin
  if not TabelaExiste('Vendas') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE Vendas( '+
      '  vendaId int IDENTITY(1,1) NOT NULL, '+
      '  clienteId int NOT NULL, '+
      '  dataVenda datetime default getdate(), '+
      '  totalVenda decimal(18,5) default 0.00000, '+
      '  PRIMARY KEY (vendaId), '+
      '  CONSTRAINT FK_VendasClientes FOREIGN KEY (clienteId) REFERENCES clientes(clienteId) '+
      ') '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.VendasItens;
begin
  if not TabelaExiste('VendasItens') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE VendasItens( '+
      '  vendaId int NOT NULL, '+
      '  produtoId int NOT NULL, '+
      '  valorUnitario decimal(18,5) default 0.00000, '+
      '  quantidade decimal(18,5) default 0.00000, '+
      '  totalProduto decimal(18,5) default 0.00000, '+
      '  PRIMARY KEY (vendaId, produtoId), '+
      '  CONSTRAINT FK_VendasItensProdutos FOREIGN KEY (produtoId) REFERENCES produtos(produtoId) '+
      ') '
    );
  end;
end;

procedure TAtualizacaoTableMSSQL.Usuario;
var
  oUsuario: TUsuario;
begin
  if not TabelaExiste('Usuarios') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE Usuarios( '+
      '  usuarioId int identity(1,1) not null, '+
      '  nome varchar(50) not null, '+
      '  senha varchar(40) not null, '+
      '  PRIMARY KEY (usuarioId) '+
      ') '
    );

    Try
      oUsuario := TUsuario.Create(ConexaoDB);
      oUsuario.nome := 'ADMIN';
      oUsuario.senha := '123';

      if not oUsuario.UsuarioExiste(oUsuario.nome) then
        oUsuario.Inserir;
    Finally
      if Assigned(oUsuario) then
        FreeAndNil(oUsuario);
    End;
  end;
end;

procedure TAtualizacaoTableMSSQL.UsuariosAcaoAcesso;
begin
  if not TabelaExiste('usuariosAcaoAcesso') then
  begin
    ExecutaDiretoBancoDeDados(
      'CREATE TABLE usuariosAcaoAcesso( ' +
      'usuarioId INT NOT NULL, '+
      'acaoAcessoId INT NOT NULL, '+
      'ativo BIT NOT NULL DEFAULT 1, '+
      'PRIMARY KEY(usuarioId, acaoAcessoId), '+
      'CONSTRAINT FK_UsuarioAcaoAcessoUsuario '+
      'FOREIGN KEY (usuarioId) REFERENCES usuarios(usuarioId), '+
      'CONSTRAINT FK_UsuarioAcaoAcessoAcaoAcesso '+
      'FOREIGN KEY (acaoAcessoId) REFERENCES acaoAcesso(acaoAcessoId)' +
      ')'
    );
  end;
end;

end.
