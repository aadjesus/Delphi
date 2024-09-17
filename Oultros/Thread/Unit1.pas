unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Button1: TBitBtn;
    Button2: TBitBtn;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
     bCancelar: Boolean;
  public
    { Public declarations }
  end;

  thProcessa = Class(TThread)
  protected
    constructor Create;
    procedure Execute;Override;
    procedure IncreaseNumber;
  end;


var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TThread1 }

constructor thProcessa.Create;
begin
     inherited Create(false);
end;

procedure thProcessa.Execute;
var success :boolean;
begin
     self.Priority := tpLowest;
     with Form1 do
     begin
          while not bCancelar do
          begin
               Synchronize(IncreaseNumber);
          end;
     end;
end;

procedure thProcessa.IncreaseNumber;
begin
     with Form1 do
     Edit1.Text := IntToStr(Succ(StrToInt(Edit1.Text)));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Self.Caption := 'Você pode cancelar o Loop';
     Edit1.Text := '1';
     Edit1.ReadOnly := True;
     Button1.Caption := 'Iniciar';
     Button2.Caption := 'Parar';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     bCancelar := False;
     thProcessa.Create;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     bCancelar := True;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
     bCancelar := False;
     while not bCancelar do
     begin
          Edit1.Text := inttostr(strtoint(Edit1.Text)+1);
          Edit1.Refresh;
     end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
     bCancelar := false;
end;

end.

