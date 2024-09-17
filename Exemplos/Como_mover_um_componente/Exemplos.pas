unit Exemplos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    MouseDownSpot : TPoint ;
    Capturing     : Boolean ;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


procedure TForm1.Panel1MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
begin
//  if ssCtrl in Shift then
    SetCapture(Panel1.Handle);
    Capturing := True ;
    MouseDownSpot.X := x ;
    MouseDownSpot.Y := Y ;
//  end ;
end;

procedure TForm1.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,  Y: Integer);
Var
  vLef,
  vTop : Integer ;
begin
  if Capturing Then
  begin
    vLef := Panel1.Left - (MouseDownSpot.x-x);
    vTop := Panel1.Top  - (MouseDownSpot.x-y);

    If ((vLef > 0) And (vLef + Panel1.Width  < Form1.Width)) And
       ((vTop > 0) And (vTop + Panel1.Height < Form1.Height)) Then
    Begin
//      Panel1.s ;
      Panel1.Left := vLef ;
      Panel1.Top  := vTop ;
    End ;
  end;
end;

procedure TForm1.Panel1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  vLef,
  vTop : Integer ;
begin
  if Capturing then
  begin
    vLef := Panel1.Left - (MouseDownSpot.x - x);
    vTop := Panel1.Top  - (MouseDownSpot.y - y);

    If ((vLef > 0) And (vLef + Panel1.Width  < Form1.Width)) And
       ((vTop > 0) And (vTop + Panel1.Height < Form1.Height)) Then
    Begin
      ReleaseCapture;
      Capturing   := false ;
      Panel1.Left := vLef ;
      Panel1.Top  := vTop ;
    End ;
  end;
end;

end.




