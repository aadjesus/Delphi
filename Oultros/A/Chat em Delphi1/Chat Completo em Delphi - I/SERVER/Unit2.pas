unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Edit3: TEdit;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm2.Button1Click(Sender: TObject);
var i:byte;
begin
if pass = edit3.text then
begin
if edit1.text = edit2.text then
begin
pass:= edit1.text;
for i:=0 to form1.serversocket1.socket.activeconnections-1 do
form1.serversocket1.socket.Connections[i].SendText('13'+'ô'+ pass);
end
else
showmessage(' Password missmatch');
end
else
showmessage('Password Salah');
close;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
close;
end;

end.
