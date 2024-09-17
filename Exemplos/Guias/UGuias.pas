unit UGuias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, RDprint, NumEdit;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    RGroupFont: TRadioGroup;
    RadioGroup2: TRadioGroup;
    Button1: TButton;
    Label20: TLabel;
    SpEQtdLinhas: TSpinEdit;
    Label1: TLabel;
    RDprint1: TRDprint;
    RGroupImp: TRadioGroup;
    NEdtColunas: TNumEdit;
    procedure RGroupFontClick(Sender: TObject);
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

procedure TForm1.RGroupFontClick(Sender: TObject);
begin
  Case RGroupImp.ItemIndex of
    0 : Begin
          Case RGroupFont.ItemIndex of
            0 : NEdtColunas.Value :=  40 ;
            1 : NEdtColunas.Value :=  80 ;
            2 : NEdtColunas.Value :=  96 ;
            3 : NEdtColunas.Value := 137 ;
            4 : NEdtColunas.Value := 160 ;
          End ; // Case RGroupFont.ItemIndex of
        End ; // 0 : Begin
    1 : Begin
          Case RGroupFont.ItemIndex of
            0 : NEdtColunas.Value :=  66 ;
            1 : NEdtColunas.Value := 132 ;
            2 : NEdtColunas.Value := 160 ;
            3 : NEdtColunas.Value := 240 ;
            4 : NEdtColunas.Value := 264 ;
          End ; // Case RGroupFont.ItemIndex of
        End ; // 1 : Begin
  End ; // Case RGroupImp.ItemIndex of
end;

procedure TForm1.Button1Click(Sender: TObject);
Var
  vLinha,
  i : Integer ;
  r11,
  r12,
  r21,
  r22 : String ;
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
  With RDprint1 do
  Begin
    TamanhoQteColunas := StrToInt(NEdtColunas.text) ;
    Case RGroupFont.ItemIndex of
      0 : FonteTamanhoPadrao := S05cpp ;
      1 : FonteTamanhoPadrao := S10cpp ;
      2 : FonteTamanhoPadrao := S12cpp ;
      3 : FonteTamanhoPadrao := S17cpp ;
      4 : FonteTamanhoPadrao := S20cpp ;
    End ; // Case RGroupFont.ItemIndex of

    Abrir ;
    If Not Setup Then Exit ;

    vLinha := 0 ;
    For i := 0 to Trunc(SpEQtdLinhas.Value /2 ) do
    Begin
      Inc(vLinha) ;
      r11 := StrZero(vLinha,2) + '-456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890' ;
      r21 :=                     '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890' ;
      Imp(vLinha,01,Copy(r11+r21,1,TamanhoQteColunas)) ;
      Inc(vLinha) ;
      r12 := StrZero(vLinha,2) + '-      1         2         3         4         5         6         7         8         9         0         1         2         3         4         5' ;
      r22 :=                     '         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0' ;
      Imp(vLinha,01,Copy(r12+r22,1,TamanhoQteColunas)) ;
      If vLinha = SpEQtdLinhas.Value Then
        Break ;
    End ; //
    Fechar ;
  End ; // With RDprint1 do
end;

end.
