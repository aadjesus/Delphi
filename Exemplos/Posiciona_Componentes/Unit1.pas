unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Aplicar, NumEdit, Mask, TimeEdit, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    GBoxValores: TGroupBox;
    AplicarICMS: TAplicar;
    PanelValViagens: TPanel;
    Label1: TLabel;
    NEdtValViagens: TNumEdit;
    PanelValDiarias: TPanel;
    Label2: TLabel;
    NEdtValDiarias: TNumEdit;
    PanelValAntecipacoes: TPanel;
    Label3: TLabel;
    NEdtValAntecipacoes: TNumEdit;
    PanelOutros: TPanel;
    Label4: TLabel;
    NEdtValOutros: TNumEdit;
    PanelDescontos: TPanel;
    Label6: TLabel;
    NEdtValDesconto: TNumEdit;
    PanelValTotal: TPanel;
    Label7: TLabel;
    NEdtValTotal: TNumEdit;
    Button1: TButton;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  i,j: integer ;
begin
  PanelValAntecipacoes.Visible := CheckBox1.Checked ;
  With TGroupBox(GBoxValores) do
  Begin
    For i := 0 To ControlCount-1 Do
    Begin
      If (Controls[i] Is TPanel) Then
      Begin
        If CheckBox1.Checked Then
          TPanel(Controls[i]).Width := 94
        Else // If CheckBox1.Checked Then
          TPanel(Controls[i]).Width := 114 ;

        For j := 0 To TPanel(Controls[i]).ControlCount-1 Do
          If TPanel(Controls[i]).Controls[j] Is TNumEdit Then
            TNumEdit(TPanel(Controls[i]).Controls[j]).Width := TPanel(Controls[i]).Width ;


        If i = 1 Then
        Begin
          TPanel(Controls[i]).Left := 6 ;
          Continue ;
        End Else // If i = 0 Then
          If TPanel(Controls[i]).Visible then
            TPanel(Controls[i]).Left  := TPanel(Controls[i-1]).Left + TPanel(Controls[i]).Width + 3
          Else
            TPanel(Controls[i]).Left  := TPanel(Controls[i-2]).Left + TPanel(Controls[i]).Width + 3 ;

      End ; // If Controls[i] Is TNumEdit Then
    End ; // For i := 0 To ControlCount-1 Do
  End ; // With TGroupBox(GBoxValores) do
end;

end.
