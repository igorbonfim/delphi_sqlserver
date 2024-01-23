inherited frmCadProduto: TfrmCadProduto
  Caption = 'Cadastro de Produto'
  ExplicitWidth = 779
  ExplicitHeight = 530
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    ActivePage = tabManutencao
    inherited tabListagem: TTabSheet
      inherited grdListagem: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'produtoId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 337
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valor'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DescricaoCategoria'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      OnContextPopup = tabManutencaoContextPopup
      object Label1: TLabel
        Left = 11
        Top = 108
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object Label2: TLabel
        Left = 11
        Top = 229
        Width = 24
        Height = 13
        Caption = 'Valor'
      end
      object Label3: TLabel
        Left = 162
        Top = 229
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label4: TLabel
        Left = 288
        Top = 62
        Width = 47
        Height = 13
        Caption = 'Categoria'
      end
      object edtProdutoId: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 35
        Width = 121
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
        Text = ''
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 78
        Width = 272
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
        Text = ''
      end
      object edtDescricao: TMemo
        Left = 11
        Top = 128
        Width = 734
        Height = 89
        MaxLength = 255
        TabOrder = 2
      end
      object edtValor: TCurrencyEdit
        Left = 11
        Top = 248
        Width = 121
        Height = 21
        TabOrder = 3
      end
      object edtQuantidade: TCurrencyEdit
        Left = 162
        Top = 248
        Width = 121
        Height = 21
        DisplayFormat = ' 0.00'
        TabOrder = 4
      end
      object pnlImagemProduto: TPanel
        Left = 635
        Top = 0
        Width = 110
        Height = 99
        BorderStyle = bsSingle
        TabOrder = 5
        object imgImagemProduto: TImage
          Left = 1
          Top = 1
          Width = 104
          Height = 93
          Align = alClient
          AutoSize = True
          Center = True
          PopupMenu = popMenuImagem
          Stretch = True
          ExplicitLeft = 64
          ExplicitTop = 40
          ExplicitWidth = 105
          ExplicitHeight = 105
        end
      end
      object edtSearchCategoriaId: TEditClickKey
        Left = 285
        Top = 78
        Width = 64
        Height = 21
        NumbersOnly = True
        TabOrder = 6
        OnExit = edtSearchCategoriaIdExit
        BitBtnClickKey = SearchMore1
      end
      object SearchMore1: TSearchMore
        Left = 349
        Top = 76
        Width = 25
        Height = 25
        Caption = '...'
        TabOrder = 7
        PesquisaCaption = 'Consulta'
        PesquisaWidth = 640
        PesquisaHeight = 480
        PesquisaTextHintMaskEdit = 'Digite a pesquisa'
        PesquisaCaptionMaskEdit = 'Pesquisar por ...'
        PesquisaCaptionBotaoIncluir = '&Incluir'
        DataSource = dtsCategoria
        PesquisaIndexConsulta = 'categoriaId'
        PesquisaControlBookMark = False
        PesquisaResultFieldKey = 'categoriaId'
        PesquisaResultDescription = 'descricao'
        PesquisaResultEditFieldKey = edtSearchCategoriaId
        PesquisaResultEditFieldDescription = edtSearchCategoriaDescricao
      end
      object edtSearchCategoriaDescricao: TEdit
        Left = 374
        Top = 78
        Width = 258
        Height = 21
        Enabled = False
        TabOrder = 8
        Text = 'SearchMore1'
      end
    end
  end
  inherited pnlRodape: TPanel
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT p.produtoId,'
      #9'   p.nome,'
      #9'   p.descricao,'
      #9'   p.valor,'
      #9'   p.quantidade,'
      #9'   p.categoriaId,'
      #9'   c.descricao As DescricaoCategoria'
      '  FROM produtos as p'
      '  LEFT JOIN Categorias as c on c.categoriaId = p.categoriaId')
    Left = 375
    object QryListagemprodutoId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoId'
      Origin = 'p'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Origin = 'p'
      Size = 60
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Origin = 'p'
      Size = 255
    end
    object QryListagemvalor: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      Origin = 'p'
    end
    object QryListagemquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
      Origin = 'p'
    end
    object QryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo da Categoria'
      FieldName = 'categoriaId'
      Origin = 'p'
    end
    object QryListagemDescricaoCategoria: TWideStringField
      DisplayLabel = 'Descri'#231#227'o da Categoria'
      FieldName = 'DescricaoCategoria'
      Origin = 'c.descricao'
      Size = 30
    end
  end
  inherited dtsListagem: TDataSource
    Left = 439
  end
  object QryCategoria: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT categoriaId, descricao FROM Categorias')
    Params = <>
    Left = 380
    Top = 96
    object QryCategoriacategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object QryCategoriadescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  object dtsCategoria: TDataSource
    DataSet = QryCategoria
    Left = 436
    Top = 96
  end
  object popMenuImagem: TPopupMenu
    Left = 663
    Top = 32
    object CarregarImagem1: TMenuItem
      Caption = 'Carregar Imagem'
      OnClick = CarregarImagem1Click
    end
    object LimparImagem1: TMenuItem
      Caption = 'Limpar Imagem'
      OnClick = LimparImagem1Click
    end
  end
end
