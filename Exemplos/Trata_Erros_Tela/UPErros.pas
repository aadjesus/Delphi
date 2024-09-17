unit UPErros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, bde, NumEdit, jpeg, ExtDlgs,

  Menus, DB, ComCtrls, ExtCtrls, Buttons, DBTables,
  DBIPROCS, DBITypes, DBIErrs, Gauges, ImgList, ToolWin ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    DateEdit1: TDateEdit;
    Button2: TButton;
    NumEdit1: TNumEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure NumEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    vErro : Boolean ;
    BitMap: TBitmap ;
    procedure ManipulaExcecoes(Sender: TObject; E: Exception);
    function CaptureScreenRect( ARect: TRect ): TBitmap;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.ManipulaExcecoes(Sender: TObject; E: Exception);
begin
  BitMap := TBitmap.Create;
  BitMap := CaptureScreenRect(Bounds(0, 0, Screen.Width, Screen.Height));
  BitMap.SaveToFile(ExtractFilePath(Application.ExeName) + 'erro.bmp');
  BitMap.Free ;

  vErro := True ;
  MessageDlg(E.Message + #13#13 +
             IntToStr(E.InstanceSize),mtError, [mbOK], 0) ;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.OnException := ManipulaExcecoes;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  StrToInt('ABCD');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  StrToDate('0') ;
end;

function TForm1.CaptureScreenRect( ARect: TRect ): TBitmap;
var
  ScreenDC: HDC;
begin
  Result := TBitmap.Create;
  with Result, ARect do
  begin
    Width := Right - Left;
    Height := Bottom - Top;
    ScreenDC := GetDC( 0 );
    try
      BitBlt( Canvas.Handle, 0, 0, Width, Height, ScreenDC, Left, Top, SRCCOPY );
    finally
      ReleaseDC( 0, ScreenDC );
    end;
  // Palette := GetSystemPalette;
  end;
end;


procedure TForm1.NumEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  ShowMessage(  Format('O código da tecla pressionada é: %d', [Key]) )
end;

end.

