unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit5: TEdit;
    Label5: TLabel;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Btn: TButton;
  contador: Integer;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
        btn:=Tbutton.create(self);
        btn.Visible:=false;
        btn.Parent:=self;
        btn.Top    := StrToInt(Edit1.Text);
        btn.Left   := StrToInt(Edit2.Text);
        btn.Height := StrToInt(Edit3.Text);
        btn.Width  := StrToInt(Edit4.Text);
        btn.Name:='Btn'+inttostr(contador);
        btn.Caption:= Edit5.Text;
        inc(contador);
        btn.visible:=true;
end;

end.
