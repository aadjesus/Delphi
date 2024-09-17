unit usalvajanelativa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure screenX(bild : Tbitmap) ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.screenX(bild: Tbitmap);
Var
 c : Tcanvas ;
 r,t : Trect ;
 h : THandle ;
begin
 c := Tcanvas.create ;
 c.handle := getwindowdc(getdesktopwindow) ;
 h := getforegroundwindow ;
 if h > 0 then
 getwindowrect(h,t) ;
 try
   r := rect(0,0,t.right-t.left,t.bottom - t.top) ;
   bild.width := t.right - t.left ;
   bild.height := t.bottom - t.top ;
   bild.canvas.copyrect(r,c,t) ;
 finally
   releasedc(0,c.handle) ;
   c.free ;
 end;


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
form1.visible := False ;
sleep(750);
screenX(Image1.picture.bitmap) ;
form1.visible := true ;

end;

end.
