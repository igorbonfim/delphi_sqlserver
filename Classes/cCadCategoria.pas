unit cCadCategoria;

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
  TCategoria = class
    private
        ConexaoDB : TZConnection;
        F_categoriaId : Integer;
        F_descricao : String;
    function GetCategoriaID: Integer;
    function getDescricao: String;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: String);
    public
      constructor Create(aConexao : TZConnection);
      destructor Destroy; override;
      function Inserir : Boolean;
      function Atualizar : Boolean;
      function Apagar : Boolean;
      function Selecionar(id : Integer) : Boolean;
    published
      property codigo : Integer read GetCategoriaID write setCodigo;
      property descricao : String read getDescricao write setDescricao;

  end;

implementation

{ TCategoria }
{$region 'Construtor and Destructor'}
constructor TCategoria.Create(aConexao : TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TCategoria.Destroy;
begin

  inherited;
end;
{$endregion}

{$region 'CRUD'}
function TCategoria.Apagar : Boolean;
var
  Qry : TZQuery;
begin
  if MessageDlg('Apagar o registro: ' +#13+#13+
                'Código: ' + IntToStr(F_categoriaId) + #13+
                'Descrição: ' +F_descricao, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Result := false;
    Abort;
  end;

  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM CATEGORIAS ' +
                'WHERE CATEGORIAID = :CATEGORIAID ');
    Qry.ParamByName('categoriaId').AsInteger := F_categoriaId;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := False;
    End;

  finally
    if Assigned(Qry) then
        FreeAndNil(Qry);
  end;
end;

function TCategoria.Atualizar: Boolean;
var
  Qry : TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE CATEGORIAS ' +
               ' SET DESCRICAO = :DESCRICAO ' +
               ' WHERE CATEGORIAID = :CATEGORIAID ');
    Qry.ParamByName('categoriaId').AsInteger := Self.F_categoriaId;
    Qry.ParamByName('descricao').AsString := Self.F_descricao;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := False;
    End;

  finally
    if Assigned(Qry) then
        FreeAndNil(Qry);
  end;
end;

function TCategoria.Inserir: Boolean;
var
  Qry : TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO CATEGORIAS(DESCRICAO) VALUES(:DESCRICAO)');
    Qry.ParamByName('descricao').AsString := Self.F_descricao;

    Try
      ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      ConexaoDB.Commit;
    Except
      ConexaoDB.Rollback;
      Result := False;
    End;

  finally
    if Assigned(Qry) then
        FreeAndNil(Qry);
  end;
end;

function TCategoria.Selecionar(id: Integer): Boolean;
var
  Qry : TZQuery;
begin
  Try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT CATEGORIAID, ' +
                'DESCRICAO ' +
                'FROM CATEGORIAS ' +
                'WHERE CATEGORIAID = :CATEGORIAID');
    Qry.ParamByName('CATEGORIAID').AsInteger := id;
    Try
      Qry.Open;

      Self.F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;
      Self.F_descricao := Qry.FieldByName('descricao').AsString;
    Except
      Result := false;
    End;
  Finally
    if Assigned(Qry) then
        FreeAndNil(Qry);
  End;
end;
{$endregion}

{$region 'Gets'}
function TCategoria.GetCategoriaID: Integer;
begin
  Result := Self.F_categoriaId;
end;

function TCategoria.getDescricao: String;
begin
  Result := Self.F_descricao;
end;
{$endregion}

{$region 'Sets'}
procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_categoriaId := Value;
end;

procedure TCategoria.setDescricao(const Value: String);
begin
  Self.F_descricao := Value;
end;
{$endregion}
end.
