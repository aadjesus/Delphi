unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm5 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
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
  Form5: TForm5;

implementation

uses Unit1, Unit2;

{$R *.DFM}

procedure TForm5.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure TForm5.BitBtn1Click(Sender: TObject);
var i: byte;
    label keluar;
begin
i:=0;
repeat
inc(i);
if uppercase(edit1.text) = uppercase(nick[i-1]) then
begin
showmessage('Nick '+'" '+ edit1.text +' "'+ ' is currently used');
goto keluar;
end;
until i=g ;
form1.label2.caption:=edit1.text;
form2.edit2.text:=edit1.text;
form1.clientsocket1.socket.sendtext('6'+'ô'+inttostr(urut)+'§'+edit1.text);
close;
keluar:
end;



end.
