unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Cancelar, Limpar, Confirma, StdCtrls, Buttons, Excluir, ExtCtrls,
  Desfazer, NumEdit, Visualizar, Db, RxMemDS;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PanelBotoes: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Excluir1: TExcluir;
    Limpar1: TLimpar;
    Confirma1: TConfirma;
    Visualizar1: TVisualizar;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure PosicionaBotoes(pPanel: TPanel ; pMudaTamanhoDoPainel : Boolean = True ; pMudaTamanhoDosBotoes : Boolean = True ) ;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  posicionabotoes(PanelBotoes) ;
end;

Procedure TForm1.PosicionaBotoes(pPanel: TPanel ; pMudaTamanhoDoPainel : Boolean = True ; pMudaTamanhoDosBotoes : Boolean = True ) ;
var
  i,
  vEspaco,
  vControle,
  vQtdeBotoes  : Integer ;
  vLBoxOrdenar : TListBox ;
Const
  HeightPanelBotoes = 55 ;
  TopBotoes         = 13 ;
  HeightBotoes      = 30 ;
  WidthBotoes       = 85 ;

  function IIf(pCondicao: Boolean; pResultTrue, pResultFalse: Variant): Variant ;
  Begin
    If pCondicao Then
      Result := pResultTrue
    else
      Result := pResultFalse;
  End;

  function StrZero( nNum : Real; iTam : Byte; iPrec : Byte = 0): String;
  var I    : Byte;
      sAux : String;
  Begin
    Str( nNum:iTam:iPrec, sAux );
    I := 1;
    While sAux[I] = ' ' Do
    Begin
      sAux[I] := '0';
      Inc( I );
    End;
    Result := sAux;
  End;

begin
  With TPanel(pPanel) do
  Begin
    // Cria ListBox p/ ordenar os botões conforme o TabOrder
    vLBoxOrdenar := TListBox.Create(pPanel) ;
    vLBoxOrdenar.Visible := False ;
    vLBoxOrdenar.Parent  := pPanel ;
    vLBoxOrdenar.Name    := 'vLBoxOrdenar' ;
    vLBoxOrdenar.Sorted  := True ;
    vLBoxOrdenar.Clear   ;

    // Conta a quantidade de botões visíveis no painel e guarda o TabOrder e o Controle de cada componente
    For i := 0 To ControlCount - 1 Do
      If (Controls[i] Is TButton) And (TButton(Controls[i]).Visible) Then
        vLBoxOrdenar.Items.Add('A:'+ StrZero(TButton(Controls[i]).TabOrder,2) +
                               'B:'+ StrZero(i,2) ) ;

    If pMudaTamanhoDoPainel Then
      Height := HeightPanelBotoes ; // Redefine a altura padrão do panel

    vQtdeBotoes := vLBoxOrdenar.Items.Count ;
    vEspaco     := Trunc((pPanel.Width-(vQtdeBotoes*WidthBotoes))/(vQtdeBotoes+1) ) ;

    For i := 0 To vLBoxOrdenar.Items.Count-1  Do
    Begin
      // Identifica qual é o controle do componente
      vControle := StrToInt(Copy(vLBoxOrdenar.Items[i],Pos('B:',vLBoxOrdenar.Items[i])+ 2,2)) ;

      If pMudaTamanhoDosBotoes Then
      Begin
        TButton(Controls[vControle]).Height := HeightBotoes ; // Redefine tamanho e largura dos botões
        TButton(Controls[vControle]).Width  := WidthBotoes  ;
        TButton(Controls[vControle]).Top    := TopBotoes    ;
      End ; // If pTamaBotoes Then

      vWidthMaiorBotao := TButton(Controls[vControle]).Width ;
      If i <> 0 Then
        vWidthMaiorBotao := TButton(Controls[vControle-1]).Width

      // Define as posições dos botões
      TButton(Controls[vControle]).Top  := Trunc((Height-TButton(Controls[vControle]).Height)/2) ;
      TButton(Controls[vControle]).Left := (vEspaco * 1 + i) + (WidthBotoes*i) ;
    End ; // For i := 0 To ControlCount-1 Do

  End ; // With TPanel(pPanel) do
  vLBoxOrdenar.Free ;
End ;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Visualizar1.Visible := Not Visualizar1.Visible ;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  posicionabotoes(PanelBotoes,False,False) ;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  with PanelBotoes do
    Height := 81 ;

  with Confirma1 do
  begin
    Height := 30 ;
    Width  := 85 ;
    Top    := 39 ;
    Left   := 62 ;
  end;

  with Limpar1 do
  begin
    Height := 30 ;
    Width  := 141 ;
    Top    := 27 ;
    Left   := 244 ;
  end;

  with Excluir1 do
  begin
    Height := 33 ;
    Width  := 106 ;
    Top    := 29 ;
    Left   := 381 ;
  end;

  with Visualizar1 do
  begin
    Height  := 30 ;
    Width   := 85 ;
    Top     := 28 ;
    Left    := 500 ;
    Visible := True ;
  end;

end;

end.



