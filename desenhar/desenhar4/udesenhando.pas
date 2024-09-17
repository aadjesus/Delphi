unit udesenhando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, WinProcs, RXCtrls, DB, RxMemDS, Grids,
  DBGrids, Menus;

type
  TForm1 = class(TForm)
    Image1: TImage;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1NUMERO: TIntegerField;
    RxMemoryData1LEFT: TIntegerField;
    RxMemoryData1TOP: TIntegerField;
    RxMemoryData1WIDTH: TIntegerField;
    RxMemoryData1HEIGHT: TIntegerField;
    RxMemoryData1DESCRICAO: TStringField;
    RxMemoryData1COMPONENT1: TStringField;
    RxMemoryData1COMPONENT2: TStringField;
    RxMemoryData1COMPONENT3: TStringField;
    Panel1: TPanel;
    ScrollBar1: TScrollBar;
    procedure FormShow(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    vDesenhar,
    vDesenho,
    vDesenhando    : Boolean ;
    vPosIni     : TPoint ;
    vQtdeMarca  : integer;
    ShpMarca    : TShape;
    ShpNumMarca : TShape;
    LblNumMarca : TLabel;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Types;

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  DoubleBuffered:=True;
  RxMemoryData1.Open;
  vQtdeMarca :=  0;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  vDesenhar := ssCtrl in Shift ;
  vDesenho  := false ;
  vDesenhando := vDesenhar;
  If vDesenhar then
  Begin
    Image1.Cursor := crCross ;
    vPosIni := Point(X + Image1.Left ,y + Image1.Top) ;
  End ; // If vDesenhar then
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  vWidth,
  vHeight : Integer;
  procedure CriaComponentesMarca;
  begin
    Inc(vQtdeMarca);
    ShpMarca := TShape.Create(Form1);
    with ShpMarca do
    begin
      Left := vPosIni.X ;
      Top  := vPosIni.y ;
      Parent := Form1 ;
      Pen.Color := clRed;
      Pen.Mode := pmMask;
      Pen.Style := psInsideFrame;
      Pen.Width := 2;
      Width := 0;
      Height := 0;
      Name := 'ShpMarca' + IntToStr(vQtdeMarca);
    end;

    ShpNumMarca := TShape.Create(Form1);
    with ShpNumMarca do
    begin
      Left := ShpMarca.Left + 1;
      Top := ShpMarca.Top + 1;
      Parent := Form1;
      Brush.Color := clRed;
      Pen.Color := clRed;
      Pen.Width := 2;
      Width := 0;
      Height := 0;
      Name := 'ShpNumMarca' + IntToStr(vQtdeMarca);
    end;

    LblNumMarca := TLabel.Create(Form1);
    with LblNumMarca do
    begin
      Left := ShpNumMarca.Left;
      Top := ShpNumMarca.Top;
      Parent := Form1;
      AutoSize := False;
      Width := 24;
      Height := 17;
      Caption := IntToStr(vQtdeMarca);
      Color := clRed;
      Font.Style := [fsBold];
      Visible := False;
      Alignment := taCenter;
      Layout := tlCenter;
      Name := 'LblNumMarca' + IntToStr(vQtdeMarca);
    end;
  end;
begin
  If vDesenhar then
  begin
    vDesenho := (Image1.Left+x > vPosIni.X) Or
                (Image1.Top+y  > vPosIni.X);

    if vDesenho then
    begin
      if vDesenhando then
      Begin
        CriaComponentesMarca;
        vDesenhando := false;
      end;

      if Image1.Left+x > vPosIni.X then
      begin
        ShpMarca.Width     := (Image1.Left+x)-ShpMarca.Left ;
        ShpNumMarca.Width  := (Image1.Left+x)-ShpNumMarca.Left ;
      end;

      if Image1.Top+y > vPosIni.X then
      begin
        ShpMarca.Height    := (Image1.Top+y)-ShpMarca.Top ;
        ShpNumMarca.Height := (Image1.Top+y)-ShpNumMarca.Top ;
      end;

      if ShpNumMarca.Width  > 24 then ShpNumMarca.Width  := 24;
      if ShpNumMarca.Height > 17 then ShpNumMarca.Height := 17;
    end ;

  end;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If vDesenhar then
  Begin
    vDesenhar       := False ;
    Image1.Cursor   := crDefault ;

    LblNumMarca.Visible := vDesenho;
    inc(vQtdeMarca);

    If vDesenho Then
      with  RxMemoryData1 do
      begin
        Append;
        FieldByName('COMPONENT1').AsString := ShpMarca.Name ;
        FieldByName('COMPONENT2').AsString := ShpNumMarca.Name ;
        FieldByName('COMPONENT3').AsString := LblNumMarca.Name ;
        FieldByName('NUMERO').AsInteger := vQtdeMarca ;
        FieldByName('LEFT').AsInteger := ShpMarca.Left ;
        FieldByName('TOP').AsInteger := ShpMarca.Top;
        FieldByName('WIDTH').AsInteger := ShpMarca.Width;
        FieldByName('HEIGHT').AsInteger := ShpMarca.Height;
        Post;
      end;
  End ; // If vDesenhar then
end;

procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = Vk_Delete then
  begin
    TShape( FindComponent( RxMemoryData1.FieldByName('COMPONENT1').AsString)).Destroy;
    TShape( FindComponent( RxMemoryData1.FieldByName('COMPONENT2').AsString)).Destroy;
    TLabel( FindComponent( RxMemoryData1.FieldByName('COMPONENT3').AsString)).Destroy;
    RxMemoryData1.Delete;
    if RxMemoryData1.RecordCount = 0 then
      vQtdeMarca := 0;
  end;
end;

end.

