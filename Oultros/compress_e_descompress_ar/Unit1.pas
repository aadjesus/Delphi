unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ZLib;

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

var
FileIni, FileOut: TFileStream;
Zip: TCompressionStream;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FileIni:=TFileStream.Create('c:\Globus\Sistemas\Acidentes\ACDCadastroAcidentes.pas', fmOpenRead and fmShareExclusive);
  FileOut:=TFileStream.Create('c:\Globus\Sistemas\Acidentes2\ACDCadastroAcidentes.pas', fmCreate or fmShareExclusive);
  Zip:=TCompressionStream.Create(clMax, FileOut);
  Zip.CopyFrom(FileIni, FileIni.Size);
  Zip.Free;
  FileOut.Free;
  FileIni.Free;
end;

end.
{
procedure TForm1.CompressãoClick(Sender: TObject);
var
FileIni, FileOut: TFileStream;
Zip: TCompressionStream;
begin
FileIni:=TFileStream.Create('C:\pasta\...arquivo a ser comprimido...', fmOpenRead and fmShareExclusive);
FileOut:=TFileStream.Create('C:\pasta\...arquivo comprimido...', fmCreate or fmShareExclusive);
Zip:=TCompressionStream.Create(clMax, FileOut);
Zip.CopyFrom(FileIni, FileIni.Size);
Zip.Free;
FileOut.Free;
FileIni.Free;
end;

procedure TForm1.DescompressãoClick(Sender: TObject);
var
FileIni, FileOut: TFileStream;
DeZip: TDecompressionStream;
i: Integer;
Buf: array[0..1023]of Byte;
begin
FileIni:=TFileStream.Create('C:\pasta\...arquivo comprimido...', fmOpenRead and fmShareExclusive);
FileOut:=TFileStream.Create('C:\pasta\...arquivo descomprimido...', fmCreate or fmShareExclusive);
DeZip:=TDecompressionStream.Create(FileIni);
repeat
i:=DeZip.Read(Buf, SizeOf(Buf));
if i <> 0 then FileOut.Write(Buf, i);
until i <= 0;
DeZip.Free;
FileOut.Free;
FileIni.Free;
end;

}
