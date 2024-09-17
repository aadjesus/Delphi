unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, Wordcap;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Edit1: TEdit;
    Edit4: TEdit;
    Edit2: TEdit;
    Edit5: TEdit;
    Edit3: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    MSOfficeCaption1: TMSOfficeCaption;
    Panel2: TPanel;
    procedure Edit1Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1 : TForm1;

implementation

Uses
  Funcoes, Unit2 ;

{$R *.DFM}


procedure TForm1.Edit1Exit(Sender: TObject);
begin
  ShowMessage(TComponent(Sender).Name ) ;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  AttribuPanel('xxxx',@Panel1) ;
end;

end.
