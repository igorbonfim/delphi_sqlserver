unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, cUsuarioLogado;

type
  TfrmLogin = class(TForm)
    btnAcessar: TBitBtn;
    btnFechar: TBitBtn;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAcessarClick(Sender: TObject);
  private
    bFechar: Boolean;
    procedure FecharAplicacao;
    procedure FecharFormulario;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses cCadUsuario, uDTMConexao, uPrincipal;

procedure TfrmLogin.btnFecharClick(Sender: TObject);
begin
  FecharAplicacao;  // fecha a aplicação
end;

procedure TfrmLogin.btnAcessarClick(Sender: TObject);
var
  oUsuario: TUsuario;
begin
  try
    oUsuario := TUsuario.Create(dtmPrincipal.ConexaoDB);
    if oUsuario.Logar(edtUsuario.Text, edtSenha.Text) then
    begin
      oUsuarioLogado.codigo := oUsuario.codigo;
      oUsuarioLogado.nome   := oUsuario.nome;
      oUsuarioLogado.senha  := oUsuario.senha;
      FecharFormulario
    end
    else
    begin
      MessageDlg('Usuario inválido', mtInformation, [mbOk], 0);
      edtUsuario.SetFocus;
    end;

  finally
    if Assigned(oUsuario) then
      FreeAndNil(oUsuario);
  end;
end;

procedure TfrmLogin.FecharFormulario;
begin
  bFechar := true;
  Close;
end;

procedure TfrmLogin.FecharAplicacao;
begin
  bFechar := true;
  Application.Terminate;
end;

procedure TfrmLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := bFechar;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  bFechar := false;
end;

end.
