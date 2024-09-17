unit UnitModelo_Panel_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Confirma, ExtCtrls, Grids, DBGrids, Imprimir;

type
  TFrmModeloPanelForm = class(TForm)
    Button1: TButton;
    PnlModeloPanelForm: TPanel;
    PnlBotoesModelo: TPanel;
    Imprimir1: TImprimir;
    PnlTelaModelo: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    ImageGlobus: TImage;
    Panel5: TPanel;
    Panel9: TPanel;
    PnlSaidaModelo: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    PnlTitulo: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure BtnValoresNfClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmModeloPanelForm: TFrmModeloPanelForm;

implementation

{$R *.DFM}

procedure TFrmModeloPanelForm.Button1Click(Sender: TObject);
begin
  With PnlModeloPanelForm do
  Begin
    Width   := FrmModeloPanelForm.Width  - 60 ;
    Height  := FrmModeloPanelForm.Height - 60 ;
    Top     := Trunc((FrmModeloPanelForm.Width  - Width)  / 2) ;
    Left    := Trunc((FrmModeloPanelForm.Height - Height) / 2) ;
    Visible := True ;
  End ; // With PnlModeloPanelTela do
end;

procedure TFrmModeloPanelForm.BtnValoresNfClick(Sender: TObject);
begin
  PnlModeloPanelForm.Visible := False ;
end;

end.
