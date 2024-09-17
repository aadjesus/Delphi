unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm10 = class(TForm)
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation
uses unit1;
{$R *.DFM}

procedure TForm10.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure TForm10.BitBtn1Click(Sender: TObject);
begin
if edit1.text = pass then
begin
mode:= true;
form1.modmenu1.visible:= true;
form1.modmenu1.enabled:=true;
form1.speedbutton11.visible:= true;
form1.speedbutton11.enabled:=true;
close;
end
else
showmessage('Password anda salah');
end;

end.
