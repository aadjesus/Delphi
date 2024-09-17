unit UComboMatriz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  i,j,k,result:integer;
  s,t:string;
  Tab: array [1..100,1..10] of integer;
  TabS: array [1..100,1..10] of string;
implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);

begin
edit3.Enabled:=false;
i:=1;
j:=1;
k:=1;
while j<=10 do
begin
Combobox1.Items.Add(IntToStr(j));
Inc(j);
end;
while i<=100 do
begin
Combobox2.Items.Add(IntToStr(i));
Inc(i);
end;
for i:=1 to 100 do
begin
    for j:=1 to 10 do
    begin
         tabs[i,j]:= inttostr(k);
         tab[i,j]:=strtoint(tabs[i,j]);
         Inc(k);
    end;
end;

end;



procedure TForm1.Button1Click(Sender: TObject);
begin
i:=combobox1.ItemIndex+1;
j:=combobox2.ItemIndex+1;
edit3.ReadOnly:=True;
edit3.Text:=IntToStr(tab[i,j]);
end;

end.
