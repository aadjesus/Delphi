unit usalvajanelativa4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure CapturaTelaAtiva(bild : Tbitmap) ;
    procedure CapturaTelaInteira(bild : Tbitmap) ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{ TForm1 }

procedure TForm1.CapturaTelaAtiva(bild: Tbitmap);
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
   bild.width  := t.right  - t.left ;
   bild.height := t.bottom - t.top ;
   bild.canvas.copyrect(r,c,t) ;
 finally
   releasedc(0,c.handle) ;
   c.free ;
 end;
end;

procedure TForm1.CapturaTelaInteira(bild: Tbitmap);
Var
 c : Tcanvas ;
 r : Trect ;
begin
 c := Tcanvas.create ;
 c.handle := getwindowdc(getdesktopwindow) ;
 if h > 0 then
 getwindowrect(h,t) ;
 try
   r := rect(0,0,Screen.right-Screen.left,Screen.bottom - Screen.top) ;
   bild.width  := Screen.right  - Screen.left ;
   bild.height := Screen.bottom - Screen.top ;
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
  CapturaTelaAtiva(Image1.picture.bitmap) ;
  form1.visible := true ;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  form1.visible := False ;
  sleep(750);
  CapturaTelaInteira(Image1.picture.bitmap) ;
  form1.visible := true ;
end;

end.
