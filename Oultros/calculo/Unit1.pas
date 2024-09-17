unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NumEdit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    vCalculoDePedagio: TNumEdit;
    FRACAO_PESO_MIN: TNumEdit;
    VL_FRACAO_PESO: TNumEdit;
    vResulPedagio: TNumEdit;
    vPedagio: TNumEdit;
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
var _vCalculoDePedagio,
    _FRACAO_PESO_MIN,
    _VL_FRACAO_PESO,
    _vResulPedagio,
    _vPedagio: real;


    function CalculaVlrCondicao(vCampo, vVlrAtual, vVlrSubst: Double):Integer;
    Var
      vCalculo : Double;
    Begin

      If vCampo = vVlrAtual Then
        vCalculo := vVlrSubst
      Else
        vCalculo := vCampo ;

      Result := StrToInt(FormatFloat('0',vCalculo));

    End;

begin
    _vCalculoDePedagio := vCalculoDePedagio.Value ;
    _FRACAO_PESO_MIN   := FRACAO_PESO_MIN.Value   ;
    _VL_FRACAO_PESO    := VL_FRACAO_PESO.Value    ;


          _vResulPedagio := Trunc(_vCalculoDePedagio * 100) div (CalculaVlrCondicao(_FRACAO_PESO_MIN,0,1) * 100);
          If Trunc(_vCalculoDePedagio * 100) mod Trunc(_FRACAO_PESO_MIN  * 100) = 0 Then
             _vPedagio := _vResulPedagio * _VL_FRACAO_PESO
          Else
            _vPedagio := (_vResulPedagio + 1) * _VL_FRACAO_PESO;


    vCalculoDePedagio.Value := _vCalculoDePedagio ;
    FRACAO_PESO_MIN.Value   := _FRACAO_PESO_MIN   ;
    VL_FRACAO_PESO.Value    := _VL_FRACAO_PESO    ;
    vResulPedagio.Value     := _vResulPedagio     ;
    vPedagio.Value          := _vPedagio          ;

end;

end.
