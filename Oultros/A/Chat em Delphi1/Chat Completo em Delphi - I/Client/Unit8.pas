unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm8 = class(TForm)
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
  Form8: TForm8;

implementation

uses Unit1;

{$R *.DFM}
 var
 s: string;

 procedure TForm8.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure TForm8.BitBtn1Click(Sender: TObject);
var i:integer;
    temu: boolean ;
    label keluar;

begin
i:=-1;
repeat
inc(i);
if uppercase(nick[i])= uppercase(edit1.text) then
temu:= true
else
temu:= false
until (temu= true) or (i=g);
if temu = false then
begin
showmessage('User '+ '"'+edit1.text+' "'+' does not exist' );
goto keluar;
end
else
if temu= true then
form1.clientsocket1.socket.sendtext('3'+'ô'+inttostr(urut)+'`'+edit1.text);
close;
keluar:
end;

end.
