program VisuakizaFontes;

uses
  Forms,
  UVisuakizaFontes in 'UVisuakizaFontes.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
