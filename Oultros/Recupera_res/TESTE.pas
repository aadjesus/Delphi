unit TESTE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R aaa.res} 

procedure TForm1.Button1Click(Sender: TObject);
  Procedure RestauraArquivos(pNomeTp, pNomeArq : String) ;
  Var
    vArquivo :String ;
    Res : TResourceStream ;
  Begin
    vArquivo := ExtractFilePath(Application.ExeName) + pNomeArq  ;
    If FileExists(pNomeArq) Then
      DeleteFile(pNomeArq) ;
    Res := TResourceStream.Create(Hinstance, 'A', PChar(pNomeTp) );
    Try
      Res.SavetoFile(vArquivo) ;
    Finally
      Res.Free ;
    End;
  End ; // Procedure RestauraArquivos(pNomeDLL, pNomeTp : String ) ;

begin
  RestauraArquivos('DAL','DAL.DLL') ;
  RestauraArquivos('DTO','DTO.DLL') ;

//aaa1 DLLFILE BART.JPG
//aaa2 DLLFILE DIVER211.JPG
end;

end.
