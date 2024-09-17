unit unTesteLinhas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, WinProcs;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Links: Array[1..10] of HRGN;

implementation

{$R *.DFM}

procedure TForm1.Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If ssLeft in Shift Then
  begin
    // REDIMENSIONA ou MOVIMENTA O COMPONENTE
    WinProcs.ReleaseCapture;
    TWinControl(Sender).Perform(WM_SYSCOMMAND,$F009,0);
  end;
end;


end.

