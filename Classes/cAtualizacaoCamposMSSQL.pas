unit cAtualizacaoCamposMSSQL;

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
      cAtualizacaoBancoDeDados;

type
  TAtualizacaoCamposMSSQL = class(TAtualizaBancoDeDados)
    private
      function CampoExisteNaTabela(aNomeTabela, aCampo: String): Boolean;
      procedure Versao1;
    protected

    public
      constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
  end;


implementation

{ TAtualizacaoCamposMSSQL }

function TAtualizacaoCamposMSSQL.CampoExisteNaTabela(aNomeTabela,
  aCampo: String): Boolean;
var
  Qry: TZQuery;
begin
  Try
    Result := False;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COUNT(COLUMN_NAME) AS QTDE ');
    Qry.SQL.Add('FROM INFORMATION_SCHEMA.COLUMNS ');
    Qry.SQL.Add('WHERE TABLE_NAME = :TABELA ');
    Qry.SQL.Add('AND COLUMN_NAME = :CAMPO');
    Qry.ParamByName('Tabela').AsString := aNomeTabela;
    Qry.ParamByName('Campo').AsString := aCampo;
    Qry.Open;

    if Qry.FieldByName('Qtde').AsInteger > 0 then
      Result := True;

  Finally
    Qry.Close;

    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

constructor TAtualizacaoCamposMSSQL.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TAtualizacaoCamposMSSQL.Destroy;
begin

  inherited;
end;

procedure TAtualizacaoCamposMSSQL.Versao1;
begin
  if not CampoExisteNaTabela('Categorias', 'teste') then
    ExecutaDiretoBancoDeDados('ALTER TABLE Categorias ADD Teste varchar(30) NULL');

  if CampoExisteNaTabela('Categorias', 'teste') then
    ExecutaDiretoBancoDeDados('ALTER TABLE Categorias DROP COLUMN Teste');
end;

end.
