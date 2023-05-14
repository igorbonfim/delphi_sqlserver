inherited frmCadUsuario: TfrmCadUsuario
  Caption = 'Cadastro de Usu'#225'rio'
  ClientHeight = 255
  ClientWidth = 713
  ExplicitWidth = 719
  ExplicitHeight = 284
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 713
    Height = 207
    ActivePage = tabManutencao
    ExplicitWidth = 713
    ExplicitHeight = 207
    inherited tabListagem: TTabSheet
      ExplicitWidth = 705
      ExplicitHeight = 179
      inherited pnlListagemTopo: TPanel
        Width = 705
        ExplicitWidth = 705
      end
      inherited grdListagem: TDBGrid
        Width = 705
        Height = 122
        Columns = <
          item
            Expanded = False
            FieldName = 'usuarioID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 596
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 705
      ExplicitHeight = 179
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 78
        Width = 246
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 30
        TabOrder = 1
      end
      object edtCodigo: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 35
        Width = 69
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtSenha: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 120
        Width = 121
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'Senha'
        MaxLength = 30
        PasswordChar = '*'
        TabOrder = 2
      end
    end
  end
  inherited pnlRodape: TPanel
    Top = 207
    Width = 713
    ExplicitTop = 207
    ExplicitWidth = 713
    inherited btnFechar: TBitBtn
      Left = 634
      ExplicitLeft = 634
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT usuarioID, nome, senha FROM usuarios')
    Left = 556
    Top = 32
    object QryListagemusuarioID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'usuarioID'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Required = True
      Size = 50
    end
    object QryListagemsenha: TWideStringField
      DisplayLabel = 'Senha'
      FieldName = 'senha'
      Required = True
      Size = 40
    end
  end
  inherited dtsListagem: TDataSource
    Left = 644
    Top = 32
  end
end
