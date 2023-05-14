unit cAtualizacaoBancoDeDados;

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
      System.SysUtils;

type
  TAtualizaBancoDeDados = class
  private
  public
    ConexaoDB: TZConnection;
    constructor Create(aConexao: TZConnection);
    procedure ExecutaDiretoBancoDeDados(aScript: String);
end;

type
  TAtualizaBancoDeDadosMSSQL = class
  private
  public
    ConexaoDB: TZConnection;
    function AtualizarBancoDeDadosMSSQL: Boolean;
    constructor Create(aConexao: TZConnection);
end;

implementation

{ TAtualizaBancoDeDados }

uses cAtualizacaoTabelaMSSQL, cAtualizacaoCamposMSSQL;

constructor TAtualizaBancoDeDados.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

procedure TAtualizaBancoDeDados.ExecutaDiretoBancoDeDados(aScript: String);
var
  Qry: TZQuery;
begin
  Try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(aScript);

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
    End;

  Finally
    Qry.Close;
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

{ TAtualizaBancoDeDadosMSSQL }

function TAtualizaBancoDeDadosMSSQL.AtualizarBancoDeDadosMSSQL: Boolean;
var
  oAtualizarDB: TAtualizaBancoDeDados;
  oTabela: TAtualizacaoTableMSSQL;
  oCampo: TAtualizacaoCamposMSSQL;
begin
  Try
    //Classe principal de atualização
    oAtualizarDB := TAtualizaBancoDeDados.Create(ConexaoDB);

    //Classe filha de atualização
    oTabela := TAtualizacaoTableMSSQL.Create(ConexaoDB);
    oCampo  := TAtualizacaoCamposMSSQL.Create(ConexaoDB);
  Finally
    if Assigned(oAtualizarDB) then
      FreeAndNil(oAtualizarDB);

    if Assigned(oTabela) then
      FreeAndNil(oTabela);
  End;
end;

constructor TAtualizaBancoDeDadosMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

end.
