program Desliga;

uses
  Forms,
  Unit_Desliga in 'Unit_Desliga.pas' {FormDesliga};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormDesliga, FormDesliga);
  Application.Run;
end.
