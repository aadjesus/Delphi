unit CNTApresentacao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TCNTFormApresentacao = class(TForm)
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CNTFormApresentacao: TCNTFormApresentacao;

implementation

{$R *.DFM}

//------- Evento OnActivate ------------------------------\\
procedure TCNTFormApresentacao.FormActivate(Sender: TObject);
var I : Integer;
begin
{
  For i := 1 to 600 do
  Begin
     //Sleep(1000) ; Estara 1 segungo
      Left := Left-1 ;
  End;
 }
end;

end.
