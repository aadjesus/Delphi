unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ZipMstr;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ZipMaster1: TZipMaster;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ZipMaster1Progress(Sender: TObject; ProgrType: ProgressType;
      Filename: String; FileSize: Integer);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
//{$R ZipMsgxx.RES}

procedure TForm1.Button1Click(Sender: TObject);
begin
  ZipMaster1.ZipFileName := 'C:\Globus\DOWNLOAD\BCO.zip' ;
  ZipMaster1.ExtrBaseDir := 'C:\' ;
  ZipMaster1.Extract ;
end;

procedure TForm1.Button2Click(Sender: TObject);
const
  vTpArq : Array[0..4] of String = ('RPT','SQL','EXE','DLL','TXT') ;
  vDir   : Array[0..2] of String = ('\REPORT','\SCRIPTS','') ;
Var
  l,h,i     : Integer ;
  SR        : TSearchRec ;
  vOrigem,
  vArquivos : String ;
begin
  ZipMaster1.ZipFileName := 'C:\Globus\DOWNLOAD\BCO.zip' ;
  ZipMaster1.FSpecArgs.Clear ;

  For l := 2 downto 0 do // Diretorio do sistema e sub-diretorios
  Begin
    vOrigem  := 'C:\GLOBUS\SISTEMAS\BANCOS' + vDir[l] ;
    For h := 4 downto 0 do // Tipos de arquivos
    Begin
      vArquivos := vOrigem + '\*.' + vTpArq[h] ;
      I := FindFirst(vArquivos  , faAnyFile, SR);
      While I = 0 do
      begin
        If (SR.Attr and faDirectory) <> faDirectory then
          ZipMaster1.FSpecArgs.Add(vOrigem +'\'+ SR.Name) ;
        I := FindNext(SR) ;
      End ; // While I = 0 do
    End ; // For h := 4 downto 0 do
  End ; // For l := 2 downto 0 do
  ZipMaster1.Add ;

end;

procedure TForm1.ZipMaster1Progress(Sender: TObject;
  ProgrType: ProgressType; Filename: String; FileSize: Integer);
var
    vOrigem,
    vDestino : String ;
begin
  If Pos('FTPHOST.INI',UpperCase(Filename)) > 0 Then
  Begin
    ShowMessage( 'Filename: ' + Filename ) ;
    vOrigem  := Filename ;
    vDestino := ExtractFileDir(Filename) + '\FTPHOST.old' ;

    CopyFile(PChar(vOrigem),PChar(vDestino),True);
  End ;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ZipMaster1.ZipFileName := 'C:\Documents and Settings\Alessandro.augusto\Meus documentos\Particular\Delphi\LIXO\d\tests.zip' ;
  ZipMaster1.ExtrBaseDir := 'C:\Documents and Settings\Alessandro.augusto\Meus documentos\Particular\Delphi\LIXO\d\' ;
  ZipMaster1.Extract ;
end;

end.


