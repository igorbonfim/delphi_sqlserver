unit uUsuariosVsAcoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TfrmUsuariosVsAcoes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    grdUsuarios: TDBGrid;
    grdAcoes: TDBGrid;
    QryUsuario: TZQuery;
    QryAcoes: TZQuery;
    dtsUsuario: TDataSource;
    dtsAcoes: TDataSource;
    QryUsuariousuarioID: TIntegerField;
    QryUsuarionome: TWideStringField;
    btnFechar: TBitBtn;
    QryAcoesusuarioId: TIntegerField;
    QryAcoesacaoAcessoId: TIntegerField;
    QryAcoesdescricao: TWideStringField;
    QryAcoesativo: TBooleanField;
    procedure QryUsuarioAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure grdAcoesDblClick(Sender: TObject);
    procedure grdAcoesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    procedure SelecionarAcoesAcessoPorUsuario;
  public
    { Public declarations }
  end;

var
  frmUsuariosVsAcoes: TfrmUsuariosVsAcoes;

implementation

{$R *.dfm}

uses uDTMConexao;

{ TfrmUsuariosVcAcoes }

procedure TfrmUsuariosVsAcoes.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUsuariosVsAcoes.grdAcoesDblClick(Sender: TObject);
var
  Qry: TZQuery;
  bmRegistroAtual: TBookMark;
begin
  Try
    bmRegistroAtual := QryAcoes.GetBookmark;
    Qry := TZQuery.Create(nil);
    Qry.Connection := DtmPrincipal.ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('UPDATE usuariosAcaoAcesso ' +
                'SET    ativo = :ativo '+
                'WHERE  usuarioId = :usuarioId '+
                'AND    acaoAcessoId = :acaoAcessoId');
    Qry.ParamByName('usuarioId').AsInteger := QryAcoes.FieldByName('usuarioId').AsInteger;
    Qry.ParamByName('acaoAcessoId').AsInteger := QryAcoes.FieldByName('acaoAcessoId').AsInteger;
    Qry.ParamByName('ativo').AsBoolean := not QryAcoes.FieldByName('ativo').AsBoolean;

    Try
      DtmPrincipal.ConexaoDB.StartTransaction;
      Qry.ExecSQL;
      DtmPrincipal.ConexaoDB.Commit;
    Except
      DtmPrincipal.ConexaoDB.Rollback;
    End;
  Finally
    SelecionarAcoesAcessoPorUsuario;
    QryAcoes.GotoBookmark(bmRegistroAtual);
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

procedure TfrmUsuariosVsAcoes.grdAcoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not QryAcoes.FieldByName('ativo').AsBoolean then
  begin
    TDBGrid(Sender).Canvas.Font.Color := clWhite;
    TDBGrid(Sender).Canvas.Brush.Color := clRed;
  end;
  TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).Columns[Datacol].Field, State);
end;

procedure TfrmUsuariosVsAcoes.FormShow(Sender: TObject);
begin
  Try
    QryUsuario.DisableControls;
    QryUsuario.Open;
    SelecionarAcoesAcessoPorUsuario;
  Finally
    QryUsuario.EnableControls;
  End;
end;

procedure TfrmUsuariosVsAcoes.QryUsuarioAfterScroll(DataSet: TDataSet);
begin
  SelecionarAcoesAcessoPorUsuario;
end;

procedure TfrmUsuariosVsAcoes.SelecionarAcoesAcessoPorUsuario;
begin
  QryAcoes.Close;
  QryAcoes.ParamByName('usuarioId').AsInteger := QryUsuario.FieldByName('usuarioId').AsInteger;
  QryAcoes.Open;
end;

end.
