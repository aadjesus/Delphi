unit Encontra_Hint_Na_Tela_U;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, StdCtrls, Buttons, Mask, NumEdit, TimeEdit,
  Grids, DBGrids;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    GroupBox1: TGroupBox;
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    Button1: TButton;
    DBGrid1: TDBGrid;
    TimeEdit1: TTimeEdit;
    NumEdit1: TNumEdit;
    MaskEdit1: TMaskEdit;
    SpeedButton1: TSpeedButton;
    BitBtn1: TBitBtn;
    ControlBar1: TControlBar;
    PageScroller1: TPageScroller;
    TreeView1: TTreeView;
    Memo1: TMemo;
    Image1: TImage;
    ToolBar1: TToolBar;
    CoolBar1: TCoolBar;
    ListView1: TListView;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormShow(Sender: TObject);
Var
  v,
  vTop,
  vLeft  : integer ;
  vImage : TImage ;
  vPanel : TPanel ;
  Procedure CriaIdendificadorDeHint ;
  Var a,b : integer ;
  Begin
    // Cria um componente panel
    vPanel := TPanel.Create(Nil) ;
    vPanel.BevelOuter := bvNone ;
    vPanel.Height := 04 ;
    vPanel.Width  := 04 ;

    // Cria um componente image p/ desenhar o triangulo dentro
    vImage := TImage.Create(Nil) ;
    vImage.Parent      := vPanel ;
    vImage.Align       := alClient ;
    vImage.Transparent := True ;

    // Desenha um triangulo no image
    For a := 0 to vImage.Width do
      For b := 0 to vImage.Width do
        vImage.Canvas.Pixels[b,vImage.Top+b-a] := clRed ;
  End ;
Begin

  With TForm(Sender) do
  Begin
    For v := 0 to ComponentCount - 1 do
    Begin
      If (Components[v] Is TWinControl)                And
         (TWinControl(Components[v]).ShowHint)         And
         (Trim(TWinControl(Components[v]).Hint) <> '') Then
      Begin
        CriaIdendificadorDeHint ;

        TWinControl(Components[v]).Hint := TWinControl(Components[v]).ClassName ;
        vPanel.Parent := TWinControl(Components[v]).Parent ;

        // Quando for um TGROUPBOX ou TRADIOGROUP desce + 3 p/ o identificador ficar dentro do quadro
        vTop := TWinControl(Components[v]).Top+1 ;
        If (Components[v] Is TGroupBox) Or (Components[v] Is TRadioGroup) Then
          vTop := vTop+4 ;

        // Posiciona o panel no canto superior esquerdo do componente
        vPanel.Top   := vTop ;
        vPanel.Left  := TWinControl(Components[v]).Left+TWinControl(Components[v]).Width-6 ;
        vPanel.Color := TWinControl(Components[v]).Brush.Color ;
        vPanel.Hint  := TWinControl(Components[v]).Hint ;
        vPanel.ShowHint := True ;
      End Else // If (Components[v] Is TWinControl) And (...
      If (Components[v] Is TGraphicControl)                And
         (TGraphicControl(Components[v]).ShowHint)         And
         (Trim(TGraphicControl(Components[v]).Hint) <> '') Then
      Begin
        CriaIdendificadorDeHint ;
        vPanel.Parent := TGraphicControl(Components[v]).Parent ;
        TGraphicControl(Components[v]).Hint := TGraphicControl(Components[v]).ClassName ;

        // Quando for um LABEL o identificador vai ficar do lado do componente p/ ficar encima da ultima letra
        vLeft := TGraphicControl(Components[v]).Left+TGraphicControl(Components[v]).Width-7 ;
        If Components[v] Is TLabel Then
          vLeft := vLeft + vPanel.Width ;

        // Posiciona o panel no canto superior esquerdo do componente
        vPanel.Top   := TGraphicControl(Components[v]).Top+1 ;
        vPanel.Left  := vLeft ;
        vPanel.Hint  := TGraphicControl(Components[v]).Hint ;
        vPanel.ShowHint := True ;
      End ; // If (Components[v] Is TGraphicControl) And (...

    End ; // For i := 0 to ComponentCount - 1 do
  End ; // With TForm(Sender) do
End ;


end.
