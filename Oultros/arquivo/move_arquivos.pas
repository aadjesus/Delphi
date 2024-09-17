unit move_arquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
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
  function ProcessArquivo(const Origem, Destino : string; Operacao, Modo:Integer) : Boolean;
  // Requer a unit ShellApi na clausula uses da unit
  Const
    Aborted : Boolean = False;
  var
    shfo : TSHFileOpStruct ;
  begin
    FillChar(shfo,SizeOf(shfo),$0);
    with shfo do
    begin
      if Operacao > 2 then
      begin
        operacao := 2;
      end;

      if Modo > 5 then
      begin
        modo := 1;
      end;

      case operacao of
        1: wFunc := FO_MOVE;
        2: wFunc := FO_COPY;
      end;

      pFrom := Pchar(Origem);
      pTo := Pchar(Destino);

      case Modo of
        1: fFlags := FOF_SILENT;
        2: fFlags := FOF_ALLOWUNDO or FOF_FILESONLY;
        3: fFlags := FOF_RENAMEONCOLLISION;
        4: fFlags := FOF_NOCONFIRMATION;
        5: fFlags := FOF_SIMPLEPROGRESS;
      end;
    end;
    Result := (SHFileOperation(shfo)= 0) and (not Aborted);
  end;

begin
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  SR: TSearchRec;
  I: integer;
  Origem, Destino: string;
begin
  I := FindFirst('c:\Globus\Aplicativos\AtualizaModulo\*.Exe', faAnyFile, SR);
  While I = 0 do begin
    if (SR.Attr and faDirectory) <> faDirectory then
    begin
      Origem := 'c:\Globus\Aplicativos\AtualizaModulo\' + SR.Name ;

      Destino := 'c:\Globus\Aplicativos\' + SR.Name ;
      If CopyFile(PChar(Origem), PChar(Destino), true) then
        DeleteFile(Origem) ;
    End ;

    I := FindNext(SR);
  End;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Dados: TSHFileOpStruct;
begin
  FillChar(Dados,SizeOf(Dados), 0);
  with Dados do
  begin
    wFunc := FO_COPY;
    pFrom := PChar('C:\Globus\Aplicativos\AtualizaModulo\*.Exe') ;
    pTo   := PChar('C:\Globus\Aplicativos\') ;
    fFlags:= FOF_ALLOWUNDO ;
  end;
  SHFileOperation(Dados);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
destino : String ;
begin
  destino := 'C:\Globus\BACKUP\' + FormatDateTime('yyyymmdd', date) ;
  RenameFile('c:\Globus\Aplicativos\AtualizaModulo',destino)
end;

procedure TForm1.Button5Click(Sender: TObject);
begin

    ChDir('C:\GLOBUS\') ;
    CreateDir('DOWNLOAD') ;

    CreateDir('BACKUP') ;
    CreateDir('BACKUP\SISTEMAS') ;
    CreateDir('BACKUP\SISTEMAS\' + FormatDateTime('yyyymmdd', date)) ;

end;

end.
