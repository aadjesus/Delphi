unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    btnSalva: TButton;
    btnLer: TButton;
    Memo1: TMemo;
    procedure btnSalvaClick(Sender: TObject);
    procedure btnLerClick(Sender: TObject);
  private
    { Private declarations }
    function AttachToFile(const AFileName: String; MemoryStream: TMemoryStream): Boolean;
    function LoadFromFile(const AFileName: String; MemoryStream: TMemoryStream): Boolean;
  public
    { Public declarations }
  end;


var
  Form1: TForm1;


implementation

{$R *.dfm}

{ TForm1 }

function TForm1.AttachToFile(const AFileName: String;
  MemoryStream: TMemoryStream): Boolean;
var
aStream: TFileStream;
iSize: Integer;
begin
  Result := False;
  if not FileExists(AFileName) then
  Exit;
  try
  aStream := TFileStream.Create(AFileName, fmOpenWrite or fmShareDenyWrite);
  MemoryStream.Seek(0, soFromBeginning);
  // posiciona no final do arquivo.
  aStream.Seek(0, soFromEnd);
  // copia os dados para um Stream de memória.
  aStream.CopyFrom(MemoryStream, 0);
  // salva o “Stream-Size”
  iSize := MemoryStream.Size + SizeOf(Integer);
  aStream.Write(iSize, SizeOf(iSize));
  finally
  aStream.Free;
  end;
  Result := True;
end;

function TForm1.LoadFromFile(const AFileName: String;
  MemoryStream: TMemoryStream): Boolean;
var
aStream: TFileStream;
iSize: Integer;
begin
  Result := False;
  if not FileExists(AFileName) then
    Exit;

  try
    aStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);

    // posiciona para leitura da String recém gravada.
    aStream.Seek( - SizeOf(Integer), soFromEnd);
    aStream.Read(iSize, SizeOf(iSize));
    if iSize > aStream.Size then
    begin
      aStream.Free;
      Exit;
    end;
    // Carrega em um Stream de memória.
    aStream.Seek( - iSize, soFromEnd);
    MemoryStream.SetSize(iSize - SizeOf(Integer));
    MemoryStream.CopyFrom(aStream, iSize - SizeOf(iSize));
    MemoryStream.Seek(0, soFromBeginning);
  finally
    aStream.Free;
  end;
  Result := True;
end;


procedure TForm1.btnSalvaClick(Sender: TObject);
var
aStream: TMemoryStream;
begin
  aStream := TMemoryStream.Create;
  Memo1.Lines.SaveToStream(aStream);
  AttachToFile('Teste.exe', aStream);
  aStream.Free;
  Memo1.Clear;
end;

procedure TForm1.btnLerClick(Sender: TObject);
var
aStream: TMemoryStream;
begin
  aStream := TMemoryStream.Create;
  LoadFromFile('Teste.exe', aStream);
  Memo1.Lines.LoadFromStream(aStream);
  aStream.Free;
end;

end.



