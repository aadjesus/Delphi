unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ZipMstr, ShellApi, ZLib;

type
  TForm1 = class(TForm)
    Button2: TButton;
    Button5: TButton;
    Button1: TButton;
    ZipMaster1: TZipMaster;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
    Function CompactaArquivo(pArquivo : String ; pArquivoDestino : String=''; pMsg:Boolean=False  ) : Boolean ;
    Function DesCompactaArquivo(pArquivo : String ; pArquivoDestino : String='' ; pMsg:Boolean=False  ) : Boolean ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
Var
   SR : TSearchRec ;
   i, h : Integer ;
   vOrigem,
   vArquivos : String ;
   vLista    : TStringList ;
begin
  ZipMaster1.ZipFileName := 'C:\GLOBUS\BACKUP\a_' + FormatDateTime('DDMMYYYY_HHNN',Now) + '.Zip' ;
  ZipMaster1.FSpecArgs.Clear ;

  vLista   := TStringList.Create ;
  I := FindFirst('C:\GLOBUS\SISTEMAS\BANCOS\*.*', faAnyFile, SR) ;
  While I = 0 do
  begin
    If (SR.Name+' ')[1] = '.' then
    begin
      I := FindNext( SR ) ;
      Continue ;
    end;

    If Pos(UpperCase(ExtractFileExt(SR.Name)),'.RPT.SQL.EXE.DLL.TXT') > 0 Then
    begin
      ZipMaster1.FSpecArgs.Add('C:\GLOBUS\SISTEMAS\BANCOS\' + SR.Name) ;
      vLista.Add('C:\GLOBUS\SISTEMAS\BANCOS\' + SR.Name) ;
    End ;
    I := FindNext(SR) ;
  End ; // While I = 0 do
  ZipMaster1.Add ;
  FindClose(sr);

  For i := 0 to vLista.Count-1 do
  Begin
    FileSetAttr(vLista.Strings[i],0) ;
    If DeleteFile(vLista.Strings[i]) Then
      ShowMessage('ok') ;
  End ; //

  vLista.Free ;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  H : HWnd;
  function Executa (Arquivo : String; Estado : Integer) : Cardinal ;
  var
    Programa : array [0..512] of char;
    CurDir : array [0..255] of char;
    WorkDir : String;
    StartupInfo : TStartupInfo;
    ProcessInfo : TProcessInformation;
  begin
    StrPCopy (Programa, Arquivo);
    GetDir (0, WorkDir);
    StrPCopy (CurDir, WorkDir);
    FillChar (StartupInfo, Sizeof (StartupInfo), #0);
    StartupInfo.cb := sizeof (StartupInfo);
    StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartupInfo.wShowWindow := Estado;

    H := FindWindow(Nil,'Controle');
    ShowWindow(H,SW_HIDE);

    if not CreateProcess(nil, Programa, nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInfo) then
      Result := StrToInt('-1')
    Else
    begin
      WaitForSingleObject (ProcessInfo.hProcess, Infinite);
      GetExitCodeProcess (ProcessInfo.hProcess, Result);
    end;
  end;

begin

  WindowState := wsMinimized ;

  Executa ('C:\Globus\Sistemas\Controle\Controle.exe /ATUALIZACAO',0) ;


  ShowWindow(H,SW_SHOWNORMAL);
  WindowState := wsNormal ;
  ShowMessage('teste') ;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   ZipMaster1.ZipFileName := 'C:\Globus\DOWNLOAD\SQL.zip' ;
   If ZipMaster1.ZipFileName='' Then
     ShowMessage('erro');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  FileIni, FileOut: TFileStream;
  Zip: TCompressionStream;
begin
  FileIni:=TFileStream.Create('C:\Globus\Log_AcessoMenu.txt', fmOpenRead and fmShareExclusive);
  FileOut:=TFileStream.Create('C:\Globus\Log_AcessoMenu.2txt', fmCreate   or  fmShareExclusive);
  Zip := TCompressionStream.Create(clMax, FileOut);

  Zip.CopyFrom(FileIni, FileIni.Size);
  Zip.Free;
  FileOut.Free;
  FileIni.Free;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  FileIni, FileOut: TFileStream;
  DeZip: TDecompressionStream;
  i: Integer;
Buf: array[0..1023]of Byte;
begin
  FileIni:=TFileStream.Create('C:\Globus\Log_AcessoMenu.2txt', fmOpenRead and fmShareExclusive);
  FileOut:=TFileStream.Create('C:\Globus\Log_AcessoMenu.txt', fmCreate or fmShareExclusive);
  DeZip:=TDecompressionStream.Create(FileIni);
  repeat
  i:=DeZip.Read(Buf, SizeOf(Buf));
  if i <> 0 then FileOut.Write(Buf, i);
  until i <= 0;
  DeZip.Free;
  FileOut.Free;
  FileIni.Free;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
{

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
uses System.Security.Cryptography, System.Text; 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function Encriptar(const StringLimpa: string): string;
var
ue : UnicodeEncoding;
clearBytes, hashedBytes : array of Byte;
begin
ue := UnicodeEncoding.Create;
clearBytes := ue.GetBytes(StringLimpa) ;
hashedBytes := (CryptoConfig.CreateFromName('MD5') AS HashAlgorithm).ComputeHash(clearBytes) ;
Result := BitConverter.ToString(hashedBytes) ;

//Remover os "-"

Result := Result.Replace('-',System.String.Empty) ;
end; (* Encriptado *)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Como usar:

strVarEncriptada := Encriptar(‘Matheus Venâncio’);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


}
end;

function TForm1.CompactaArquivo(pArquivo : String ; pArquivoDestino : String=''; pMsg:Boolean=False  ) : Boolean ;
Var
  vArqMenuIni,
  vArqMenuOut     : TFileStream ;
  vCompacta       : TCompressionStream ;
  vArquivoDestino : String ;
begin
  Result := False ;
  If Not FileExists(pArquivo) Then
  Begin
    If pMsg Then
      ShowMessage('Arquivo (' + pArquivo + ') não encontrado.') ;
    Exit ;
  End ; // If Not FileExists(pArquivo) Then

  If pArquivo = pArquivoDestino Then
  Begin
    If pMsg Then
      ShowMessage('Arquivo destino ('+ pArquivoDestino +') não pode ser igual ao arquivo origem (' + pArquivo + ').') ;
    Exit ;
  End ; // If pArquivo = pArquivoDestino Then

  If FileExists(pArquivoDestino) Then
  Begin
    FileSetAttr(pArquivoDestino,0) ;
    If Not DeleteFile(pArquivoDestino) Then
    Begin
      If pMsg Then
        ShowMessage('Não foi possivel apagar o arquivo destino ('+ pArquivoDestino +').') ;
      Exit ;
    End ; // If Not DeleteFile(...
  End ; // If FileExists(...

  If pArquivoDestino='' then
    vArquivoDestino := pArquivo + '2'
  Else
    vArquivoDestino := pArquivoDestino ;

  Try
    vArqMenuIni := TFileStream.Create(pArquivo,        fmOpenRead and fmShareExclusive) ;
    vArqMenuOut := TFileStream.Create(vArquivoDestino, fmCreate   or  fmShareExclusive) ;

    vCompacta   := TCompressionStream.Create(clMax, vArqMenuOut) ;
    vCompacta.CopyFrom(vArqMenuIni, vArqMenuIni.Size);
    vCompacta.Free ;
    vArqMenuIni.Free ;
    vArqMenuOut.Free ;
  Except
    Begin
      If pMsg Then
        ShowMessage('Erro na compactação do arquivo.') ;
      Exit ;
    End ;
  End ; // Try - Except

  FileSetAttr(vArquivoDestino,1) ;
  If pArquivoDestino='' Then
  Begin
    FileSetAttr(pArquivo,0) ;
    If (Not DeleteFile(pArquivo)) Or
       (Not RenameFile (vArquivoDestino, pArquivo)) Then
    Begin
      If pMsg Then
        ShowMessage('Não foi possivel atualizar o arquivo origem ('+ pArquivo +').') ;
      Exit ;
    End ; // If (Not DeleteFile(...
  End ; // If pArquivoDestino='' Then

  Result := True ;
end;

function TForm1.DesCompactaArquivo(pArquivo : String ; pArquivoDestino : String='' ; pMsg:Boolean=False  ) : Boolean ;
var
  i: Integer;
  vBuf  : array[0..1023] of Byte ;
  vArqMenuIni,
  vArqMenuOut     : TFileStream ;
  vDesCompacta    : TDecompressionStream;
  vArquivoDestino : String ;
begin
  Result := False ;
  If Not FileExists(pArquivo) Then
  Begin
    If pMsg Then
      ShowMessage('Arquivo (' + pArquivo + ') não encontrado.') ;
    Exit ;
  End ; // If Not FileExists(pArquivo) Then

  If pArquivo = pArquivoDestino Then
  Begin
    If pMsg Then
      ShowMessage('Arquivo destino ('+ pArquivoDestino +') não pode ser igual ao arquivo origem (' + pArquivo + ').') ;
    Exit ;
  End ; // If pArquivo = pArquivoDestino Then

  If FileExists(pArquivoDestino) Then
  Begin
    FileSetAttr(pArquivoDestino,0) ;
    If Not DeleteFile(pArquivoDestino) Then
    Begin
      If pMsg Then
        ShowMessage('Não foi possivel apagar o arquivo destino ('+ pArquivoDestino +').') ;
      Exit ;
    End ; // If Not DeleteFile(...
  End ; // If FileExists(...

  If pArquivoDestino='' then
    vArquivoDestino := pArquivo + '2'
  Else
    vArquivoDestino := pArquivoDestino ;

  Try
    vArqMenuIni  := TFileStream.Create(pArquivo,        fmOpenRead and fmShareExclusive);
    vArqMenuOut  := TFileStream.Create(vArquivoDestino, fmCreate   or  fmShareExclusive);
    vDesCompacta :=TDecompressionStream.Create(vArqMenuIni) ;
    Repeat
      i := vDesCompacta.Read(vBuf, SizeOf(vBuf));
      If i <> 0 then
        vArqMenuOut.Write(vBuf, i);
    Until i <= 0 ;
    vDesCompacta.Free;
    vArqMenuOut.Free ;
    vArqMenuIni.Free ;
  Except
    Begin
      If pMsg Then
        ShowMessage('Erro na compactação do arquivo.') ;
      Exit ;
    End ;
  End ; // Try - Except

  FileSetAttr(vArquivoDestino,1) ;
  If pArquivoDestino='' Then
  Begin
    FileSetAttr(pArquivo,0) ;
    If (Not DeleteFile(pArquivo)) Or
       (Not RenameFile (vArquivoDestino, pArquivo)) Then
    Begin
      If pMsg Then
        ShowMessage('Não foi possivel atualizar o arquivo origem ('+ pArquivo +').') ;
      Exit ;
    End ; // If (Not DeleteFile(...
  End ; // If pArquivoDestino='' Then

  Result := True ;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  If CompactaArquivo('Log_AcessoMenu.txt','',True) Then
    ShowMessage('Ok.')
  Else
    ShowMessage('Erro') ;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  If DesCompactaArquivo('Log_AcessoMenu.txt','',True) Then
    ShowMessage('Ok.')
  Else
    ShowMessage('Erro') ;
end;

end.
