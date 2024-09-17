unit tela1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;


implementation

Uses
   FuncUteis, fprincipal;

{$R *.dfm}

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DeletaItemMenu(FormPrincipal.Janelas1, FormPrincipal.ela11.Caption);
  FreeAndNil(Form2);
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
  CriaItemMenu(FormPrincipal.Janelas1, FormPrincipal.ela11);
end;

end.
