object frmRelProVenda: TfrmRelProVenda
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio de Produto por Categoria'
  ClientHeight = 585
  ClientWidth = 797
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = -5
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dtsVenda
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Transparent = False
    object Cabecalho: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 51
      BandType = btHeader
      Transparent = False
      object RLLabel1: TRLLabel
        Left = 6
        Top = 16
        Width = 81
        Height = 24
        Caption = 'Vendas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
      object RLDraw1: TRLDraw
        Left = 0
        Top = 40
        Width = 718
        Height = 12
        DrawKind = dkLine
        Pen.Width = 2
        Transparent = False
      end
    end
    object Rodape: TRLBand
      Left = 38
      Top = 241
      Width = 718
      Height = 40
      BandType = btFooter
      Transparent = False
      object RLDraw2: TRLDraw
        Left = 0
        Top = 0
        Width = 718
        Height = 12
        Align = faTop
        DrawKind = dkLine
        Pen.Width = 2
        Transparent = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 6
        Top = 18
        Width = 60
        Height = 16
        Info = itFullDate
        Text = ''
        Transparent = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 642
        Top = 18
        Width = 27
        Height = 16
        Alignment = taRightJustify
        Info = itPageNumber
        Text = ''
        Transparent = False
      end
      object RLSystemInfo3: TRLSystemInfo
        Left = 691
        Top = 18
        Width = 22
        Height = 16
        Info = itLastPageNumber
        Text = ''
        Transparent = False
      end
      object RLLabel2: TRLLabel
        Left = 675
        Top = 18
        Width = 11
        Height = 16
        Caption = '/'
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 578
        Top = 18
        Width = 49
        Height = 16
        Caption = 'P'#225'gina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object BandaTotalizador: TRLBand
      Left = 38
      Top = 209
      Width = 718
      Height = 32
      BandType = btSummary
      Transparent = False
      object RLDBResult2: TRLDBResult
        Left = 607
        Top = 15
        Width = 108
        Height = 16
        Alignment = taRightJustify
        DataField = 'TotalVenda'
        DataSource = dtsVenda
        Info = riSum
        Text = ''
        Transparent = False
      end
      object RLDraw4: TRLDraw
        Left = 322
        Top = 6
        Width = 396
        Height = 12
        DrawKind = dkLine
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 510
        Top = 15
        Width = 125
        Height = 16
        Caption = 'Total da Venda: R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
      end
    end
    object BandaDoGrupo: TRLGroup
      Left = 38
      Top = 89
      Width = 718
      Height = 120
      DataFields = 'vendaId'
      Transparent = False
      object BandaCodigoVenda: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 18
        BandType = btHeader
        Color = clSilver
        ParentColor = False
        Transparent = False
        object RLLabel8: TRLLabel
          Left = 3
          Top = 0
          Width = 49
          Height = 16
          Caption = 'Venda:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText6: TRLDBText
          Left = 56
          Top = 0
          Width = 47
          Height = 16
          DataField = 'vendaId'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
      end
      object Detalhe: TRLBand
        Left = 0
        Top = 18
        Width = 718
        Height = 20
        Transparent = False
        object RLDBText1: TRLDBText
          Left = 56
          Top = 4
          Width = 20
          Height = 16
          DataField = 'clienteId'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLDBText2: TRLDBText
          Left = 93
          Top = 4
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLDBText4: TRLDBText
          Left = 647
          Top = 4
          Width = 66
          Height = 16
          Alignment = taRightJustify
          DataField = 'dataVenda'
          DataSource = dtsVenda
          Text = ''
          Transparent = False
        end
        object RLLabel5: TRLLabel
          Left = 3
          Top = 4
          Width = 53
          Height = 16
          Caption = 'C'#243'digo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel9: TRLLabel
          Left = 78
          Top = 4
          Width = 11
          Height = 14
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel11: TRLLabel
          Left = 602
          Top = 4
          Width = 37
          Height = 16
          Alignment = taRightJustify
          Caption = 'Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object Subdetalhe: TRLSubDetail
        Left = 0
        Top = 38
        Width = 718
        Height = 64
        DataSource = dtsVendaItens
        Transparent = False
        object RLBand2: TRLBand
          Left = 0
          Top = 0
          Width = 718
          Height = 20
          BandType = btHeader
          Color = clInfoBk
          ParentColor = False
          Transparent = False
          object RLLabel7: TRLLabel
            Left = 11
            Top = 4
            Width = 64
            Height = 16
            Caption = 'Produtos:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel10: TRLLabel
            Left = 304
            Top = 4
            Width = 78
            Height = 16
            Alignment = taRightJustify
            Caption = 'Quantidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel12: TRLLabel
            Left = 434
            Top = 5
            Width = 92
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor Unit'#225'rio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel13: TRLLabel
            Left = 641
            Top = 4
            Width = 74
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor Total'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
        object RLBand4: TRLBand
          Left = 0
          Top = 20
          Width = 718
          Height = 20
          Transparent = False
          object RLLabel4: TRLLabel
            Left = 42
            Top = 2
            Width = 11
            Height = 14
            Caption = '-'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLDBText3: TRLDBText
            Left = 59
            Top = 3
            Width = 36
            Height = 16
            DataField = 'nome'
            DataSource = dtsVendaItens
            Text = ''
            Transparent = False
          end
          object RLDBText5: TRLDBText
            Left = 22
            Top = 3
            Width = 31
            Height = 16
            DataField = 'produtoId'
            DataSource = dtsVendaItens
            Text = ''
            Transparent = False
          end
          object RLDBText7: TRLDBText
            Left = 315
            Top = 3
            Width = 67
            Height = 16
            Alignment = taRightJustify
            DataField = 'quantidade'
            DataSource = dtsVendaItens
            Text = ''
            Transparent = False
          end
          object RLDBText8: TRLDBText
            Left = 452
            Top = 3
            Width = 74
            Height = 16
            Alignment = taRightJustify
            DataField = 'valorUnitario'
            DataSource = dtsVendaItens
            Text = ''
            Transparent = False
          end
          object RLDBText9: TRLDBText
            Left = 641
            Top = 3
            Width = 74
            Height = 16
            Alignment = taRightJustify
            DataField = 'totalProduto'
            DataSource = dtsVendaItens
            Text = ''
            Transparent = False
          end
        end
      end
    end
  end
  object QryVenda: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT vendas.vendaId,'
      '       vendas.clienteId,'
      '       clientes.nome,'
      '       vendas.dataVenda,'
      '       vendas.totalVenda'
      'FROM   vendas'
      'INNER JOIN clientes ON clientes.clienteId = vendas.clienteId'
      'WHERE vendas.vendaId = :vendaId')
    Params = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 2
      end>
    Left = 136
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 2
      end>
    object QryVendavendaId: TIntegerField
      FieldName = 'vendaId'
      ReadOnly = True
    end
    object QryVendaclienteId: TIntegerField
      FieldName = 'clienteId'
      Required = True
    end
    object QryVendanome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryVendadataVenda: TDateTimeField
      FieldName = 'dataVenda'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object QryVendaTotalVenda: TFloatField
      FieldName = 'TotalVenda'
      Required = True
      DisplayFormat = '#0.00'
    end
  end
  object dtsVenda: TDataSource
    DataSet = QryVenda
    Left = 208
    Top = 8
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 280
    Top = 8
  end
  object RLXLSFilter1: TRLXLSFilter
    DisplayName = 'Planilha Excel 97-2013'
    Left = 347
    Top = 8
  end
  object RLXLSXFilter1: TRLXLSXFilter
    DisplayName = 'Planilha Excel'
    Left = 411
    Top = 8
  end
  object QryVendaItens: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT vendasItens.vendaId,'
      '       vendasItens.produtoId,'
      '       produtos.nome,'
      '       vendasItens.quantidade,'
      '       vendasItens.valorUnitario,'
      #9'   vendasItens.totalProduto'
      'FROM   vendasItens'
      
        'INNER JOIN produtos ON produtos.produtoId = vendasItens.produtoI' +
        'd'
      'WHERE vendasItens.vendaId = :vendaId'
      'ORDER BY vendasItens.produtoId')
    Params = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 2
      end>
    Left = 488
    Top = 8
    ParamData = <
      item
        DataType = ftInteger
        Name = 'vendaId'
        ParamType = ptInput
        Value = 2
      end>
    object QryVendaItensvendaId: TIntegerField
      FieldName = 'vendaId'
      Required = True
      DisplayFormat = '#0.00'
    end
    object QryVendaItensprodutoId: TIntegerField
      FieldName = 'produtoId'
      Required = True
    end
    object QryVendaItensnome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryVendaItensquantidade: TFloatField
      FieldName = 'quantidade'
      Required = True
    end
    object QryVendaItensvalorUnitario: TFloatField
      FieldName = 'valorUnitario'
      Required = True
      DisplayFormat = '#0.00'
    end
    object QryVendaItenstotalProduto: TFloatField
      FieldName = 'totalProduto'
      Required = True
      DisplayFormat = '#0.00'
    end
  end
  object dtsVendaItens: TDataSource
    DataSet = QryVendaItens
    Left = 560
    Top = 8
  end
end
