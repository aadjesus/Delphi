program PPrototicoDelphi7;

uses
  Forms,
  UPrototicoDelphi7 in 'UPrototicoDelphi7.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
