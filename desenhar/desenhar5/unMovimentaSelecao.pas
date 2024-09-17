unit unMovimentaSelecao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TForm1 = class(TForm)
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
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

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Capturando := True;
  Origem := Point(X,Y);
  With Form1.Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Pen.Style := psDot;
    Brush.Style := bsClear;
    Pen.Mode := pmNotXor;
    Rectangle(X,Y,X + 100,Y + 20);
  end;
end;

procedure TForm1.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Capturando Then
    Capturando := False;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If Capturando Then
  begin
    With Form1.Canvas do
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

end.
