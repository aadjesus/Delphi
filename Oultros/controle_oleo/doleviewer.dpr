program doleviewer;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas',
  Windows,
  SysUtils;

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.ShowMainForm :=  not Form1.FAuto;  
  Application.Run;
end.
