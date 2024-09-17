unit Unitxx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NumEdit, ExtCtrls;

type
  TForm1 = class(TForm)
    PnlTela: TPanel;
    NumEdit1: TNumEdit;
    NumEdit2: TNumEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
Var
  vPanel : TPanel ;
  vShape : TShape ;
  i : Integer ;
begin
  vPanel := TPanel.Create(PnlTela) ;
  With vPanel do
  Begin
    Parent     := PnlTela ;
    Name       := 'Linha' + NumEdit1.Text  ;
    Align      := alTop ;
    BevelOuter := bvNone ;
    Caption    := '' ;
    Top        := 0 ;
    Height     := 20 ;
    For i := 1 to StrToInt(NumEdit2.Text) do
    Begin
      vShape := TShape.Create(vPanel) ;
      With vShape do
      Begin
        Parent := vPanel ;
        Align  := alLeft ;
        Shape  := stRoundRect ;
      End ;
    End ; //

  End ; //
end ;

end.


