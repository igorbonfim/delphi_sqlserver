object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Vendas'
  ClientHeight = 653
  ClientWidth = 1128
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mainPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StbPrincipal: TStatusBar
    Left = 0
    Top = 634
    Width = 1128
    Height = 19
    Panels = <
      item
        Width = 150
      end>
  end
  object pnlDashboard: TPanel
    Left = 0
    Top = 0
    Width = 1128
    Height = 41
    Align = alTop
    TabOrder = 1
    OnClick = pnlDashboardClick
    object Label1: TLabel
      Left = 6
      Top = 9
      Width = 102
      Height = 23
      Caption = 'Dashboard'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object GridPanel1: TGridPanel
    Left = 0
    Top = 41
    Width = 1128
    Height = 593
    Align = alClient
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = pnlProdutoEmEstoque
        Row = 0
      end
      item
        Column = 1
        Control = pnlValorVendaPorClienteUltimaSemana
        Row = 0
      end
      item
        Column = 0
        Control = pnlVendasUltimaSemana
        Row = 1
      end
      item
        Column = 1
        Control = pnl10ProdutosMaisVendidos
        Row = 1
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    TabOrder = 2
    object pnlProdutoEmEstoque: TPanel
      Left = 1
      Top = 1
      Width = 563
      Height = 296
      Align = alClient
      TabOrder = 0
      object DBChart4: TDBChart
        Left = 1
        Top = 1
        Width = 561
        Height = 294
        Title.Text.Strings = (
          'Produto em Estoque')
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series1: TBarSeries
          Marks.Brush.Gradient.Colors = <
            item
              Color = clRed
            end
            item
              Color = 819443
              Offset = 0.067915690866510540
            end
            item
              Color = clYellow
              Offset = 1.000000000000000000
            end>
          Marks.Brush.Gradient.Direction = gdTopBottom
          Marks.Brush.Gradient.EndColor = clYellow
          Marks.Brush.Gradient.MidColor = 819443
          Marks.Brush.Gradient.StartColor = clRed
          Marks.Brush.Gradient.Visible = True
          Marks.Font.Color = 159
          Marks.Font.Name = 'Tahoma'
          Marks.Font.Style = [fsBold, fsItalic]
          Marks.Frame.Color = 33023
          Marks.RoundSize = 14
          Marks.Visible = False
          DataSource = DTMGrafico.QryProdutoEstoque
          Title = 'ProdutoEstoque'
          XLabelsSource = 'Label'
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Bar'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
        end
      end
    end
    object pnlValorVendaPorClienteUltimaSemana: TPanel
      Left = 564
      Top = 1
      Width = 563
      Height = 296
      Align = alClient
      Caption = 'pnlValorVendaPorClienteUltimaSemana'
      TabOrder = 1
      object DBChart2: TDBChart
        Left = 1
        Top = 1
        Width = 561
        Height = 294
        Title.Text.Strings = (
          'Valor de Venda por Cliente na Ultima Semana')
        Legend.TextStyle = ltsLeftPercent
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object Series2: TPieSeries
          Marks.Brush.Gradient.Colors = <
            item
              Color = clRed
            end
            item
              Color = 819443
              Offset = 0.067915690866510540
            end
            item
              Color = clYellow
              Offset = 1.000000000000000000
            end>
          Marks.Brush.Gradient.Direction = gdTopBottom
          Marks.Brush.Gradient.EndColor = clYellow
          Marks.Brush.Gradient.MidColor = 819443
          Marks.Brush.Gradient.StartColor = clRed
          Marks.Brush.Gradient.Visible = True
          Marks.Font.Color = 159
          Marks.Font.Name = 'Tahoma'
          Marks.Font.Style = [fsBold, fsItalic]
          Marks.Frame.Color = 33023
          Marks.RoundSize = 14
          Marks.Visible = False
          Marks.Style = smsPercentTotal
          Marks.Callout.Length = 20
          DataSource = DTMGrafico.QryValorVendaPorCliente
          Title = 'ValorDeVendaPorClienteNaUltimaSemana'
          XLabelsSource = 'Label'
          XValues.Order = loAscending
          YValues.Name = 'Pie'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Width = 4
          OtherSlice.Legend.TextStyle = ltsPercent
          OtherSlice.Legend.Visible = False
        end
      end
    end
    object pnlVendasUltimaSemana: TPanel
      Left = 1
      Top = 297
      Width = 563
      Height = 295
      Align = alClient
      Caption = 'pnlVendasUltimaSemana'
      TabOrder = 2
      object DBChart1: TDBChart
        Left = 1
        Top = 1
        Width = 561
        Height = 293
        Title.Text.Strings = (
          'Vendas da '#218'ltima Semana')
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object FastLineSeries1: TFastLineSeries
          DataSource = DTMGrafico.QryVendasUltimaSemana
          Title = 'VendasDaUltimaSemana'
          XLabelsSource = 'Label'
          LinePen.Color = 10708548
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
        end
      end
    end
    object pnl10ProdutosMaisVendidos: TPanel
      Left = 564
      Top = 297
      Width = 563
      Height = 295
      Align = alClient
      Caption = 'pnl10ProdutosMaisVendidos'
      TabOrder = 3
      object DBChart3: TDBChart
        Left = 1
        Top = 1
        Width = 561
        Height = 293
        Title.Text.Strings = (
          'Os 10 Produtos Mais Vendidos')
        Legend.TextStyle = ltsLeftPercent
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
        object PieSeries1: TPieSeries
          Marks.Brush.Gradient.Colors = <
            item
              Color = clRed
            end
            item
              Color = 819443
              Offset = 0.067915690866510540
            end
            item
              Color = clYellow
              Offset = 1.000000000000000000
            end>
          Marks.Brush.Gradient.Direction = gdTopBottom
          Marks.Brush.Gradient.EndColor = clYellow
          Marks.Brush.Gradient.MidColor = 819443
          Marks.Brush.Gradient.StartColor = clRed
          Marks.Brush.Gradient.Visible = True
          Marks.Font.Color = 159
          Marks.Font.Name = 'Tahoma'
          Marks.Font.Style = [fsBold, fsItalic]
          Marks.Frame.Color = 33023
          Marks.RoundSize = 14
          Marks.Visible = False
          Marks.Style = smsPercentTotal
          Marks.Callout.Length = 20
          DataSource = DTMGrafico.Qry10ProdutosMaisVendidos
          Title = '10ProdutosMaisVendidos'
          XLabelsSource = 'Label'
          XValues.Order = loAscending
          YValues.Name = 'Pie'
          YValues.Order = loNone
          YValues.ValueSource = 'Value'
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Width = 4
          OtherSlice.Legend.TextStyle = ltsPercent
          OtherSlice.Legend.Visible = False
        end
      end
    end
  end
  object mainPrincipal: TMainMenu
    Left = 1056
    Top = 8
    object CADA1: TMenuItem
      Caption = 'CADASTRO'
      object CLIENTE1: TMenuItem
        Caption = 'CLIENTE'
        ShortCut = 16451
        OnClick = CLIENTE1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object CATEGORIA1: TMenuItem
        Caption = 'CATEGORIA'
        OnClick = CATEGORIA1Click
      end
      object PRODUTO1: TMenuItem
        Caption = 'PRODUTO'
        ShortCut = 16464
        OnClick = PRODUTO1Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object USUARIO1: TMenuItem
        Caption = 'USUARIO'
        OnClick = USUARIO1Click
      end
      object AOACESSO1: TMenuItem
        Caption = 'A'#199#195'O ACESSO'
        OnClick = AOACESSO1Click
      end
      object USUARIOSVSAES1: TMenuItem
        Caption = 'USUARIOS VS A'#199#213'ES'
        OnClick = USUARIOSVSAES1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object ALTERARSENHA1: TMenuItem
        Caption = 'ALTERAR SENHA'
        OnClick = ALTERARSENHA1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mnuFechar: TMenuItem
        Caption = 'FECHAR'
        OnClick = mnuFecharClick
      end
    end
    object MOVIMENTAO1: TMenuItem
      Caption = 'MOVIMENTA'#199#195'O'
      object VENDAS1: TMenuItem
        Caption = 'VENDAS'
        ShortCut = 120
        OnClick = VENDAS1Click
      end
    end
    object RELATRIOS1: TMenuItem
      Caption = 'RELAT'#211'RIOS'
      object Categoria2: TMenuItem
        Caption = 'CATEGORIA'
        OnClick = Categoria2Click
      end
      object CLIENTE2: TMenuItem
        Caption = 'CLIENTE'
        OnClick = CLIENTE2Click
      end
      object FICHADECLIENTE1: TMenuItem
        Caption = 'FICHA DE CLIENTE'
        OnClick = FICHADECLIENTE1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object PRODUTO2: TMenuItem
        Caption = 'PRODUTO'
        OnClick = PRODUTO2Click
      end
      object PRODUTOPORCATEGORIA1: TMenuItem
        Caption = 'PRODUTO POR CATEGORIA'
        OnClick = PRODUTOPORCATEGORIA1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object VENDAPORDATA1: TMenuItem
        Caption = 'VENDA POR DATA'
        OnClick = VENDAPORDATA1Click
      end
    end
  end
  object tmrAtualizacaoDashboard: TTimer
    Interval = 60000
    OnTimer = tmrAtualizacaoDashboardTimer
    Left = 872
  end
end
