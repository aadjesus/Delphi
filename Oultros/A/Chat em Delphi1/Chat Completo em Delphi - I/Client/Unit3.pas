unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm3.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
form1.ClientSocket1.Socket.sendtext('5'+'ô'+inttostr(urut));
Form1 .ClientSocket1.Active := false;
g:=0;
urut:=0;
close;
form1.richedit1.SelAttributes.Color:= clRed;
form1.RichEdit1.Lines.add ('Disconnected from server');
 end;

end.
