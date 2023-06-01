inherited frmCadCliente: TfrmCadCliente
  Caption = 'Cadastro de Cliente'
  ClientWidth = 792
  ExplicitWidth = 798
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgcPrincipal: TPageControl
    Width = 792
    ActivePage = tabManutencao
    ExplicitWidth = 792
    inherited tabListagem: TTabSheet
      ExplicitWidth = 784
      inherited pnlListagemTopo: TPanel
        Width = 784
        ExplicitWidth = 784
      end
      inherited grdListagem: TDBGrid
        Width = 784
        Columns = <
          item
            Expanded = False
            FieldName = 'clienteId'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cep'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'endereco'
            Visible = True
          end>
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitWidth = 784
      object Label1: TLabel
        Left = 11
        Top = 104
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object Label2: TLabel
        Left = 139
        Top = 261
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object Label3: TLabel
        Left = 11
        Top = 261
        Width = 96
        Height = 13
        Caption = 'Data de Nascimento'
      end
      object Label4: TLabel
        Left = 504
        Top = 205
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object edtClienteId: TLabeledEdit
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
      end
      object edtNome: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 77
        Width = 382
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        MaxLength = 60
        TabOrder = 1
      end
      object edtCEP: TMaskEdit
        Left = 11
        Top = 118
        Width = 68
        Height = 21
        EditMask = '99.999-999;1;_'
        MaxLength = 10
        TabOrder = 3
        Text = '  .   -   '
      end
      object edtEndereco: TLabeledEdit
        Left = 90
        Top = 118
        Width = 382
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        MaxLength = 60
        TabOrder = 4
      end
      object edtBairro: TLabeledEdit
        Left = 334
        Top = 219
        Width = 164
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        MaxLength = 40
        TabOrder = 8
      end
      object edtCidade: TLabeledEdit
        Left = 11
        Top = 219
        Width = 317
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        MaxLength = 30
        TabOrder = 7
      end
      object edtTelefone: TMaskEdit
        Left = 139
        Top = 277
        Width = 86
        Height = 21
        EditMask = '(99) 9999-9999;1;_'
        MaxLength = 14
        TabOrder = 11
        Text = '(  )     -    '
      end
      object edtEmail: TLabeledEdit
        Left = 399
        Top = 78
        Width = 157
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'E-mail'
        MaxLength = 100
        TabOrder = 2
      end
      object edtDataNascimento: TDateEdit
        Left = 11
        Top = 277
        Width = 121
        Height = 21
        DialogTitle = 'Selecione a Data'
        NumGlyphs = 2
        CalendarStyle = csDialog
        TabOrder = 10
      end
      object edtNumero: TLabeledEdit
        Left = 478
        Top = 118
        Width = 78
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'N'#250'mero'
        MaxLength = 10
        TabOrder = 5
      end
      object edtComplemento: TLabeledEdit
        Left = 11
        Top = 165
        Width = 545
        Height = 21
        EditLabel.Width = 65
        EditLabel.Height = 13
        EditLabel.Caption = 'Complemento'
        MaxLength = 60
        TabOrder = 6
      end
      object dbcEstado: TDBComboBox
        Left = 504
        Top = 219
        Width = 52
        Height = 21
        Style = csDropDownList
        DataField = 'estado'
        DataSource = dtsListagem
        Items.Strings = (
          'AC'
          'AL'
          'AP'
          'AM'
          'BA'
          'CE'
          'DF'
          'ES'
          'GO'
          'MA'
          'MT'
          'MS'
          'MG'
          'PA'
          'PB'
          'PR'
          'PE'
          'PI'
          'RJ'
          'RN'
          'RS'
          'RO'
          'RR'
          'SC'
          'SP'
          'SE'
          'TO')
        TabOrder = 9
      end
    end
  end
  inherited pnlRodape: TPanel
    Width = 792
    ExplicitWidth = 792
    inherited btnNovo: TBitBtn
      Left = 3
      ExplicitLeft = 3
    end
    inherited btnFechar: TBitBtn
      Left = 713
      ExplicitLeft = 713
    end
    inherited btnNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT clienteId,'
      '             nome,'
      '             endereco,'
      '             cidade,'
      '             bairro,'
      '             estado,'
      '             cep,'
      '             telefone,'
      '             email,'
      '             datanascimento'
      'FROM clientes')
    object QryListagemclienteId: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'clienteId'
      ReadOnly = True
    end
    object QryListagemnome: TWideStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 60
    end
    object QryListagemendereco: TWideStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'endereco'
      Size = 60
    end
    object QryListagemcidade: TWideStringField
      FieldName = 'cidade'
      Size = 50
    end
    object QryListagembairro: TWideStringField
      FieldName = 'bairro'
      Size = 40
    end
    object QryListagemestado: TWideStringField
      FieldName = 'estado'
      Size = 2
    end
    object QryListagemcep: TWideStringField
      DisplayLabel = 'CEP'
      FieldName = 'cep'
      Size = 10
    end
    object QryListagemtelefone: TWideStringField
      FieldName = 'telefone'
      Size = 14
    end
    object QryListagememail: TWideStringField
      FieldName = 'email'
      Size = 100
    end
    object QryListagemdatanascimento: TDateTimeField
      FieldName = 'datanascimento'
    end
  end
end
