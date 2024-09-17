program RunTime;

uses
  Forms,
  RunTime1 in 'RunTime1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
