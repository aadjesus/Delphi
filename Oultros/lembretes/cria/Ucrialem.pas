unit Ucrialem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus;

type
  TForm1 = class(TForm)
    Button1: TButton;
    vPanelAux: TPanel;
    PopupMenu1: TPopupMenu;
    asdas1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  vQtdeLembretes : integer ;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
  Var
    vShapeLembrete : TShape ;
    vPnlLembrete   : TPanel ;
    vLblLembrete   : TLabel ;
    vMemoLembrete  : TMemo ;
    vBvlLembrete   : TBevel ;
    i,
    vLeft,
    vTop           : Integer ;
begin
    vQtdeLembretes := 0 ;
    vLeft          := 0 ;
    vTop           := 0 ;
    For i := 0 to vPanelAux.ControlCount-1 do
      If (vPanelAux.Controls[i] Is TShape) And
         (Pos('vShapeLembrete_',vPanelAux.Controls[i].Name) > 0) Then
      Begin
        Inc(vQtdeLembretes) ;
        inc(vLeft) ;
        If (vLeft mod 3) = 0 Then
        Begin
          vLeft := 0 ;
          Inc(vTop) ;
        End ; // If IncInt(vLeft) = 3 Then
      End ; // If (Components[i] Is TShape) And (...

    vShapeLembrete := TShape.Create(Self) ;
    With vShapeLembrete do
    Begin
      Parent      := vPanelAux ;
      Left        := vPanelAux.Left + 5 + (vLeft * Width ) + (vLeft * 5) ;
      Top         := vPanelAux.Top  + 5 + (vTop  * Height) + (vTop  * 5) ;
      Shape       := stRoundRect ;
      Width       := 310 ;
      Height      := 90  ;
      Name        := 'vShapeLembrete_' + inttostr(vQtdeLembretes) ;
//      Brush.Color := clYellow ;
      Color := clYellow ;
      PopupMenu   := PopupMenu1 ;

      vPnlLembrete  := TPanel.Create(Self) ;
      With vPnlLembrete do
      Begin
        Parent     := vPanelAux ;
        Left       := vShapeLembrete.Left + 4 ;
        Top        := vShapeLembrete.Top  + 4 ;
        Width      := 300 ;
        Height     := 83 ;
        BevelOuter := bvNone ;
        Color      := clYellow ;
        Name       := 'vPnlLembrete_' + inttostr(vQtdeLembretes) ;
        Font.Size  := 8 ;
        Font.Name  := 'MS Sans Serif' ;
        Font.Style := [] ;
//        PopupMenu  := FPMenuGeral ;
enabled := False ;
      ShowHint    := true ;
        BringToFront ;

        vLblLembrete := TLabel.Create(Self) ;
        With vLblLembrete do
        Begin
          Parent  := vPnlLembrete ;
          Align   := alTop ;
          Caption := 'cabe' ;
//          Color   := clYellow ;
          Name    := 'vLblLembrete_' + inttostr(vQtdeLembretes) ;
          ParentShowHint  := true ;
      hint        := 'Atenção : 01/01/2006' + #13 +
                     'Validade: 01/01/2006' ;

        	ParentColor := True ;
        End ; // With vLblLembrete do

        vBvlLembrete := TBevel.Create(Self) ;
        With vBvlLembrete do
        Begin
          Parent := vPnlLembrete ;
          Align  := alTop ;
          Shape  := bsTopLine ;
          Style  := bsRaised ;
          Height := 2  ;
          Top     := 100 ;
          Name   := 'vBvlLembrete_' + inttostr(vQtdeLembretes) ;
          ParentShowHint  := true ;
        End ; // With vBvlLembrete do

        vMemoLembrete := TMemo.Create(Self) ;
        With vMemoLembrete do
        Begin
          Parent      := vPnlLembrete ;
          Align       := alClient ;
          Text        := 'xxxxxxxx' ;
          BevelOuter  := bvNone ;
          BorderStyle := bsNone ;
//          Color       := clYellow ;
          Name        := 'vMemoLembrete_' + inttostr(vQtdeLembretes) ;
          ParentShowHint  := true ;
        	ParentColor := True ;
        End ; // With vMemoLembrete do
      End ; // With vPnlLembrete do
    End ; // With vShapeLembrete do

end;

end.
