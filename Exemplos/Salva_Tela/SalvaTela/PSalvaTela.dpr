program PSalvaTela;

uses
  Forms,
  USalvaTela in 'USalvaTela.pas' {FrmEST_NotaFiscal},
  UEnviaTela in 'UEnviaTela.pas' {FrmEnviaTela};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmEST_NotaFiscal, FrmEST_NotaFiscal);
  Application.CreateForm(TFrmEnviaTela, FrmEnviaTela);
  Application.Run;
end.
