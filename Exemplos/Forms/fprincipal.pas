unit fprincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls;

type
  TFormPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Janelas1: TMenuItem;
    Sobre1: TMenuItem;
    ela11: TMenuItem;
    ela21: TMenuItem;
    ela31: TMenuItem;
    Sobreosistema1: TMenuItem;
    Label1: TLabel;
    procedure ela11Click(Sender: TObject);
    procedure ela21Click(Sender: TObject);
    procedure ela31Click(Sender: TObject);
    procedure Sobreosistema1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses tela1, tela2, tela3, about, funcuteis;

{$R *.dfm}


procedure TFormPrincipal.ela11Click(Sender: TObject);
begin
   if not assigned(Form2) Then  // se o form não foi criado, cria-se
      Application.CreateForm(tform2, form2);

   CriaItemMenu(Janelas1, ela11);
   Form2.Show;
end;

procedure TFormPrincipal.ela21Click(Sender: TObject);
begin
   if not assigned(Form3) Then // se o form não foi criado, cria-se
      Application.CreateForm(tform3, form3);

   CriaItemMenu(Janelas1, ela21);
   Form3.Show;
end;

procedure TFormPrincipal.ela31Click(Sender: TObject);
begin
   if not assigned(Form4) Then // se o form não foi criado, cria-se
      Application.CreateForm(tform4, form4);
   CriaItemMenu(Janelas1, ela31);
   Form4.Show;
end;

procedure TFormPrincipal.Sobreosistema1Click(Sender: TObject);
begin
   if not assigned(FormAbout) Then // se o form não foi criado, cria-se
      Application.CreateForm(tFormAbout, FormAbout);

   CriaItemMenu(Janelas1, Sobreosistema1);
   FormAbout.Show;
end;

end.
