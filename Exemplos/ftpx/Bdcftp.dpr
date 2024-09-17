program BDCftp;

uses
  Forms,
  ftp1 in 'ftp1.pas' {Form1},
  UsrInfo in 'usrinfo.pas' {ConnectForm},
  log in 'log.pas' {LogSheet};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TConnectForm, ConnectForm);
  Application.CreateForm(TLogSheet, LogSheet);
  Application.Run;
end.
