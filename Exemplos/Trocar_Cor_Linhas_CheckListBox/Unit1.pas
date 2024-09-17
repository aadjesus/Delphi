unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CheckLst, StdCtrls;

type
  TForm1 = class(TForm)
    CheckListBox1: TCheckListBox;
    procedure CheckListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.CheckListBox1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
   CheckListBox1.Canvas.FillRect(Rect) ;
   If Not (odFocused in State) Then
   Begin
     If CheckListBox1.Checked[Index] Then
     Begin
       CheckListBox1.Canvas.Font.Color  := clRed ;
       CheckListBox1.Canvas.Brush.Color := clWhite ;
     End Else
     Begin
       CheckListBox1.Canvas.Font.Color  := clBlack ;
       CheckListBox1.Canvas.Brush.Color := clWhite ;
     End ;
   End ;
   CheckListBox1.Canvas.TextOut(Rect.Left+2,Rect.Top,CheckListBox1.Items.Strings[Index]) ;
end;

end.
