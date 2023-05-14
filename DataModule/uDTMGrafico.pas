unit uDTMGrafico;

interface

uses
  System.SysUtils, System.Classes, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TDTMGrafico = class(TDataModule)
    QryProdutoEstoque: TZQuery;
    QryValorVendaPorCliente: TZQuery;
    Qry10ProdutosMaisVendidos: TZQuery;
    QryValorVendaPorClienteLabel: TWideStringField;
    QryValorVendaPorClienteValue: TFloatField;
    QryProdutoEstoqueLabel: TWideStringField;
    QryProdutoEstoqueValue: TFloatField;
    Qry10ProdutosMaisVendidosLabel: TWideStringField;
    Qry10ProdutosMaisVendidosValue: TFloatField;
    QryVendasUltimaSemana: TZQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DTMGrafico: TDTMGrafico;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDTMConexao;

{$R *.dfm}

end.
