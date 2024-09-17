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
                ,'2 op��o'
                ,ExtractFilePath(Application.ExeName)
                ,ExtractFileName(Application.Title)
                ,' 5 op��o')
                ;
//Por �ltimo Coloque no Bot�o no evento OnClick:
//begin
//CreateShortCut(ExtractFilePath(Application.ExeName)+ExtractFileName(Application.exename),'2 op��o',ExtractFilePath(Application.ExeName),ExtractFileName(Application.Title),' 5 op��o');
// 1 endere�o fisico do arquivo exe
//2
//3 Op��o de Inciar em (pasta de destino)
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

//Declare a fun��o ap�s a cl�usula implementation:

{$R *.dfm}

procedure CreateShortcut (FileName, Parameters, InitialDir, ShortcutName, ShortcutFolder : String);
begin
end;

//Por �ltimo Coloque no Bot�o no evento OnClick:
begin
CreateShortCut(ExtractFilePath(Application.ExeName)+ExtractFileName(Application.exename),'2 op��o',ExtractFilePath(Application.ExeName),ExtractFileName(Application.Title),' 5 op��o');
// 1 endere�o fisico do arquivo exe
//2
//3 Op��o de Inciar em (pasta de destino)
//4 Nome do Atalho
//5
End;

*)
