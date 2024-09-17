unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TForm7 = class(TForm)
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
  Form7: TForm7;

implementation
 uses unit1;
{$R *.DFM}

procedure TForm7.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure TForm7.BitBtn1Click(Sender: TObject);
Var
    selkar,awal,akal : string;
    i,j,k,l,x,y,a : Byte;
    Z : Array[1..101] of Boolean;
    kal2 : array [1..101] of char;
    kal1 : array [1..10] of string;
    quest : array [1..10] of string;
    label label1 ;
begin
     if (length(edit1.text)=0) or (length(edit2.text)=0) then
     begin
     messagedlg('Missing Field Required',mtWarning,[mbOK],0);
     goto label1;
     end
     else
     l:=0;
     x:=0;
     awal:= edit1.text+#32;
     repeat
     k:= l+1;
     repeat
     inc(l);
     until copy(awal,l,1) = #32   ;
     inc(x);
     kal1[x]:= copy (awal,k,l-k);
     until  l = length(awal) ;
     Randomize;
     for y:= 1 to x do
     begin
     akal:= kal1[y];
     For i := 1 to length(kal1[y]) Do
     Begin
          Repeat
               j := Random(length(kal1[y]))+1;
               If Z[j] <> True Then
               Begin
                   kal2[j]:= akal[i];
                   Z[j] := True;
               End
               Else
               Begin
                    j := 101;
                    Z[j] := False;
               End;
          Until Z[j] = True;
     End;
    for a:= 1 to length(kal1[y])+1 do
    z[a]:= false;
   for a:= 1 to length(kal1[y]) do
   quest[y]:= kal2[a]+quest[y];
   end;
 for i:= x downto 1 do
selkar:= quest[i]+' '+selkar;
form1.ClientSocket1.Socket.SendText('15'+'ô'+ inttostr(urut)+'§'+edit1.text+'æ'+selkar+'±'+edit2.text);
close;
label1:
end;

end.
