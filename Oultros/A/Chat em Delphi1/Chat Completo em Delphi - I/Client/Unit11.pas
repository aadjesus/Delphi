unit Unit11;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TForm11 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Edit3: TEdit;
    BitBtn2: TBitBtn;
    Label6: TLabel;
    Label7: TLabel;
    Edit4: TEdit;
    BitBtn3: TBitBtn;
    Label8: TLabel;
    Edit5: TEdit;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    CheckBox2: TCheckBox;
    CheckBox4: TCheckBox;
    Edit6: TEdit;
    Label9: TLabel;
    BitBtn6: TBitBtn;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    private
     { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation
uses unit1, Unit2;
{$R *.DFM}

procedure TForm11.BitBtn1Click(Sender: TObject); {kick}
var i: byte;
    temu: boolean;
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
showmessage('Nick '+'"'+ edit1.text+'"'+' does not exist');
goto label2
end
else
if temu= true then
begin
if radiogroup1.itemindex=-1 then
showmessage('Enter your status')
else
if radiogroup1.itemindex=1 then
form1.clientsocket1.socket.sendtext('7'+'ô'+'?'+'§'+edit1.text+'æ'+edit2.text)
else
if radiogroup1.itemindex=0 then
form1.clientsocket1.socket.sendtext('7'+'ô'+inttostr(urut)+ '§'+edit1.text+ 'æ'+edit2.text)
else
if radiogroup1.itemindex=2 then
form1.clientsocket1.socket.sendtext('7'+'ô'+'`'+ '§'+edit1.text+'æ'+'@');
end;
label2:
end;


procedure TForm11.BitBtn5Click(Sender: TObject);
begin
close;
end;



procedure TForm11.BitBtn2Click(Sender: TObject); { set moderator}

var i: byte;
    temu: boolean;
    label label2;
begin
 i:=0;
repeat
inc(i);
if uppercase(nick[i-1]) = uppercase(edit3.text) then
temu:= true
else
temu:= false;
until (temu=true) or (i=g);
if temu=false then
begin
showmessage('Nick '+'"'+ edit3.text+'"'+' does not exist');
goto label2
end
else
if temu= true then
begin
if CheckBox2.Checked  = true then
form1.clientsocket1.socket.sendtext('8'+'ô'+'?'+'§'+edit3.text)
else
if checkbox2.checked =false then
form1.clientsocket1.socket.sendtext('8'+'ô'+inttostr(urut)+ '§'+edit3.text);
end;

label2:
end;


procedure TForm11.BitBtn4Click(Sender: TObject); {set topic}
begin
begin
if CheckBox4.Checked  = true then
form1.clientsocket1.socket.sendtext('9'+'ô'+'?'+'§'+edit5.text)
else
if checkbox4.checked =false then
form1.clientsocket1.socket.sendtext('9'+'ô'+inttostr(urut)+ '§'+edit5.text);
end;
end;

procedure TForm11.BitBtn3Click(Sender: TObject);  {frezze}

var i: byte;
    temu: boolean;
    label label2;
begin
 i:=0;
repeat
inc(i);
if uppercase(nick[i-1]) = uppercase(edit4.text) then
temu:= true
else
temu:= false;
until (temu=true) or (i=g);
if temu=false then
begin
showmessage('Tidak ada nick '+ edit4.text);
goto label2
end
else
if temu= true then
begin
if radiogroup2.itemindex=-1 then
showmessage('Enter your status')
else
if radiogroup2.itemindex=1then
form1.clientsocket1.socket.sendtext('10'+'ô'+'?'+'§'+edit4.text)
else
if radiogroup2.itemindex=0 then
form1.clientsocket1.socket.sendtext('10'+'ô'+inttostr(urut)+ '§'+edit4.text)
else
if radiogroup2.itemindex=2 then
form1.clientsocket1.socket.sendtext('10'+'ô'+'`'+'§'+edit4.text);
label2:
end
end;



procedure TForm11.BitBtn6Click(Sender: TObject);
begin
form2.edit2.text:= edit6.text;
end;

end.
