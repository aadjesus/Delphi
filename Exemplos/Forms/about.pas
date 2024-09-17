unit about;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormAbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation

uses fprincipal, funcuteis;

{$R *.dfm}

procedure TFormAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DeletaItemMenu(FormPrincipal.Janelas1, FormPrincipal.Sobreosistema1.Caption);
  FreeAndNil(FormAbout);
end;

procedure TFormAbout.FormActivate(Sender: TObject);
begin
  CriaItemMenu(FormPrincipal.Janelas1, FormPrincipal.Sobreosistema1);
end;

end.
