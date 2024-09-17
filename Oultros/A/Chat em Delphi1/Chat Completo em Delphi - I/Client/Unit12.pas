unit Unit12;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type
  TForm12 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Button1: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit2: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit2DblClick(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm12.BitBtn1Click(Sender: TObject);

var  c : byte;
     fil: string;
     i: integer;
     temu: boolean;
     label keluar;
Begin
if edit2.text = '' then
begin
messagedlg('Please enter filename',mtInformation,[mbOK],0);
goto keluar;
end
else
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
showmessage('User '+' "'+ edit1.text+ ' "'+' does not exist');
goto keluar;
end
else
if temu= true then
  c:= length(edit2.text);
  repeat
  dec(c);
  until copy(edit2.text,c,1)='\';
  fil:= copy(edit2.text,c+1, length(edit2.text)-c);
  form1.clientsocket1.socket.SendText('12'+'ô'+ inttostr(urut)+'æ'+edit1.text+'§'+fil );
  form1.RichEdit1.SelAttributes.color:=clBlue;
  form1.richedit1.lines.add('Waiting for user '+edit1.text+ ' to acknowledge');
  close;
  keluar:
end;


procedure TForm12.Button1Click(Sender: TObject);
begin
 form1.OpenDialog1.Execute;
 edit2.text:=form1.opendialog1.filename;
end;

procedure TForm12.BitBtn2Click(Sender: TObject);
begin
close;

end;


procedure TForm12.Edit2DblClick(Sender: TObject);
begin
form1.OpenDialog1.execute;
edit2.text:= form1.opendialog1.filename;
end;

end.
