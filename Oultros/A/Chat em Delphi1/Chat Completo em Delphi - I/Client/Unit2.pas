unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    



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
procedure TForm2.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);

   label label1;
begin
if (length(edit2.text) > 15) or (length(edit2.text)=0)or (length(edit1.text)=0) or (length(edit1.text)=0) then
begin
messagedlg('Required field missing',mtWarning,[mbOK],0);
goto label1;
end
else
form1.ClientSocket1.Port :=200;
form1.clientSocket1.Host := Edit3.Text;
form1.ClientSocket1.Active := True;
g:=0;
close;
label1:
end;






end.
