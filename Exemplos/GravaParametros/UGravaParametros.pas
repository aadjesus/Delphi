unit UGravaParametros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, NumEdit, TimeEdit, Mask, ExtCtrls, ToolEdit, CheckLst, Buttons,
  ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    MaskEdit1: TMaskEdit; // TCustomEdit
    TimeEdit1: TTimeEdit; // TCustomEdit
    NumEdit1: TNumEdit;   // TCustomEdit
    DateEdit1: TDateEdit; // TCustomEdit
    ComboBox1: TComboBox;
    DateTimePicker1: TDateTimePicker;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    Memo1: TMemo;            // TCustomEdit
    RichEdit1: TRichEdit;    // TCustomEdit
    RadioGroup1: TRadioGroup;
    CheckListBox1: TCheckListBox;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    Procedure GravaParametros ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{ TForm1 }

procedure TForm1.GravaParametros;
Var
  i : Integer ;
begin
  With Screen.ActiveForm do
  Begin
    For i := 0 to ComponentCount - 1 do
    Begin
    
    End ; // For i := 0 to ComponentCount - 1 do
  End ; // With Screen.ActiveForm do
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  TCustomEdit(Edit1).Text      := '2' ;
  TCustomEdit(MaskEdit1).Text  := '3' ;
  TCustomEdit(TimeEdit1).Text  := '01:01:01' ;
  TCustomEdit(NumEdit1).Text   := '4' ;
  TCustomEdit(DateEdit1).Text  := '01/01/2006' ;
  TCustomEdit(Memo1).Text      := '5' ;
  TCustomEdit(RichEdit1).Text  := '6' ;
//  TCustomEdit(DateTimePicker1).Text := '01/01/2006' ;
end;

end.

