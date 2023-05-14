unit cArquivoIni;

interface

uses  System.Classes,
      Vcl.Controls,
      Vcl.ExtCtrls,
      Vcl.Dialogs,
      System.SysUtils,
      System.IniFiles,
      Vcl.Forms;

type
  TArquivoIni = class
    private
    public
      class function ArquivoIni: String; static;
      class function LerIni(aSecao, aEntrada: String): String; static;
      class procedure AtualizarIni(aSecao, aEntrada, aValor: String); static;
  end;

implementation

{ TArquivoIni }

class function TArquivoIni.ArquivoIni: String;
begin
  Result := ChangeFileExt(Application.ExeName, '.INI');
end;

class procedure TArquivoIni.AtualizarIni(aSecao, aEntrada, aValor: String);
var
  Ini: TIniFile;
begin
  Try
    Ini := TIniFile.Create(ArquivoIni);
    Ini.WriteString(aSecao, aEntrada, aValor);
  Finally
    Ini.Free;
  End;
end;

class function TArquivoIni.LerIni(aSecao, aEntrada: String): String;
var
  Ini: TIniFile;
begin
  Try
    Ini := TIniFile.Create(ArquivoIni);
    Result := Ini.ReadString(aSecao, aEntrada, 'NÃO ENCONTRADO');
  Finally
    Ini.Free;
  End;
end;

end.
