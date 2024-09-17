unit UMostraOsExeAbertos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TLHelp32, Mask, ToolEdit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
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

procedure TForm1.Button1Click(Sender: TObject);
  procedure ListProcess(List: TStrings);
  var
    ProcEntry: TProcessEntry32;
    Hnd: THandle;
    Fnd: Boolean;

    Function UltimoA(pArq : String) : String ;
    Var
       ffd : TWin32FindData;
       dft : DWord;
       lft : TFileTime;
       h   : THandle;
    Begin
      pArq := ExtractFilePath(pArq) + pArq ;
      h := Windows.FindFirstFile(PChar(pArq), ffd);
      if(INVALID_HANDLE_VALUE <> h)then
      begin
        Windows.FindClose( h );
        FileTimeToLocalFileTime(ffd.ftLastAccessTime, lft );
        FileTimeToDosDateTime(lft,LongRec(dft).Hi, LongRec(dft).Lo);
        Result := DateTimeToStr(FileDateToDateTime(dft)) ;
      end;
    End ;

  begin
    List.Clear;
    Hnd := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
    if Hnd <> -1 then
    begin
      ProcEntry.dwSize := SizeOf(TProcessEntry32);
      Fnd := Process32First(Hnd, ProcEntry);
      while Fnd do
      begin
        List.Add(Copy(ProcEntry.szExeFile,1,50) +' '+ UltimoA(ProcEntry.szExeFile) );
        Fnd := Process32Next(Hnd, ProcEntry);
      end;
      CloseHandle(Hnd);
    end;
  end;
begin
  ListProcess(ListBox1.Items );
end;


end.




