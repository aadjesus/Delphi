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
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation
 uses unit1;
{$R *.DFM}

procedure TForm3.BitBtn1Click(Sender: TObject);
var i: byte;
begin
for i:= 0 to form1.serversocket1.socket.activeconnections-1 do
form1.serversocket1.socket.connections[i].sendtext('13'+'ô'+ pass);
close;
end;

procedure TForm3.BitBtn2Click(Sender: TObject);
var i: byte;
begin
for i:= 0to form1.serversocket1.socket.activeconnections-1 do
form1.serversocket1.socket.Connections[i].sendtext('17'+'ô');
close;
end;

end.
