unit cCadUsuario;

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
      uFuncaoCriptografia;

type
  TUsuario = class
    private
      ConexaoDB: TZConnection;
      F_usuarioId: Integer;
      F_nome: string;
      F_senha: string;
      function getSenha: string;
      procedure setSenha(const Value: string);

    public
      constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
      function Inserir: Boolean;
      function Atualizar: Boolean;
      function Apagar: Boolean;
      function Selecionar(id: Integer): Boolean;
      function Logar(aUsuario, aSenha: String): Boolean;
      function UsuarioExiste(aUsuario: String): Boolean;
      function AlterarSenha: Boolean;
    published
      property codigo :Integer  read F_usuarioId  write F_usuarioId;
      property nome   :string   read F_nome       write F_nome;
      property senha  :string   read getSenha     write setSenha;
    end;

implementation

{$region 'Constructor and Destructor'}
constructor TUsuario.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TUsuario.Destroy;
begin
  inherited;
end;
{$endRegion}

{$region 'CRUD'}

function TUsuario.Apagar: Boolean;
var
  Qry: TZQuery;
begin
  if MessageDlg('Apagar o Registro: ' +#13+#13+
               'Código: ' +IntToStr(F_usuarioId)+#13+
               'Nome: ' +F_nome, mtConfirmation, [mbYes, mbNo], 0)=mrNo then
 begin
    Result := false;
    abort;
 end;

 try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM usuarios ' +
                'WHERE usuarioId = :usuarioId ');
    Qry.ParamByName('usuarioId').AsInteger := F_usuarioId;

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

function TUsuario.Atualizar : Boolean;
var
  Qry : TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE usuarios '+
                '   SET nome          =:nome '+
                '      ,senha        =:senha '+
                '   WHERE usuarioId   =:usuarioId');
    Qry.ParamByName('usuarioId').AsInteger    := Self.F_usuarioId;
    Qry.ParamByName('nome').AsString          := Self.F_nome;
    Qry.ParamByName('descricao').AsString     := Self.F_senha;

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

function TUsuario.Inserir : Boolean;
var
  Qry : TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('INSERT INTO usuarios (nome,'+
                '                      senha)'+
                'VALUES               (:nome, '+
                '                      :senha)' );
    Qry.ParamByName('nome').AsString      := Self.F_nome;
    Qry.ParamByName('senha').AsString     := Self.F_senha;

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

function TUsuario.Selecionar(id: Integer) : Boolean;
var
  Qry : TZQuery;
begin
  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT usuarioId, '+
                '       nome, '+
                '       senha '+
                'FROM   usuarios '+
                'WHERE  usuarioId = :usuarioId');
    Qry.ParamByName('usuarioId').AsInteger := id;
    Try
      Qry.Open;

      Self.F_usuarioId    := Qry.FieldByName('usuarioId').AsInteger;
      Self.F_nome         := Qry.FieldByName('nome').AsString;
      Self.F_senha        := Qry.FieldByName('senha').AsString;
    Except
      Result := false;
    End;

  finally
    if Assigned(Qry) then
        FreeAndNil(Qry);
  end;
end;

function TUsuario.UsuarioExiste(aUsuario: String): Boolean;
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COUNT(usuarioId) AS Qtde '+
                'FROM usuarios '+
                'WHERE nome = :nome');
    Qry.ParamByName('nome').AsString := aUsuario;

    Try
      Qry.Open;

      if Qry.FieldByName('Qtde').AsInteger > 0 then
        result := true
      else
        result := false;

    Except
      Result := false;
    End;

   finally
     if Assigned(Qry) then
       FreeAndNil(Qry);
   end;
end;

{$endRegion}

{$region 'GET E SET'}
function TUsuario.GetSenha: String;
begin
  Result := Descriptografar(Self.F_senha);
end;

procedure TUsuario.setSenha(const Value: string);
begin
  Self.F_senha  := Criptografar(Value);
end;
{$endRegion}

{$region 'Login'}
function TUsuario.Logar(aUsuario: String; aSenha: String): Boolean;
var
  Qry: TZQuery;
begin
  try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT usuarioId, nome, senha '+
                'FROM   usuarios '+
                'WHERE  nome = :nome AND senha = :senha');
    Qry.ParamByName('nome').AsString := aUsuario;
    Qry.ParamByName('senha').AsString := Criptografar(aSenha);

    Try
     Qry.Open;

     if Qry.FieldByName('usuarioId').AsInteger > 0 then
     begin
       F_usuarioId  := Qry.FieldByName('usuarioId').AsInteger;
       F_nome       := Qry.FieldByName('nome').AsString;
       F_senha      := Qry.FieldByName('senha').AsString;
       Result       := true
     end
     else
       Result := false;

    Except
      Result := false;
    End;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;
{$endregion}

{$region 'Alteração de senha'}
function TUsuario.AlterarSenha: Boolean;
var
  Qry: TZQuery;
begin
  try
    Result := True;
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE usuarios ' +
                'SET    senha = :senha ' +
                'WHERE  usuarioId = :usuarioId');
    Qry.ParamByName('usuarioId').AsInteger  := Self.F_usuarioId;
    Qry.ParamByName('senha').AsString       := Self.F_senha;

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
{$endregion}

end.
