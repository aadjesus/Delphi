unit unMovimentaSelecao2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Capturando: Boolean;
  Origem: tPoint;


implementation

{$R *.DFM}

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Capturando := True;
  Origem := Point(X,Y);
  With Image1.Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 2;
//    Pen.Style := psDot;
    Brush.Style := bsClear;
    Pen.Mode := pmNotXor;
    Rectangle(X,Y,X + 100,Y + 20);
  end;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If Capturando Then
  begin
    With Image1.Canvas do
    begin
      // APAGA ANTERIOR
      Rectangle(Origem.X,Origem.Y,Origem.X + 100,Origem.Y + 20);

      // DESENHA NOVO
      Rectangle(X,Y,X + 100,Y + 20);

      // GUARDA ATUAL PARA APAGAR DEPOIS
      Origem := Point(X,Y);
    end;
  end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Capturando Then
    Capturando := False;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Image1.Picture.SaveToFile('L:\APAGUE\TESTE.BMP');
end;

end.
