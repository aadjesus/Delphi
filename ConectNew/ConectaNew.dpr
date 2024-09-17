program ConectaNew;

uses
  Forms,
  UtConectaNew in 'UtConectaNew.pas' {FrmConectaNew},
  CntNewServidores in 'CntNewServidores.pas' {FrmCntNewServidores};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmConectaNew, FrmConectaNew);
  Application.CreateForm(TFrmCntNewServidores, FrmCntNewServidores);
  //  Showwindow(application.handle,sw_hide);
  Application.Run ;
end.

