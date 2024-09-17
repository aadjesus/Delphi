unit tela3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses fprincipal, funcuteis;

{$R *.dfm}

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DeletaItemMenu(FormPrincipal.Janelas1, FormPrincipal.ela31.Caption);
  //FechaJanela(FormPrincipal.Janelas1, FormPrincipal.ela31);
  FreeAndNil(Form4);
end;

procedure TForm4.FormActivate(Sender: TObject);
begin
  CriaItemMenu(FormPrincipal.Janelas1, FormPrincipal.ela31);
end;

end.
