unit uAlterarSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmAlterarSenha = class(TForm)
    lblSenhaAtual: TLabel;
    lblNovaSenha: TLabel;
    edtNovaSenha: TEdit;
    edtSenhaAtual: TEdit;
    btnFechar: TBitBtn;
    btnAlterar: TBitBtn;
    edtConfirmaSenha: TEdit;
    lblConfirmaSenha: TLabel;
    lblUsuarioLogado: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    procedure LimparEdits;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlterarSenha: TfrmAlterarSenha;

implementation

{$R *.dfm}

uses cCadUsuario, cUsuarioLogado, uPrincipal, uDTMConexao;

procedure TfrmAlterarSenha.btnAlterarClick(Sender: TObject);
var
  oUsuario: TUsuario;
begin
  if (edtSenhaAtual.Text = oUsuarioLogado.senha) then
  begin
    if (edtNovaSenha.Text = edtConfirmaSenha.Text) then
    begin
      try
        oUsuario := TUsuario.Create(DtmPrincipal.ConexaoDB);
        oUsuario.codigo := oUsuarioLogado.codigo;
        oUsuario.senha := edtNovaSenha.Text;
        oUsuario.AlterarSenha;
        oUsuarioLogado.senha := edtNovaSenha.Text;
        MessageDlg('Senha alterada com sucesso.', MtInformation, [mbok], 0);
        LimparEdits;
      finally
        FreeAndNil(oUsuario);
      end;
    end
    else
    begin
      MessageDlg('Senhas digitadas não são iguais', MtInformation, [mbok], 0);
      edtNovaSenha.SetFocus;
    end;
  end
  else
  begin
    MessageDlg('Senha atual inválida', MtInformation, [mbok], 0);
  end;
end;

procedure TfrmAlterarSenha.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAlterarSenha.FormShow(Sender: TObject);
begin
  LimparEdits;
end;

procedure TfrmAlterarSenha.LimparEdits;
begin
  edtSenhaAtual.Clear;
  edtNovaSenha.Clear;
  edtConfirmaSenha.Clear;
  lblUsuarioLogado.Caption := oUsuarioLogado.nome;
end;

end.
