unit lembretes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, WinProcs;

type
  TForm1 = class(TForm)
    vShapeLembrete: TShape;
    vPnlLembrete: TPanel;
    vLblLembrete: TLabel;
    vBvlLembrete: TBevel;
    vMemoLembrete: TMemo;
    procedure vPnlLembreteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.vPnlLembreteMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  If ssLeft in Shift Then
  begin
    // REDIMENSIONA ou MOVIMENTA O COMPONENTE
    WinProcs.ReleaseCapture ;
//    TWinControl(Sender).Perform(WM_SYSCOMMAND,$F009,0);
    TGraphicControl(Sender).Perform(WM_SYSCOMMAND,$F009,0);
//    vShapeLembrete.Left := TWinControl(Sender).Left ;
//    vShapeLembrete.Top  := TWinControl(Sender).top ;
  end;
end;

end.
