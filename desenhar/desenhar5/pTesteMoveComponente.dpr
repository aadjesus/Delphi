program pTesteMoveComponente;

uses
  Forms,
  TesteMoveComponente in 'TesteMoveComponente.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
