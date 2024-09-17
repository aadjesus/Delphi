(*
$F001 - REDIMENSIONAR ESQUERDA
$F002 - REDIMENSIONAR DIREITA
$F003 - REDIMENSIONAR TOPO
$F004 - REDIMENSIONAR CANTO SUPERIOR ESQUERDO
$F005 - REDIMENSIONAR CANTO SUPERIOR DIREITO
$F006 - REDIMENSIONAR BASE
$F007 - REDIMENSIONAR CANTO INFERIOR ESQUERDO
$F008 - REDIMENSIONAR CANTO INFERIOR DIREITO
$F009 - MOVIMENTA O COMPONENTE

if ssLeft in vShift then
  TWinControl(Button1).Perform( WM_SYSCOMMAND, $F009, 0 );


//Button1.Perform(WM_SYSCOMMAND,$F012,10);
//movewindow(Button1.handle,10,10,20,30,True);
//hwnd
//SendMessage(Button1.Handle,WM_SYSCOMMAND,$F012,1);
//  ShowWindow(Panel1.Handle, SC_SIZE );
//TWinControl(Button1).Perform( WM_SYSCOMMAND, $F001, 0 );
  vShift := Shift;
//  if ssLeft in Shift then
//    TWinControl(Button1).Perform( WM_SYSCOMMAND, $F009, 0 );

*)

unit TesteMoveComponente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,WinProcs;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    procedure Panel2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  vMovimento: LongInt;

implementation

Const
  cBorda = 4;

{$R *.DFM}

procedure TForm1.Panel2MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
Var
  vLargura,
  vAltura: Integer;
begin
  If ssLeft in Shift Then
  begin
    // REDIMENSIONA ou MOVIMENTA O COMPONENTE
    WinProcs.ReleaseCapture;
    TWinControl(Sender).Perform(WM_SYSCOMMAND,vMovimento,0);
  end Else
  begin
    vLargura := TWinControl(Sender).Width;
    vAltura := TWinControl(Sender).Height;

    If (((X - cBorda) <= 0) And
        ((Y - cBorda) <= 0)) Then
    begin
      TWinControl(Sender).Cursor := crSizeNWSE;
      vMovimento := $F004 // - REDIMENSIONAR CANTO SUPERIOR ESQUERDO
    end Else If (((X + cBorda) >= vLargura) And
                ((Y + cBorda) >= vAltura)) Then
    begin
      TWinControl(Sender).Cursor := crSizeNWSE;
      vMovimento := $F008 // - REDIMENSIONAR CANTO INFERIOR DIREITO
    end else If (((X - cBorda) <= 0) And
                ((Y + cBorda) >= vAltura)) Then
    begin
      TWinControl(Sender).Cursor := crSizeNESW;
      vMovimento := $F007 // - REDIMENSIONAR CANTO SUPERIOR DIREITO
    end Else If (((X + cBorda) >= vLargura) And
                ((Y - cBorda) <= 0)) Then
    begin
      TWinControl(Sender).Cursor := crSizeNESW;
      vMovimento := $F005 // - REDIMENSIONAR CANTO INFERIOR ESQUERDO
    end else If ((X - cBorda) <= 0) Then
    begin
      TWinControl(Sender).Cursor := crSizeWE;
      vMovimento := $F001 // - REDIMENSIONAR ESQUERDA
    end else If ((X + cBorda) >= vLargura) Then
    begin
      TWinControl(Sender).Cursor := crSizeWE;
      vMovimento := $F002 // - REDIMENSIONAR DIREITA
    end else If ((Y - cBorda) <= 0) Then
    begin
      TWinControl(Sender).Cursor := crSizeNS;
      vMovimento := $F003 // - REDIMENSIONAR TOPO
    end else If ((Y + cBorda) >= vAltura) Then
    begin
      TWinControl(Sender).Cursor := crSizeNS;
      vMovimento := $F006 // - REDIMENSIONAR BASE
    end else
    begin
      TWinControl(Sender).Cursor := crDefault;
      vMovimento := $F009 // - MOVIMENTA O COMPONENTE
    end;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  vMovimento := $F009;
end;

end.
