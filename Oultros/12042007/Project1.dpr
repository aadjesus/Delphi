program Project1;

uses
  SvcMgr,
  teste in 'teste.pas' {Service1: TService};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TService1, Service1);
  Application.Run;
end.
