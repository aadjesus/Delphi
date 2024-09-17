unit URichEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RxRichEd, RichEdit;

type
  TForm1 = class(TForm)
    RxRichEdit1: TRxRichEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MarkRichEditText(RichEdit: TRxRichEdit; fgColor, bkColor: TColor; MarkMode: Integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.MarkRichEditText(RichEdit: TRxRichEdit; fgColor, bkColor: TColor; MarkMode: Integer);
  var
  CharFormat: TCharFormat2;
  begin
    //na marcação de palavra, na chamada a EM_SETCHARFORMAT deve ser
    //concatenado SCF_SELECTION ao parâmetro SCF_WORD
    if MarkMode = SCF_WORD then
      MarkMode := MarkMode or SCF_SELECTION;
    CharFormat.cbSize := SizeOf(CharFormat);
    CharFormat.dwMask := CFM_BACKCOLOR or CFM_COLOR;
    CharFormat.crBackColor := ColorToRGB(bkColor);
    CharFormat.crTextColor := ColorToRGB(fgColor);
    SendMessage(RichEdit.handle, EM_SETCHARFORMAT, MarkMode, LongInt(@CharFormat));
  end;


procedure TForm1.Button1Click(Sender: TObject);
begin
MarkRichEditText(RxRichEdit1, clRed, clLime, SCF_SELECTION);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
MarkRichEditText(RxRichEdit1, clBlack, clYellow, SCF_ALL);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
MarkRichEditText(RxRichEdit1, RxRichEdit1.Font.Color, clAqua, SCF_WORD);
end;

end.
