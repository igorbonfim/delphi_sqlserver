unit uRelCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uDTMConexao, RLReport, RLFilters, RLPDFFilter,
  RLXLSXFilter, RLXLSFilter;

type
  TfrmRelCadProduto = class(TForm)
    QryProduto: TZQuery;
    dtsProduto: TDataSource;
    Relatorio: TRLReport;
    Cabecalho: TRLBand;
    RLLabel1: TRLLabel;
    RLDraw1: TRLDraw;
    RLPDFFilter1: TRLPDFFilter;
    Rodape: TRLBand;
    RLDraw2: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    Detalhe: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    Colunas: TRLBand;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLPanel1: TRLPanel;
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    QryProdutoprodutoId: TIntegerField;
    QryProdutonome: TWideStringField;
    QryProdutovalor: TFloatField;
    QryProdutoquantidade: TFloatField;
    RLLabel6: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText4: TRLDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadProduto: TfrmRelCadProduto;

implementation

{$R *.dfm}

procedure TfrmRelCadProduto.FormCreate(Sender: TObject);
begin
  QryProduto.Open;
end;

procedure TfrmRelCadProduto.FormDestroy(Sender: TObject);
begin
  QryProduto.Destroy;
end;

end.
