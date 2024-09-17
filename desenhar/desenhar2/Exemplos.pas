unit Exemplos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, StdCtrls, Jpeg, DB, RxMemDS;

type
  TForm1 = class(TForm)
    Image1: TImage;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    vDesenhar  : Boolean ;
    vPosIni    : TPoint ;
    vQtdeMarca :Integer ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  vDesenhar := ssCtrl in Shift ;
  If vDesenhar then
  Begin
    vPosIni := Point(X,y) ;
    Image1.Cursor := crCross ;
  End ; // If vDesenhar then
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  If vDesenhar then
  Begin
    vDesenhar     := False ;
    Image1.Cursor := crDefault ;

    Inc(vQtdeMarca) ;
    If vPosIni.X > x Then
      vPosIni.x := x ;

    If vPosIni.y > y Then
      vPosIni.y := y ;

    Image1.Canvas.Rectangle(vPosIni.X,vPosIni.Y+1,vPosIni.X+18,vPosIni.Y-15) ;
    Image1.Canvas.TextOut(vPosIni.X+3,vPosIni.Y-14, IntToStr(vQtdeMarca) ) ;
  End ; // If vDesenhar then
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If vDesenhar then
  Begin
//    Image1.Canvas.FillRect(Rect(0,0,Width, Height)) ;
    Image1.Canvas.Rectangle(vPosIni.X,vPosIni.Y,x+1,y+1) ;
  End ;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  vQtdeMarca := 0 ;
//  Image1.Canvas.Brush.Style := bsClear;
//  Image1.Canvas.Pen.Mode    := pmNotXor;
  Image1.Canvas.Pen.Color   := clRed ;
  Image1.Canvas.Pen.Width   := 2 ;
  Image1.Canvas.Font.Color  := clRed ;
end;

end.
