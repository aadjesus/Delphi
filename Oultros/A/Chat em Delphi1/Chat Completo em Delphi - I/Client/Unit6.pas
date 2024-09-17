unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
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
  Form6: TForm6;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm6.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure TForm6.BitBtn1Click(Sender: TObject);
var i: integer;
     temu: boolean;
     label keluar;
begin
i:=-1;
repeat
inc(i);
if uppercase(nick[i]) = uppercase(edit1.text) then
temu:= true
else
temu:= false;
until (temu = true) or (i =g);
if temu = false then
begin
showmessage('Nick '+' "'+ edit1.text+ ' "'+' does not exist');
goto keluar;
end
else
if temu= true then
form1.clientsocket1.socket.sendtext('4'+'ô'+ inttostr(urut) +'`'+ edit1.text+ '!'+edit2.text);
form1.richedit1.selattributes.color:= tcolor($005E24F4);
form1.richedit1.lines.add('Message Sent to '+ edit1.text);
close;
keluar:
end;

end.
