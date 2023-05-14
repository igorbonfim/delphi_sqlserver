unit uRelCadProdutoPorCategoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uDTMConexao, RLReport, RLFilters, RLPDFFilter,
  RLXLSXFilter, RLXLSFilter;

type
  TfrmRelCadProdutoPorCategoria = class(TForm)
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
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    QryProdutoprodutoId: TIntegerField;
    QryProdutonome: TWideStringField;
    QryProdutovalor: TFloatField;
    QryProdutoquantidade: TFloatField;
    QryProdutoDescricao: TWideStringField;
    QryProdutoCategoriaId: TIntegerField;
    QryProdutoDescricaoCategoria: TWideStringField;
    BandaDoGrupo: TRLGroup;
    RLBand1: TRLBand;
    RLPanel1: TRLPanel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    Colunas: TRLBand;
    Detalhe: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLLabel8: TRLLabel;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel9: TRLLabel;
    RLBand2: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDraw3: TRLDraw;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLDBResult2: TRLDBResult;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCadProdutoPorCategoria: TfrmRelCadProdutoPorCategoria;

implementation

{$R *.dfm}

procedure TfrmRelCadProdutoPorCategoria.FormCreate(Sender: TObject);
begin
  QryProduto.Open;
end;

procedure TfrmRelCadProdutoPorCategoria.FormDestroy(Sender: TObject);
begin
  QryProduto.Destroy;
end;

end.
