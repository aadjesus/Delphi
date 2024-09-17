unit udesenhando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, WinProcs, RXCtrls, DB, RxMemDS, Grids,
  DBGrids, Menus, RXDBCtrl, Buttons, RxRichEd;

type
  TFrmCTR_EnviarEMailDaTela = class(TForm)
    DSTopicos: TDataSource;
    MDTopicos: TRxMemoryData;
    MDTopicosLEFT: TIntegerField;
    MDTopicosTOP: TIntegerField;
    MDTopicosWIDTH: TIntegerField;
    MDTopicosHEIGHT: TIntegerField;
    MDTopicosDESCRICAO: TStringField;
    MDTopicosCOMPONENT1: TStringField;
    MDTopicosCOMPONENT2: TStringField;
    MDTopicosCOMPONENT3: TStringField;
    MDTopicosNUMERO: TStringField;
    PnlImagemTela: TPanel;
    PnlAssunto: TPanel;
    LabAssunto: TLabel;
    EdtAssunto: TEdit;
    PnlBotoesEmail: TPanel;
    SButPrioridades: TSpeedButton;
    SButAnexar: TSpeedButton;
    PnlTpEmail: TPanel;
    Label1: TLabel;
    CBoxTipoEMail: TComboBox;
    PnlTexto: TPanel;
    REdtTexto: TRxRichEdit;
    PnlBotoes: TPanel;
    BBtnEnviar: TBitBtn;
    MainMenu1: TMainMenu;
    Saida: TMenuItem;
    PnlTopicos: TPanel;
    DbGridTopicos: TRxDBGrid;
    SBoxImagemTela: TScrollBox;
    ImageTela: TImage;
    PMenuTopicos: TPopupMenu;
    IMenuExcluir: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure ImageTelaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageTelaMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ImageTelaMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DbGridTopicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    vQtdeTopico    : String;
    vDesenhar,
    vDesenho       : Boolean ;
    vPosIni        : TPoint ;
    ShpTopico      : TShape;
    ShpNumTopico   : TShape;
    LblNumTopico   : TLabel;
  public
    { Public declarations }
  end;

var
  FrmCTR_EnviarEMailDaTela: TFrmCTR_EnviarEMailDaTela;

implementation

uses Types;

{$R *.dfm}

procedure TFrmCTR_EnviarEMailDaTela.FormShow(Sender: TObject);
begin
  DoubleBuffered:=True;
  MDTopicos.Open;
  MDTopicos.SortOnFields('NUMERO');
  SBoxImagemTela.VertScrollBar.Range := 280;
  SBoxImagemTela.HorzScrollBar.Range := 780;
end;

procedure TFrmCTR_EnviarEMailDaTela.ImageTelaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  Function RetornaProximoNumero(pProximo : Integer) : String;
  Begin
    Result := FormatFloat('00',pProximo + 1) ;
    If MDTopicos.Locate('COMPONENT1','ShpTopico'+Result,[]) Then
    begin
       MDTopicos.Last;
       Result := RetornaProximoNumero(StrToInt(Result));
    end;
  End;
begin
  vQtdeTopico := RetornaProximoNumero(MDTopicos.RecordCount);

  vDesenhar  := ssCtrl in Shift ;
  vDesenho   := false ;
  If vDesenhar And (MDTopicos.RecordCount <= 10) then
  Begin
    ImageTela.Cursor := crCross ;
    vPosIni := Point(X + ImageTela.Left ,y + ImageTela.Top) ;

    ShpTopico := TShape.Create(FrmCTR_EnviarEMailDaTela);
    With ShpTopico do
    Begin
      Left      := vPosIni.X;
      Top       := vPosIni.y;
      Parent    := SBoxImagemTela;
      Pen.Color := clRed;
      Pen.Mode  := pmMask;
      Pen.Style := psInsideFrame;
      Pen.Width := 2;
      Width     := 0;
      Height    := 0;
      Name      := 'ShpTopico' + vQtdeTopico;
      Tag       := StrToInt(vQtdeTopico);
    End; // with ShpTopico do

    ShpNumTopico := TShape.Create(FrmCTR_EnviarEMailDaTela);
    With ShpNumTopico do
    Begin
      Left        := ShpTopico.Left + 1;
      Top         := ShpTopico.Top + 1;
      Parent      := SBoxImagemTela;
      Brush.Color := clRed;
      Pen.Color   := clRed;
      Pen.Width   := 2;
      Width       := 0;
      Height      := 0;
      Name        := 'ShpNumTopico' + vQtdeTopico;
    End; // with ShpNumTopico do

    LblNumTopico := TLabel.Create(FrmCTR_EnviarEMailDaTela);
    With LblNumTopico do
    Begin
      Left       := ShpNumTopico.Left;
      Top        := ShpNumTopico.Top;
      Parent     := SBoxImagemTela;
      AutoSize   := False;
      Width      := 24;
      Height     := 17;
      Caption    := vQtdeTopico;
      Color      := clRed;
      Font.Style := [fsBold];
      Visible    := False;
      Alignment  := taCenter;
      Layout     := tlCenter;
      Name       := 'LblNumTopico' + vQtdeTopico;
    End; // with LblNumTopico do
  End; // If vDesenhar then
end;

procedure TFrmCTR_EnviarEMailDaTela.ImageTelaMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  If vDesenhar then
  Begin
    If ImageTela.Left+x > ShpTopico.Left then
    Begin
      ShpTopico.Width     := (ImageTela.Left+x)-ShpTopico.Left ;
      ShpNumTopico.Width  := (ImageTela.Left+x)-ShpNumTopico.Left ;
      vDesenho := true;
    End;

    If ImageTela.Top+y > ShpTopico.Top then
    Begin
      ShpTopico.Height    := (ImageTela.Top+y)-ShpTopico.Top ;
      ShpNumTopico.Height := (ImageTela.Top+y)-ShpNumTopico.Top ;
      vDesenho := true;
    End;

    If ShpNumTopico.Width  > 24 then ShpNumTopico.Width  := 24;
    If ShpNumTopico.Height > 17 then ShpNumTopico.Height := 17;
  End; // If vDesenhar then
end;

procedure TFrmCTR_EnviarEMailDaTela.ImageTelaMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If vDesenhar then
  Begin
    vDesenhar        := False ;
    ImageTela.Cursor := crDefault ;

    If (ShpTopico.Width < 24) Or (ShpTopico.Height < 17) Or (Not vDesenho) Then
    Begin
      ShpTopico.Destroy;
      ShpNumTopico.Destroy;
      LblNumTopico.Destroy;
      Exit;
    End; // If (ShpTopico.Width < 24) Or (...

    LblNumTopico.Visible := true;
    With MDTopicos do
    Begin
      Append;
      FieldByName('COMPONENT1').AsString  := ShpTopico.Name ;
      FieldByName('COMPONENT2').AsString  := ShpNumTopico.Name ;
      FieldByName('COMPONENT3').AsString  := LblNumTopico.Name ;
      FieldByName('NUMERO'    ).AsString  := FormatFloat('00',ShpTopico.Tag) ;
      FieldByName('LEFT'      ).AsInteger := ShpTopico.Left ;
      FieldByName('TOP'       ).AsInteger := ShpTopico.Top;
      FieldByName('WIDTH'     ).AsInteger := ShpTopico.Width;
      FieldByName('HEIGHT'    ).AsInteger := ShpTopico.Height;
      Post;
    End; // With MDTopicos do
  End; // If vDesenhar then
end;

procedure TFrmCTR_EnviarEMailDaTela.DbGridTopicosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (key = Vk_Delete) And (Not MDTopicos.IsEmpty) then
  Begin
    TShape( FindComponent( MDTopicos.FieldByName('COMPONENT1').AsString)).Destroy;
    TShape( FindComponent( MDTopicos.FieldByName('COMPONENT2').AsString)).Destroy;
    TLabel( FindComponent( MDTopicos.FieldByName('COMPONENT3').AsString)).Destroy;
    MDTopicos.Delete;
    If MDTopicos.IsEmpty Then
      vQtdeTopico := '00';
  End;
end;

end.

