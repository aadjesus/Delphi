program TreeView_P;

uses
  Forms,
  TreeView_U in 'TreeView_U.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
