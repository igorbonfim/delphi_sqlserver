object frmRelCadProdutoPorCategoria: TfrmRelCadProdutoPorCategoria
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
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Relatorio: TRLReport
    Left = -5
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dtsProduto
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
        Width = 372
        Height = 24
        Caption = 'Listagem de Produtos por Categoria'
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
      Top = 209
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
    object BandaDoGrupo: TRLGroup
      Left = 38
      Top = 89
      Width = 718
      Height = 120
      DataFields = 'CategoriaId'
      Transparent = False
      object RLBand1: TRLBand
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
          Width = 70
          Height = 16
          Caption = 'Categoria:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText5: TRLDBText
          Left = 112
          Top = 0
          Width = 117
          Height = 16
          DataField = 'DescricaoCategoria'
          DataSource = dtsProduto
          Text = ''
          Transparent = False
        end
        object RLDBText6: TRLDBText
          Left = 76
          Top = 0
          Width = 19
          Height = 16
          DataField = 'CategoriaId'
          DataSource = dtsProduto
          Text = ''
          Transparent = False
        end
        object RLLabel9: TRLLabel
          Left = 99
          Top = 0
          Width = 7
          Height = 16
          Alignment = taRightJustify
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
      object Colunas: TRLBand
        Left = 0
        Top = 18
        Width = 718
        Height = 18
        BandType = btColumnHeader
        Transparent = False
        object RLPanel1: TRLPanel
          Left = 0
          Top = 0
          Width = 718
          Height = 18
          Align = faClient
          Color = clInfoBk
          ParentColor = False
          Transparent = False
          object RLLabel4: TRLLabel
            Left = 3
            Top = 2
            Width = 49
            Height = 16
            Caption = 'C'#243'digo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel5: TRLLabel
            Left = 76
            Top = 2
            Width = 41
            Height = 16
            Caption = 'Nome'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel6: TRLLabel
            Left = 491
            Top = 2
            Width = 78
            Height = 16
            Caption = 'Quantidade'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
          object RLLabel7: TRLLabel
            Left = 677
            Top = 2
            Width = 38
            Height = 16
            Alignment = taRightJustify
            Caption = 'Valor'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = False
          end
        end
      end
      object Detalhe: TRLBand
        Left = 0
        Top = 36
        Width = 718
        Height = 24
        Transparent = False
        object RLDBText1: TRLDBText
          Left = 3
          Top = 1
          Width = 57
          Height = 16
          DataField = 'produtoId'
          DataSource = dtsProduto
          Text = ''
          Transparent = False
        end
        object RLDBText2: TRLDBText
          Left = 76
          Top = 1
          Width = 36
          Height = 16
          DataField = 'nome'
          DataSource = dtsProduto
          Text = ''
          Transparent = False
        end
        object RLDBText3: TRLDBText
          Left = 502
          Top = 1
          Width = 67
          Height = 16
          Alignment = taRightJustify
          DataField = 'quantidade'
          DataSource = dtsProduto
          Text = ''
          Transparent = False
        end
        object RLDBText4: TRLDBText
          Left = 683
          Top = 1
          Width = 30
          Height = 16
          Alignment = taRightJustify
          DataField = 'valor'
          DataSource = dtsProduto
          Text = ''
          Transparent = False
        end
      end
      object RLBand2: TRLBand
        Left = 0
        Top = 60
        Width = 718
        Height = 53
        BandType = btSummary
        object RLDBResult1: TRLDBResult
          Left = 609
          Top = 7
          Width = 106
          Height = 16
          Alignment = taRightJustify
          DataField = 'quantidade'
          DataSource = dtsProduto
          Info = riSum
          Text = ''
        end
        object RLDraw3: TRLDraw
          Left = 322
          Top = -2
          Width = 396
          Height = 12
          DrawKind = dkLine
          Transparent = False
        end
        object RLLabel10: TRLLabel
          Left = 322
          Top = 7
          Width = 247
          Height = 16
          Caption = 'Quantidade no Estoque por Categoria:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel11: TRLLabel
          Left = 373
          Top = 29
          Width = 196
          Height = 16
          Caption = 'M'#233'dia de Valor por Categoria:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBResult2: TRLDBResult
          Left = 627
          Top = 29
          Width = 88
          Height = 16
          Alignment = taRightJustify
          DataField = 'valor'
          DataSource = dtsProduto
          Info = riAverage
          Text = ''
        end
      end
    end
  end
  object QryProduto: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    Active = True
    SQL.Strings = (
      'SELECT produtos.produtoId,'
      '             produtos.Nome,'
      '             produtos.Descricao,'
      '             produtos.Valor,'
      '             produtos.Quantidade,'
      '             produtos.CategoriaId,'
      '             categorias.descricao AS DescricaoCategoria'
      'FROM   produtos'
      'LEFT JOIN categorias '
      '       ON categorias.CategoriaId = produtos.CategoriaId'
      'ORDER BY  produtos.CategoriaId, produtos.produtoId')
    Params = <>
    Left = 136
    Top = 8
    object QryProdutoprodutoId: TIntegerField
      FieldName = 'produtoId'
      ReadOnly = True
    end
    object QryProdutonome: TWideStringField
      FieldName = 'nome'
      Size = 60
    end
    object QryProdutovalor: TFloatField
      FieldName = 'valor'
      DisplayFormat = '#0.00'
    end
    object QryProdutoquantidade: TFloatField
      FieldName = 'quantidade'
    end
    object QryProdutoDescricao: TWideStringField
      FieldName = 'Descricao'
      Size = 255
    end
    object QryProdutoCategoriaId: TIntegerField
      FieldName = 'CategoriaId'
    end
    object QryProdutoDescricaoCategoria: TWideStringField
      FieldName = 'DescricaoCategoria'
      Size = 30
    end
  end
  object dtsProduto: TDataSource
    DataSet = QryProduto
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
end
