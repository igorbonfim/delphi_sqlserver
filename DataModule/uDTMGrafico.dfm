object DTMGrafico: TDTMGrafico
  OldCreateOrder = False
  Height = 288
  Width = 515
  object QryProdutoEstoque: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT CONVERT(VARCHAR, produtoId) +'#39' - '#39'+ nome AS Label, Quanti' +
        'dade As Value FROM Produtos')
    Params = <>
    Left = 40
    Top = 8
    object QryProdutoEstoqueLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 93
    end
    object QryProdutoEstoqueValue: TFloatField
      FieldName = 'Value'
    end
  end
  object QryValorVendaPorCliente: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT CONVERT(VARCHAR, vendas.clienteID) + '#39' - '#39'+ clientes.Nome' +
        ' AS Label, SUM(vendas.totalVenda) AS Value'
      'FROM Vendas'
      'INNER JOIN clientes ON clientes.clienteId = vendas.clienteId'
      
        'WHERE Vendas.dataVenda BETWEEN CONVERT(DATE, GETDATE()-7) AND CO' +
        'NVERT(DATE, GETDATE())'
      'GROUP BY Vendas.clienteId, Clientes.nome')
    Params = <>
    Left = 296
    Top = 8
    object QryValorVendaPorClienteLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 93
    end
    object QryValorVendaPorClienteValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
  object Qry10ProdutosMaisVendidos: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      
        'SELECT TOP 10 CONVERT(VARCHAR, vi.produtoId) + '#39'-'#39' +p.nome AS La' +
        'bel, SUM(vi.totalProduto) AS Value'
      'FROM vendasItens AS vi'
      'INNER JOIN produtos AS P ON p.produtoId = vi.produtoId'
      'GROUP BY vi.produtoId, p.nome'
      'ORDER BY Label DESC')
    Params = <>
    Left = 160
    Top = 8
    object Qry10ProdutosMaisVendidosLabel: TWideStringField
      FieldName = 'Label'
      ReadOnly = True
      Size = 91
    end
    object Qry10ProdutosMaisVendidosValue: TFloatField
      FieldName = 'Value'
      ReadOnly = True
    end
  end
  object QryVendasUltimaSemana: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      
        'SELECT vendas.dataVenda AS Label, SUM(vendas.totalVenda) AS Valu' +
        'e'
      'FROM Vendas'
      
        'WHERE vendas.dataVenda BETWEEN CONVERT(DATE, GETDATE()-7) AND CO' +
        'NVERT(DATE, GETDATE())'
      'GROUP BY Vendas.dataVenda')
    Params = <>
    Left = 424
    Top = 8
  end
end
