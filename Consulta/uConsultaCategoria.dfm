inherited frmConsultaCategoria: TfrmConsultaCategoria
  Caption = 'Consulta de Categorias'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    ExplicitWidth = 755
    inherited mskPesquisa: TMaskEdit
      ExplicitLeft = 1
      ExplicitTop = 27
      ExplicitWidth = 753
    end
  end
  inherited Panel2: TPanel
    ExplicitLeft = 0
    ExplicitTop = 49
    ExplicitWidth = 755
  end
  inherited Panel3: TPanel
    ExplicitLeft = 0
    ExplicitTop = 406
    ExplicitWidth = 755
    inherited btnFechar: TBitBtn
      ExplicitLeft = 672
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select categoriaId, descricao from categorias')
    Left = 612
    object QryListagemcategoriaId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'categoriaId'
      ReadOnly = True
    end
    object QryListagemdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 30
    end
  end
  inherited dtsListagem: TDataSource
    Left = 676
  end
end
