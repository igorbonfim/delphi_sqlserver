unit cUsuarioLogado;

interface

uses  System.Classes, System.SysUtils, ZAbstractConnection, ZConnection, Data.DB,
      ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TUsuarioLogado = class
    private
        F_UsuarioId : Integer;
        F_nome : String;
        F_senha : String;
    public
      class function TenhoAcesso(aUsuarioId: Integer; aChave: string; aConexao: TZConnection): Boolean; static;
    published
      property codigo : Integer read F_UsuarioId  write F_UsuarioId;
      property nome   : String  read F_nome       write F_nome;
      property senha  : String  read F_senha      write F_senha;

  end;

implementation

{ TUsuarioLogado }

class function TUsuarioLogado.TenhoAcesso(aUsuarioId: Integer; aChave: string;
  aConexao: TZConnection): Boolean;
var
  Qry: TZQuery;
begin
  Try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := aConexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT usuarioId FROM usuariosAcaoAcesso ' +
                'WHERE  usuarioId = :usuarioId '+
                'AND    acaoAcessoId = (SELECT TOP 1 acaoAcessoId FROM acaoAcesso WHERE chave = :chave) '+
                'AND    ativo = 1');
    Qry.ParamByName('usuarioId').AsInteger := aUsuarioId;
    Qry.ParamByName('chave').AsString := aChave;

    Qry.Open;

    if Qry.IsEmpty then
      Result := False;

  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

end.
