unit cCadProduto;

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
      System.StrUtils,
      Vcl.Imaging.jpeg,
      Vcl.Graphics;

type
  TProduto = class
    private
      ConexaoDB : TZConnection;
      F_produtoId : Integer;
      F_nome : String;
      F_descricao : string;
      F_valor : Double;
      F_quantidade : Double;
      F_categoriaId : Integer;
      F_Foto: TBitmap;

    public
      constructor Create(aConexao : TZConnection);
      destructor Destroy; override;
      function Inserir : Boolean;
      function Atualizar : Boolean;
      function Apagar : Boolean;
      function Selecionar(id : Integer) : Boolean;
    published
      property codigo       :Integer  read F_produtoId    write F_produtoId;
      property nome         :string   read F_nome         write F_nome;
      property descricao    :string   read F_descricao    write F_descricao;
      property valor        :Double   read F_valor        write F_valor;
      property quantidade   :Double   read F_quantidade   write F_quantidade;
      property categoriaId  :Integer  read F_categoriaId  write F_categoriaId;
      property foto         :TBitmap  read F_Foto         write F_Foto;
  end;

implementation

{$region 'Constructor and Destructor'}
constructor TProduto.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;

  F_Foto := TBitmap.Create;
  F_Foto.Assign(nil);
end;

destructor TProduto.Destroy;
begin

  if Assigned(F_Foto) then
  begin
    F_Foto.Assign(nil);
    F_Foto.Free;
  end;

  inherited;
end;
{$endRegion}

{$region 'CRUD'}
function TProduto.Apagar : Boolean;
var
  Qry : TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' +#13+#13+
               'Código: ' +IntToStr(F_produtoId)+#13+
               'Descrição: ' +F_nome, mtConfirmation, [mbYes, mbNo], 0)=mrNo then
  begin
    Result := false;
    abort;
  end;

  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM produtos ' +
                'WHERE produtoId = :produtoId ');
    Qry.ParamByName('produtoId').AsInteger := F_produtoId;

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

function TProduto.Atualizar : Boolean;
var
  Qry : TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE produtos '+
                '   SET nome          =:nome '+
                '       ,descricao    =:descricao '+
                '       ,valor        =:valor '+
                '       ,quantidade   =:quantidade '+
                '       ,foto         =:foto '+
                '       ,categoriaId  =:categoriaId '+
                '   WHERE produtoId   =:produtoId');
    Qry.ParamByName('produtoId').AsInteger    := Self.F_produtoId;
    Qry.ParamByName('nome').AsString          := Self.F_nome;
    Qry.ParamByName('descricao').AsString     := Self.F_descricao;
    Qry.ParamByName('valor').AsFloat          := Self.F_valor;
    Qry.ParamByName('quantidade').AsFloat     := Self.F_quantidade;
    Qry.ParamByName('categoriaId').AsInteger  := Self.F_categoriaId;

    if Self.F_Foto.Empty then
      Qry.ParamByName('foto').Clear
    else
      Qry.ParamByName('foto').Assign(Self.F_Foto);

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

function TProduto.Inserir : Boolean;
var
  Qry : TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO produtos (nome, '+
                '                      descricao, '+
                '                      valor, '+
                '                      quantidade, '+
                '                      categoriaId, '+
                '                      foto) '+
                'VALUES               (:nome, '+
                '                      :descricao, '+
                '                      :valor, '+
                '                      :quantidade, '+
                '                      :categoriaId, '+
                '                      :foto)');
    Qry.ParamByName('nome').AsString          := Self.F_nome;
    Qry.ParamByName('descricao').AsString     := Self.F_descricao;
    Qry.ParamByName('valor').AsFloat          := Self.F_valor;
    Qry.ParamByName('quantidade').AsFloat     := Self.F_quantidade;
    Qry.ParamByName('categoriaId').AsInteger  := Self.F_categoriaId;

    if Self.F_Foto.Empty then
      Qry.ParamByName('foto').Clear
    else
      Qry.ParamByName('foto').Assign(Self.F_Foto);

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

function TProduto.Selecionar(id: Integer) : Boolean;
var
  Qry : TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT produtoId, '+
                '       nome, '+
                '       descricao, '+
                '       valor, '+
                '       quantidade, '+
                '       categoriaId, '+
                '       foto '+
                'FROM   produtos '+
                'WHERE  produtoId = :produtoId');
    Qry.ParamByName('produtoId').AsInteger := id;
    Try
      Qry.Open;

      Self.F_produtoId   := Qry.FieldByName('produtoId').AsInteger;
      Self.F_nome        := Qry.FieldByName('nome').AsString;
      Self.F_descricao   := Qry.FieldByName('descricao').AsString;
      Self.F_valor       := Qry.FieldByName('valor').AsFloat;
      Self.F_quantidade  := Qry.FieldByName('quantidade').AsFloat;
      Self.F_categoriaId := Qry.FieldByName('categoriaId').AsInteger;
      Self.F_Foto.Assign(Qry.FieldByName('foto'));
    Except
      Result := false;
    End;

  finally
    if Assigned(Qry) then
        FreeAndNil(Qry);
  end;
end;
{$endRegion}

end.
