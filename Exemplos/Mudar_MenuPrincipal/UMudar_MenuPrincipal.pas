unit UMudar_MenuPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, Menus, StdCtrls, ShellAPI
  ,UMudar_MenuPrincipalTela1;

const
  wm_IconMessage = wm_User;

type
  TForm1 = class(TForm)
    Button1: TButton;
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Controle1: TMenuItem;
    Local1: TMenuItem;
    UF1: TMenuItem;
    Destinodoleo1: TMenuItem;
    Estoque1: TMenuItem;
    cdMarca: TMenuItem;
    cdMaterial: TMenuItem;
    cdUnidadeDeMedida: TMenuItem;
    cdHistorico: TMenuItem;
    porVale1: TMenuItem;
    porNotafiscal1: TMenuItem;
    Frota1: TMenuItem;
    Veiculos1: TMenuItem;
    Folha1: TMenuItem;
    CadastrodeFuncSimplificados1: TMenuItem;
    Condio1: TMenuItem;
    Funcao1: TMenuItem;
    Sindicatos1: TMenuItem;
    rea1: TMenuItem;
    Departamento1: TMenuItem;
    Setor1: TMenuItem;
    Seo1: TMenuItem;
    RegioGeogrfica1: TMenuItem;
    Tipodeleo1: TMenuItem;
    Tanque1: TMenuItem;
    Bomba1: TMenuItem;
    Banco1: TMenuItem;
    Bancos1: TMenuItem;
    Agncias1: TMenuItem;
    Contabilidade1: TMenuItem;
    Tiposdedocumentos1: TMenuItem;
    ndices1: TMenuItem;
    Tiposdereceita1: TMenuItem;
    Arrecadao1: TMenuItem;
    Linha3: TMenuItem;
    Escriturao1: TMenuItem;
    Classificacoesfiscais1: TMenuItem;
    Operacoesfiscais1: TMenuItem;
    DVS1: TMenuItem;
    Tipodebem1: TMenuItem;
    ContasPagar1: TMenuItem;
    CadastroDeFornecedores: TMenuItem;
    TiposdeDocumento1: TMenuItem;
    Tiposdedespesa1: TMenuItem;
    ContasReceber1: TMenuItem;
    Clientes1: TMenuItem;
    Tiposdereceitas1: TMenuItem;
    Movimentao1: TMenuItem;
    TabeladePreo1: TMenuItem;
    N2: TMenuItem;
    AbastecimentoKm1: TMenuItem;
    VelocimetroAbastecimento1: TMenuItem;
    Abastecimento1: TMenuItem;
    Velocimetro1: TMenuItem;
    Abastecimentoexterno2: TMenuItem;
    a1: TMenuItem;
    Outrosconsumos1: TMenuItem;
    EfetuaIntegraocomEstoque1: TMenuItem;
    N3: TMenuItem;
    TransferenciaTanqueTanque1: TMenuItem;
    MovimentodeEntradaTanque1: TMenuItem;
    DigitaoHodometrodaBomba1: TMenuItem;
    N4: TMenuItem;
    MovimentodeAferio1: TMenuItem;
    N5: TMenuItem;
    mnDevolucaoAbastecimento: TMenuItem;
    mnTrocaDeOleo: TMenuItem;
    DigitaodeHormetro1: TMenuItem;
    Consulta2: TMenuItem;
    AbastecimentodeCarros2: TMenuItem;
    MovimentodeTanque1: TMenuItem;
    MovimentodeBomba1: TMenuItem;
    OutrosConsumos3: TMenuItem;
    Listagem1: TMenuItem;
    lstTipoOleoCombo: TMenuItem;
    Tanque2: TMenuItem;
    Bomba2: TMenuItem;
    TabeladePreo2: TMenuItem;
    ListagemGenrica1: TMenuItem;
    Construtor1: TMenuItem;
    Imprimir1: TMenuItem;
    Relatrio1: TMenuItem;
    ConsumocomCarros1: TMenuItem;
    Modelo11: TMenuItem;
    Modelo21: TMenuItem;
    Abastecimentoexterno1: TMenuItem;
    Abastecimentoexterno3: TMenuItem;
    AbastecimentoexternoCTF1: TMenuItem;
    AbastecimentoQuilometragem1: TMenuItem;
    OutrosConsumos2: TMenuItem;
    Bombapordia1: TMenuItem;
    Criticadeconsumo1: TMenuItem;
    ConsumoDiriocomleodeMotor1: TMenuItem;
    ConsumodeleoporMotor1: TMenuItem;
    Demonstraodeconsumo1: TMenuItem;
    Velocimetrocomerro1: TMenuItem;
    Relatriomensaldefrota1: TMenuItem;
    mnRelTrocaDeOleo: TMenuItem;
    GrficoKmsRodados1: TMenuItem;
    Grfico1: TMenuItem;
    GrficoCustoKmLModeloChassi1: TMenuItem;
    Custocomleodiesel1: TMenuItem;
    ConsumoMedioOleo: TMenuItem;
    Custocomcombustlubrificantes1: TMenuItem;
    Abastecimentopormotorista1: TMenuItem;
    Kmmximoemnimo1: TMenuItem;
    Reajustesdotipodeleo1: TMenuItem;
    MdConsTpoleo1: TMenuItem;
    AbastecimentoporBomba1: TMenuItem;
    Veculosnoabastecidos1: TMenuItem;
    ConsumoDirioporPrefixo1: TMenuItem;
    Abastecimento: TMenuItem;
    Abastecimento3: TMenuItem;
    Auxiliares1: TMenuItem;
    Importar1: TMenuItem;
    Abastecimento2: TMenuItem;
    Excel1: TMenuItem;
    Velocimetro2: TMenuItem;
    ImpAbastVeloc: TMenuItem;
    TrocaSenhadoUsurio1: TMenuItem;
    LimparMovimento1: TMenuItem;
    BombaTanque1: TMenuItem;
    Estornar1: TMenuItem;
    AbastecimentoVelocmetro1: TMenuItem;
    Regravalinhanoabastecimento1: TMenuItem;
    N6: TMenuItem;
    Globusreport1: TMenuItem;
    Saida: TMenuItem;
    Ajuda1: TMenuItem;
    AjudaDoModulo: TMenuItem;
    N1: TMenuItem;
    AjudaSobreSistema: TMenuItem;
    BarraDeEstatus: TStatusBar;
    Image2: TImage;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    tbVelocimetroAbastecimento1: TToolButton;
    PopupMenu1: TPopupMenu;
    Retorna1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Retorna1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Local1Click(Sender: TObject);
    procedure SaidaClick(Sender: TObject);
  private
    { Private declarations }
     vHeightAtu,
     vWidthAtu,
     vLeftAtu,
     vTopAtu : Integer ;
     procedure IconTray (var Msg: TMessage); message wm_IconMessage;
     procedure WMNCHitTest(var Msg: TMessage); message WM_NCHitTest;
     Procedure MudaLayOutTela(pNormal : Boolean = True ) ;
  public
    { Public declarations }
     nid : TNotifyIconData ;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  MudaLayOutTela(False) ;
end;

procedure TForm1.IconTray(var Msg: TMessage);
var
  Pt: TPoint ;
begin
  If Msg.lParam = wm_rbuttondown then
  Begin
    GetCursorPos(Pt) ;
    PopupMenu1.Popup(Pt.x, Pt.y);
  End;
end;

procedure TForm1.WMNCHitTest(var Msg: TMessage);
begin
  DefaultHandler(Msg);
end;

procedure TForm1.Retorna1Click(Sender: TObject);
begin
  MudaLayOutTela ;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  nid.uFlags := 0 ;
  Shell_NotifyIcon (NIM_DELETE, @nid);
end;

procedure TForm1.MudaLayOutTela(pNormal : Boolean = True ) ;
Var
  vTamMenu,
  i : Integer ;
  vApli : HWnd ;
begin
  For i := 0 to ComponentCount - 1 do
  Begin
    If Components[i] Is TWinControl Then
      TWinControl(Components[i]).Visible := pNormal ;
    If Components[i] Is TGraphicControl Then
      TGraphicControl(Components[i]).Visible := pNormal ;
  End ; // For i := 0 to ComponentCount - 1 do

  If pNormal Then
  Begin
    BorderStyle := bsSingle ;
    FormStyle   := fsNormal ;
    Height      := vHeightAtu ;
    Width       := vWidthAtu ;
    Left        := vLeftAtu ;
    Top         := vTopAtu ;
    Nid.uFlags := 0 ;
    Shell_NotifyIcon (NIM_DELETE, @nid) ;
  End Else // If pNormal Then
  Begin
    vTamMenu := 0 ;
    For i := 0 to MainMenu1.Items.Count-1 do
      vTamMenu := vTamMenu + Length(Trim(MainMenu1.Items[i].Caption)) ;

    vHeightAtu := Height ;
    vWidthAtu  := Width ;
    vLeftAtu   := Left ;
    vTopAtu    := Top ;

    Height := 0 ;
    Width  := Trunc((500*vTamMenu)/80) ; // Faz o calculo baseado no tamanho da fonte do menu de 8
    Left   := Screen.Width - Width ;
    Top    := 0 ;

    BorderStyle := bsNone ;
    FormStyle   := fsStayOnTop ;

    // retira da barra iniciar
    vApli := FindWindow(Nil,'PMudar_MenuPrincipal') ;
    If vApli <> 0 Then ShowWindow(vApli,SW_HIDE) ;

    // carrega o ícone inicial
    Icon.Handle := LoadIcon(HInstance,'MAINICON');

    // preenche os dados da estrutura NotifyIcon
    Nid.cbSize := sizeof(nid) ;
    Nid.wnd    := Handle ;
    Nid.uID    := 1 ; // Identificador do ícone
    Nid.uCallBAckMessage := wm_IconMessage ;
    Nid.hIcon := Icon.Handle ;
    Nid.szTip := 'LloydSoft' ;
    Nid.uFlags := nif_Message or Nif_Icon or nif_Tip ;
    Shell_NotifyIcon(NIM_ADD, @nid) ;
  End ; // End Else // If pNormal Then
end;

procedure TForm1.Local1Click(Sender: TObject);
begin
  With TForm2.create(Self) do
  Begin
    ShowModal ;
    Free ;
  End ; //
end;

procedure TForm1.SaidaClick(Sender: TObject);
begin
  Close ;
end;

end.
