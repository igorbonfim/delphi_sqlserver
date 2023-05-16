object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 375
  Width = 463
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16'
      'AutoEncodeStrings=True')
    AutoCommit = False
    TransactIsolationLevel = tiReadCommitted
    SQLHourGlass = True
    HostName = '.'
    Port = 1433
    Database = 'Vendas'
    User = 'sa'
    Password = '@ijbp12345'
    Protocol = 'mssql'
    LibraryLocation = 'C:\Projetos\Curso Delphi com SQL Server Udemy\ntwdblib.dll'
    Left = 48
    Top = 32
  end
end
