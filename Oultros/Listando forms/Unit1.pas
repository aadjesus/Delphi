unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    NumForms : Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  with TForm2.Create(Self) do begin
    Inc(NumForms);
    Caption := 'Form '+ IntToStr(NumForms);
    Show;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  NumForms := 0;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to Screen.FormCount-1 do
    Listbox1.Items.Add(Screen.Forms[i].Caption);
end;

end.
