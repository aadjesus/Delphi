unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, FileCtrl, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    DriveComboBox: TDriveComboBox;
    DirectoryListBox: TDirectoryListBox;
    Panel8: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    FListBoxArquivos: TFileListBox;
    BitBtnDescompactar: TBitBtn;
    BitBtnCompactar: TBitBtn;
    CheckBox1: TCheckBox;
    procedure BitBtnCompactarClick(Sender: TObject);
    procedure BitBtnDescompactarClick(Sender: TObject);
    procedure FListBoxArquivosDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

Uses ZLib ;

{$R *.dfm}

procedure TForm1.BitBtnCompactarClick(Sender: TObject);
Var
  vArqMenuIni,
  vArqMenuOut     : TFileStream ;
  vCompacta       : TCompressionStream ;
  vArquivoDestino : String ;
begin
  If Not FileExists(FListBoxArquivos.FileName) Then
  Begin
    ShowMessage('Arquivo (' + FListBoxArquivos.FileName + ') não encontrado.') ;
    Exit ;
  End ; // If Not FileExists(FListBoxArquivos.FileName) Then

  vArquivoDestino := Copy(FListBoxArquivos.FileName,1,Pos('.',FListBoxArquivos.FileName)-1) + '.Nov' ;
  If FileExists(vArquivoDestino) Then
  Begin
    FileSetAttr(vArquivoDestino,0) ;
    If Not DeleteFile(vArquivoDestino) Then
    Begin
      ShowMessage('Não foi possivel apagar o arquivo destino ('+ vArquivoDestino +').') ;
      Exit ;
    End ; // If Not DeleteFile(...
  End ; // If FileExists(...

  Try
    vArqMenuIni := TFileStream.Create(FListBoxArquivos.FileName,        fmOpenRead and fmShareExclusive) ;
    vArqMenuOut := TFileStream.Create(vArquivoDestino, fmCreate   or  fmShareExclusive) ;

    vCompacta   := TCompressionStream.Create(clMax, vArqMenuOut) ;
    vCompacta.CopyFrom(vArqMenuIni, vArqMenuIni.Size);
    vCompacta.Free ;
    vArqMenuIni.Free ;
    vArqMenuOut.Free ;
  Except
    Begin
      ShowMessage('Erro na compactação do arquivo.') ;
      Exit ;
    End ;
  End ; // Try - Except

  FileSetAttr(vArquivoDestino,1) ;
  If Not CheckBox1.Checked Then
  Begin
    FileSetAttr(FListBoxArquivos.FileName,0) ;
    If (Not DeleteFile(FListBoxArquivos.FileName)) Or
       (Not RenameFile (vArquivoDestino, FListBoxArquivos.FileName)) Then
      ShowMessage('Não foi possivel atualizar o arquivo origem ('+ FListBoxArquivos.FileName +').') ;
  End ; // If vArquivoDestino='' Then
  FListBoxArquivos.Refresh ;
end;

procedure TForm1.BitBtnDescompactarClick(Sender: TObject);
var
  i: Integer;
  vBuf  : array[0..1023] of Byte ;
  vArqMenuIni,
  vArqMenuOut     : TFileStream ;
  vDesCompacta    : TDecompressionStream;
  vArquivoDestino : String ;
begin
  If Not FileExists(FListBoxArquivos.FileName) Then
  Begin
    ShowMessage('Arquivo (' + FListBoxArquivos.FileName + ') não encontrado.') ;
    Exit ;
  End ; // If Not FileExists(FListBoxArquivos.FileName) Then

  vArquivoDestino := Copy(FListBoxArquivos.FileName,1,Pos('.',FListBoxArquivos.FileName)-1) + '.Vel' ;
  If FileExists(vArquivoDestino) Then
  Begin
    FileSetAttr(vArquivoDestino,0) ;
    If Not DeleteFile(vArquivoDestino) Then
    Begin
      ShowMessage('Não foi possivel apagar o arquivo destino ('+ vArquivoDestino +').') ;
      Exit ;
    End ; // If Not DeleteFile(...
  End ; // If FileExists(...

  Try
    vArqMenuIni  := TFileStream.Create(FListBoxArquivos.FileName,        fmOpenRead and fmShareExclusive);
    vArqMenuOut  := TFileStream.Create(vArquivoDestino, fmCreate   or  fmShareExclusive);
    vDesCompacta := TDecompressionStream.Create(vArqMenuIni) ;
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
      ShowMessage('Erro na descompactação do arquivo.') ;
      Exit ;
    End ;
  End ; // Try - Except

  FileSetAttr(vArquivoDestino,1) ;
  If Not CheckBox1.Checked Then
  Begin
    FileSetAttr(FListBoxArquivos.FileName,0) ;
    If (Not DeleteFile(FListBoxArquivos.FileName)) Or
       (Not RenameFile (vArquivoDestino, FListBoxArquivos.FileName)) Then
      ShowMessage('Não foi possivel atualizar o arquivo origem ('+ FListBoxArquivos.FileName +').') ;
  End ; // If vArquivoDestino='' Then
  FListBoxArquivos.Refresh ;
end;

procedure TForm1.FListBoxArquivosDblClick(Sender: TObject);
begin
  Try
    WinExec(PChar('NOTEPAD.EXE ' + FListBoxArquivos.FileName),SW_MAXIMIZE) ;
  Except
    ShowMessage('Não foi possível abrir o arquivo.') ;
  End ; // Try - Except
end;

end.
