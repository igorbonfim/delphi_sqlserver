unit cControleEstoque;

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
      Data.DB,
      Datasnap.DBClient,
      System.SysUtils;

type
  TControleEstoque = class
  private
    ConexaoDB: TZConnection;
    F_ProdutoId: Integer;
    F_Quantidade: Double;
  public
    constructor Create(aConexao: TZConnection);
    destructor Destroy; override;
    function BaixarEstoque: Boolean;
    function RetornarEstoque: Boolean;
  published
    property ProdutoId:  Integer  read F_ProdutoId   write F_ProdutoId;
    property Quantidade: Double   read F_Quantidade  write F_Quantidade;
  end;

implementation

{$region 'Construtor and Destructor'}
constructor TControleEstoque.Create(aConexao : TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TControleEstoque.Destroy;
begin

  inherited;
end;
{$endregion}

function TControleEstoque.BaixarEstoque: Boolean;
var
  Qry: TZQuery;
begin
  Try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE PRODUTOS '+
                'SET QUANTIDADE = QUANTIDADE - :qtdeBaixa '+
                'WHERE produtoId = :produtoId');
    Qry.Params.ParamByName('produtoId').AsInteger := ProdutoId;
    Qry.Params.ParamByName('qtdeBaixa').AsFloat   := Quantidade;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := False;
    End;

  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function TControleEstoque.RetornarEstoque: Boolean;
var
  Qry: TZQuery;
begin
  Try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE PRODUTOS '+
                'SET QUANTIDADE = QUANTIDADE + :qtdeBaixa '+
                'WHERE produtoId = :produtoId');
    Qry.Params.ParamByName('produtoId').AsInteger := ProdutoId;
    Qry.Params.ParamByName('qtdeBaixa').AsFloat   := Quantidade;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := False;
    End;

  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

end.
