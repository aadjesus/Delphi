program ProjectModelo_Panel_Form;

uses
  Forms,
  UnitModelo_Panel_Form in 'UnitModelo_Panel_Form.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFrmModeloPanelForm, FrmModeloPanelForm);
  Application.Run;
end.
