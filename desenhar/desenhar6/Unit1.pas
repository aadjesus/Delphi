unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  vPanel : TPanel ;
  vImage : TImage ;
  Lin,Col,Ini,Fin : integer ;
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  vImage.Canvas.brush.color := clMenu ;
  vImage.Canvas.Rectangle(0,0,vImage.Width,vImage.Height) ;

  For Lin := 2 to 8 do
    For Col := 3 to 4 do
      vImage.Canvas.Pixels[ Col , Lin] := clBlue ;

  Ini := 0 ;
  Fin := 7 ;
  For Lin := 8 to 12 do
  Begin
    For Col := Ini to Fin do
      vImage.Canvas.Pixels[ Col , Lin] := clBlue ;
    Inc(Ini) ;
    Dec(Fin) ;
  End ; // For Lin := 8 to 12 do

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  vImage.Canvas.brush.color := clMenu ;
  vImage.Canvas.Rectangle(0,0,vImage.Width,vImage.Height) ;

  Ini := 4 ;
  Fin := 3 ;
  For Lin := 1 to 5 do
  Begin
    For Col := Ini to Fin do
      vImage.Canvas.Pixels[ Col , Lin] := clBlue ;

    Dec(Ini) ;
    Inc(Fin) ;
  End ; // For Lin := 8 to 12 do

  For Lin := 5 to 11 do
    For Col := 3 to 4 do
      vImage.Canvas.Pixels[ Col , Lin] := clBlue ;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  vPanel := TPanel.Create(TForm(Sender)) ;
  vPanel.Name       := 'PanelCreOuDec' ;
  vPanel.Parent     := DBGrid1 ;
  vPanel.Left       := 0 ;
  vPanel.Top        := 0 ;
  vPanel.Height     := 17 ;
  vPanel.Width      := 11 ;
  vPanel.Caption    := '' ;

  vImage := TImage.Create(vPanel) ;
  vImage.Name        := 'ImageCreOuDec' ;
  vImage.Parent      := vPanel ;
  vImage.Align       := alClient ;
  vImage.Transparent := True ;
end;

end.


