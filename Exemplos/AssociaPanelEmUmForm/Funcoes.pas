unit Funcoes;

interface

uses
  ExtCtrls, Forms, Controls,Wordcap, Classes ;

type
  TBotoes = (bNenhum,bOk,bCancela) ;
  Function AttribuPanel(pTitulo : String ; pPanel : Pointer ; pBotoes : TBotoes = bNenhum ) : Boolean ;
Var
  FForm : TForm ;

Implementation

Function AttribuPanel(pTitulo : String ; pPanel : Pointer ; pBotoes : TBotoes = bNenhum ) : Boolean ;
Var
  vPanelBotoes     : TPanel ;
  MSOfficeCaption1 : TMSOfficeCaption ;
  vParent          : TWinControl ;
  vAlign  : TAlign ;
  vTop,
  vLeft,
  vHeight,
  vWidth  : Integer ;
Begin
  vParent := TPanel(pPanel^).Parent ;
  vAlign  := TPanel(pPanel^).Align ;
  vTop    := TPanel(pPanel^).Top ;
  vLeft   := TPanel(pPanel^).Left ;
  vHeight := TPanel(pPanel^).Height ;
  vWidth  := TPanel(pPanel^).Width ;

  FForm := TForm.Create(Application) ;
  With FForm do
  Try
    If pBotoes <> bNenhum Then
    Begin
      vPanelBotoes            := TPanel.Create(FForm) ;
      vPanelBotoes.Align      := alBottom ;
      vPanelBotoes.BevelInner := bvLowered ;
      vPanelBotoes.Caption    := '' ;
      vPanelBotoes.Parent     := FForm ;
      vPanelBotoes.Height     := 55 ;
    End ; // If pBotoes <> bNenhum Then

    // Define as propriedades e eventos do form
    KeyPreview  := True ;
    Position    := poScreenCenter ;
    BorderIcons := [biSystemMenu,biMaximize] ;
    BorderIcons := [biSystemMenu] ;
    BorderStyle := bsSingle ;

    TPanel(pPanel^).Parent := FForm ;

    Height        := 30 + TPanel(pPanel^).Height + vPanelBotoes.Height  ;
    Width         := TPanel(pPanel^).Width + 2 ;
    TPanel(pPanel^).Align  := alClient ;
    ShowModal ;
  Finally
    With TPanel(pPanel^) do
    Begin
      Align  := vAlign ;
      Top    := vTop ;
      Left   := vLeft ;
      Height := vHeight ;
      Width  := vWidth ;
      Parent := vParent;
    End ; // With TPanel(pPanel^) do
    FForm.Release ;
    FForm := Nil ;
  End ; // With FForm do
End ;


end.
