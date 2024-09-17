unit RunTime1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
TForm1 = class(TForm)
Button1: TButton;
    Label1: TLabel;
procedure Button1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
procedure Button1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
procedure Button1MouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
private
{ Private declarations }
public
{ Public declarations }
MouseDownSpot : TPoint;
Capturing : bool;
end;
var
Form1: TForm1;

implementation
{$R *.DFM}

// Evento OnMouseDown do Form
procedure TForm1.Button1MouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if ssCtrl in Shift then begin
SetCapture(Button1.Handle);
Capturing := true;
MouseDownSpot.X := x;
MouseDownSpot.Y := Y;
end;
end;

// Evento OnMouseMove do Form
procedure TForm1.Button1MouseMove(Sender:
TObject; Shift: TShiftState; X, Y: Integer);
begin
if Capturing then begin
Button1.Left:= Button1.Left-(MouseDownSpot.x-x);
Button1.Top:= Button1.Top - (MouseDownSpot.y-y);
end;
end;

// Evento OnMouseUp do Form
procedure TForm1.Button1MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if Capturing then begin
ReleaseCapture;
Capturing := false;
Button1.Left := Button1.Left - (MouseDownSpot.x -x);
Button1.Top := Button1.Top - (MouseDownSpot.y - y);
end;
end;
end.
