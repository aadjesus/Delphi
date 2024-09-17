unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CreateShortcut (FileName, Parameters, InitialDir, ShortcutName, ShortcutFolder : String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ShlObj, ActiveX,ComObj, Registry;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  CreateShortCut(ExtractFilePath(Application.ExeName)
                +ExtractFileName(Application.exename)
                ,'2 opção'
                ,ExtractFilePath(Application.ExeName)
                ,ExtractFileName(Application.Title)
                ,' 5 opção')
                ;
//Por último Coloque no Botão no evento OnClick:
//begin
//CreateShortCut(ExtractFilePath(Application.ExeName)+ExtractFileName(Application.exename),'2 opção',ExtractFilePath(Application.ExeName),ExtractFileName(Application.Title),' 5 opção');
// 1 endereço fisico do arquivo exe
//2
//3 Opção de Inciar em (pasta de destino)
//4 Nome do Atalho
//5


end;

procedure TForm1.CreateShortcut(FileName, Parameters, InitialDir, ShortcutName, ShortcutFolder: String);
var
  MyObject : IUnknown;
  MySLink : IShellLink;
  MyPFile : IPersistFile;
  Directory : String;
  WFileName : WideString;
  MyReg : TRegIniFile;
begin
  MyObject := CreateComObject(CLSID_ShellLink);
  MySLink := MyObject as IShellLink;
  MyPFile := MyObject as IPersistFile;
  with MySLink do
  begin
    SetArguments(pchar(Parameters));
    SetPath(PChar(FileName));
    SetWorkingDirectory(PChar(InitialDir));
  end;
  MyReg := TRegIniFile.Create('Software\MicroSoft\Windows\CurrentVersion\Explorer');
  Directory := MyReg.ReadString ('Shell Folders','Desktop','');
  WFileName := Directory + '\' + ShortcutName + '.lnk';
  MyPFile.Save (PWChar (WFileName), False);
  MyReg.Free;
end;

end.
(*

ShlObj, ActiveX,ComObj, Registry;

//Declare a função após a cláusula implementation:

{$R *.dfm}

procedure CreateShortcut (FileName, Parameters, InitialDir, ShortcutName, ShortcutFolder : String);
begin
end;

//Por último Coloque no Botão no evento OnClick:
begin
CreateShortCut(ExtractFilePath(Application.ExeName)+ExtractFileName(Application.exename),'2 opção',ExtractFilePath(Application.ExeName),ExtractFileName(Application.Title),' 5 opção');
// 1 endereço fisico do arquivo exe
//2
//3 Opção de Inciar em (pasta de destino)
//4 Nome do Atalho
//5
End;

*)
