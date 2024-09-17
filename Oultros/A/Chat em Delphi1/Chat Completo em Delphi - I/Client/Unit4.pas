unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm4 = class(TForm)
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
  Form4: TForm4;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm4.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure TForm4.BitBtn1Click(Sender: TObject);
begin
form1.ClientSocket1.Socket.sendtext('5'+'ô'+inttostr(urut));
sleep(50);
application.terminate;
end;

end.
