unit tela2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses fprincipal, funcuteis;

{$R *.dfm}

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DeletaItemMenu(FormPrincipal.Janelas1, FormPrincipal.ela21.Caption);
  FreeAndNil(Form3);
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
  CriaItemMenu(FormPrincipal.Janelas1, FormPrincipal.ela21);
end;

end.
