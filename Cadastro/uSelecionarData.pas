unit uSelecionarData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  RxToolEdit, System.DateUtils;

type
  TfrmSelecionarData = class(TForm)
    edtDataInicio: TDateEdit;
    Label3: TLabel;
    Label1: TLabel;
    edtDataFinal: TDateEdit;
    btnOk: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    F_dataInicio, F_dataFinal: TDateTime;
    function ValidacaoData: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelecionarData: TfrmSelecionarData;

implementation

{$R *.dfm}

uses uRelVendaPorData;

function TfrmSelecionarData.ValidacaoData: Boolean;
begin
  if ((EdtDataFinal.Date) < (EdtDataInicio.Date)) AND (EdtDataFinal.Date > 0) then
  begin
    MessageDlg('Data Inicial não pode ser maior que data Final', mtInformation, [mbOk], 0);
    EdtDataFinal.SetFocus;
    Result := False;
    abort;
  end;

  if (EdtDataFinal.Date = 0) OR (EdtDataInicio.Date = 0) then
  begin
    MessageDlg('Data Inicial ou Final são campos obrigatórios', mtInformation, [mbOK], 0);
    EdtDataInicio.SetFocus;
    Result := False;
    abort;
  end;

  Result := True;
end;

procedure TfrmSelecionarData.btnOkClick(Sender: TObject);
begin
  ValidacaoData;
  frmRelProVendaPorData := TfrmRelProVendaPorData.Create(Self);
  frmRelProVendaPorData.QryVenda.Close;
  frmRelProVendaPorData.QryVenda.ParamByName('DataInicio').AsDate := EdtDataInicio.Date;
  frmRelProVendaPorData.QryVenda.ParamByName('DataFim').AsDate := EdtDataFinal.Date;
  frmRelProVendaPorData.QryVenda.Open;
  frmRelProVendaPorData.Relatorio.PreviewModal;
end;

procedure TfrmSelecionarData.FormShow(Sender: TObject);
begin
  EdtDataInicio.Date := StartOfTheMonth(Date);
  EdtDataFinal.Date  := EndOfTheMonth(Date);
end;

end.
