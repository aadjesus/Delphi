unit USalvaTela;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,jpeg, Menus, Buttons, 
  ComCtrls, Grids, DBGrids, RXDBCtrl, NumEdit, ToolEdit, Mask;

type
  TFrmEST_NotaFiscal = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    MedNumeroNF: TMaskEdit;
    SbtPesq_NF: TSpeedButton;
    DedEntradaSaidaNF: TDateEdit;
    EdSerieNF: TEdit;
    DedDataEmissaoNF: TDateEdit;
    PageControl: TPageControl;
    Tab_NF: TTabSheet;
    Panel_Nota: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label27: TLabel;
    Label_ForCli: TLabel;
    SbtPesq_ForCli: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    SbtPesq_CFO: TSpeedButton;
    Label32: TLabel;
    SbtPesq_Doc: TSpeedButton;
    Label28: TLabel;
    Label21: TLabel;
    Label7: TLabel;
    SbpPesqCentroCusto: TSpeedButton;
    Label112: TLabel;
    EdtForCli: TEdit;
    EdtDescrForCli: TEdit;
    EdtNaturezaOperacaoNF: TEdit;
    EdtCFOPNF: TEdit;
    EdDescTpDoc: TEdit;
    EdCodTpDoc: TEdit;
    NedtValorItensNF: TNumEdit;
    NedtValorTotalNF: TNumEdit;
    Panel5: TPanel;
    SbtPesq_CFORetorno: TSpeedButton;
    Label38: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    SbtPesq_NF_CFO: TSpeedButton;
    Label30: TLabel;
    Label31: TLabel;
    Label6: TLabel;
    EdtNaturezaOperacaoNFRetorno: TEdit;
    EdtCFORetorno: TEdit;
    DedDataEntradaNF_CFO: TDateEdit;
    EdtSerieNF_CFO: TEdit;
    MedNumeroNF_CFO: TMaskEdit;
    NedTotalNF_CFO: TNumEdit;
    CheckBox_CFO_Retorno: TCheckBox;
    NedtValorSeguro: TNumEdit;
    GrpICMS: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    NedtBaseCalcICMSNF: TNumEdit;
    NedtAliquotaICMSNF: TNumEdit;
    NedtValorICMSNF: TNumEdit;
    NedtOutrasICMS: TNumEdit;
    NedtIsentaICMS: TNumEdit;
    GrpIPI: TGroupBox;
    Label33: TLabel;
    Label15: TLabel;
    Label34: TLabel;
    NedBaseCalcIPINF: TNumEdit;
    NedtAliquotaIPINF: TNumEdit;
    NedtValorIPINF: TNumEdit;
    CbxIPISobre: TCheckBox;
    GrpICMSSubst: TGroupBox;
    Label105: TLabel;
    Label106: TLabel;
    NedtAliqICMSSub: TNumEdit;
    NedtValorIcmsSub: TNumEdit;
    CbxICMSSubsSobre: TCheckBox;
    CbxAtribuirICMSSub: TCheckBox;
    grpDesconto: TGroupBox;
    Label59: TLabel;
    Label107: TLabel;
    NedtAliqDesconto: TNumEdit;
    NedtValorDesconto: TNumEdit;
    CbxDescontoSobre: TCheckBox;
    GrpImpostos: TGroupBox;
    Label36: TLabel;
    Label101: TLabel;
    Label43: TLabel;
    Label53: TLabel;
    Label39: TLabel;
    Label52: TLabel;
    Label54: TLabel;
    Label110: TLabel;
    NedtAliqPIS: TNumEdit;
    NedtValorPIS: TNumEdit;
    NedtAliqCOFINS: TNumEdit;
    NedtValorCOFINS: TNumEdit;
    NedtValorINSS: TNumEdit;
    NedtAliqINSS: TNumEdit;
    NedtAliqISS: TNumEdit;
    NedtValorISS: TNumEdit;
    NedtAliqIR: TNumEdit;
    NedtValorIR: TNumEdit;
    NedtAliqCSLL: TNumEdit;
    NedtValorCSLL: TNumEdit;
    GrpFrete: TGroupBox;
    Label14: TLabel;
    NedtValorFrete: TNumEdit;
    CbxFreteSobre: TCheckBox;
    GrpOutrasDespesas: TGroupBox;
    Label16: TLabel;
    NedtValorDespesas: TNumEdit;
    CbxOutrasDespesasSobre: TCheckBox;
    GrpICMSDifAliquota: TGroupBox;
    Label35: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    ChkICMSdifaliquota: TCheckBox;
    NedICMSDifBase: TNumEdit;
    NedAliquotaICMSDif: TNumEdit;
    NedValorICMSDif: TNumEdit;
    GrpVlServico: TGroupBox;
    Label104: TLabel;
    ChkAtribuiValorServico: TCheckBox;
    NedValorServico: TNumEdit;
    medCodCusto: TMaskEdit;
    Tab_Itens: TTabSheet;
    Panel6: TPanel;
    SbtPesq_HistMov: TSpeedButton;
    Label17: TLabel;
    Label19: TLabel;
    SbtPesq_Funcionario: TSpeedButton;
    Label23: TLabel;
    SbtPesq_Local: TSpeedButton;
    Label24: TLabel;
    Label25: TLabel;
    SbtPesq_PedidosNF: TSpeedButton;
    Label26: TLabel;
    SbtPesq_Item: TSpeedButton;
    Label29: TLabel;
    Label56: TLabel;
    Label58: TLabel;
    SpbPesq_Marca: TSpeedButton;
    Label60: TLabel;
    Label61: TLabel;
    Label63: TLabel;
    Label66: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label62: TLabel;
    Label74: TLabel;
    MedCodHisMov: TMaskEdit;
    EdtDescricaoHisMov: TEdit;
    MedCodFunc: TMaskEdit;
    EdtNomeFunc: TEdit;
    MedCodigoLocal: TMaskEdit;
    EdtDescLocal: TEdit;
    NedQtdeTotalDeItens: TNumEdit;
    NedTotalNF: TNumEdit;
    MedCodigoInternoMaterial: TMaskEdit;
    EdtDescMaterial: TEdit;
    MedDV: TMaskEdit;
    NedQtdeItem: TNumEdit;
    NedQtdeConsignacaoItem: TNumEdit;
    MedCodigoMarcaMat: TMaskEdit;
    EdtDescricaoMarca: TEdit;
    NedValorUnitarioItem: TNumEdit;
    NedValorICMSItem: TNumEdit;
    NedValorIPIItem: TNumEdit;
    NedValorTotalItem: TNumEdit;
    NedValorDescontoItem: TNumEdit;
    NedValorPISItem: TNumEdit;
    NedValorCOFINSItem: TNumEdit;
    NedValorINSSItem: TNumEdit;
    NedValorISSItem: TNumEdit;
    NedValorIRItem: TNumEdit;
    NedValorSeguroItem: TNumEdit;
    NedValorFreteItem: TNumEdit;
    NedOutrasDespesasItem: TNumEdit;
    PageControl_Itens: TPageControl;
    Tab_Itens_I: TTabSheet;
    Panel7: TPanel;
    Label64: TLabel;
    Label65: TLabel;
    BtnAlterar_Item: TSpeedButton;
    BtnExcluir_Item: TSpeedButton;
    NedValorTotalItems: TNumEdit;
    NedQtdeTotalItem: TNumEdit;
    DbgItens: TRxDBGrid;
    Tab_Itens_S: TTabSheet;
    Panel8: TPanel;
    ListView_Servicos: TListView;
    PnlCFOP: TPanel;
    Label113: TLabel;
    SbtPesq_CFOServ: TSpeedButton;
    Label116: TLabel;
    ed_CFOServ: TEdit;
    ed_CFODescServ: TEdit;
    PnlServico: TPanel;
    Label40: TLabel;
    Label103: TLabel;
    sbtpesqveiculo: TSpeedButton;
    Label41: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    Label111: TLabel;
    sbTpDespesa: TSpeedButton;
    Label92: TLabel;
    SbtPesq_Conta_SE: TSpeedButton;
    lbCCusto: TLabel;
    sbPesqCCusto: TSpeedButton;
    Label44: TLabel;
    EdtDescricao_SE: TEdit;
    ChkAtribuido_SE: TCheckBox;
    CBoxMatAvulso: TCheckBox;
    MedPrefixo: TMaskEdit;
    NedValor_SE: TNumEdit;
    NedDesconto_SE: TNumEdit;
    NedDespesa_SE: TNumEdit;
    medTpDespesa: TMaskEdit;
    MedConta_SE: TMaskEdit;
    EdDescConta_SE: TEdit;
    medCCusto: TMaskEdit;
    NedTotalServico: TNumEdit;
    grpoutrosvalores: TGroupBox;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    SbtIncluiOutrosValores: TSpeedButton;
    CboOutrosvalores: TComboBox;
    NedValorICMSSubs: TNumEdit;
    chkIntegraValeNF: TCheckBox;
    chkAutorizado: TCheckBox;
    Tab_Bem: TTabSheet;
    Panel3: TPanel;
    Label46: TLabel;
    Label45: TLabel;
    SbtPesq_TipoDeBem: TSpeedButton;
    Label47: TLabel;
    SbtPesq_ContaDespesa: TSpeedButton;
    Label48: TLabel;
    Label89: TLabel;
    Label84: TLabel;
    ListView_CompraBem: TListView;
    NedValorCompraBem: TNumEdit;
    MedCodigoTipoBem: TMaskEdit;
    EdtDescricaoTipoBem: TEdit;
    EdtNroPlano: TEdit;
    EdtDescricaoPlanoConta: TEdit;
    EdtCodContaCtb: TEdit;
    EdtDescricaoConta: TEdit;
    CkbContabilizaBem: TCheckBox;
    NedTotalDigitado_Bem: TNumEdit;
    nedQtde: TNumEdit;
    Tab_Abastecimento: TTabSheet;
    Panel4: TPanel;
    Label49: TLabel;
    SbtPesq_TipoOleo: TSpeedButton;
    Label50: TLabel;
    Label51: TLabel;
    Label18: TLabel;
    Label88: TLabel;
    ListView_Abastecimento: TListView;
    MedCodigoTipoOleo: TMaskEdit;
    EdtDescricaoTipoOleo: TEdit;
    NedValorT_OL: TNumEdit;
    NedQtde_OL: TNumEdit;
    NedValorU_OL: TNumEdit;
    NedTotalDigitado_Aba: TNumEdit;
    Tab_ConsumoDireto: TTabSheet;
    Panel2: TPanel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    SbtPesq_Conta: TSpeedButton;
    SbtPesq_Custo: TSpeedButton;
    Label73: TLabel;
    SbtPesq_Setor: TSpeedButton;
    SbtPesq_Veiculo: TSpeedButton;
    Btn_ItemConsumoDireto: TSpeedButton;
    Btn_ItenConsumoDiretoLimpa: TSpeedButton;
    Label85: TLabel;
    sbtordemservico: TSpeedButton;
    Label87: TLabel;
    Btn_ItenConsumoDiretoGrava: TSpeedButton;
    CkbConsumoDireto: TCheckBox;
    MedPlano: TMaskEdit;
    EdDescricaoPlano: TEdit;
    MedConta_Consumo: TMaskEdit;
    EdtDescConta: TEdit;
    MedCusto: TMaskEdit;
    EdtDescCusto: TEdit;
    EdtPlacaVeic: TEdit;
    MedSetor: TMaskEdit;
    EdtDescSetor: TEdit;
    EdPrefixoVeicMov: TEdit;
    DbgItensConsumoDireto: TDBGrid;
    mednumeroos: TMaskEdit;
    chkdigitaqtde: TCheckBox;
    nedqtdesaida: TNumEdit;
    Tab_Vencimentos: TTabSheet;
    Panel1: TPanel;
    Label71: TLabel;
    Label72: TLabel;
    Label86: TLabel;
    Btn_ExcluiVencto: TSpeedButton;
    Label37: TLabel;
    Label102: TLabel;
    CbxTipoVenctoNF: TComboBox;
    NedDiasVenctoNF: TNumEdit;
    NedTotalNotaVencimento: TNumEdit;
    DbGrid_Vencimentos: TDBGrid;
    NedTotalParcelas: TNumEdit;
    CbxCondicaoPagtoNF: TComboBox;
    GroupBox2: TGroupBox;
    Btn_ConsultaPedido: TSpeedButton;
    DBGrid_Pedidos: TDBGrid;
    Panel_Botoes: TPanel;
    MainMenu1: TMainMenu;
    Saida: TMenuItem;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    Classificacoesfiscais1: TMenuItem;
    ndices1: TMenuItem;
    Tiposdereceita1: TMenuItem;
    CadastroDeFornecedores: TMenuItem;
    CadastrodeFuncSimplificados1: TMenuItem;
    cdHistorico: TMenuItem;
    Local1: TMenuItem;
    cdMaterial: TMenuItem;
    cdMarca: TMenuItem;
    Setor1: TMenuItem;
    TipodeBem1: TMenuItem;
    TiposdeDocumento1: TMenuItem;
    Tipodeleo1: TMenuItem;
    Veiculos1: TMenuItem;
    Parametros1: TMenuItem;
    AtribuirTotalIPIsobreoTotaldosItens1: TMenuItem;
    Imprimir: TMenuItem;
    NotaFiscal1: TMenuItem;
    Imprimirautorizaodepagto1: TMenuItem;
    Limitardiasparaentradadanota1: TMenuItem;
    Consultas1: TMenuItem;
    Pendenciatransfreq1: TMenuItem;
    Label_TipoOperacaoNF: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SalvaTela ;
    procedure SalvaTela2 ;
  end;

var
  FrmEST_NotaFiscal: TFrmEST_NotaFiscal;

implementation

Uses UEnviaTela ;

{$R *.DFM}

procedure TFrmEST_NotaFiscal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_F9 Then
   SalvaTela ;
  If Key = VK_F8 Then
   SalvaTela2 ;
end;

procedure TFrmEST_NotaFiscal.SalvaTela;
Var
  Bitmap      : TBitmap ;
  Dc          : HDc ;
  DesktoPrect : TRect ;
  SR          : TSearchRec ;
  I,
  vQtdeArq    : Integer ;
  vPath,
  vNomeArq    : String ;
begin
  dc      := GetDC( 0 );
  BitMap  := TBitmap.Create ;
  Try
    Try
      DesktoPrect := Bounds(Screen.ActiveForm.Left
                           ,Screen.ActiveForm.Top
                           ,Screen.ActiveForm.Width
                           ,Screen.ActiveForm.Height) ;

      BitMap.Width  := DesktoPrect.Right  - DesktoPrect.Left ;
      BitMap.Height := DesktoPrect.Bottom - DesktoPrect.Top ;

      BitBlt(BitMap.Canvas.Handle
            ,0
            ,0
            ,BitMap.Width
            ,BitMap.Height
            ,dc
            ,DesktoPrect.Left
            ,DesktoPrect.Top
            ,SRCCOPY ) ;

      With TJPEGImage.Create do
      Begin

        CompressionQuality := 25 ;
        Assign(Bitmap) ;
        Compress ;
        vPath    := ExtractFilePath(Application.ExeName) ;
        vNomeArq := Screen.ActiveForm.Name ;

        // Rotina p/ contar quantos arquivos existem na pasta
        I := FindFirst(vPath + vNomeArq + '*.bmp', faAnyFile, SR) ;
        vQtdeArq := 0 ;
        while I = 0 do
        begin
          Inc(vQtdeArq) ;
          I := FindNext(SR);
        End ; // while I = 0 do
        vNomeArq := vNomeArq + IntToStr(vQtdeArq) + '.bmp' ;
        SaveToFile(vPath + vNomeArq ) ;

        Free ;
      End ; // With TJPEGImage.Create do
    Finally
      BitMap.Free ;
    End ; // Try - Finally
  Finally
    ReleaseDC(0,dc) ;
  End ; // Try - Finally

  With TFrmEnviaTela.Create(Self) do
  Begin
    EdtAssunto.Text := Screen.ActiveForm.Caption ;
    ShowModal ;
    Free ;
  End ; // With TFrmEnviaTela.Create(Self) do


end;

procedure TFrmEST_NotaFiscal.SalvaTela2;
Var
  Bitmap      : TBitmap ;
  Dc          : HDc ;
  DesktoPrect : TRect ;
  SR          : TSearchRec ;
  I,
  vQtdeArq    : Integer ;
  vPath,
  vNomeArq    : String ;
  image : TImage ;

begin
  dc     := GetDC( 0 );
  BitMap := TBitmap.Create ;


  keybd_event(vk_snapshot,0, 0, 0); {Tela Toda}
  keybd_event(vk_snapshot,1, 0, 0); {Janela Ativa}
end;

end.
