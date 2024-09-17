program CDROM;

uses
  Forms,
  uCdRom in 'uCdRom.pas' {frmPrincipal};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
