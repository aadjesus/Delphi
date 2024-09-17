unit UVisuakizaFontes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXSpin, RxRichEd, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    RxRichEdit1: TRxRichEdit;
    Panel1: TPanel;
    Panel5: TPanel;
    ListBox3: TListBox;
    Panel3: TPanel;
    Panel4: TPanel;
    ComboBox1: TComboBox;
    Panel6: TPanel;
    RxSpinEdit1: TRxSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    FontDialog1: TFontDialog;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

end.
