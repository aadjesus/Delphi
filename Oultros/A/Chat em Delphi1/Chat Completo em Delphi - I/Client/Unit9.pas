unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm9 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Edit2: TEdit;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    Edit3: TEdit;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation
uses unit1;
{$R *.DFM}

procedure TForm9.BitBtn1Click(Sender: TObject);
var i: byte;
    temu : boolean;
    label label2;

begin
i:=0;
repeat
inc(i);
if uppercase(nick[i-1]) = uppercase(edit1.text) then
temu:= true
else
temu:= false;
until (temu=true) or (i=g);
if temu=false then
begin
showmessage('User '+ '"'+edit1.text+'"'+' does not exist');
goto label2
end
else
if temu= true then
begin
form1.clientsocket1.socket.sendtext('7'+'ô'+inttostr(urut)+ '§'+edit1.text+ 'æ'+edit3.text);
end;
label2:
end;
procedure TForm9.BitBtn2Click(Sender: TObject);
begin
form1.clientsocket1.socket.sendtext('9'+'ô'+inttostr(urut)+ '§'+edit2.text);
end;

end.
