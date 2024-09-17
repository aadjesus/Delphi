unit UPanelForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Panel1.BeginDrag(true) ;
  Panel1.EndDrag(true) ;
end;

procedure TForm1.FormCreate(Sender: TObject);
//var   hR : THandle;
begin
   {cria uma Região elíptica}
//   hR := CreateEllipticRgn(0,0,100,200);
//   SetWindowRgn(Handle,hR,True);

end;

end.
