unit cBancoDeDados;

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
  TBancoDeDados = class
    private
      ConexaoDB: TZConnection;
      F_servidor: String;
      F_usuario: String;
      F_senhaBanco: String;
      F_library: String;
      F_protocol: String;
      F_database: String;
      F_porta: Integer;
    public
      procedure PropriedadesBancoDeDados;
      constructor Create(aConexao: TZConnection);
      destructor Destroy; override;
    published
      property servidor:    String  read F_servidor    write F_servidor;
      property usuario:     String  read F_usuario     write F_usuario;
      property senhaBanco:  String  read F_senhaBanco  write F_senhaBanco;
      property libraryPath: String  read F_library     write F_library;
      property protocol:    String  read F_protocol    write F_protocol;
      property database:    String  read F_database    write F_database;
      property porta:       Integer read F_porta       write F_porta;
  end;

implementation

{ TBancoDeDados }

constructor TBancoDeDados.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;

destructor TBancoDeDados.Destroy;
begin
  inherited;
end;

procedure TBancoDeDados.PropriedadesBancoDeDados;
var
  Qry: TZQuery;
begin
  Try
    Qry := TZQuery.Create(nil);
    Qry.Connection := ConexaoDB;
    Qry.SQL.Clear;
    Qry.Open;
    Try
      ConexaoDB.HostName            := '.';
      ConexaoDB.User                := 'sa';
      ConexaoDB.Password            := '@ijbp12345';
      ConexaoDB.LibraryLocation     := 'C:\Projetos\curso_delphi\ntwdblib.dll';
      ConexaoDB.Protocol            := 'mssql';
      ConexaoDB.Database            := 'Vendas';
      ConexaoDB.Port                := 1433;

      Self.F_servidor   := ConexaoDB.HostName;
      Self.F_usuario    := ConexaoDB.User;
      Self.F_senhaBanco := ConexaoDB.Password;
      Self.F_library    := ConexaoDB.LibraryLocation;
      Self.F_protocol   := ConexaoDB.Protocol;
      Self.F_database   := ConexaoDB.Database;
      Self.F_porta      := ConexaoDB.Port;
    Except on E: Exception do
      ShowMessage(e.Message);
    End;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

end.
