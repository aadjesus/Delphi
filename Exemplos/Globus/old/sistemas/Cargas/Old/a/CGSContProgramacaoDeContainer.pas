unit CGSContProgramacaoDeContainer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Limpar, StdCtrls, Buttons, Confirma, ExtCtrls, RxMemDS, DB,
  DBTables, Menus, SBSelecaoAle, ToolEdit, Mask, BgmPedeGaragem,
  BGMPedeFilialGaragem, BgmPedeEmpresa, Grids, DBGrids, ComCtrls,
  FormatParam, Desfazer, TimeEdit, ImgList, DBCtrls, CGS_CAD_Classes,
  Imprimir, CGS_Funcoes, CTR_CAD_Classes, RDprint, NumEdit, DBTime,
  RXDBCtrl,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt} ;

type
  TRetornoImp = Record
    Reimprimi   : Boolean ;
    ImpressaoOK : String ;
  End ; // TRetornoImp = Record

  TDadosNFCont = Record
    Nota_Fiscal    : String ;
    Item_Grupo     : String ;
    Serie_Nf       : String ;
    Descricao_Prod : String ;
    Dt_Emissao     : String ;
    Varios         : String ;
    QtdeItens      : Integer ;
    Achou          : Boolean ;
  End ; // TDadosNFCont = Record

  TDadosCont = Record
    NumContainer : String ;
    Tara         : Real ;
    Num_Lacre    : String ;
  End ; // TDadosNFCont = Record

  TFrmCGSContProgramacaoDeContainer = class(TForm)
    MainMenu1: TMainMenu;
    Sada1: TMenuItem;
    QryPesquisa: TQuery;
    DSProg: TDataSource;
    MDProg: TRxMemoryData;
    FormatParam: TFormatParam;
    PnlFiltro: TPanel;
    PnlTela: TPanel;
    PageControl1: TPageControl;
    TabSProgramacao: TTabSheet;
    PnlProg: TPanel;
    TabSVarios: TTabSheet;
    PnlBotoes: TPanel;
    Gravar1: TConfirma;
    Limpar1: TLimpar;
    Label27: TLabel;
    Label14: TLabel;
    PnlEscala: TPanel;
    LblMotorista: TLabel;
    lblVeiculo: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    BGMPedeEmpresa: TBgmPedeEmpresa;
    BGMPedeFilial: TBGMPedeFilialGaragem;
    BgmPedeGaragem: TBgmPedeGaragem;
    RGroupTpServico: TRadioGroup;
    GBoxDataPedido: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    DEdtDataPedidoIni: TDateEdit;
    DEdtDataPedidoFin: TDateEdit;
    GBoxClientes: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    MEdtClienteIni: TMaskEdit;
    MEdtClienteFin: TMaskEdit;
    GBoxBooking: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MEdtBookingIni: TMaskEdit;
    MEdtBookingFin: TMaskEdit;
    GBoxContainer: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    MEdtContainerIni: TMaskEdit;
    MEdtContainerFin: TMaskEdit;
    GBoxVeiculos: TGroupBox;
    Label5: TLabel;
    Label8: TLabel;
    MEdtVeiculoIni: TMaskEdit;
    MEdtVeiculoFin: TMaskEdit;
    GBoxTpCont: TGroupBox;
    Label9: TLabel;
    Label12: TLabel;
    MEdtTpContainerIni: TMaskEdit;
    MEdtTpContainerFin: TMaskEdit;
    GBoxTerminal: TGroupBox;
    Label13: TLabel;
    Label15: TLabel;
    MEdtTerminalIni: TMaskEdit;
    MEdtTerminalFin: TMaskEdit;
    PnlBotaoConsSet: TPanel;
    PnlSetas: TPanel;
    ImageSetaU: TImage;
    ImageSetaD: TImage;
    SButSetas: TSpeedButton;
    Consultar: TConfirma;
    CBoxDesmembrado: TCheckBox;
    ImageList1: TImageList;
    dsCabecalho: TDataSource;
    dsCompara: TDataSource;
    spbMotorista: TSpeedButton;
    spbVeiculo: TSpeedButton;
    spbCarreta1: TSpeedButton;
    spbCarreta2: TSpeedButton;
    spbTipoVeiculo: TSpeedButton;
    Label16: TLabel;
    edtCodMotorista: TDBEdit;
    edtDesMotorista: TDBEdit;
    edtVeiculo: TDBEdit;
    edtCarreta1: TDBEdit;
    edtCarreta2: TDBEdit;
    edtCodTipodeVeiculo: TDBEdit;
    edtDesTipoDeVeiculo: TDBEdit;
    BtnMaisEsc: TBitBtn;
    Label17: TLabel;
    RadioGStatus: TRadioGroup;
    CBoxMostraCancelados: TCheckBox;
    DBGridProg: TDBGrid;
    MDProgUltDoc: TRxMemoryData;
    RDprint1: TRDprint;
    QryCab: TQuery;
    QryItens: TQuery;
    SBarInfo: TStatusBar;
    ContTrocadeFormulrios: TMenuItem;
    Pedidodecliente1: TMenuItem;
    PnlLocalid: TPanel;
    MEdtLocOrige: TMaskEdit;
    Carga: TLabel;
    SButLocOrige: TSpeedButton;
    EdtDescrLocOrige: TDBEdit;
    EdtUFLocOrige: TDBEdit;
    MEdtLocDeste: TMaskEdit;
    Descarga: TLabel;
    SButLocDeste: TSpeedButton;
    EdtDescrLocDeste: TDBEdit;
    EdtUFLocDeste: TDBEdit;
    Label18: TLabel;
    BtnMaisLoc: TBitBtn;
    DSProgUltDoc: TDataSource;
    DBGridProgUltDoc: TDBGrid;
    PMenuGeral: TPopupMenu;
    IMenuProgramacao: TMenuItem;
    IMenuProgUltDoc: TMenuItem;
    IMenuAltLocalid: TMenuItem;
    IMenuVisualizaPedido: TMenuItem;
    IMenuCanRea: TMenuItem;
    IMenuMarDes: TMenuItem;
    IMenuImprimirDocto: TMenuItem;
    IMenuReimprimir: TMenuItem;
    QryAuxiliar: TQuery;
    GBoxParamServ: TGroupBox;
    GBoxSaiGar_CheEnt: TGroupBox;
    Label36: TLabel;
    Label37: TLabel;
    CBoxDBBaixaAuto: TDBCheckBox;
    CBoxDBImpServ: TDBCheckBox;
    DEdtSaiGar_CheEnt: TDBDateEdit;
    TEdtSaiGar_CheEnt: TTimeEdit;
    dsItens: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Sada1Click(Sender: TObject);
    procedure BGMPedeEmpresaPedeEmpresaExit(Sender: TObject);
    procedure BGMPedeFilialPedeFilialGaragemExit(Sender: TObject);
    procedure BgmPedeGaragemPedeGaragemExit(Sender: TObject);
    procedure DEdtDataPedidoIniExit(Sender: TObject);
    procedure RGroupTpServicoClick(Sender: TObject);
    procedure Limpar1Click(Sender: TObject);
    procedure SButSetasClick(Sender: TObject);
    procedure PMenuGeralPopup(Sender: TObject);
    procedure IMenuProgramacaoClick(Sender: TObject);
    procedure ConsultarClick(Sender: TObject);
    procedure DBGridProgDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure MDProgAfterOpen(DataSet: TDataSet);
    procedure edtVeiculoExit(Sender: TObject);
    procedure edtCodMotoristaExit(Sender: TObject);
    procedure edtCarreta1Exit(Sender: TObject);
    procedure edtCarreta2Exit(Sender: TObject);
    procedure edtCodMotoristaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodMotoristaChange(Sender: TObject);
    procedure edtVeiculoChange(Sender: TObject);
    procedure edtCarreta1Change(Sender: TObject);
    procedure edtCarreta2Change(Sender: TObject);
    procedure edtCodTipodeVeiculoExit(Sender: TObject);
    procedure BtnMaisEscClick(Sender: TObject);
    procedure DBGridProgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridProgTitleClick(Column: TColumn);
    procedure Gravar1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MDProgAfterScroll(DataSet: TDataSet);
    procedure RDprint1NewPage(Sender: TObject; Pagina: Integer);
    procedure ContTrocadeFormulriosClick(Sender: TObject);
    procedure MEdtLocOrigeChange(Sender: TObject);
    procedure MEdtLocOrigeEnter(Sender: TObject);
    procedure MEdtLocOrigeExit(Sender: TObject);
    procedure spbMotoristaClick(Sender: TObject);
    procedure MDProgUltDocFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure edtCodTipodeVeiculoEnter(Sender: TObject);
    procedure DEdtSaiGar_CheEntEnter(Sender: TObject);
    procedure DEdtSaiGar_CheEntExit(Sender: TObject);
    procedure CBoxDBBaixaAutoExit(Sender: TObject);
  private
    { Private declarations }
    vFiltro              : Boolean ;
    vLinha               : Integer ;
    vTipoVeiculos        : TTiposDeVeiculos;
    vCarga_Encomenda,
    vVerificaTipoVeiculo : String ;
    vDocto               : TDoctoCont ;
    vcGaragem            : TGaragem ;
    vcLocalidade         : TLocalidade ;
    vDadosNFCont         : TDadosNFCont ;
    Procedure HabilitaBotoes ;
    procedure HabilitarCarretas(pVeic: String = ''; pCodVeic: String = '');
    procedure DefinirTipoDeVeiculoBitrem;
    function ProximoControleFocado(Ativo, Atual: TWinControl; vVerificarShiftTab: Boolean = false): Boolean;
    function CapacVeiculos(vMostrarMensagem: Boolean): Boolean;
    function CarretasSaoIguais(Sender: TObject): Boolean;
    procedure LimparCarretas;
    procedure GravaOuAtualizaDocto(pBaixaDoc : Boolean = False) ;
    Function LocalizaServico(pTpServico : String; pAnterior : Boolean = False) : String ;

    function ImpressaoDoctoCont(Var pSimParaTodos, pMostraSetupRD : Boolean; pNumero_Docto : Integer = 0; pTpServico : String = '') : Boolean ;

    function DadosNF(pQuery: TDataSet; pCarSeparacao : String = '/' ; pConcatena : String = 'NSIDE'; pSeparacaoConc : String = '-' ): TDadosNFCont ;
    function ProxLinha : Integer ;
    function ProcuraServComNumContainer(pCodIntPedido, pCodIntItemPedido : Integer ) : TDadosCont;
    {
    Modelos de layout cadastrados a partir da tela de "Troca de formulários".
    --- ----------------- ------------------- ------------------- --------------------- --------------------- ---------------------- ----------------
    COD CLIENTE           Pedido              Apanha              Retirada              Embarque              Devolucao              DTR
    --- ----------------- ------------------- ------------------- --------------------- --------------------- ---------------------- ----------------
    000 Geral             ImpPedidoModelo_000 ImpApanhaModelo_000 ImpRetiradaModelo_000 ImpEmbarqueModelo_000 ImpDevolucaoModelo_000 ImpDTRModelo_000
    }
//    procedure ImpPedidoModelo_000(pQryCab, pQryItens : TQuery) ;
    procedure ImpApanhaModelo_000(pQryCab, pQryItens : TQuery) ;
    procedure ImpRetiradaModelo_000(pQryCab, pQryItens : TQuery) ;
    procedure ImpEmbarqueModelo_000(pQryCab, pQryItens : TQuery) ;
    procedure ImpDevolucaoModelo_000(pQryCab, pQryItens : TQuery) ;
    procedure ImpDTRModelo_000(pQryCab, pQryItens : TQuery) ;
  public
    { Public declarations }
  end;

Const
  cMes : Array[1..12] of String[9] = ('JANEIRO','FEVEREIRO','MARCO'   ,'ABRIL'  ,'MAIO'    ,'JUNHO',
                                      'JULHO'  ,'AGOSTO'   ,'SETEMBRO','OUTUBRO','NOVEMBRO','DEZEMBRO');

var
  FrmCGSContProgramacaoDeContainer: TFrmCGSContProgramacaoDeContainer;

implementation

uses dmControle, MenuPrincipal, Bgm_string, Bgm_dados, Bgm_tela, DmCGSDocumentos,
     CGSComum, TUR_Funcoes, SetupRD, CGSContPedidoDeCliente, CGSEmissaoDocumento,
     CGSContControleDeFormularios, 
     {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{$R *.dfm}

procedure TFrmCGSContProgramacaoDeContainer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vcGaragem.Free ;
  vTipoVeiculos.Free ;
  vcLocalidade.Free ;
  Action := Cafree ;
end;

procedure TFrmCGSContProgramacaoDeContainer.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt}
  HabilitaBotoes ;
end;

procedure TFrmCGSContProgramacaoDeContainer.FormShow(Sender: TObject);
Var
  i : Integer ;
begin
  BGMPedeEmpresa.Sistema := vcSistema ;
  BGMPedeEmpresa.Usuario := vcUsuario ;
  vcGaragem              := TGaragem.Create ;
  vcLocalidade           := TLocalidade.Create ;

  vTipoVeiculos := TTiposDeVeiculos.Create;

  PnlProg.Parent := PnlTela ;
  Limpar1.Click ;

  TRadioGroup(RadioGStatus.Controls[0]).Font.Color := clRed ;        // Pendente
  TRadioGroup(RadioGStatus.Controls[1]).Font.Color := $00009100 {clLime} ;       // Escalado
  TRadioGroup(RadioGStatus.Controls[2]).Font.Color := clBlue ;       // Programado
  TRadioGroup(RadioGStatus.Controls[3]).Font.Color := clMedGray ;    // Realizado

  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt}
end;

procedure TFrmCGSContProgramacaoDeContainer.Sada1Click(Sender: TObject);
begin
  Close ;
end;

procedure TFrmCGSContProgramacaoDeContainer.BGMPedeEmpresaPedeEmpresaExit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) And $1000000) <> 0) And vTAB) Then
  Begin
    vEsc := False ;
    BGMPedeEmpresa.SetFocus ;
    Exit ;
  End ; // If vEsc Or (...

  If vAbandonaExit Or
     Limpar1.FocuSed Then
  Begin
    vAbandonaExit := False ;
    Exit ;
  End ; // If vAbandonaExit Or ...

  BGMPedeFilial.CodigoEmpresa  := BGMPedeEmpresa.CodigoEmpresa ;
  BGMPedeFilial.PopulaComboBox ;
  If Trim(BGMPedeFilial.Text) = '' Then
  Begin
    MensagemDLG('Nenhuma filial cadastrada para esta empresa.', mtInformacao, mbok) ;
    BGMPedeEmpresa.SetFocus ;
  End ; // If Trim(BGMPedeFilial1.Text) = '' Then
end;

procedure TFrmCGSContProgramacaoDeContainer.BGMPedeFilialPedeFilialGaragemExit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) And $1000000) <> 0) And vTAB) Then
  Begin
    vEsc := False ;
    BGMPedeFilial.LimpaFilial ;
    Exit ;
  End ; // If vEsc Or (...

  If vAbandonaExit Or
     Limpar1.FocuSed Then
  Begin
    vAbandonaExit := False ;
    Exit ;
  End ; // If vAbandonaExit Or ...

  BgmPedeGaragem.CodigoEmpresa  := BGMPedeFilial.CodigoEmpresa ;
  BgmPedeGaragem.CodigoFilial   := BGMPedeFilial.CodigoFG ;
  BgmPedeGaragem.PopulaComboBox ;
end;

procedure TFrmCGSContProgramacaoDeContainer.BgmPedeGaragemPedeGaragemExit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) And $1000000) <> 0) And vTAB) Then
  Begin
    vEsc := False ;
    BgmPedeGaragem.LimparGaragem ;
    Exit ;
  End ; // If vEsc Or (...

  If vAbandonaExit Or
     Limpar1.FocuSed Then
  Begin
    vAbandonaExit := False ;
    Exit ;
  End ; // If vAbandonaExit Or ...

  with QryPesquisa do
  begin
    Close ;
    SQL.Clear ;
    SQL.Add('SELECT PEDIDOGERADOSEMROTA') ;
    SQL.Add('     , BLOQUEIA_ACTGERADASEMROTA') ;
    SQL.Add('     , BLOQUEIADOCTOSEMTABELAS') ;
    SQL.Add('     , ANALISEEXIGCLIENTES') ;
    SQL.Add('     , FLAG_A_VISTA') ;
    SQL.Add('     , PEDEINSCESTADNOSERVFRETE') ;
    SQL.Add('     , PERMITEALTERAR_DADOSCLIENTES') ;
    SQL.Add('     , FRETE_COMBINADO') ;
    SQL.Add('  FROM PBA012') ;
    SQL.Add(' WHERE GARAGEM = :P_GARAGEM') ;
    SQL.Add('   AND FILIAL  = :P_FILIAL') ;
    SQL.Add('   AND EMPRESA = :P_EMPRESA') ;
    ParamByName('P_EMPRESA').AsInteger := BgmPedeGaragem.CodigoEmpresa ;
    ParamByName('P_FILIAL' ).AsInteger := BgmPedeGaragem.CodigoFilial ;
    ParamByName('P_GARAGEM').AsInteger := BgmPedeGaragem.CodigoGa ;
    If AbrirQuery(QryPesquisa,'Pesq','Parâmetros por locais não cadastrado.','Pesquisando...').Achou Then
    Begin
      vParametros.AnalisaPedidoGeradoSemRota   := FieldByName('PEDIDOGERADOSEMROTA'         ).AsString = 'S' ;
      vParametros.BloqueiaACTSemRota           := FieldByName('BLOQUEIA_ACTGERADASEMROTA'   ).AsString = 'S' ;
      vParametros.BloqueiaDoctoSemTabela       := FieldByName('BloqueiaDoctoSemTabelas'     ).AsString = 'S' ;
      vParametros.AnaliseExigClientes          := FieldByName('ANALISEEXIGCLIENTES'         ).AsString = 'S' ;
      vParametros.BaixarServicoPagosAVista     := FieldByName('FLAG_A_VISTA'                ).AsString = 'S' ;
      vParametros.PedeInscEstadNoServFrete     := FieldByName('PEDEINSCESTADNOSERVFRETE'    ).AsString = 'S' ;
      vParametros.PermiteAlterar_DadosClientes := FieldByName('PERMITEALTERAR_DADOSCLIENTES').AsString = 'S' ;

      vcGaragem.Filial.Empresa.Codigoempresa := BgmPedeGaragem.CodigoEmpresa ;
      vcGaragem.Filial.Codigofl              := BgmPedeGaragem.CodigoFilial ;
      vcGaragem.Codigoga                     := BgmPedeGaragem.CodigoGa ;
      vcGaragem.Atualiza ;
    End Else // If AbrirQuery(...
    Begin
      BgmPedeGaragem.LimparGaragem ;
      ColocarFoco(BgmPedeGaragem) ;
    End ; // End Else // If AbrirQuery(...
  end;
end;

procedure TFrmCGSContProgramacaoDeContainer.DEdtDataPedidoIniExit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) And $1000000) <> 0) And vTAB) Then
  Begin
    vEsc := False ;
    If Sender Is TEdit Then
      TEdit(Sender).Clear
    Else If Sender Is TDateEdit Then
      TDateEdit(Sender).Clear
    Else If Sender Is TMaskEdit Then
      TMaskEdit(Sender).Clear ;

    If Sender = DEdtDataPedidoIni Then
      TRadioGroup(RGroupTpServico.Controls[RGroupTpServico.ItemIndex]).SetFocus ;

    Exit ; 
  End ; // If vEsc Or (...

  If vAbandonaExit Or
     Gravar1.FocuSed Or
     Limpar1.FocuSed Then
  Begin
    vAbandonaExit := False ;
    Exit ;
  End ; // If vAbandonaExit Or ...

  ValidaObjetosPorFaixa(Self,Sender) ;
end;

procedure TFrmCGSContProgramacaoDeContainer.RGroupTpServicoClick(Sender: TObject);
begin
  MEdtContainerIni.Enabled := RGroupTpServico.ItemIndex <> 1 ;
  MEdtContainerFin.Enabled := MEdtContainerIni.Enabled ;
  MEdtContainerIni.Color   := IIf(MEdtContainerFin.Enabled,clWindow,clBtnFace) ;
  MEdtContainerFin.Color   := MEdtContainerIni.Color ;
  MEdtContainerIni.Clear ;
  MEdtContainerFin.Clear ;
end;

procedure TFrmCGSContProgramacaoDeContainer.Limpar1Click(Sender: TObject);
Var
  i : Integer ;
begin
  vAbandonaExit    := True ;
  If ActiveControl <> Limpar1 Then
    ColocarFoco(Limpar1) ;

  Gravar1.Enabled  := False ;
  Limpar1.Enabled  := False ;
  For i := 0 to ComponentCount - 1 do
  Begin
         If Components[i] Is TEdit     Then TEdit(    Components[i]).Clear
    Else If Components[i] Is TMaskEdit Then TMaskEdit(Components[i]).Clear
    Else If Components[i] Is TDateEdit Then TDateEdit(Components[i]).Clear
    Else If Components[i] Is TTimeEdit Then TTimeEdit(Components[i]).Clear
    Else If Components[i] Is TMemo     Then TMemo(    Components[i]).Clear
    Else If Components[i] Is TCheckBox Then TCheckBox(Components[i]).Checked := True ;
  End ; // For i := 0 to ComponentCount - 1 do

  //              0
  SBarInfo.Panels[1].Text := 'Pendente:' ;
  SBarInfo.Panels[2].Text := 'Escalado:' ;
  SBarInfo.Panels[3].Text := 'Programado:' ;
  SBarInfo.Panels[4].Text := 'Realizado:' ;
  SBarInfo.Panels[5].Text := 'Total:' ;
  CBoxDesmembrado.Checked   := False ;
  RGroupTpServico.ItemIndex := 2 ;
  RadioGStatus.ItemIndex    := 4 ;
  RGroupTpServicoClick(Sender) ;

  MDProg.EmptyTable ;
  MDProgUltDoc.EmptyTable ;
  DBGridProgUltDoc.Visible := False ;

  BgmPedeGaragem.LimparGaragem ;
  BGMPedeFilial.LimpaFilial ;
  BgmPedeEmpresa.LimpaEmpresa ;
  BgmPedeEmpresa.PopulaComboBox ;

  If Not PnlFiltro.Visible Then
    SButSetasClick(SButSetas) ;

  HabilitaBotoes ;
  BgmPedeEmpresa.SetFocus ;
end;

procedure TFrmCGSContProgramacaoDeContainer.SButSetasClick(Sender: TObject);
begin
  PnlFiltro.Visible := Not PnlFiltro.Visible ;
  SButSetas.Glyph   := TImage(FindComponent('ImageSeta' + IIf(PnlFiltro.Visible,'U','D'))).Picture.Bitmap ;
  If PnlFiltro.Visible Then
  Begin
    PnlBotaoConsSet.Align  := alBottom ;
    PnlBotaoConsSet.Parent := PnlFiltro ;
  End Else // If PnlFiltro.Visible Then
  Begin
    PnlBotaoConsSet.Align  := alTop ;
    PnlBotaoConsSet.Parent := Self ;
  End ; // End Else // If PnlFiltro.Visible Then
  PnlBotaoConsSet.BevelInner := IIf(PnlFiltro.Visible,bvNone,bvLowered) ;
  PnlBotaoConsSet.BevelOuter := IIf(PnlFiltro.Visible,bvNone,bvRaised) ;
end;

procedure TFrmCGSContProgramacaoDeContainer.PMenuGeralPopup(Sender: TObject);
Var
  vRegAtual : TBookmark ;
  vCondicao : String ;
  vCtrcOuNf,
  vDtr,
  vCancelado,
  vRealizado,
  vDigitoMot,
  vDigitoVeic,
  vAchoUltDoc,
  vMarcado,
  vProgramado,
  vDesmembrado : Boolean ;
begin
  IMenuVisualizaPedido.Enabled := True ;

  vCtrcOuNf    := MDProg.FieldByName('TPSERVICO').AsString = 'F' ;
  vDtr         := MDProg.FieldByName('TPSERVICO').AsString = 'T' ;
  vCancelado   := MDProg.FieldByName('STATUS'   ).AsString = 'C' ;
  vRealizado   := MDProg.FieldByName('STATUS'   ).AsString = 'R' ;
  vMarcado     := MDProg.FieldByName('MARCA'    ).AsInteger = 1 ;
  vProgramado  := MDProg.FieldByName('D_SAIGAR_CHEENT').AsDateTime <> 0 ;
  vDigitoMot   := Trim(MDProg.FieldByName('MOTORISTA').AsString) <> '' ;
  vDigitoVeic  := Trim(MDProg.FieldByName('VEICULO'  ).AsString) <> '' ;
  vAchoUltDoc  := DBGridProgUltDoc.Visible ;
  vDesmembrado := MDProg.FieldByName('DESMEMBRADO').AsString = 'S' ;

  IMenuProgramacao.Visible     := PMenuGeral.PopupComponent = DBGridProg ;
  IMenuProgUltDoc.Visible      := IMenuProgramacao.Visible ;
  IMenuAltLocalid.Visible      := IMenuProgramacao.Visible ;
  IMenuVisualizaPedido.Visible := IMenuProgramacao.Visible ;
  IMenuCanRea.Visible          := IMenuProgramacao.Visible ;
  IMenuMarDes.Visible          := IMenuProgramacao.Visible ;
  IMenuImprimirDocto.Visible   := IMenuProgramacao.Visible ;
  IMenuReimprimir.Visible      := PMenuGeral.PopupComponent = DBGridProgUltDoc ;
  If IMenuProgramacao.Visible Then
  Begin
    IMenuProgramacao.Enabled     :=     (Not vCtrcOuNf)
                                    And (Not vDtr)
                                    And (Not vCancelado)
                                    And (Not vRealizado) ;

    IMenuAltLocalid.Enabled      := IMenuProgramacao.Enabled ;

    IMenuProgUltDoc.Enabled      := IMenuProgramacao.Enabled And (Not vDigitoMot)
                                                             And (Not vDigitoVeic)
                                                             And vAchoUltDoc ;

    IMenuCanRea.Enabled          := ((Not vRealizado) Or ((Not vDesmembrado) And (Not vCtrcOuNf)) ) And (Not vMarcado) ;

    IMenuMarDes.Enabled          :=     (IMenuProgramacao.Enabled Or vCtrcOuNf Or vDtr Or ((Not vDesmembrado) And (Not vCtrcOuNf)) )
                                    And vDigitoMot
                                    And vDigitoVeic
                                    And vProgramado 
                                    And (Not vCancelado)
                                    And ((Not vRealizado) Or ( ((Not vDesmembrado) And (Not vCtrcOuNf))
                                                             )
                                        ) ;
    MDProg.DisableControls ;
    vFiltro := False ;
    If IMenuMarDes.Enabled Then
    Begin
      vRegAtual := MDProg.GetBookmark ;
      vCondicao := '' ;
      If MDProg.Locate('MARCA',1,[loCaseInsensitive]) Then
        vCondicao := MDProg.FieldByName('TPSERVICO').AsString + MDProg.FieldByName('DESMEMBRADO').AsString + MDProg.FieldByName('STATUS').AsString ;

      MDProg.GotoBookmark(vRegAtual) ;
      IMenuMarDes.Enabled := (vCondicao='') Or (vCondicao = MDProg.FieldByName('TPSERVICO').AsString + MDProg.FieldByName('DESMEMBRADO').AsString + MDProg.FieldByName('STATUS').AsString) ;
    End ; // If IMenuMarDes.Enabled Then

    vRegAtual := MDProg.GetBookmark ;
    IMenuImprimirDocto.Enabled := False ;
    If IMenuMarDes.Enabled Then
    Begin
      IMenuImprimirDocto.Enabled := MDProg.Locate('MARCA',1,[loCaseInsensitive]) ;
      MDProg.GotoBookmark(vRegAtual) ;
    End ; // If IMenuMarDes.Enabled Then

    vFiltro := True ;
    MDProg.FreeBookmark(vRegAtual) ;
    MDProg.EnableControls ;
  End Else // If IMenuProgramacao.Visible Then
    IMenuReimprimir.Enabled      := MDProgUltDoc.FieldByName('TPSERVICO').AsString <> 'F' ;
end;

procedure TFrmCGSContProgramacaoDeContainer.IMenuProgramacaoClick(Sender: TObject);
  Procedure ColocarEmEdicao(DataSource: TDataSource) ;
  Begin
    with DataSource do
    begin
      DataSet.EnableControls ;
      Enabled := True ;
      if not(State in [dsEdit, dsInsert]) then
        Edit ;
    End ;
  End ; // Procedure ColocarEmEdicao(DataSource: TDataSource) ;

  Procedure EscalarProgramar ;
  Var i : Integer ;
  Begin
    ColocarEmEdicao(dsCabecalho) ;
    For i := 0 to MDProg.FieldCount-1 do
      If Pos(Right(MDProg.Fields[i].FieldName,5),'PRESA_ILIAL_RAGEM_RISTA_ICULO_RRETA_ETA_2') > 0 Then
        dsCabecalho.DataSet.FindField( MDProg.Fields[i].FieldName ).Value := MDProg.Fields[i].Value ;

    ColocarEmEdicao(dsCompara) ;
    For i := 0 to MDProg.FieldCount-1 do
      If (Pos(Right(MDProg.Fields[i].FieldName,5),'PRESA_ILIAL_RAGEM_RISTA_ICULO_RRETA_ETA_2') > 0) And
         (dsCompara.DataSet.FindField( MDProg.Fields[i].FieldName ) <> nil) Then
        dsCompara.DataSet.FindField( MDProg.Fields[i].FieldName ).Value := MDProg.Fields[i].Value ;

    ColocarEmEdicao(DSProg) ;
    CBoxDBBaixaAuto.Enabled     := (Pos(MDProg.FieldByName('TPSERVICO').AsString,'A_D') > 0) And (MDProg.FieldByName('DESMEMBRADO').AsString = 'S') ;
    TEdtSaiGar_CheEnt.TimeValue := MDProg.FieldByName('H_SAIGAR_CHEENT').AsDateTime ;

    DBGridProg.Enabled        := False ;
    PnlBotaoConsSet.Enabled   := False ;
    PnlFiltro.Enabled         := False ;
    PnlBotoes.Enabled         := False ;
    PnlEscala.Visible         := True ;
    GBoxSaiGar_CheEnt.Visible := True ;
    PnlEscala.Parent          := PnlTela ;
    edtCodMotorista.SetFocus ;
  End ; // Procedure EscalarProgramar ;

  Procedure ProgramarComOsDadosDoUltimoDocto ;
  Var i : Integer ;
  Begin
    With MDProg do
    Begin
      Edit ;
      For i := 0 to MDProgUltDoc.Fields.Count-1 do
        If Pos(Right(MDProgUltDoc.Fields[i].DisplayName,5),'RISTA_ICULO_RRETA_ETA_2') > 0 Then
          FindField(MDProgUltDoc.Fields[i].DisplayName).Value := MDProgUltDoc.Fields[i].Value ;

      FieldByName('GRAVAR').AsString := 'S' ;
      Post ;
    End ; // With MDProg do
  End ; // Procedure ProgramarComOsDadosDoUltimoDocto ;

  Procedure AlteraLocalidades ;
  Begin
    DBGridProg.Enabled      := False ;
    PnlBotaoConsSet.Enabled := False ;
    PnlFiltro.Enabled       := False ;
    PnlBotoes.Enabled       := False ;
    PnlLocalid.Visible      := True ;
    PnlLocalid.Parent       := PnlTela ;
    MEdtLocOrige.Text       := MDProg.FieldByName('LOCALID_COLETA' ).AsString ;
    MEdtLocDeste.Text       := MDProg.FieldByName('LOCALID_ENTREGA').AsString ;
    MEdtLocOrigeExit(MEdtLocOrige) ;
    MEdtLocOrigeExit(MEdtLocDeste) ;
    MEdtLocOrige.SetFocus ;
  End ; // Procedure AlteraLocalidades ;

  Procedure VisualizaPedido ;
  Var vItemDeMenuChamadorAnt : String ;
  Begin
    vItemDeMenuChamadorAnt               := frmMenuPrincipal.vItemDeMenuChamador ;
    frmMenuPrincipal.vItemDeMenuChamador := TComponent(Sender).Name ;


    With TfrmCGSContPedidoDeCliente.Create(Self) do
    Begin
      BGMPedeEmpresa.vPosicionarNaEmpresa := Self.BgmPedeGaragem.CodigoEmpresa ;
      BGMPedeEmpresa.PopulaComboBox ;
      BGMPedeFilial.CodigoEmpresa         := Self.BgmPedeGaragem.CodigoEmpresa ;
      BGMPedeFilial.vPosicionarNaFilial   := Self.BgmPedeGaragem.CodigoFilial ;
      BGMPedeFilial.PopulaComboBox ;
      BgmPedeGaragem.CodigoEmpresa        := Self.BgmPedeGaragem.CodigoEmpresa ;
      BgmPedeGaragem.CodigoFilial         := Self.BgmPedeGaragem.CodigoFilial ;
      BgmPedeGaragem.vPosicionarNaGaragem := Self.BgmPedeGaragem.CodigoGa ;
      BgmPedeGaragem.PopulaComboBox ;
      MEdtSerie.Text                      := MDProg.FieldByName('SERIE'        ).AsString ;
      MEdtNrPedido.Text                   := MDProg.FieldByName('NUMERO_PEDIDO').AsString ;

      BGMPedeEmpresaPedeEmpresaEnter(BGMPedeEmpresa) ;
      BGMPedeEmpresaPedeEmpresaExit(BGMPedeEmpresa) ;
      BGMPedeFilialPedeFilialGaragemExit(BGMPedeFilial) ;
      BgmPedeGaragemPedeGaragemExit(BgmPedeGaragem) ;
      MEdtSerieExit(MEdtSerie) ;
      MEdtNrPedidoExit(MEdtNrPedido) ;
      ShowModal ;
      Free ;
    End ; // With TfrmCGSContPedidoDeCliente.Create(Self) do

    frmMenuPrincipal.vItemDeMenuChamador := vItemDeMenuChamadorAnt ;
    If frmMenuPrincipal.vItemDeMenuChamador <> '' Then
      DireitoAoBotoesDaTela(vcUsuario, vcSistema, frmMenuPrincipal.vItemDeMenuChamador) ;
  End ; // Procedure VisualizaPedido ;

  Procedure MarcaDesmarcar ;
  Var
    vEscalado : Boolean ;
  Begin
    vEscalado := (Trim(MDProg.FieldByName('MOTORISTA' ).AsString) <> '') And (Trim(MDProg.FieldByName('VEICULO'  ).AsString) <> '') ;

    TDBGrid(ActiveControl).DataSource.DataSet.Edit ;
    MDProg.FieldByName('MARCA' ).AsInteger  := IIf((Sender = IMenuCanRea) And (IMenuCanRea.Caption = 'Cancelar'),2,IIf(MDProg.FieldByName('MARCA').AsInteger = 0,IIf(Sender = IMenuCanRea,2,1),0 )) ;
    If Sender = IMenuCanRea Then
      MDProg.FieldByName('GRAVAR').AsString := 'S' ;

    MDProg.FieldByName('STATUS').AsString := IIf(MDProg.FieldByName('MARCA'           ).AsInteger  = 2  ,'C',
                                             IIf(MDProg.FieldByName('STATUS_OLD'      ).AsString   = 'R','R',
                                             IIf(vEscalado And (MDProg.FieldByName('D_SAIGAR_CHEENT').AsDateTime <> 0),'G',
                                             IIf(vEscalado,'E','P')))) ;
    TDBGrid(ActiveControl).DataSource.DataSet.Post ;
  End ; // Procedure MarcaDesmarcar ;

  Procedure ImprimirDocto ;
  Var
    i,
    vRegistro,
    vTotalReg     : Integer ;
    vGeraCTRC,
    vDesmembrado,
    vMostraSetupRD,
    vSimParaTodos : Boolean ;
    vRegAtual,
    vRegAtual2    : TBookmark ;
    procedure PararEdicao(DataSource: TDataSource);
    begin
      with DataSource do
      begin
        DataSet.DisableControls;
        Enabled := false;
        if State in [dsEdit, dsInsert] then
          DataSet.Cancel;
      end;
    end; // procedure PararEdicao(DataSource: TDataSource);

    Procedure PopulaMDCabecalho(pMD : TRxMemoryData ) ;
    Var i : Integer ;
    Begin
      For i := 0 to pMD.Fields.Count-1 do
        If dmCGSDoc.rxCabecalho.FindField(pMD.Fields[i].DisplayName) <> Nil Then
          dmCGSDoc.rxCabecalho.FindField(pMD.Fields[i].DisplayName).Value := pMD.Fields[i].Value ;
    End ; // Procedure PopulaMDCabecalho(pMD : TRxMemoryData ) ;

  Begin
    With MDProg do
    Begin
      vRegAtual := GetBookmark ;
      vFiltro   := False ;

      Locate('MARCA',1,[loCaseInsensitive]) ;
      vGeraCTRC := FieldByName('TPSERVICO').AsString = 'F' ;

      DisableControls ;
      BarraDeProgresso(0,0,0) ;
      vRegistro      := 0 ;
      vTotalReg      := RecordCount ;
      vDesmembrado   := False ;

      If vGeraCTRC Then
      Begin
(*
        ColocarEmEdicao(dsCabecalho) ;
        ColocarEmEdicao(dsItens) ;

        dmCGSDoc.rxCabecalho.EmptyTable ;
        dmCGSDoc.rxItens.EmptyTable ;

        First ;
        While Not Eof do
        Begin
          If FieldByName('MARCA').AsInteger = 1 Then
          Begin
            BarraDeProgresso(1,IncInt(vRegistro),vTotalReg,'Gerando documento...','E');
            vDesmembrado := FieldByName('DESMEMBRADO').AsString='S' ;

//            dmCGSDoc.rxCabecalho.BeforePost := dmCGSDoc.rxCabecalhoAntesDeGravar ;
            dmCGSDoc.rxCabecalho.BeforePost := dmCGSDoc.rxCabecalhoAntesDeGravarEmissaoAutomatica ;

            dmCGSDoc.rxCabecalho.Append ;

            If FieldByName('TIPO_PEDIDO').AsString = 'I' Then
            Begin
              MDProgUltDoc.Locate('CODINTPEDIDO;CODINTITEMPEDIDO;TPSERVICO',VarArrayOf([FieldByName('CODINTPEDIDO'    ).AsInteger
                                                                                       ,FieldByName('CODINTITEMPEDIDO').AsInteger
                                                                                       ,'R']),[loCaseInsensitive]) ;
              PopulaMDCabecalho(MDProgUltDoc) ;
            End Else // If FieldByName('TIPO_PEDIDO').AsString = 'I' Then
              PopulaMDCabecalho(MDProg) ;

            dmCGSDoc.rxCabecalho.FindField('TIPO_DOCTO'     ).AsInteger := FieldByName('TIPO_DOCTOCTRC').AsInteger ;
            dmCGSDoc.rxCabecalho.FindField('TIPO_FRETE'     ).AsString  := cTipoFrete_CIF ;
            dmCGSDoc.rxCabecalho.FindField('CARGA_ENCOMENDA').AsString  := vCarga_Encomenda ;
            dmCGSDoc.rxCabecalho.Post ;

            dmCGSDoc.rxCabecalho.BeforePost := nil;

            With QryPesquisa do
            Begin
              Close ;
              Sql.Clear ;
              Sql.Add('SELECT A.NOTA_FISCAL') ;
              Sql.Add('     , A.SERIE_NF') ;
              Sql.Add('     , A.ITEM_GRUPO') ;
              Sql.Add('     , B.DESCRICAO_PROD') ;
              Sql.Add('     , A.DT_EMISSAO_NF') ;
              Sql.Add('     , A.ALTURA_M3') ;
              Sql.Add('     , A.LARGURA_M3') ;
              Sql.Add('     , A.PROFUNDIDADE_M3') ;
              Sql.Add('     , A.TOTAL_M3') ;
              Sql.Add('     , A.VOLUMES') ;
              Sql.Add('     , A.PESO_LIQUIDO') ;
              Sql.Add('     , A.PESO_BRUTO') ;
              Sql.Add('     , A.VLR_MERCADORIA') ;
              Sql.Add('  FROM CGS_CONTNFSERVICOS A') ;
              Sql.Add('     , CMA041             B') ;
              Sql.Add(' WHERE A.ITEM_GRUPO       = B.CODIGO') ;
              Sql.Add('   AND A.CODINTPEDIDO     = :P_CODINTPEDIDO') ;
              Sql.Add('   AND A.CODINTITEMPEDIDO = :P_CODINTITEMPEDIDO') ;
              ParamByName('P_CODINTPEDIDO'    ).AsInteger := MDProg.FieldByName('CODINTPEDIDO'    ).AsInteger ;
              ParamByName('P_CODINTITEMPEDIDO').AsInteger := MDProg.FieldByName('CODINTITEMPEDIDO').AsInteger ;
              AbrirQuery(QryPesquisa,'PesqNF') ;
              First ;
              While Not Eof do
              Begin
                dmCGSDoc.rxItens.Append ;
                For i := 0 to MDProg.Fields.Count-1 do
                  If dmCGSDoc.rxItens.FindField(MDProg.Fields[i].DisplayName) <> Nil Then
                    dmCGSDoc.rxItens.FindField(MDProg.Fields[i].DisplayName).Value := MDProg.Fields[i].Value ;

                For i := 0 to Fields.Count-1 do
                  If dmCGSDoc.rxItens.FindField(Fields[i].DisplayName) <> Nil Then
                    dmCGSDoc.rxItens.FindField(Fields[i].DisplayName).Value := Fields[i].Value ;

                Next ;
                dmCGSDoc.rxItens.Post ;
              End ; // While Not Eof do
              EnableControls ;
            End ; // With QryPesquisa do

            vRegAtual2 := dmCGSDoc.rxCabecalho.GetBookMark ;
            dmCGSDoc.rxCabecalho.Edit;
            dmCGSDoc.CompletarDados(True, False, cChamada_ContProgramacaoDeContainer,False) ;

            dmCGSDoc.rxCabecalho.GoToBookMark(vRegAtual2) ;
            dmCGSDoc.rxCabecalho.FreeBookmark(vRegAtual2) ;
          End ; // If FieldByName('MARCA').AsInteger = 1 Then

          Next ;
        End ; // While Not Eof do


        With dmCGSDoc.rxCabecalho do
        Begin
          First ;
          While Not Eof do
          Begin
            If (FieldByName('TABELA_CALCULO').AsString = '') And
               (FieldByName('ERRO_EMISSAO'  ).AsString = '') Then
            Begin
              Edit ;
              FieldByName('ERRO_EMISSAO').AsString := 'Tabela não encontrada.' ;
              Post ;
            End ; // If (FieldByName('TABELA_CALCULO').AsString = '') And (...
            Next ;
          End ; // While Not Eof do
        End ; // With dmCGSDoc.rxCabecalho do


*)
        With TfrmCGSEmissaoDocumento.Create(Self) Do
        Begin
          vpEmpresa  := BgmPedeGaragem.CodigoEmpresa ;
          vpFilial   := BgmPedeGaragem.CodigoFilial ;
          vpGaragem  := BgmPedeGaragem.CodigoGa ;
          vpChamada  := cChamada_ContProgramacaoDeContainer ;
          vpRetornaDocsEmitidos := True ;

          ShowModal;

          If vpAtualizarDadosAposImpressos Then
          Begin
            If vcDatabase.InTransaction then
              vcDatabase.Rollback ;
            vcDatabase.StartTransaction ;

            rmdEmitidos.First ;
            While Not rmdEmitidos.Eof do
            Begin
              MDProg.Locate('ID',rmdEmitidos.FieldByName('ID').AsInteger,[loCaseInsensitive]) ;
              MDProg.Edit ;
              MDProg.FieldByName('SERIE_DOCTO' ).AsString  := rmdEmitidos.FieldByName('SERIE'       ).AsString ;
              MDProg.FieldByName('TIPO_DOCTO'  ).AsInteger := rmdEmitidos.FieldByName('TIPO_DOCTO'  ).AsInteger ;
              MDProg.FieldByName('NUMERO_DOCTO').AsInteger := rmdEmitidos.FieldByName('CONHECIMENTO').AsInteger ;
              MDProg.FieldByName('MARCA'       ).AsInteger := 3 ;
              MDProg.Post ;
              GravaOuAtualizaDocto(True) ; // Baixa o docto atual

              GravaLOG( vcSistema
                      , vcUsuario
                      , Now
                      , 'Programacao de container gero :'
                      + ' O docto: '   + StrZero(rmdEmitidos.FieldByName('CONHECIMENTO').AsInteger,7)
                      + ', serie: '    +         rmdEmitidos.FieldByName('SERIE'       ).AsString
                      + ', tp docto: ' +         rmdEmitidos.FieldByName('TIPO_DOCTO'  ).AsString
                      + ' para emp: '  + StrZero(BgmPedeGaragem.CodigoEmpresa,3)
                      + ', fil: '      + StrZero(BgmPedeGaragem.CodigoFilial,3)
                      + ', gar: '      + StrZero(BgmPedeGaragem.CodigoGa,3)) ;

              rmdEmitidos.Next ;
            End ; // While Not dmCGSDoc.rxCabecalho.Eof do

            vcDatabase.Commit ;
          End ; // If vpAtualizarDadosAposImpressos Then
          Free ;
        End ; // With TfrmCGSEmissaoDocumento.Create(Self) Do

//        If Not dsCabecalho.Enabled Then
//          PararEdicao(dsCabecalho) ;
//        If Not dsItens.Enabled Then
//          PararEdicao(dsItens) ;

      End Else // If vGeraCTRC Then
      Begin
        vDocto := CalculaProximoDoctoCont(BgmPedeGaragem.CodigoEmpresa
                                         ,BgmPedeGaragem.CodigoFilial
                                         ,BgmPedeGaragem.CodigoGa
                                         ,FieldByName('TPSERVICO').AsString) ;
        vSimParaTodos  := False ;
        vMostraSetupRD := True ;
        First ;
        While (Not Eof) And vDocto.Achou do
        Begin
          BarraDeProgresso(1,IncInt(vRegistro),vTotalReg,'Imprimindo...','E');

          If FieldByName('MARCA').AsInteger = 1 Then
          Begin
            If vcDataBase.InTransaction Then vcDataBase.Rollback ;
            vcDataBase.StartTransaction ;

            vDesmembrado := FieldByName('DESMEMBRADO').AsString='S' ;

            Edit ;
            vDocto := CalculaProximoDoctoCont(BgmPedeGaragem.CodigoEmpresa
                                             ,BgmPedeGaragem.CodigoFilial
                                             ,BgmPedeGaragem.CodigoGa
                                             ,FieldByName('TPSERVICO').AsString
                                             ,vDocto.Serie) ;
            FieldByName('SERIE_DOCTO' ).AsString  := vDocto.Serie ;
            FieldByName('TIPO_DOCTO'  ).AsInteger := vDocto.Tipo_Docto ;
            FieldByName('NUMERO_DOCTO').AsInteger := vDocto.Numero ;
            FieldByName('LAYOUT'      ).AsInteger := vDocto.LayOut ;
            GravaOuAtualizaDocto(True) ; // Baixa o docto atual

            FieldByName('CRIADOCTO'   ).AsString  := 'S' ;
            FieldByName('REEIMPRIMIR').AsString   := 'N' ;
            GravaOuAtualizaDocto ; // Cria novo docto

            If ImpressaoDoctoCont(vSimParaTodos,vMostraSetupRD) Then
            Begin
              If vDesmembrado And (FieldByName('TPSERVICO').AsString = 'E') Then
              Begin
                FieldByName('MARCA'     ).AsInteger := 0 ;
                FieldByName('TPSERVICO' ).AsString  := 'T' ;
                FieldByName('DESCTPSERV').AsString  := 'DTR' ;
                FieldByName('CRIADOCTO' ).AsString  := 'N' ;
              End Else // If FieldByName('TPSERVICO').AsString = 'E' Then
                FieldByName('MARCA'      ).AsInteger := 3 ;

              vcDataBase.Commit ;
            End Else // If ImpressaoDoctoCont(...
            Begin
              FieldByName('CRIADOCTO'  ).AsString := 'N' ;
              FieldByName('REEIMPRIMIR').AsString := 'S' ;
              vcDataBase.Rollback ;
            End ;
            Post ;

          End ; // If FieldByName('MARCA').AsInteger = 1 Then

          Next ;
        End ; // While (Not Eof) And ...
      End ; // End Else // If vGeraCTRC Then
      BarraDeProgresso(3,0,0) ;
      EnableControls ;

      If Not vDesmembrado Then
      Begin
        DisableControls ;
        First ;
        While Not Eof do
        Begin
          If FieldByName('MARCA').AsInteger = 3 Then
          Begin
            Edit ;
            FieldByName('MARCA'    ).AsInteger := IIf(FieldByName('TPSERVICO').AsString = 'F',3,1) ;
            FieldByName('CRIADOCTO').AsString  := 'N' ;
            FieldByName('TPSERVICO').AsString  := LocalizaServico(FieldByName('TPSERVICO').AsString) ;
            Post ;
          End ; // If FieldByName('MARCA').AsInteger = 3 Then
          Next ;
        End ; // While Not Eof do
        EnableControls ;
      End ; // If Not vDesmembrado Then

      DisableControls ;
      While Locate('MARCA',3,[loCaseInsensitive]) do
        Delete ;
      EnableControls ;

      If Not vDesmembrado And Locate('MARCA;REEIMPRIMIR',VarArrayOf([1,'N']),[loCaseInsensitive]) Then
        ImprimirDocto ;

      vFiltro   := True ;
      GotoBookmark(vRegAtual) ;
      FreeBookmark(vRegAtual) ;
    End ; // With MDProg do
  End ; // Procedure ImprimirDocto ;

  Procedure Reimprimir ;
  Var
    vMostraSetupRD,
    vSimParaTodos : Boolean ;
  Begin
    vMostraSetupRD := True ;
    vSimParaTodos  := True ;

    ImpressaoDoctoCont(vSimParaTodos
                      ,vMostraSetupRD
                      ,MDProgUltDoc.FieldByName('NUMERO_DOCTO').AsInteger
                      ,MDProgUltDoc.FieldByName('TPSERVICO'   ).AsString) ;
  End ; // Procedure Reimprimir ;
begin
  PMenuGeral.PopupComponent := ActiveControl ;
  PMenuGeralPopup(Sender) ;

  If TMenuItem(Sender).Visible And TMenuItem(Sender).Enabled Then
    Case PMenuGeral.Items.IndexOf(TMenuItem(Sender)) of
      0    : EscalarProgramar ;
      1    : ProgramarComOsDadosDoUltimoDocto ;
      2    : AlteraLocalidades ;
      3    : VisualizaPedido ;
      4..5 : MarcaDesmarcar ;
      6    : ImprimirDocto ;
      7    : Reimprimir ;
    End ; // Case PMenuGeral.Items.IndexOf(TMenuItem(Sender)) of

  HabilitaBotoes ;
end;

procedure TFrmCGSContProgramacaoDeContainer.HabilitaBotoes ;
Var
  vRegAtual : TBookmark ;
begin
  SButSetas.Enabled    := Not MDProg.IsEmpty ;
  PMenuGeral.AutoPopup := SButSetas.Enabled ;
  Gravar1.Enabled      := SButSetas.Enabled And (dm.vtemdireitoinclusao Or dm.vtemdireitoalteracao) ;
  If Gravar1.Enabled Then
  Begin
    vRegAtual := MDProg.GetBookmark ;
    vFiltro   := False ;
    Gravar1.Enabled := MDProg.Locate('GRAVAR','S',[loCaseInsensitive]) ;
    vFiltro   := True ;      
    MDProg.GotoBookmark(vRegAtual) ;
    MDProg.FreeBookmark(vRegAtual) ;
  End ; // If Gravar1.Enabled Then
  Consultar.Enabled := Not Gravar1.Enabled ;
  Limpar1.Enabled   := True ;
end;

procedure TFrmCGSContProgramacaoDeContainer.ConsultarClick(Sender: TObject);
Var
  i,
  vQtdeP,
  vQtdeE,
  vQtdeG,
  vQtdeR,
  vQtdeT      : Integer ;
  vDescTpServ : String ;
  vApaga      : Boolean ;
  Function ConverteValorPest : Real ;
  Begin
    Result := MDProg.FieldByName('TOTAL_PREST').AsFloat ;
    If Trim(MDProg.FieldByName('CODINDIC').AsString) = '' Then
      With QryAuxiliar do
      Begin
        Close ;
        Sql.Clear ;
        Sql.Add('SELECT A.VLINDIC') ;
        Sql.Add('  FROM FININDVL A') ;
        Sql.Add('     , (  SELECT MAX(DTINDIC) AS DTINDIC') ;
        Sql.Add('            FROM FININDVL') ;
        Sql.Add('           WHERE CODINDIC = :P_CODINDIC') ;
        Sql.Add('        GROUP BY CODINDIC) B') ;
        Sql.Add(' WHERE A.DTINDIC  = B.DTINDIC') ;
        Sql.Add('   AND A.CODINDIC = :P_CODINDIC') ;
        ParamByName('P_CODINDIC').AsString := MDProg.FieldByName('CODINDIC').AsString ;
        AbrirQuery(QryAuxiliar,'PesqIndice') ;
        Result := Result * FieldByName('VLINDIC').AsFloat ;
      End ; // With QryPesquisa do
  End ; // Function ConverteValorPest : Real ;
begin
  Consultar.Enabled  := False ;
  PnlEscala.Visible  := False ;
  PnlLocalid.Visible := False ;
  GBoxSaiGar_CheEnt.Visible := False ;
  If VerIficaParametrosDaTela Then
  Begin
    With QryPesquisa do
    Begin
      Close ;
      Sql.Clear ;
      Sql.Add('SELECT A.CODINTPEDIDO') ;
      Sql.Add('     , A.CODINTITEMPEDIDO') ;
      Sql.Add('     , A.STATUS') ;                // P=Pendente \ E=Escalada \ G=Programado \ R=Realizado
      Sql.Add('     , A.STATUS AS STATUS_OLD') ;
      Sql.Add('     , A.TPSERVICO') ;             // A=Apanha \ E=Embarque \ T=DTR \ R=Retirada \ D=Devolução \ F-Fim(Ultimo servico "CTRC ou NF")
      Sql.Add('     , A.DATA_DOCTO') ;
      Sql.Add('     , A.DATA_BAIXA') ;
      Sql.Add('     , A.TIPO_DOCTO') ;
      Sql.Add('     , A.NUMERO_DOCTO') ;
      Sql.Add('     , A.SERIE AS SERIE_DOCTO') ;
      Sql.Add('     , A.NUMCONTAINER') ;
      Sql.Add('     , A.MERCADORIA') ;
      Sql.Add('     , A.DESMEMBRADO') ;
      Sql.Add('     , A.TARA') ;
      Sql.Add('     , A.NUM_LACRE') ;
      Sql.Add('     , A.BAIXAAUTO') ;
      Sql.Add('     , A.IMPSERVICO') ;
      Sql.Add('     , A.DH_SAIGAR_CHEENT') ;
      Sql.Add('     , TO_DATE(TO_CHAR(A.DH_SAIGAR_CHEENT,''DD/MM/YYYY''),''DD/MM/YYYY'') AS D_SAIGAR_CHEENT') ;
      Sql.Add('     , A.DH_SAIGAR_CHEENT AS H_SAIGAR_CHEENT') ;
      Sql.Add('     , B.EMPRESA') ;
      Sql.Add('     , B.FILIAL') ;
      Sql.Add('     , B.GARAGEM') ;
      Sql.Add('     , B.TIPO_PEDIDO') ;
      Sql.Add('     , DECODE(B.TIPO_PEDIDO,''E'',5,4) AS ITIPO_PEDIDO') ;
      Sql.Add('     , B.SERIE') ;
      Sql.Add('     , B.NUMERO_PEDIDO') ;
      Sql.Add('     , B.DATAHORA_PEDIDO') ;
      Sql.Add('     , B.SOL_NOME') ;
      Sql.Add('     , B.CLIENTE_FAT') ;
      Sql.Add('     , B.REM_CODIGO') ;
      Sql.Add('     , B.REM_CGC') ;
      Sql.Add('     , B.DEST_CODIGO') ;
      Sql.Add('     , B.DEST_CGC') ;
      Sql.Add('     , DECODE(B.LOCALID_COLETA,B.LOCALID_ENTREGA,8,1) AS TIPO_DOCTOCTRC') ;

      Sql.Add('     , B.NUMBOOKING') ;
      Sql.Add('     , DECODE(A.LOCALID_COLETA, NULL,B.LOCALID_COLETA, A.LOCALID_COLETA)  AS LOCALID_COLETA') ;
      Sql.Add('     , DECODE(A.LOCALID_ENTREGA,NULL,B.LOCALID_ENTREGA,A.LOCALID_ENTREGA) AS LOCALID_ENTREGA') ;
      Sql.Add('     , B.DATAHORA_ABERTURA') ;
      Sql.Add('     , B.DATAHORA_DEADLINE') ;

      Sql.Add('     , D.CODCLI') ;
      Sql.Add('     , D.NRCLI') ;
      Sql.Add('     , D.RSOCIALCLI AS SOLICITANTE') ;

      Sql.Add('     , A.MOTORISTA      , E.CODIGO AS CODIGO_MOTORISTA, E.NOME AS NOME_MOTORISTA, E.IDENTIFICACAO AS ID_MOTORISTA') ;
      Sql.Add('     , A.ID_VEICULO     , A.VEICULO     , F.PREFIXOVEIC AS PREFIXO_VEICULO') ;
      Sql.Add('     , A.ID_CARRETA     , A.CARRETA     , G.PREFIXOVEIC AS PREFIXO_CARRETA') ;
      Sql.Add('     , A.ID_CARRETA_2   , A.CARRETA_2   , H.PREFIXOVEIC AS PREFIXO_CARRETA_2') ;
      Sql.Add('     , A.TIPO_VEICULO   , N.DESCRICAO AS DESCRICAO_TIPO_VEICULO') ;

      Sql.Add('     , I.CODIGO AS ESPECIE') ;
      Sql.Add('     , I.DESCRICAO AS DESCRICAO_NATUREZA') ;
      Sql.Add('     , J.CODIGO AS UNIDADE') ;
      Sql.Add('     , J.DESCRICAO AS DESCRICAO_ESPECIE') ;
      Sql.Add('     , L.CODIGO AS TIPO_CONTAINER') ;
      Sql.Add('     , L.DESCRICAO AS DESCTIPO_CONTAINER') ;
      Sql.Add('     , L.CODINDIC') ;
      Sql.Add('     , L.VALOR AS TOTAL_PREST') ;
      Sql.Add('     , L.VALOR AS FRETE_VALOR') ;
      Sql.Add('     , M.CODIGO AS TERMINAL') ;
      Sql.Add('     , M.DESCRICAO AS DESCTERMINAL') ;

      Sql.Add('     , ''N'' AS FRETE_COMBINADO') ;
      Sql.Add('     , 0 AS MARCA') ;
      Sql.Add('     , 0 AS LAYOUT') ;
      Sql.Add('     , 1 AS QTDEDOC') ;
      Sql.Add('     , ''N'' AS GRAVAR') ;
      Sql.Add('     , ''N'' AS NECESSITACOMPL') ;
      Sql.Add('     , ''N'' AS CRIADOCTO') ;
      Sql.Add('     , ''S'' AS REEIMPRIMIR') ;
      Sql.Add('     , LPAD('' '',10) AS DESCTPSERV') ;

      Sql.Add('     , SYSDATE AS DATA_EMISSAO') ;
      Sql.Add('     , ROWNUM AS ID') ;

      Sql.Add('  FROM CGS_CONTSERVICOS          A') ;
      Sql.Add('     , CGS_CONTPEDIDOCLIENTE     B') ;
      Sql.Add('     , BGM_CLIENTE               D') ;
      Sql.Add('     , (SELECT IDENTIFICACAO') ;
      Sql.Add('             , CODIGO') ;
      Sql.Add('             , NOME') ;
      Sql.Add('             , CODINTFUNC') ;
      Sql.Add('          FROM (SELECT CODINTFUNC') ;
      Sql.Add('                     , ''I'' AS IDENTIFICACAO') ;
      Sql.Add('                     , CODFUNC AS CODIGO') ;
      Sql.Add('                     , NOMEFUNC AS NOME') ;
      Sql.Add('                  FROM FLP_FUNCIONARIOS') ;
      Sql.Add('                 UNION ALL') ;
      Sql.Add('                SELECT CODINTPROAUT AS CODINTFUNC') ;
      Sql.Add('                     , ''E'' AS IDENTIFICACAO') ;
      Sql.Add('                     , CODPROAUT AS CODIGO') ;
      Sql.Add('                     , NOMEPROAUT  AS NOME') ;
      Sql.Add('                  FROM FLP_PROAUTONOMOS)) E') ;
      Sql.Add('     , FRT_CADVEICULOS           F') ;
      Sql.Add('     , FRT_CADVEICULOS           G') ;
      Sql.Add('     , FRT_CADVEICULOS           H') ;
      Sql.Add('     , FTA005                    I') ;
      Sql.Add('     , EXA003                    J') ;
      Sql.Add('     , CGS_CONTTIPOCONTAINER     L') ;
      Sql.Add('     , CGS_CONTTERMINAL          M') ;
      Sql.Add('     , EXA023                    N') ;
      Sql.Add(' WHERE A.CODINTPEDIDO      = B.CODINTPEDIDO') ;
      Sql.Add('   AND B.SOL_CODIGO        = D.CODCLI') ;
      Sql.Add('   AND A.MOTORISTA         = E.CODINTFUNC(+)') ;
      Sql.Add('   AND A.ID_MOTORISTA      = E.IDENTIFICACAO(+)') ;
      Sql.Add('   AND A.VEICULO           = F.CODIGOVEIC(+)') ;
      Sql.Add('   AND A.CARRETA           = G.CODIGOVEIC(+)') ;
      Sql.Add('   AND A.CARRETA_2         = H.CODIGOVEIC(+)') ;
      Sql.Add('   AND B.ESPECIE           = I.CODIGO(+)') ;
      Sql.Add('   AND B.UNIDADE           = J.CODIGO(+)') ;
      Sql.Add('   AND A.TIPO_CONTAINER    = L.CODIGO') ;
      Sql.Add('   AND A.TERMINAL          = M.CODIGO') ;

      Sql.Add('   AND A.TIPO_VEICULO      = N.CODIGO') ;

      Sql.Add('   AND B.EMPRESA           = :P_EMPRESA') ;
      Sql.Add('   AND B.FILIAL            = :P_FILIAL') ;
      Sql.Add('   AND B.GARAGEM           = :P_GARAGEM') ;
      Sql.Add('   AND B.DATAHORA_ABERTURA >= :P_ABERTURA') ;
      Sql.Add('   AND B.DATAHORA_DEADLINE <= :P_DEADLINE') ;
      FormatParam.Execute ;
      If RGroupTpServico.ItemIndex <> 2 Then
        Sql.Add('   AND B.TIPO_PEDIDO        = ' + QuotedStr(RGroupTpServico.Items[RGroupTpServico.ItemIndex][1]) ) ;
      If CBoxDesmembrado.Checked Then
        Sql.Add('   AND A.DESMEMBRADO        = ''S''') ;
      Sql.Add('ORDER BY A.CODINTPEDIDO') ;
      Sql.Add('       , A.CODINTITEMPEDIDO') ;
      Sql.Add('       , A.DATA_DOCTO DESC') ;

      ParamByName('P_EMPRESA' ).AsInteger  := BgmPedeGaragem.CodigoEmpresa ;
      ParamByName('P_FILIAL'  ).AsInteger  := BgmPedeGaragem.CodigoFilial ;
      ParamByName('P_GARAGEM' ).AsInteger  := BgmPedeGaragem.CodigoGa ;
      ParamByName('P_ABERTURA').AsDateTime := StrToDateTime(DEdtDataPedidoIni.Text +' 00:00')  ;
      ParamByName('P_DEADLINE').AsDateTime := StrToDateTime(DEdtDataPedidoFin.Text +' 23:59')  ;
      If FormatParam.Achou Then
      Begin
        vFiltro := False ;
        If MDProg.Fields.Count = 0 Then
          MDProg.CopyStructure(QryPesquisa) ;
        MDProg.EmptyTable ;
        MDProg.Open ;

        If MDProgUltDoc.Fields.Count = 0 Then
          MDProgUltDoc.CopyStructure(QryPesquisa) ;
        MDProgUltDoc.EmptyTable ;
        MDProgUltDoc.Open ;

        MDProg.DisableControls ;
        MDProgUltDoc.DisableControls ;
        First ;
        While Not Eof do
        Begin
          vDescTpServ := '' ;
          If FieldByName('DESMEMBRADO').AsString = 'N' Then
            vDescTpServ := 'OS'
          Else // If FieldByName('DESMEMBRADO').AsString = 'N' Then
          If FieldByName('TPSERVICO').AsString = 'F' Then
            vDescTpServ := IIf(FieldByName('TIPO_DOCTOCTRC').AsInteger = 1,'CTRC','NF')
          Else // If FieldByName('TPSERVICO').AsString = 'F' Then
          For i := 0 to Length(cTipoDocCont) do
            If cTipoDocCont[i,2] = FieldByName('TPSERVICO').AsString Then
              vDescTpServ := cTipoDocCont[i,1] ;

          If FieldByName('NUMERO_DOCTO').AsInteger <> 0 Then
          Begin
            MDProgUltDoc.Append ;
            For i := 0 to MDProgUltDoc.Fields.Count-1 do
              MDProgUltDoc.Fields[i].Value := FindField(MDProgUltDoc.Fields[i].DisplayName).Value ;

            MDProgUltDoc.FindField('DESCTPSERV').AsString := vDescTpServ ;
          End ; // If (FieldByName('NUMERO_DOCTO').AsInteger <> 0) And (...

          If MDProg.Locate('CODINTPEDIDO;CODINTITEMPEDIDO',VarArrayOf([FieldByName('CODINTPEDIDO').AsInteger,FieldByName('CODINTITEMPEDIDO').AsInteger]),[loCaseInsensitive]) Then
          Begin
            If (FieldByName('DATA_BAIXA').AsDateTime <> 0) And
               (FieldByName('NUMERO_DOCTO').AsInteger <> 0) Or
               (((MDProg.FieldByName('TPSERVICO').AsString = 'T') And (FieldByName('DATA_BAIXA').AsDateTime = 0)) Or (FieldByName('DESMEMBRADO').AsString = 'N')) Then
            Begin
              If MDProg.FieldByName('NUMCONTAINER').AsString = '' Then
              Begin
                MDProg.Edit ;
                MDProg.FieldByName('NUMCONTAINER').AsString := FieldByName('NUMCONTAINER').AsString ;
                MDProg.FieldByName('NUM_LACRE'   ).AsString := FieldByName('NUM_LACRE'   ).AsString ;
                MDProg.FieldByName('TARA'        ).AsFloat  := FieldByName('TARA'        ).AsFloat ;
                MDProg.Post ;
              End ;
              Next ;
              Continue ;
            End ; // If (FieldByName('DATA_BAIXA').AsDateTime <> 0) And (...
            MDProg.Edit ;
          End Else // If MDProg.Locate(...
            MDProg.Append ;

          MDProg.Edit ;
          For i := 0 to MDProg.Fields.Count-1 do
            MDProg.Fields[i].Value                   := FindField(MDProg.Fields[i].DisplayName).Value ;
          MDProg.FieldByName('MARCA'      ).AsString := IIf(FieldByName('STATUS').AsString='C',2,0) ;
          MDProg.FieldByName('TOTAL_PREST').AsFloat  := ConverteValorPest ;
          MDProg.FieldByName('FRETE_VALOR').AsFloat  := MDProg.FieldByName('TOTAL_PREST').AsFloat ;
          MDProg.FindField('DESCTPSERV'   ).AsString := vDescTpServ ;
          MDProg.Post ;
          Next ;
        End ; // While Not Eof do

        MDProgUltDoc.First ;

        MDProg.First ;
        vApaga := False ;
        While Not MDProg.Eof do
        Begin
          If MDProg.FieldByName('STATUS').AsString = 'C' Then
            Case RadioGStatus.ItemIndex of
              0 : vApaga := (Trim(MDProg.FieldByName('MOTORISTA').AsString) <> '') And (Trim(MDProg.FieldByName('VEICULO').AsString) <> '') ;
              1 : vApaga := (Trim(MDProg.FieldByName('MOTORISTA').AsString)  = '')  Or (Trim(MDProg.FieldByName('VEICULO').AsString)  = '')  Or (MDProg.FieldByName('DH_SAIGAR_CHEENT').AsDateTime <> 0)  Or (MDProg.FieldByName('DH_SAIGAR_CHEENT').AsString <> '30/12/1899') ;
              2 : vApaga := MDProg.FieldByName('DH_SAIGAR_CHEENT').AsDateTime = 0 ;
              4 : vApaga := Not CBoxMostraCancelados.Checked
            End // Case RadioGStatus.ItemIndex of
          Else // If MDProg.FieldByName('STATUS').AsString = 'C' Then
            Case RadioGStatus.ItemIndex of
              0 : vApaga := MDProg.FieldByName('STATUS').AsString <> 'P' ;
              1 : vApaga := MDProg.FieldByName('STATUS').AsString <> 'E' ;
              2 : vApaga := MDProg.FieldByName('STATUS').AsString <> 'G' ;
              3 : vApaga := MDProg.FieldByName('STATUS').AsString <> 'R' ;
            End ; // Case RadioGStatus.ItemIndex of

          If vApaga Then
            MDProg.Delete
          Else // If vApaga Then
            MDProg.Next ;
        End ; // While Not MDProg.Eof do

        vQtdeP := 0 ;
        vQtdeE := 0 ;
        vQtdeG := 0 ;
        vQtdeR := 0 ;
        vQtdeT := 0 ;
        MDProg.First ;
        While Not MDProg.Eof do
        Begin
          If      MDProg.FieldByName('STATUS').AsString = 'P' Then
            Inc(vQtdeP)
          Else If MDProg.FieldByName('STATUS').AsString = 'E' Then
            Inc(vQtdeE)
          Else If MDProg.FieldByName('STATUS').AsString = 'G' Then
            Inc(vQtdeG)
          Else If MDProg.FieldByName('STATUS').AsString = 'R' Then
            Inc(vQtdeR) ;
          Inc(vQtdeT) ;

          MDProg.Next ;
        End ; // While Not Eof do
        SBarInfo.Panels[1].Text := 'Pendente: '   + StrZero(vQtdeP,4) ;
        SBarInfo.Panels[2].Text := 'Escalado: '   + StrZero(vQtdeE,4) ;
        SBarInfo.Panels[3].Text := 'Programado: ' + StrZero(vQtdeG,4) ;
        SBarInfo.Panels[4].Text := 'Realizado: '  + StrZero(vQtdeR,4) ;
        SBarInfo.Panels[5].Text := 'Total: '      + StrZero(vQtdeT,4) ;

        MDProg.First ;
        MDProg.EnableControls ;
        MDProgUltDoc.EnableControls ;
        vFiltro := True ;

        If MDProg.IsEmpty Then
          MensagemDLG('Não foram encontrados dados com os filtros selecionados.', mtInformacao, mbok)
        Else // If MDProg.IsEmpty Then
        Begin
          With dmCGSDoc.qryDados do
          Begin
            Close ;
            ParamByName('P_EMPRESA'     ).AsInteger := 0 ;
            ParamByName('P_FILIAL'      ).AsInteger := 0 ;
            ParamByName('P_GARAGEM'     ).AsInteger := 0 ;
            ParamByName('P_TIPO_DOCTO'  ).AsInteger := 0 ;
            ParamByName('P_SERIE'       ).AsString  := '' ;
            ParamByName('P_CONHECIMENTO').AsInteger := 0 ;
            AbrirQuery(dmCGSDoc.qryDados,'Pesq','','Pesquisando...') ;
          End ; // With dmCGSDoc.qryDados do

          With dmCGSDoc.qryItens do
          Begin
            Close ;
            ParamByName('P_EMPRESA'     ).AsInteger := 0 ;
            ParamByName('P_FILIAL'      ).AsInteger := 0 ;
            ParamByName('P_GARAGEM'     ).AsInteger := 0 ;
            ParamByName('P_TIPO_DOCTO'  ).AsInteger := 0 ;
            ParamByName('P_SERIE'       ).AsString  := '' ;
            ParamByName('P_CONHECIMENTO').AsInteger := 0 ;
            AbrirQuery(dmCGSDoc.qryItens,'Pesq','','Pesquisando...') ;
          End ; // With dmCGSDoc.qryItens do
          vCarga_Encomenda := dmCGSDoc.TrazClassificacaoDeTransporte(''
                                                                    ,BgmPedeGaragem.CodigoEmpresa
                                                                    ,BgmPedeGaragem.CodigoFilial) ;
        End ; // Else // If MDProg.IsEmpty Then

      End ; // If FormatParam.Achou Then
    End ; // With QryPesquisa do
    HabilitaBotoes ;
    TWinControl(FindComponent( IIf(MDProg.IsEmpty,'Consultar','DBGridProg') )).SetFocus ;
  End ; // If VerIficaParametrosDaTela Then
  HabilitaBotoes ;
end;

procedure TFrmCGSContProgramacaoDeContainer.DBGridProgDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
Var
  vRealizado,
  vProg  : Boolean ;
  vCor   : TColor ;
begin
  vRealizado := (MDProg.FieldByName('STATUS').AsString = 'R') And ((MDProg.FieldByName('DESMEMBRADO').AsString   = 'S') Or
                                                                   ((MDProg.FieldByName('TPSERVICO').AsString    = 'F') And
                                                                    (MDProg.FieldByName('DATA_BAIXA').AsDateTime <> 0))) ;

  vProg := (Trim(MDProg.FieldByName('MOTORISTA').AsString) <> '') And (Trim(MDProg.FieldByName('VEICULO').AsString) <> '') ;

  vCor  := IIf(vRealizado,                                            TRadioGroup(RadioGStatus.Controls[3]).Font.Color,
           IIf(MDProg.FieldByName('D_SAIGAR_CHEENT').AsDateTime <> 0, TRadioGroup(RadioGStatus.Controls[2]).Font.Color,
           IIf(vProg Or (MDProg.FieldByName('STATUS').AsString = 'E'),TRadioGroup(RadioGStatus.Controls[1]).Font.Color,
                                                                      TRadioGroup(RadioGStatus.Controls[0]).Font.Color))) ;
  If Column.Field.FieldName = 'MARCA' Then
  Begin
    If Column.Width <> 17 Then Column.Width := 17 ;
    DBGridProg.Canvas.FillRect(Rect) ;
    ImageList1.Draw(DBGridProg.Canvas
                   ,Rect.Left+1
                   ,Rect.Top+1
                   ,IIf(MDProg.IsEmpty,-1,MDProg.FieldByName('MARCA').AsInteger) ) ;
  End Else // If Column.Field.FieldName = 'MARCA' Then
  If Column.Field.FieldName = 'DESCTPSERV' Then
  Begin
    If Column.Width <> 65 Then Column.Width := 65 ;

    MudaACorDoGrid(Sender,Rect,DataCol,State,True, clWindow , vCor) ;
  End Else // If Column.Field.FieldName = 'DESCTPSERV' Then
    MudaACorDoGrid(Sender,Rect,DataCol,State,True, vCor , clWindow) ;
end;

procedure TFrmCGSContProgramacaoDeContainer.MDProgAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If DataSet = MDProg Then
    Begin
      TFloatField(FieldByName('DATAHORA_ABERTURA')).DisplayFormat := 'DD/MM/YYYY HH:NN' ;
      TFloatField(FieldByName('DATAHORA_DEADLINE')).DisplayFormat := 'DD/MM/YYYY HH:NN' ;
      TFloatField(FieldByName('TOTAL_PREST'      )).DisplayFormat := '#,###,###,##0.00' ;
    End ; // If DataSet = MDProg Then
    TFloatField(FieldByName('NUMERO_DOCTO'       )).DisplayFormat := '0000000' ;
    TFloatField(FieldByName('DATA_BAIXA'         )).DisplayFormat := 'DD/MM/YYYY HH:NN' ;
    TFloatField(FieldByName('DATA_DOCTO'         )).DisplayFormat := 'DD/MM/YYYY HH:NN' ;
  End ; // With DataSet Do
end;

procedure TFrmCGSContProgramacaoDeContainer.edtVeiculoExit(Sender: TObject);
Var
  vVerificaTipoVeiculo : String;
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) And $1000000) <> 0) And vTAB) Then
  Begin
    vEsc := False ;
    Exit ;
  End ; // If vEsc Or (...

  If CGS_VerificaParametrosLocais(BgmPedeGaragem.CodigoEmpresa
                                 ,BgmPedeGaragem.CodigoFilial
                                 ,BgmPedeGaragem.CodigoGA) Then
    HabilitarCarretas(dsCabecalho.DataSet.FieldByName('ID_VEICULO').AsString , dsCabecalho.DataSet.FieldByName('VEICULO').AsString );

  with dsCabecalho.DataSet do
  begin
    FieldByName('PREFIXO_VEICULO').AsString := edtVeiculo.Text;
    if not(dmCGSDoc.ConsistirVeiculo('PREFIXO_VEICULO'
                                    ,'ID_VEICULO'
                                    ,'VEICULO'
                                    ,'V'
                                    ,dmCGSDoc.rxCabecalho
                                    ,''
                                    ,BgmPedeGaragem.CodigoEmpresa
                                    ,BgmPedeGaragem.CodigoFilial
                                    ,BgmPedeGaragem.CodigoGA)) Or
       not(dmCGSDoc.VeiculoAutorizadoATransportarProduto(0, '', true)) or
       not(CapacVeiculos(True)) Then
    begin
      FieldByName('PREFIXO_VEICULO').Clear;
      ColocarFoco(edtVeiculo);
      spbVeiculo.Enabled := true;
    End
    Else
    Begin
      HabilitarCarretas( dsCabecalho.DataSet.FieldByName('ID_VEICULO').AsString , dsCabecalho.DataSet.FieldByName('VEICULO').AsString );

      if Trim(FieldByName('VEICULO').AsString) <>
         Trim(MDProg.FieldByName('VEICULO').AsString)  Then
      Begin
        vVerificaTipoVeiculo := dmCGSDoc.GetTipoVeiculo;
        DefinirTipoDeVeiculoBitrem;

        if (Pos('TRUC',               UpperCase(FieldByName('DESCRICAO_TIPO_VEICULO').AsString))  > 0) and
           (Pos('ONIB', RemoveAcentos(UpperCase(FieldByName('DESCRICAO_TIPO_VEICULO').AsString))) > 0) and
           (vVerificaTipoVeiculo = FieldByName('TIPO_VEICULO').AsString) Then
        begin
          HabilitarComponente(EdtCarreta1, False);
          FieldByName('ID_CARRETA').Clear;
          FieldByName('CARRETA').Clear;
          FieldByName('PREFIXO_CARRETA').Clear;

          HabilitarComponente(EdtCarreta2, False);
          FieldByName('ID_CARRETA_2').Clear;
          FieldByName('CARRETA_2').Clear;
          FieldByName('PREFIXO_CARRETA_2').Clear;

          ColocarFoco(edtCodTipodeVeiculo);
        End;
      End;
    End;
  End;

  spbCarreta1.Enabled := False;
  spbCarreta2.Enabled := False;

  If ( EdtCarreta1.Enabled ) Then
  Begin
    EdtCarreta1.SetFocus;
    spbCarreta1.Enabled := True;
  End;
end;

procedure TFrmCGSContProgramacaoDeContainer.HabilitarCarretas(pVeic, pCodVeic: String);
Var vHab: Boolean;
    vUtiliza: Boolean;

  Procedure VerificaSeUtilizaReboque(pVeic: String = '');
  Var vQry: TQuery;
  Begin
    vQry              := TQuery.Create(Nil);
    vQry.DataBaseName := cDatabaseName;

    With vQry Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT VEIC.IDENTIFICACAO                    ');
      SQL.Add('      , VEIC.TIPO                             ');
      SQL.Add('      , VEIC.VEICULO                          ');
      SQL.Add('      , VEIC.PREFIXO                          ');
      SQL.Add('      , VEIC.PLACA                            ');
      SQL.Add('      , VEIC.UF                               ');
      SQL.Add('      , TP.DESCRICAO                          ');
      SQL.Add('      , DECODE( TP.UTILIZA_REBOQUE            ');
      SQL.Add('              , 1                             ');
      SQL.Add('              , ''S''                         ');
      SQL.Add('              , ''N''                         ');
      SQL.Add('              ) AS UTILIZA_REBOK              ');
      SQL.Add('   FROM VWCGS_VEICPROPRIOSCOMCARRETAS VEIC    ');
      SQL.Add('      , EXA023                        TP      ');
      SQL.Add('  WHERE VEIC.CODIGOTIPOVEICULO(+) = TP.CODIGO ');
      SQL.Add('    AND VEICULO                   = :VEIC     ');

      ParamByName('VEIC').AsInteger := StrToInt(pVeic);

      GetSQL(vQry);
      Open;

      If Not IsEmpty Then
        vUtiliza := (FieldByName('UTILIZA_REBOK').AsString = 'S');
    End;  // With
  End;  // VerificaSeUtilizaReboque

Begin
  If (Trim(pCodVeic)<>'') Then
    VerificaSeUtilizaReboque(pCodVeic);

  vHab := (
           ( vcVerificaAtrelamento = 'N' ) Or ( ( vcVerificaAtrelamento = 'S' ) And
                                                ( ( vcCod_Atrelamento = 0 ) And
                                                  ( pVeic = 'E' )
                                                ) Or
                                                ( ( vcCod_Atrelamento = 1 ) And
                                                  ( pVeic = 'I' )
                                                )
                                              ) And Not ( DmCGSDoc.vpCamposEngessados ) And
                                              ( vUtiliza  // verifica se engata reboque
                                              )
          ) and
          (Not(DmCGSDoc.vpCamposEngessados)) ;
  If edtCarreta1.Tag <> -1 Then
    HabilitarComponente( edtCarreta1, vHab );
  If edtCarreta2.Tag <> -1 Then
    HabilitarComponente( edtCarreta2, vHab );
End;  // HabilitarCarretas

procedure TFrmCGSContProgramacaoDeContainer.edtCodMotoristaExit(Sender: TObject);
var vAlterouMotorista: Boolean;
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) And $1000000) <> 0) And vTAB) Then
  Begin
    vEsc := False ;
    PnlEscala.Parent   := TabSVarios ;
    PnlLocalid.Parent  := TabSVarios ;
    PnlBotaoConsSet.Enabled := True ;
    DBGridProg.Enabled := True ;
    PnlFiltro.Enabled  := True ;
    PnlBotoes.Enabled  := True ;
    DBGridProg.SetFocus ;
    Exit ;
  End ; // If vEsc Or (...

  with dsCabecalho.DataSet do
  begin
    FieldByName('CODIGO_MOTORISTA').AsString := TEdit(Sender).Text ;

    vAlterouMotorista := not(FieldByName('CODIGO_MOTORISTA').IsNull) and
                         (
                          (MDProg.FieldByName('MOTORISTA').IsNull) or
                          (FieldByName('MOTORISTA'   ).AsString <> MDProg.FieldByName('MOTORISTA'   ).AsString) And
                          (FieldByName('ID_MOTORISTA').AsString <> MDProg.FieldByName('ID_MOTORISTA').AsString)
                         );

    if (ProximoControleFocado(ActiveControl, TEdit(Sender))) or
       (vAlterouMotorista) then
    begin
      if not dmCGSDoc.MotoristaOK(edtVeiculo,edtCarreta1,edtCarreta2,True,cChamada_ContProgramacaoDeContainer, dmCGSDoc.rxCabecalho,
             BgmPedeGaragem.CodigoEmpresa,BgmPedeGaragem.CodigoFilial) Then
      begin
        ColocarFoco(edtCodMotorista);
        spbMotorista.Enabled   := True;
        spbVeiculo.Enabled     := False;
        spbCarreta1.Enabled    := False;
        spbCarreta2.Enabled    := False;
        spbTipoVeiculo.Enabled := False;
      End else
      begin // Atualiza o Tipo de Docto
        If (vAlterouMotorista) or
           (Trim(FieldByName('TIPO_VEICULO').AsString) = '') Then
          vVerificaTipoVeiculo := dmCGSDoc.GetTipoVeiculo ;

        DefinirTipoDeVeiculoBitrem ;

        if ( Trim(FieldByName('PREFIXO_VEICULO').AsString) <> '') and
           ( Trim(FieldByName('PREFIXO_CARRETA').AsString) <> '') and
           ( ActiveControl = edtVeiculo) and
           ( vAlterouMotorista) Then
          ColocarFoco(EdtCodTipodeVeiculo);

        HabilitarCarretas( FieldByName('ID_VEICULO').AsString , FieldByName('VEICULO').AsString );
      end;
    end ;
  end;
end;

procedure TFrmCGSContProgramacaoDeContainer.DefinirTipoDeVeiculoBitrem;
var vbitremparametro : Integer;
begin
  With dsCabecalho.DataSet, vTipoVeiculos do
  begin
    If (Trim(FieldByName('PREFIXO_VEICULO'  ).AsString) <> '') and
       (Trim(FieldByName('PREFIXO_CARRETA'  ).AsString) <> '') and
       (Trim(FieldByName('PREFIXO_CARRETA_2').AsString) <> '') Then
    begin
      // Verifica se foi definido em parâmetros
      vbitremparametro := StrtoIntDef(Trim(Copy(Cgs_Parametros_Resposta(BgmPedeGaragem.CodigoEmpresa,BgmPedeGaragem.CodigoFilial,345),1,6)),0);

      If vbitremparametro>0 Then
        FieldByName('TIPO_VEICULO').AsString := InttoStr(vbitremparametro)
      else If (vcCodigoCliente in [ cCodCli_Stefani, cCodCli_Borelli, cCodCli_TransMarcos ] ) Then
      begin
        case vcCodigoCliente of
          cCodCli_Stefani     : FieldByName('TIPO_VEICULO').AsString := '4' ; // BI-TREM
          cCodCli_Borelli     : FieldByName('TIPO_VEICULO').AsString := '5' ; // BI-TREM
          cCodCli_TransMarcos : FieldByName('TIPO_VEICULO').AsString := '4' ; // BI-TREM
        end;
      end;

      Cod_TpVeiculos := StrToIntDef(FieldByName('TIPO_VEICULO').AsString,0);
      Atualizar;
      FieldByName('DESCRICAO_TIPO_VEICULO').AsString := Desc_TpVeiculos;
      vVerificaTipoVeiculo := FieldByName('TIPO_VEICULO').AsString;
    End;
  End;
end;

function TFrmCGSContProgramacaoDeContainer.ProximoControleFocado(Ativo, Atual: TWinControl; vVerificarShiftTab: Boolean): Boolean;
begin
  Result := True ;
  If (Ativo <> nil) And
     (Atual <> nil) And
     (Ativo.Parent = Atual.Parent) Then
    Result := Ativo.TabOrder > Atual.TabOrder ;

  if (Result) and
     (Ativo.Parent <> nil) and
     (Ativo.Parent = PnlEscala) then
  begin

    // Para não disparar o OnExit do Atual
    if ((Atual = edtCodMotorista) or
        (Atual = edtVeiculo)      or
        (Atual = edtCarreta1)     or
        (Atual = edtCarreta2)
       ) and
       ((Ativo = BtnMaisEsc)
       ) then
      Result := false;
  end;

  try
    EventoEditBuscaChange(Atual, Self);
  except
  end;
end;

procedure TFrmCGSContProgramacaoDeContainer.edtCarreta1Exit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) And $1000000) <> 0) And vTAB) Then
  Begin
    vEsc := False ;
    Exit ;
  End ; // If vEsc Or (...

  with dsCabecalho.DataSet do
  Begin

    if (ProximoControleFocado(ActiveControl, TEdit(Sender))) or
       (Trim(FieldByName('PREFIXO_CARRETA').AsString) <> '') Then
    begin
      FieldByName('PREFIXO_CARRETA').AsString := TEdit(Sender).Text;

      if not(dmCGSDoc.ConsistirVeiculo('PREFIXO_CARRETA'
                                      ,'ID_CARRETA'
                                      ,'CARRETA'
                                      ,'C'
                                      ,dmCGSDoc.rxCabecalho
                                      ,''
                                      ,BgmPedeGaragem.CodigoEmpresa
                                      ,BgmPedeGaragem.CodigoFilial
                                      ,BgmPedeGaragem.CodigoGA)) or
         not(dmCGSDoc.VeiculoAutorizadoATransportarProduto(0, '', true)) or
         not(CapacVeiculos(True)) Then
      begin
        FieldByName('PREFIXO_CARRETA').Clear;
        ColocarFoco(TDBEdit(Sender));
        spbCarreta1.Enabled := true;
      end
      else
      begin
        if not CarretasSaoIguais(Sender) Then
//          DesabilitarBotaoPesquisa(Sender);
      end;

      if Trim(FieldByName('CARRETA').AsString) <>
         Trim(MDProg.FieldByName('CARRETA').AsString) Then
        vVerificaTipoVeiculo := dmCGSDoc.GetTipoVeiculo;

    end
    else
      spbCarreta1.Enabled := false;
  End;
end;

procedure TFrmCGSContProgramacaoDeContainer.edtCarreta2Exit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) And $1000000) <> 0) And vTAB) Then
  Begin
    vEsc := False ;
    Exit ;
  End ; // If vEsc Or (...

  with dsCabecalho.DataSet do
  Begin

    if (ProximoControleFocado(ActiveControl, TEdit(Sender))) or
       (Trim(FieldByName('CARRETA_2').AsString) <> '')  Then
    begin
      FieldByName('PREFIXO_CARRETA_2').AsString := TEdit(Sender).Text;

      if not(dmCGSDoc.ConsistirVeiculo('PREFIXO_CARRETA_2'
                                      ,'ID_CARRETA_2'
                                      ,'CARRETA_2'
                                      ,'C'
                                      ,dmCGSDoc.rxCabecalho
                                      ,''
                                      ,BgmPedeGaragem.CodigoEmpresa
                                      ,BgmPedeGaragem.CodigoFilial
                                      ,BgmPedeGaragem.CodigoGA)) or
         not(dmCGSDoc.VeiculoAutorizadoATransportarProduto(0, '', true)) or
         not(CapacVeiculos(True)) Then
      begin
        FieldByName('PREFIXO_CARRETA_2').Clear;
        ColocarFoco(TDBEdit(Sender));
        spbCarreta2.Enabled := true;
      end
      else
        if not CarretasSaoIguais(Sender) Then
//          DesabilitarBotaoPesquisa(Sender);

      if Trim(FieldByName('CARRETA_2').AsString) <>
         Trim(MDProg.FieldByName('CARRETA_2').AsString) Then
      Begin
        vVerificaTipoVeiculo := dmCGSDoc.GetTipoVeiculo;
        DefinirTipoDeVeiculoBitrem;
      End;
    end
    else
      spbCarreta2.Enabled := false;
  End;
end;

procedure TFrmCGSContProgramacaoDeContainer.edtCodMotoristaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var vEvento: TNotifyEvent;
begin
  If SaiuComSetaParaBaixo(Sender, key, '', Self) Then
  begin
    vEvento := nil;

    If Assigned(TEdit(Sender).OnExit) Then
      vEvento := TEdit(Sender).OnExit ;

    TEdit(Sender).OnExit := nil;

    If Sender = edtVeiculo Then
    Begin
      LimparCarretas;
      HabilitarComponente(edtCarreta1, False);
      HabilitarComponente(edtCarreta2, False);
    End ; // If Sender = edtVeiculo Then

    Perform(WM_NEXTDLGCTL, 0, 0) ;
    TEdit(Sender).OnExit := vEvento ;
  End Else
  If Key = vk_F8 Then
  Begin
    PnlEscala.Parent        := TabSVarios ;
    PnlLocalid.Parent       := TabSVarios ;

    PnlBotaoConsSet.Enabled := True ;
    DBGridProg.Enabled      := True ;
    PnlFiltro.Enabled       := True ;
    PnlBotoes.Enabled       := True ;
    DBGridProg.SetFocus ;
  End ; // If Key = vk_F8 Then
end;

function TFrmCGSContProgramacaoDeContainer.CapacVeiculos(vMostrarMensagem: Boolean): Boolean;
begin
  Result := DmCGSDoc.VerificaCapacidadeVeiculos( dsCabecalho.DataSet.FieldByName('CUBAGEM').AsFloat
                                               , dsCabecalho.DataSet.FieldByName('PESO'   ).AsFloat
                                               , vMostrarMensagem );
end;

function TFrmCGSContProgramacaoDeContainer.CarretasSaoIguais(Sender: TObject): Boolean;
begin
  with dsCabecalho.DataSet do

    if (FieldByName('ID_CARRETA_2').AsString = FieldByName('ID_CARRETA').AsString) and
       (FieldByName('CARRETA'     ).AsString = FieldByName('CARRETA_2' ).AsString) Then
    begin
      Result := True;
      MensagemDlg('Carreta 1 e 2 não podem ser a mesma.', mtAtencao, mbok);
      FieldByName(TDBEdit(Sender).DataField).Clear;
      ColocarFoco(TEdit(Sender));
    end
    else
      Result := false;
end;

procedure TFrmCGSContProgramacaoDeContainer.edtCodMotoristaChange(Sender: TObject);
begin
  spbMotorista.Enabled := Trim(TEdit(Sender).Text) = '';
  if Length(Trim( TEdit(Sender).Text)) < 6 Then
  begin
    dsCabecalho.DataSet.FieldByName('MOTORISTA').Clear;
    dsCabecalho.DataSet.FieldByName('ID_MOTORISTA').Clear;
    dsCabecalho.DataSet.FieldByName('NOME_MOTORISTA').Clear;
    dsCabecalho.DataSet.FieldByName('CODIGOFUNCAO_MOTORISTA').Clear;
  end;

  if Trim(TEdit(Sender).Text) = '' Then
    edtDesMotorista.Clear;
end;

procedure TFrmCGSContProgramacaoDeContainer.edtVeiculoChange(Sender: TObject);
begin
  spbVeiculo.Enabled := Trim(EdtVeiculo.Text) = '';
  If Not MDProg.IsEmpty Then
    if ((Length(Trim(EdtVeiculo.Text)) < 2) or
        ((Trim(MDProg.FieldByName('PREFIXO_VEICULO').AsString) <> '') And (MDProg.FieldByName('PREFIXO_VEICULO').AsString <> TDBEdit(Sender).Text)) ) Then
    begin
      dsCabecalho.DataSet.FieldByName('ID_VEICULO').Clear;
      dsCabecalho.DataSet.FieldByName('VEICULO').Clear;
      dsCabecalho.DataSet.FieldByName('CODTPVEICFROTA_VEICULO').Clear;
      If vcVerificaAtrelamento = 'S' Then
        LimparCarretas;
    end;

  HabilitarCarretas( dsCabecalho.DataSet.FieldByName('ID_VEICULO').AsString , dsCabecalho.DataSet.FieldByName('VEICULO').AsString );
end;

procedure TFrmCGSContProgramacaoDeContainer.edtCarreta1Change(Sender: TObject);
begin
  spbCarreta1.Enabled := Trim(edtCarreta1.Text) = '';
  If Not MDProg.IsEmpty Then
    if ((Length(Trim(edtCarreta1.Text)) < 2) or
        ((Trim(MDProg.FieldByName('PREFIXO_CARRETA').AsString) <> '') And (MDProg.FieldByName('PREFIXO_CARRETA').AsString <> TDBEdit(Sender).Text)) ) Then
    begin
      dsCabecalho.DataSet.FieldByName('CARRETA').AsString := '';
      dsCabecalho.DataSet.FieldByName('ID_CARRETA').AsString := '';
      dsCabecalho.DataSet.FieldByName('CODTPVEICFROTA_CARRETA').AsString := '';
    end;
end;

procedure TFrmCGSContProgramacaoDeContainer.edtCarreta2Change(Sender: TObject);
begin
  spbCarreta2.Enabled := Trim(edtCarreta2.Text) = '';
  If Not MDProg.IsEmpty Then
    if ((Length(Trim(edtCarreta2.Text)) < 2) or
        ((Trim(MDProg.FieldByName('PREFIXO_CARRETA_2').AsString) <> '') And (MDProg.FieldByName('PREFIXO_CARRETA_2').AsString <> TDBEdit(Sender).Text)) ) Then
    begin
      dsCabecalho.DataSet.FieldByName('CARRETA_2').AsString := '';
      dsCabecalho.DataSet.FieldByName('ID_CARRETA_2').AsString := '';
      dsCabecalho.DataSet.FieldByName('CODTPVEICFROTA_CARRETA_2').AsString := '';
    end;
end;

procedure TFrmCGSContProgramacaoDeContainer.LimparCarretas;
begin
  With dsCabecalho.DataSet do
  begin
    FieldByName('PREFIXO_CARRETA'         ).Clear;
    FieldByName('CARRETA'                 ).Clear;
    FieldByName('ID_CARRETA'              ).Clear;
    FieldByName('CODTPVEICFROTA_CARRETA'  ).Clear;
    FieldByName('PREFIXO_CARRETA_2'       ).Clear;
    FieldByName('CARRETA_2'               ).Clear;
    FieldByName('ID_CARRETA_2'            ).Clear;
    FieldByName('CODTPVEICFROTA_CARRETA_2').Clear;
    spbCarreta1.Enabled := False;
    spbCarreta2.Enabled := False;
  End;
end;

procedure TFrmCGSContProgramacaoDeContainer.edtCodTipodeVeiculoExit(Sender: TObject);
var vProximoFocado: Boolean ;
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) And $1000000) <> 0) And vTAB) Then
  Begin
    vEsc := False ;
    Exit ;
  End ; // If vEsc Or (...

  vProximoFocado := ProximoControleFocado(ActiveControl, TEdit(Sender)) ;

  with dsCabecalho.DataSet do
    if (vProximoFocado) or
       (Trim(FieldByName('TIPO_VEICULO').AsString) <> '') then
    begin
      if Trim(FieldByName('TIPO_VEICULO').AsString) = '' then
      begin
        if not vTipoVeiculos.Pesquisar(0,'') then
        begin
          ColocarFoco(edtCodTipodeVeiculo);
          spbTipoVeiculo.Enabled := true;
          Exit;
        end;
        FieldByName('TIPO_VEICULO').AsString := Trim(vcRetorno1);
      end;

      vTipoVeiculos.Cod_TpVeiculos := StrToIntDef(FieldByName('TIPO_VEICULO').AsString,0);
      vTipoVeiculos.Atualizar;
      if vTipoVeiculos.RegistroNovo then
      begin
        if FieldByName('TIPO_VEICULO').AsString <> '999999' then
        begin
          MensagemDlg('Tipo de veículo não cadastrado.', mtAtencao, mbOk);
          vTipoVeiculos.Limpar;
          edtCodTipodeVeiculo.Clear;
          ColocarFoco(edtCodTipodeVeiculo);
          Exit;
        end;
      end;

      FieldByName('DESCRICAO_TIPO_VEICULO').AsString := vTipoVeiculos.Desc_TpVeiculos;

      if ( ( (Trim(FieldByName('PREFIXO_VEICULO').AsString) <> '') or
             (Trim(FieldByName('PREFIXO_CARRETA').AsString) <> '') or
             (Trim(FieldByName('PREFIXO_CARRETA_2').AsString) <> '') ) and
           ( vVerificaTipoVeiculo <> '') and
           ( FieldByName('TIPO_VEICULO').AsString <> '999999') and
           ( vVerificaTipoVeiculo <> FieldByName('TIPO_VEICULO').AsString )
          ) then
        MensagemDlg('Tipo de veículo diverge da configuração do(s) veículo(s) informado(s).',mtAtencao,mbOk);

      If Not(DmCGSDoc.QtdeDiasAntesDoVencimento_RH(True,cChamada_ContProgramacaoDeContainer, dmCGSDoc.rxCabecalho)) or
         Not(DmCGSDoc.CursosEmRH(cChamada_ContProgramacaoDeContainer, dmCGSDoc.rxCabecalho)) Then
      begin
        dsCabecalho.DataSet.FieldByName('CODIGO_MOTORISTA').Clear;
        ColocarFoco(edtCodMotorista);
      end ;
    end ;
end;

procedure TFrmCGSContProgramacaoDeContainer.BtnMaisEscClick(Sender: TObject);
Var
  i : Integer ;
  vEscalado : Boolean ;
  procedure PararEdicao(DataSource: TDataSource);
  begin
    with DataSource do
    begin
      DataSet.DisableControls;
      Enabled := false;
      if State in [dsEdit, dsInsert] then
        DataSet.Cancel;
    end;
  end;
begin
  MDProg.Edit ;
  If Sender = BtnMaisEsc Then
  Begin
    For i := 0 to MDProg.FieldCount-1 do
      If Pos(Right(MDProg.Fields[i].FieldName,5),'RISTA_ICULO_RRETA_ETA_2') > 0 Then
        MDProg.Fields[i].Value := dsCabecalho.DataSet.FindField( MDProg.Fields[i].FieldName ).Value ;

    If DEdtSaiGar_CheEnt.Date <> 0 Then
    Begin
      MDProg.FieldByName('DH_SAIGAR_CHEENT').AsDateTime := StrToDateTime(DEdtSaiGar_CheEnt.Text +' '+ TEdtSaiGar_CheEnt.Text) ;
      MDProg.FieldByName('H_SAIGAR_CHEENT' ).AsDateTime := MDProg.FieldByName('DH_SAIGAR_CHEENT').AsDateTime ;
    End ; // If DEdtSaiGar_CheEnt.Date <> 0 Then
  End Else // If Sender = BtnMaisEsc Then
  Begin
    If (Trim(MEdtLocOrige.Text) = '') Or (Trim(MEdtLocDeste.Text) = '') Then
    Begin
      If Trim(MEdtLocOrige.Text) = '' Then
        MEdtLocOrige.SetFocus
      Else
        MEdtLocOrige.SetFocus ;
      Exit ;
    End ; // If (Trim(MEdtLocOrige.Text) = '') Or (...

    MDProg.FieldByName('LOCALID_COLETA' ).AsInteger := StrToInt(Trim(MEdtLocOrige.Text)) ;
    MDProg.FieldByName('LOCALID_ENTREGA').AsInteger := StrToInt(Trim(MEdtLocDeste.Text)) ;
  End ; // End Else // If Sender = BtnMaisEsc Then
  vEscalado := (Trim(MDProg.FieldByName('MOTORISTA' ).AsString) <> '') And (Trim(MDProg.FieldByName('VEICULO'  ).AsString) <> '') ;

  MDProg.FieldByName('GRAVAR').AsString := 'S' ;
  MDProg.FieldByName('STATUS').AsString := IIf(vEscalado And (MDProg.FieldByName('D_SAIGAR_CHEENT').AsDateTime <> 0),'G',
                                           IIf(vEscalado,'E','P')) ;
  MDProg.Post ;

  If Sender = BtnMaisEsc Then
  Begin
    PararEdicao(dsCabecalho) ;
    PararEdicao(dsCompara) ;
  End ; // If Sender = BtnMaisEsc Then
  HabilitaBotoes ;

  vEsc := True ;
  edtCodMotoristaExit(Sender) ;
end;

procedure TFrmCGSContProgramacaoDeContainer.DBGridProgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key  = vk_Space Then
  Begin
    PMenuGeral.PopupComponent := TDBGrid(Sender) ;
    IMenuProgramacaoClick( IMenuMarDes ) ;
  End ; // If Key  = vk_Space Then
end;

procedure TFrmCGSContProgramacaoDeContainer.DBGridProgTitleClick(Column: TColumn);
begin
  OrdenaColunas(Column) ;
end;

procedure TFrmCGSContProgramacaoDeContainer.Gravar1Click(Sender: TObject);
Var
  vRegistro,
  vTotalReg : Integer ;
begin
  Gravar1.Enabled := False ;
  Limpar1.Enabled := False ;
  If vcDataBase.InTransaction Then vcDataBase.Rollback ;
  vcDataBase.StartTransaction ;

  BarraDeProgresso(0,0,0) ;
  vRegistro := 0 ;
  vTotalReg := MDProg.RecordCount ;
  vFiltro   := False ;
  MDProg.DisableControls ;
  MDProg.First ;
  While Not MDProg.Eof do
  Begin
    BarraDeProgresso(1,IncInt(vRegistro),vTotalReg,'Atualizando...','E') ;
    If MDProg.FieldByName('GRAVAR').AsString = 'S' Then
      GravaOuAtualizaDocto ;
    MDProg.Next ;
  End ; // While Not Eof do
  BarraDeProgresso(3,0,0) ;
  MDProg.EnableControls ;
  vFiltro := True ;

  vcDataBase.Commit ;
  Limpar1.Click ;
end;

procedure TFrmCGSContProgramacaoDeContainer.FormResize(Sender: TObject);
Var
  i : Integer ;
begin
  PosicionaBotoes(Pnlbotoes) ;
  SBarInfo.Panels[0].Width := Self.Width ;
  For i := 0 to SBarInfo.Panels.Count -1 do
    If i <> 0 Then
      SBarInfo.Panels[0].Width := SBarInfo.Panels[0].Width - SBarInfo.Panels[i].Width ;
end;

procedure TFrmCGSContProgramacaoDeContainer.GravaOuAtualizaDocto(pBaixaDoc : Boolean = False) ;
Var
  vTpServico : String ;
begin
  With QryPesquisa do
  Begin
    Close ;
    Sql.Clear ;
    vTpServico := MDProg.FieldByName('TPSERVICO').AsString ;
    If MDProg.FieldByName('CRIADOCTO').AsString = 'S' Then
    Begin
      vTpServico := LocalizaServico(vTpServico) ;
      Sql.Add('INSERT INTO CGS_CONTSERVICOS (CODINTPEDIDO') ;
      Sql.Add('                             ,CODINTITEMPEDIDO') ;
      Sql.Add('                             ,TPSERVICO') ;
//      Sql.Add('                             ,DATA_DOCTO') ;
      Sql.Add('                             ,STATUS') ;
      Sql.Add('                             ,TERMINAL') ;
      Sql.Add('                             ,TIPO_CONTAINER') ;
      Sql.Add('                             ,DESMEMBRADO') ;
      Sql.Add('                             ,MERCADORIA') ;
      Sql.Add('                             ,TARA') ;
      Sql.Add('                             ,NUM_LACRE') ;
      Sql.Add('                             ,LOCALID_COLETA') ;
      Sql.Add('                             ,LOCALID_ENTREGA') ;
      If (Pos(vTpServico,'TF') > 0) Or (MDProg.FieldByName('DESMEMBRADO').AsString='N') Then
      Begin
        Sql.Add('                             ,ID_MOTORISTA') ;
        Sql.Add('                             ,MOTORISTA') ;
        Sql.Add('                             ,ID_VEICULO') ;
        Sql.Add('                             ,VEICULO') ;
        Sql.Add('                             ,ID_CARRETA') ;
        Sql.Add('                             ,CARRETA') ;
        Sql.Add('                             ,ID_CARRETA_2') ;
        Sql.Add('                             ,CARRETA_2') ;
        Sql.Add('                             ,DH_SAIGAR_CHEENT') ;
      End ; // If (Pos(vTpServico,'TF') > 0) Or (...
      Sql.Add('                             ,NUMCONTAINER') ;
      Sql.Add('                             ,TIPO_VEICULO') ;
      Sql.Add(') VALUES (:P_CODINTPEDIDO') ;
      Sql.Add('         ,:P_CODINTITEMPEDIDO') ;
      Sql.Add('         ,:P_TPSERVICO') ;
//      Sql.Add('         ,:P_DATA_DOCTO') ;
      Sql.Add('         ,:P_STATUS') ;
      Sql.Add('         ,:P_TERMINAL') ;
      Sql.Add('         ,:P_TIPO_CONTAINER') ;
      Sql.Add('         ,:P_DESMEMBRADO') ;
      Sql.Add('         ,:P_MERCADORIA') ;
      Sql.Add('         ,:P_TARA') ;
      Sql.Add('         ,:P_NUM_LACRE') ;
      Sql.Add('         ,:P_LOCALID_COLETA') ;
      Sql.Add('         ,:P_LOCALID_ENTREGA') ;
      If (Pos(vTpServico,'TF') > 0) Or (MDProg.FieldByName('DESMEMBRADO').AsString='N') Then
      Begin
        Sql.Add('         ,:P_ID_MOTORISTA') ;
        Sql.Add('         ,:P_MOTORISTA') ;
        Sql.Add('         ,:P_ID_VEICULO') ;
        Sql.Add('         ,:P_VEICULO') ;
        Sql.Add('         ,:P_ID_CARRETA') ;
        Sql.Add('         ,:P_CARRETA') ;
        Sql.Add('         ,:P_ID_CARRETA_2') ;
        Sql.Add('         ,:P_CARRETA_2') ;
        Sql.Add('         ,:P_DH_SAIGAR_CHEENT') ;
      End ; // If (Pos(vTpServico,'TF') > 0) Or (...
      Sql.Add('         ,:P_NUMCONTAINER') ;
      Sql.Add('         ,:P_TIPO_VEICULO)') ;
//      ParamByName('P_DATA_DOCTO'    ).AsDateTime := vData ;
      ParamByName('P_STATUS'        ).AsString   := IIf(MDProg.FieldByName('DESMEMBRADO').AsString='N','R',IIf(Pos(vTpServico,'TF') > 0,'G','P')) ;
      ParamByName('P_TERMINAL'      ).AsInteger  := MDProg.FieldByName('TERMINAL'      ).AsInteger ;
      ParamByName('P_TIPO_CONTAINER').AsInteger  := MDProg.FieldByName('TIPO_CONTAINER').AsInteger ;
      ParamByName('P_DESMEMBRADO'   ).AsString   := MDProg.FieldByName('DESMEMBRADO'   ).AsString ;
      ParamByName('P_MERCADORIA'    ).AsString   := MDProg.FieldByName('MERCADORIA'    ).AsString ;
    End Else // If MDProg.FieldByName('CRIADOCTO').AsString = 'S' Then
    Begin
      Sql.Add('UPDATE CGS_CONTSERVICOS') ;
      Sql.Add('   SET ID_MOTORISTA     = :P_ID_MOTORISTA') ;
      Sql.Add('     , MOTORISTA        = :P_MOTORISTA') ;
      Sql.Add('     , ID_VEICULO       = :P_ID_VEICULO') ;
      Sql.Add('     , VEICULO          = :P_VEICULO') ;
      Sql.Add('     , ID_CARRETA       = :P_ID_CARRETA') ;
      Sql.Add('     , CARRETA          = :P_CARRETA') ;
      Sql.Add('     , ID_CARRETA_2     = :P_ID_CARRETA_2') ;
      Sql.Add('     , CARRETA_2        = :P_CARRETA_2') ;
      Sql.Add('     , TIPO_VEICULO     = :P_TIPO_VEICULO') ;
      Sql.Add('     , STATUS           = :P_STATUS') ;
      Sql.Add('     , NUMCONTAINER     = :P_NUMCONTAINER') ;
      Sql.Add('     , TARA             = :P_TARA') ;
      Sql.Add('     , NUM_LACRE        = :P_NUM_LACRE') ;
      Sql.Add('     , LOCALID_COLETA   = :P_LOCALID_COLETA') ;
      Sql.Add('     , LOCALID_ENTREGA  = :P_LOCALID_ENTREGA') ;
      Sql.Add('     , BAIXAAUTO        = :P_BAIXAAUTO') ;
      Sql.Add('     , IMPSERVICO       = :P_IMPSERVICO') ;
      Sql.Add('     , DH_SAIGAR_CHEENT = :P_DH_SAIGAR_CHEENT') ;
      If pBaixaDoc Then
      Begin
        If (Pos(vTpServico,'TF') > 0) Or ((vTpServico = 'A') And (MDProg.FieldByName('BAIXAAUTO').AsString = 'S')) Then
          Sql.Add('     , DATA_BAIXA       = :P_DATA_BAIXA') ;
        Sql.Add('     , TIPO_DOCTO       = :P_TIPO_DOCTO') ;
        Sql.Add('     , SERIE            = :P_SERIE') ;
        Sql.Add('     , NUMERO_DOCTO     = :P_NUMERO_DOCTO') ;
        Sql.Add('     , DATA_DOCTO       = :P_DATA_DOCTO') ;
      End ; // If pBaixaDoc Then
      SQL.Add(' WHERE CODINTPEDIDO     = :P_CODINTPEDIDO') ;
      SQL.Add('   AND CODINTITEMPEDIDO = :P_CODINTITEMPEDIDO') ;
      SQL.Add('   AND TPSERVICO        = :P_TPSERVICO') ;
    End ; // End Else // If MDProg.FieldByName('CRIADOCTO').AsString = 'S' Then
    ParamByName('P_CODINTITEMPEDIDO').AsInteger  := MDProg.FieldByName('CODINTITEMPEDIDO').AsInteger ;
    ParamByName('P_CODINTPEDIDO'    ).AsInteger  := MDProg.FieldByName('CODINTPEDIDO'    ).AsInteger ;
    ParamByName('P_TPSERVICO'       ).AsString   := vTpServico ;
    ParamByName('P_NUMCONTAINER'    ).AsString   := MDProg.FieldByName('NUMCONTAINER'    ).AsString ;
    ParamByName('P_TARA'            ).AsFloat    := MDProg.FieldByName('TARA'            ).AsFloat ;
    ParamByName('P_NUM_LACRE'       ).AsString   := MDProg.FieldByName('NUM_LACRE'       ).AsString ;
    ParamByName('P_LOCALID_COLETA'  ).AsInteger  := MDProg.FieldByName('LOCALID_COLETA'  ).AsInteger ;
    ParamByName('P_LOCALID_ENTREGA' ).AsInteger  := MDProg.FieldByName('LOCALID_ENTREGA' ).AsInteger ;

    If (MDProg.FieldByName('CRIADOCTO').AsString = 'N') Or pBaixaDoc Or (Pos(vTpServico,'TF') > 0) Or (MDProg.FieldByName('DESMEMBRADO').AsString='N') Then
    Begin
      ParamByName('P_STATUS'         ).AsString   := IIf(pBaixaDoc,'R',MDProg.FieldByName('STATUS').AsString) ;
      ParamByName('P_ID_MOTORISTA'   ).AsString   := MDProg.FieldByName('ID_MOTORISTA'   ).AsString ;
      ParamByName('P_MOTORISTA'      ).AsString   := MDProg.FieldByName('MOTORISTA'      ).AsString ;
      ParamByName('P_ID_VEICULO'     ).AsString   := MDProg.FieldByName('ID_VEICULO'     ).AsString ;
      ParamByName('P_VEICULO'        ).AsString   := MDProg.FieldByName('VEICULO'        ).AsString ;
      ParamByName('P_ID_CARRETA'     ).AsString   := MDProg.FieldByName('ID_CARRETA'     ).AsString ;
      ParamByName('P_CARRETA'        ).AsString   := MDProg.FieldByName('CARRETA'        ).AsString ;
      ParamByName('P_ID_CARRETA_2'   ).AsString   := MDProg.FieldByName('ID_CARRETA_2'   ).AsString ;
      ParamByName('P_CARRETA_2'      ).AsString   := MDProg.FieldByName('CARRETA_2'      ).AsString ;
      If MDProg.FieldByName('CRIADOCTO').AsString = 'N' Then
      Begin
        ParamByName('P_BAIXAAUTO'       ).AsString   := MDProg.FieldByName('BAIXAAUTO'       ).AsString ;
        ParamByName('P_IMPSERVICO'      ).AsString   := MDProg.FieldByName('IMPSERVICO'      ).AsString ;
        ParamByName('P_DH_SAIGAR_CHEENT').AsDateTime := MDProg.FieldByName('DH_SAIGAR_CHEENT').AsDateTime ;
      End Else // If MDProg.FieldByName('CRIADOCTO').AsString = 'N' Then
      If Pos(vTpServico,'TF') > 0 Then
        ParamByName('P_DH_SAIGAR_CHEENT').AsDateTime := MDProg.FieldByName('DH_SAIGAR_CHEENT').AsDateTime ;

      If pBaixaDoc Then
      Begin
        ParamByName('P_DATA_DOCTO'   ).AsDateTime := TrazDatadoBanco ;
        ParamByName('P_TIPO_DOCTO'   ).AsInteger  := MDProg.FieldByName('TIPO_DOCTO'     ).AsInteger ;
        ParamByName('P_SERIE'        ).AsString   := MDProg.FieldByName('SERIE_DOCTO'    ).AsString ;
        ParamByName('P_NUMERO_DOCTO' ).AsInteger  := MDProg.FieldByName('NUMERO_DOCTO'   ).AsInteger ;
        If (Pos(vTpServico,'TF') > 0) Or ((vTpServico = 'A') And (MDProg.FieldByName('BAIXAAUTO').AsString = 'S')) Then
          ParamByName('P_DATA_BAIXA' ).AsDateTime := ParamByName('P_DATA_DOCTO').AsDateTime ;
      End ; // If pBaixaDoc Then
    End ; // If (MDProg.FieldByName('CRIADOCTO').AsString = 'N') Or (...
    ParamByName('P_TIPO_VEICULO'     ).AsInteger  := MDProg.FieldByName('TIPO_VEICULO'   ).AsInteger ;

    Try
      GetSql(QryPesquisa, Nil, False,'Incluindo') ;
      ExecSQL ;
    Except on E:EDBEngineError do
      Begin
        vcDataBase.Rollback ;
        If MensagemDLG('Problemas durante inclusão. Deseja ver erro ?', mtConfirmacao, mbSim+mbNao ) = mrSim then
          MensagemDLG( MostraErrosQuery(E,False), mtErro, mbOK ) ;
        Exit ;
      End
    End ; // Try - Except
  End ; // With QryPesquisa do
end;

procedure TFrmCGSContProgramacaoDeContainer.MDProgAfterScroll(DataSet: TDataSet);
begin
  IMenuCanRea.Caption  := IIf( MDProg.FieldByName('MARCA').AsInteger = 2,'Reativar','Cancelar') ;
  IMenuCanRea.ShortCut := ShortCut( Word(IMenuCanRea.Caption[1]) ,[ssCtrl] ) ;
  IMenuMarDes.Caption  := IIf(MDProg.FieldByName('MARCA').AsInteger = 0,'Marca','Desmarca') + ' para impressão' ;
  IMenuMarDes.ShortCut := ShortCut( Word(IMenuMarDes.Caption[1]) ,[ssCtrl] ) ;
  If vFiltro Then
  Begin
    MDProgUltDoc.Filtered    := False ;
    MDProgUltDoc.Filtered    := True ;
    DBGridProgUltDoc.Visible := Not MDProgUltDoc.IsEmpty ;
  End ; // If vFiltro Then
end;

Function TFrmCGSContProgramacaoDeContainer.LocalizaServico(pTpServico : String; pAnterior : Boolean = False) : String ;
Var i : Integer ;
const vOrdemE : Array [1..4] Of String = ('A','E','T','F') ;
      vOrdemI : Array [1..3] Of String = ('R','D','F') ;
Begin
  Result := pTpServico ;
  For i := 1 to Length(cTipoDocCont) do
    If pTpServico = cTipoDocCont[i,2] Then
      Break ;

  If cTipoDocCont[i,4] = 'E' Then
  Begin
    For i := 1 to Length(vOrdemE) do
      If pTpServico = vOrdemE[i] Then
        Break ;

    If i < 4 Then
      If pAnterior Then
        Result := vOrdemE[i-1]
      Else
        Result := vOrdemE[i+1] ;
  End Else // If cTipoDocCont[i,4] = 'E' Then
  Begin
    For i := 1 to Length(vOrdemE) do
      If pTpServico = vOrdemI[i] Then
        Break ;

    If i < 3 Then
      If pAnterior Then
        Result := vOrdemI[i-1]
      Else
        Result := vOrdemI[i+1] ;
  End ; // End Else // If cTipoDocCont[i,4] = 'E' Then
  
end; // Function LocalizaServico(pTpServico : String ; pProx : Boolean) ;

function TFrmCGSContProgramacaoDeContainer.ProxLinha: Integer;
begin
  Inc(vLinha);
  If vLinha >= (RDprint1.TamanhoQteLinhas - RDprint1.Tag) Then RDprint1.NovaPagina ;
  Result := vLinha ;
end;

function TFrmCGSContProgramacaoDeContainer.DadosNF(pQuery: TDataSet; pCarSeparacao : String = '/' ; pConcatena : String = 'NSIDE'; pSeparacaoConc : String = '-' ): TDadosNFCont ;
var
  vMontaConcatena,
  vCarSep : String ;
  vConcatena : Array[1..5] Of String ;
  i : Integer ;
  Function ConcatenaRetornos(pTp : Integer  ; pRetorno : String ; pCampo  : String='') : String ;
  Begin
    Case pTp of
      1 : Result := IIf(Pos(pCampo + pCarSeparacao , pRetorno) > 0,'', pCampo) ;                                                                      // Se o valor do campos já ñ existir no retorno
      2 : Result := IIf(Right(pRetorno,Length(pCarSeparacao)) = pCarSeparacao,'', vCarSep) ;                                                          // Só se os últimos caracteres já ñ forem os de separação
      3 : Result := IIf(Right(pRetorno,Length(pCarSeparacao)) = pCarSeparacao,Copy(pRetorno, 1,Length(pRetorno)- Length(pCarSeparacao)) , pRetorno) ; // Se os últimos caracteres forem o separação então retira
    End ; // Case pTp of
  End ; // Function ConcatenaRetornos(pTp : Integer  ; pRetorno , pCampo  : String) : String ;
Begin
  Result.Nota_Fiscal    := '' ;
  Result.Item_Grupo     := '' ;
  Result.Serie_Nf       := '' ;
  Result.Descricao_Prod := '' ;
  Result.Dt_Emissao     := '' ;
  Result.Varios         := '' ;
  Result.QtdeItens      := 0 ;
  Result.Achou          := False ;

  With pQuery Do
  Begin
    First ;
    While Not Eof Do
    Begin
      Result.Nota_Fiscal    := Result.Nota_Fiscal    + FieldByName('NOTA_FISCAL').AsString ;
      Result.Serie_Nf       := Result.Serie_Nf       + ConcatenaRetornos(1,Result.Serie_Nf,       FieldByName('SERIE_NF'      ).AsString) ;
      Result.Item_Grupo     := Result.Item_Grupo     + ConcatenaRetornos(1,Result.Item_Grupo,     FieldByName('ITEM_GRUPO'    ).AsString) ;
      Result.Descricao_Prod := Result.Descricao_Prod + ConcatenaRetornos(1,Result.Descricao_Prod, FieldByName('DESCRICAO_PROD').AsString) ;
      Result.Dt_Emissao     := Result.Dt_Emissao     + ConcatenaRetornos(1,Result.Dt_Emissao,     FormatDateTime('dd/mm/yy',FieldByName('DT_EMISSAO_NF').AsDateTime)) ;
      If Trim(pConcatena) <> '' Then
      Begin
        FillChar(vConcatena,SizeOf(vConcatena), #0) ;
        If Pos('N',pConcatena) > 0 Then
          vConcatena[Pos('N',pConcatena)] := FieldByName('NOTA_FISCAL'   ).AsString ;
        If Pos('S',pConcatena) > 0 Then
          vConcatena[Pos('S',pConcatena)] := FieldByName('SERIE_NF'      ).AsString ;
        If Pos('I',pConcatena) > 0 Then
          vConcatena[Pos('I',pConcatena)] := FieldByName('ITEM_GRUPO'    ).AsString ;
        If Pos('D',pConcatena) > 0 Then
          vConcatena[Pos('D',pConcatena)] := FieldByName('DESCRICAO_PROD').AsString ;
        If Pos('E',pConcatena) > 0 Then
          vConcatena[Pos('E',pConcatena)] := FormatDateTime('dd/mm/yy',FieldByName('DT_EMISSAO_NF').AsDateTime) ;
        vMontaConcatena := '' ;
        For i := 1 to 5 do
        Begin
          If Trim(vConcatena[i]) <> '' Then
            vMontaConcatena := vMontaConcatena + IIf(vMontaConcatena='','',pSeparacaoConc) + vConcatena[i] ;
        End ; // For i := 1 to 5 do

        Result.Varios       := Result.Varios  + ConcatenaRetornos(1,Result.Varios, vMontaConcatena) ;
      End ; // If Trim(pConcatena) <> '' Then
      Result.QtdeItens      := Result.QtdeItens      + 1 ;
      Next ;
      vCarSep := IIf(Eof,'',pCarSeparacao) ;

      Result.Nota_Fiscal    := Result.Nota_Fiscal    + ConcatenaRetornos(2,Result.Nota_Fiscal) ;
      Result.Item_Grupo     := Result.Item_Grupo     + ConcatenaRetornos(2,Result.Item_Grupo) ;
      Result.Serie_Nf       := Result.Serie_Nf       + ConcatenaRetornos(2,Result.Serie_Nf) ;
      Result.Descricao_Prod := Result.Descricao_Prod + ConcatenaRetornos(2,Result.Descricao_Prod) ;
      Result.Dt_Emissao     := Result.Dt_Emissao     + ConcatenaRetornos(2,Result.Dt_Emissao) ;
      Result.Varios         := Result.Varios         + ConcatenaRetornos(2,Result.Varios) ;
    End ; // While Not Eof Do
    Result.Nota_Fiscal    := ConcatenaRetornos(3,Result.Nota_Fiscal) ;
    Result.Item_Grupo     := ConcatenaRetornos(3,Result.Item_Grupo) ;
    Result.Serie_Nf       := ConcatenaRetornos(3,Result.Serie_Nf) ;
    Result.Descricao_Prod := ConcatenaRetornos(3,Result.Descricao_Prod) ;
    Result.Dt_Emissao     := ConcatenaRetornos(3,Result.Dt_Emissao) ;
    Result.Varios         := ConcatenaRetornos(3,Result.Varios) ;
    Result.Achou          := Result.QtdeItens > 0 ;
  End ; // With pQuery Do

End ;

function TFrmCGSContProgramacaoDeContainer.ImpressaoDoctoCont(Var pSimParaTodos, pMostraSetupRD : Boolean; pNumero_Docto : Integer = 0; pTpServico : String = '') : Boolean ;
var
  vRetorno   : String ;
  vLayOut,
  vTpServico : Integer ;
  function ConfiguracaoOk : Boolean ;
    Procedure ConfiguracaoDefaultRD(pEntreLinhas, pFonte : Variant ; pQtdeColunas,pQtdeLinhas : Integer) ;
    Begin
      FrmSetupRD.CBEntreLinha.ItemIndex := pEntreLinhas ;
      FrmSetupRD.CBcpp.ItemIndex        := pFonte ;
      RdPrint1.TamanhoQteLPP            := pEntreLinhas ;
      RdPrint1.FonteTamanhoPadrao       := pFonte ;
      RDprint1.TamanhoQteColunas        := pQtdeColunas ;
      RDprint1.TamanhoQteLinhas         := pQtdeLinhas ;
    End ; // Procedure ConfiguracaoDefaultRD(...

    Procedure ConfiguracaoDefaultApanha ;
    Begin
      Case vLayOut of
        1 : ConfiguracaoDefaultRD(Seis,S12cpp,96,60) ;
      Else
        ConfiguracaoDefaultRD(Seis,S12cpp,96,60) ;
      End ; // Case vLayOut of
    End ; // Procedure ConfiguracaoDefaultApanha ;

    Procedure ConfiguracaoDefaultRetirada ;
    Begin
      Case vLayOut of
        1 : ConfiguracaoDefaultRD(Seis,S12cpp,96,60) ;
      Else
        ConfiguracaoDefaultRD(Seis,S12cpp,96,60) ;
      End ; // Case vLayOut of
    End ; // Procedure ConfiguracaoDefaultRetirada ;

    Procedure ConfiguracaoDefaultEmbarque ;
    Begin
      Case vLayOut of
        1 : ConfiguracaoDefaultRD(Seis,S12cpp,96,60) ;
      Else
        ConfiguracaoDefaultRD(Seis,S12cpp,96,60) ;
      End ; // Case vLayOut of
    End ; // Procedure ConfiguracaoDefaultEmbarque ;

    Procedure ConfiguracaoDefaultDevolucao ;
    Begin
      Case vLayOut of
        1 : ConfiguracaoDefaultRD(Seis,S12cpp,96,60) ;
      Else
        ConfiguracaoDefaultRD(Seis,S12cpp,96,60) ;
      End ; // Case vLayOut of
    End ; // Procedure ConfiguracaoDefaultDevolucao ;

    Procedure ConfiguracaoDefaultDTR ;
    Begin
      Case vLayOut of
        1 : ConfiguracaoDefaultRD(Seis,S12cpp,96,60) ;
      Else
        ConfiguracaoDefaultRD(Seis,S12cpp,96,60) ;
      End ; // Case vLayOut of
    End ; // Procedure ConfiguracaoDefaultDTR ;
  begin
    Case vTpServico of
      2 : ConfiguracaoDefaultApanha ;
      3 : ConfiguracaoDefaultEmbarque ;
      4 : ConfiguracaoDefaultDTR ;
      5 : ConfiguracaoDefaultRetirada ;
      6 : ConfiguracaoDefaultDevolucao ;
    End ; // Case Result.TpDocto of

    If pMostraSetupRD Then
    Begin
      Result         := FrmSetupRD.SetupRD(@RDprint1,'','CGS_Cont_' + QryCab.FieldByName('TPSERVICO').AsString ,[{rdVisualizar}]) ;
      pMostraSetupRD := False ;
    End Else // If pMostraSetupRD Then
      Result := FrmSetupRD.SetupRD(@RDprint1,'','CGS_Cont_' + QryCab.FieldByName('TPSERVICO').AsString ,[rdVisualizar,rdNaoMostraSetup])
  end; // function ConfiguracaoOk : Boolean ;

  Procedure ImpApanha ;
  Begin
    Case vLayOut of
      0 : ImpApanhaModelo_000(QryCab,QryItens) ;
    End ; // Case vLayOut of
  End ; // Procedure ImpApanha ;

  Procedure ImpRetirada ;
  Begin
    Case vLayOut of
      0 : ImpRetiradaModelo_000(QryCab,QryItens) ;
    End ; // Case vLayOut of
  End ; // Procedure ImpRetirada ;

  Procedure ImpEmbarque ;
  Begin
    Case vLayOut of
      0 : ImpEmbarqueModelo_000(QryCab,QryItens) ;
    End ; // Case vLayOut of
  End ; // Procedure ImpEmbarque ;

  Procedure ImpDevolucao ;
  Begin
    Case vLayOut of
      0 : ImpDevolucaoModelo_000(QryCab,QryItens) ;
    End ; // Case vLayOut of
  End ; // Procedure ImpDevolucao ;

  Procedure ImpDTR ;
  Begin
    Case vLayOut of
      0 : ImpDTRModelo_000(QryCab,QryItens) ;
    End ; // Case vLayOut of
  End ; // Procedure ImpDTR ;
begin
  If MDProg.FieldByName('IMPSERVICO').AsString = 'N' Then
  Begin
    Result := True ;
    Exit ;
  End ; // If MDProg.FieldByName('IMPSERVICO').AsString = 'N' Then

  pTpServico := IIf(pTpServico='',  MDProg.FieldByName('TPSERVICO'   ).AsString,  pTpServico) ;

  For vTpServico := 1 to 6 do
    If pTpServico = cTipoDocCont[vTpServico,2] Then
      Break ;

  vLayOut := MDProg.FieldByName('LAYOUT').AsInteger ;
  With QryCab do
  Begin
    Close ;
    Sql.Clear ;
    Sql.Add('SELECT A.DATA_DOCTO') ;
    Sql.Add('     , A.DATA_BAIXA') ;
    Sql.Add('     , A.CODINTPEDIDO') ;
    Sql.Add('     , A.CODINTITEMPEDIDO') ;
    Sql.Add('     , A.NUMERO_DOCTO') ;
    Sql.Add('     , A.TPSERVICO') ;
    Sql.Add('     , A.SERIE') ;
    Sql.Add('     , A.NUMCONTAINER') ;
    Sql.Add('     , A.MERCADORIA') ;
    Sql.Add('     , A.DESMEMBRADO') ;
    Sql.Add('     , A.TARA') ;
    Sql.Add('     , A.NUM_LACRE') ;
    Sql.Add('     , B.TIPO_PEDIDO') ;
    Sql.Add('     , B.SOL_NOME') ;
    Sql.Add('     , B.CLIENTE_FAT') ;
    Sql.Add('     , B.REM_CODIGO') ;
    Sql.Add('     , B.REM_CGC') ;
    Sql.Add('     , B.DEST_CODIGO') ;
    Sql.Add('     , B.DEST_CGC') ;
    Sql.Add('     , B.NUMBOOKING') ;
    Sql.Add('     , B.LOCALID_COLETA') ;
    Sql.Add('     , B.LOCALID_ENTREGA') ;
    Sql.Add('     , B.DATAHORA_ABERTURA') ;
    Sql.Add('     , B.DATAHORA_DEADLINE') ;
    Sql.Add('     , B.DESTMERCADORIA') ;
    Sql.Add('     , B.AGENCIA') ;
    Sql.Add('     , P.DESCRICAO AS NOME_AGENCIA') ;
    Sql.Add('     , B.NOMENAVIO') ;
    Sql.Add('     , B.OBSERVACAO') ;
    Sql.Add('     , B.REM_LOCALIDADE') ;
    Sql.Add('     , B.REM_ENDERECO') ;
    Sql.Add('     , B.REM_NUM_END') ;
    Sql.Add('     , B.REM_BAIRRO') ;
    Sql.Add('     , B.REM_MUNIC_ORI') ;
    Sql.Add('     , B.REM_UF_ORI') ;

    Sql.Add('     , B.DEST_LOCALIDADE') ;
    Sql.Add('     , B.DEST_ENDERECO') ;
    Sql.Add('     , B.DEST_NUM_END') ;
    Sql.Add('     , B.DEST_BAIRRO') ;
    Sql.Add('     , B.DEST_MUNIC_ORI') ;
    Sql.Add('     , B.DEST_UF_ORI') ;

    Sql.Add('     , D.CODCLI') ;
    Sql.Add('     , D.NRCLI') ;
    Sql.Add('     , D.NRINSCRICAOCLI') ;
    Sql.Add('     , D.RSOCIALCLI') ;
    Sql.Add('     , A.MOTORISTA      , E.CODIGO AS CODIGO_MOTORISTA, E.NOME AS NOME_MOTORISTA, E.IDENTIFICACAO AS ID_MOTORISTA') ;
    Sql.Add('     , A.ID_VEICULO     , A.VEICULO     , F.PREFIXOVEIC AS PREFIXO_VEICULO,   F.PLACAATUALVEIC AS PLACA_VEICULO') ;
    Sql.Add('     , A.ID_CARRETA     , A.CARRETA     , G.PREFIXOVEIC AS PREFIXO_CARRETA,   F.PLACAATUALVEIC AS PLACA_CARRETA') ;
    Sql.Add('     , A.ID_CARRETA_2   , A.CARRETA_2   , H.PREFIXOVEIC AS PREFIXO_CARRETA_2, F.PLACAATUALVEIC AS PLACA_CARRETA_2') ;
    Sql.Add('     , A.TIPO_VEICULO') ;
    Sql.Add('     , L.CODIGO AS TIPO_CONTAINER') ;
    Sql.Add('     , L.DESCRICAO AS DESCTIPO_CONTAINER') ; 
    Sql.Add('     , L.CODINDIC') ;
    Sql.Add('     , L.VALOR AS TOTAL_PREST') ;
    Sql.Add('     , L.VALOR AS FRETE_VALOR') ;
    Sql.Add('     , M.CODIGO AS TERMINAL') ; 
    Sql.Add('     , M.DESCRICAO AS DESCTERMINAL') ;
    Sql.Add('     , N.CODIGO AS ESPECIE') ;
    Sql.Add('     , N.DESCRICAO AS DESCRICAO_NATUREZA') ;
    Sql.Add('     , O.CODIGO AS UNIDADE') ;
    Sql.Add('     , O.DESCRICAO AS DESCRICAO_ESPECIE') ;

    Sql.Add('  FROM CGS_CONTSERVICOS          A') ;
    Sql.Add('     , CGS_CONTPEDIDOCLIENTE     B') ;
    Sql.Add('     , BGM_CLIENTE               D') ;
    Sql.Add('     , (SELECT IDENTIFICACAO') ; 
    Sql.Add('             , CODIGO') ; 
    Sql.Add('             , NOME') ; 
    Sql.Add('             , CODINTFUNC') ; 
    Sql.Add('          FROM (SELECT CODINTFUNC') ; 
    Sql.Add('                     , ''I'' AS IDENTIFICACAO') ;
    Sql.Add('                     , CODFUNC AS CODIGO') ;
    Sql.Add('                     , NOMEFUNC AS NOME') ;
    Sql.Add('                  FROM FLP_FUNCIONARIOS') ;
    Sql.Add('                 UNION ALL') ;
    Sql.Add('                SELECT CODINTPROAUT AS CODINTFUNC') ;
    Sql.Add('                     , ''E'' AS IDENTIFICACAO') ;
    Sql.Add('                     , CODPROAUT AS CODIGO') ;
    Sql.Add('                     , NOMEPROAUT  AS NOME') ;
    Sql.Add('                  FROM FLP_PROAUTONOMOS)) E') ;
    Sql.Add('     , FRT_CADVEICULOS           F') ;
    Sql.Add('     , FRT_CADVEICULOS           G') ;
    Sql.Add('     , FRT_CADVEICULOS           H') ;
    Sql.Add('     , CGS_CONTTIPOCONTAINER     L') ;
    Sql.Add('     , CGS_CONTTERMINAL          M') ;
    Sql.Add('     , FTA005                    N') ;
    Sql.Add('     , EXA003                    O') ;
    Sql.Add('     , CGS_CONTAGENCIA           P') ;

    Sql.Add(' WHERE A.CODINTPEDIDO      = B.CODINTPEDIDO') ;
    Sql.Add('   AND B.SOL_CODIGO        = D.CODCLI') ;
    Sql.Add('   AND A.MOTORISTA         = E.CODINTFUNC(+)') ;
    Sql.Add('   AND A.ID_MOTORISTA      = E.IDENTIFICACAO(+)') ;
    Sql.Add('   AND A.VEICULO           = F.CODIGOVEIC(+)') ;
    Sql.Add('   AND A.CARRETA           = G.CODIGOVEIC(+)') ;
    Sql.Add('   AND A.CARRETA_2         = H.CODIGOVEIC(+)') ;
    Sql.Add('   AND A.TIPO_CONTAINER    = L.CODIGO') ;
    Sql.Add('   AND A.TERMINAL          = M.CODIGO') ;
    Sql.Add('   AND B.ESPECIE           = N.CODIGO(+)') ;
    Sql.Add('   AND B.UNIDADE           = O.CODIGO(+)') ;
    Sql.Add('   AND B.AGENCIA           = P.CODIGO') ;

    Sql.Add('   AND A.CODINTPEDIDO      = :P_CODINTPEDIDO') ;
    Sql.Add('   AND A.CODINTITEMPEDIDO  = :P_CODINTITEMPEDIDO') ;
    Sql.Add('   AND A.NUMERO_DOCTO      = :P_NUMERO_DOCTO') ;
    Sql.Add('   AND A.TPSERVICO         = :P_TPSERVICO') ;
    ParamByName('P_CODINTPEDIDO'    ).AsInteger := MDProg.FieldByName('CODINTPEDIDO'    ).AsInteger ;
    ParamByName('P_CODINTITEMPEDIDO').AsInteger := MDProg.FieldByName('CODINTITEMPEDIDO').AsInteger ;
    ParamByName('P_NUMERO_DOCTO'    ).AsInteger := IIf(pNumero_Docto=0,MDProg.FieldByName('NUMERO_DOCTO').AsInteger, pNumero_Docto) ;
    ParamByName('P_TPSERVICO'       ).AsString  := pTpServico ;
  End ; // With QryPesquisa do

  Result := AbrirQuery(QryCab,'Pesq').Achou And ConfiguracaoOk ;
  If Result Then
  Begin
    With QryItens do
    Begin
      Close ;
      Sql.Clear ;
      Sql.Add('SELECT A.NOTA_FISCAL') ;
      Sql.Add('     , A.SERIE_NF') ;
      Sql.Add('     , A.ITEM_GRUPO') ;
      Sql.Add('     , B.DESCRICAO_PROD') ;
      Sql.Add('     , A.DT_EMISSAO_NF') ;
      Sql.Add('     , A.ALTURA_M3') ;
      Sql.Add('     , A.LARGURA_M3') ;
      Sql.Add('     , A.PROFUNDIDADE_M3') ;
      Sql.Add('     , A.TOTAL_M3') ;
      Sql.Add('     , A.VOLUMES') ;
      Sql.Add('     , A.PESO_LIQUIDO') ;
      Sql.Add('     , A.PESO_BRUTO') ;
      Sql.Add('     , A.VLR_MERCADORIA') ;
      Sql.Add('  FROM CGS_CONTNFSERVICOS A') ;
      Sql.Add('     , CMA041             B') ;
      Sql.Add(' WHERE A.ITEM_GRUPO       = B.CODIGO') ;
      Sql.Add('   AND A.CODINTPEDIDO     = :P_CODINTPEDIDO') ;
      Sql.Add('   AND A.CODINTITEMPEDIDO = :P_CODINTITEMPEDIDO') ;
      ParamByName('P_CODINTPEDIDO'      ).AsInteger := MDProg.FieldByName('CODINTPEDIDO'    ).AsInteger ;
      ParamByName('P_CODINTITEMPEDIDO'  ).AsInteger := MDProg.FieldByName('CODINTITEMPEDIDO').AsInteger ;
      AbrirQuery(QryItens,'QryItens') ;
    End ; // With QryItens do

    RDprint1.Abrir ;
    Case vTpServico of
      2 : ImpApanha ;
      3 : ImpEmbarque ;
      4 : ImpDTR ;
      5 : ImpRetirada ;
      6 : ImpDevolucao ;
    End ; // Case Result.TpDocto of
    RDprint1.Fechar ;

    If pSimParaTodos Then
      vRetorno    := mbSimTodos
    Else // If vSimParaTodos Then
      vRetorno    := MensagemDlg('Impressão do documento nº: ' + StrZero(QryCab.FieldByName('NUMERO_DOCTO').AsInteger,6) +
                                                   ', série: ' + QryCab.FieldByName('SERIE').AsString +' ok ? ', mtConfirmacao, mbSim+mbNao+mbSimTodos) ;

    pSimParaTodos := (vRetorno = mrSimTodos) Or pSimParaTodos ;
    Result        := vRetorno <> mrNao ;
  End ; // If Result Then
end;

procedure TFrmCGSContProgramacaoDeContainer.RDprint1NewPage(Sender: TObject; Pagina: Integer);
begin
  vLinha := IIf(Pagina=1,0,1) ;
end;

procedure TFrmCGSContProgramacaoDeContainer.ContTrocadeFormulriosClick(Sender: TObject);
Var
  vItemDeMenuChamadorAnt : String ;
begin
  vItemDeMenuChamadorAnt               := frmMenuPrincipal.vItemDeMenuChamador ;
  frmMenuPrincipal.vItemDeMenuChamador := TComponent(Sender).Name ;

  If Sender = ContTrocadeFormulrios Then
    With TfrmCGSContControleDeFormularios.Create(Self) do
    Begin
      ShowModal ;
      Free ;
    End  // With TfrmCRCCadastroDeClientes.Create(Self) do
  Else
    With TFrmCGSContPedidoDeCliente.Create(Self) do
    Begin
      ShowModal ;
      Free ;
    End ; // With TfrmCGSClientesEsporadicos.Create(Self) do

  frmMenuPrincipal.vItemDeMenuChamador := vItemDeMenuChamadorAnt ;
  If frmMenuPrincipal.vItemDeMenuChamador <> '' Then
    DireitoAoBotoesDaTela(vcUsuario, vcSistema, frmMenuPrincipal.vItemDeMenuChamador) ;
end;

procedure TFrmCGSContProgramacaoDeContainer.MEdtLocOrigeChange(Sender: TObject);
begin
  If (Trim(TMaskEdit(Sender).Text) = '') Then
  Begin
    TEdit(FindComponent('EdtDescrLoc' + Right(TComponent(Sender).Name,5)) ).Clear ;
    TEdit(FindComponent('EdtUFLoc'    + Right(TComponent(Sender).Name,5)) ).Clear ;
  End ; // If (Trim(TMaskEdit(Sender).Text) = '') Then
end;

procedure TFrmCGSContProgramacaoDeContainer.MEdtLocOrigeEnter(Sender: TObject);
begin
  TSpeedButton(FindComponent('SButLoc' + Right(TComponent(Sender).Name,5))).Enabled := True ;
end;

procedure TFrmCGSContProgramacaoDeContainer.MEdtLocOrigeExit(Sender: TObject);
begin
  TSpeedButton(FindComponent('SButLoc' + Right(TComponent(Sender).Name,5))).Enabled := False ;
  If vEsc Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) and (vTAB)) Then
  Begin
    vEsc := False ;
    TMaskEdit(Sender).Clear ;
    If Sender = MEdtLocOrige Then
    Begin
      PnlLocalid.Parent   := TabSVarios ;
      PnlBotaoConsSet.Enabled := True ;
      DBGridProg.Enabled := True ;
      PnlFiltro.Enabled  := True ;
      PnlBotoes.Enabled  := True ;
      DBGridProg.SetFocus ;
    End ; // If Sender = MEdtLocOrige Then
    Exit ;
  End ; // If vEsc Or (...

  If vAbandonaExit Or
     Gravar1.FocuSed Or
     Limpar1.FocuSed Then
  Begin
    vAbandonaExit := False ;
    Exit ;
  End ; // If vAbandonaExit Or ...

  With vcLocalidade do
  Begin
    If (Not Pesquisar(StrToIntDef(Trim(TMaskEdit(Sender).Text),0))) Or RegistroNovo Then
    Begin
      If Trim(TMaskEdit(Sender).Text) <> '' Then
        MensagemDLG('Localidade não cadastrada.', MtInformacao,MbOk) ;
      TMaskEdit(Sender).Clear ;
      TMaskEdit(Sender).SetFocus ;
    End Else // If (Not Pesquisar(...
    Begin
      TMaskEdit(Sender).Text := IntToStr(Cod_Localidade) ;
      TEdit(FindComponent('EdtDescrLoc' + Right(TComponent(Sender).Name,5))).Text := Desc_Localidade ;
      TEdit(FindComponent('EdtUFLoc'    + Right(TComponent(Sender).Name,5))).Text := UF.CodigoUF ;
    End ; // End Else // If (Not Pesquisar(...
  End ; // With vcLocalidade do
end;

procedure TFrmCGSContProgramacaoDeContainer.spbMotoristaClick(Sender: TObject);
begin
  vAbAndonaExit := False ;
  PerForm(WM_NEXTDLGCTL,0,0) ;
end;

procedure TFrmCGSContProgramacaoDeContainer.MDProgUltDocFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
begin
  If vFiltro Then
    Accept := (DataSet.FieldByName('CODINTITEMPEDIDO').AsInteger = MDProg.FieldByName('CODINTITEMPEDIDO').AsInteger)
          And (DataSet.FieldByName('CODINTPEDIDO'    ).AsInteger = MDProg.FieldByName('CODINTPEDIDO'    ).AsInteger) ;
end;

procedure TFrmCGSContProgramacaoDeContainer.edtCodTipodeVeiculoEnter(Sender: TObject);
begin
  spbTipoVeiculo.Enabled := True ;
end;

procedure TFrmCGSContProgramacaoDeContainer.DEdtSaiGar_CheEntEnter(Sender: TObject);
begin
  If (Trim(edtCodMotorista.Text) = '') Or (Trim(edtVeiculo.Text) = '') Then
  Begin
    vAbAndonaExit := True ;
    DSProg.DataSet.Edit ;
    DSProg.DataSet.FieldByName('D_SAIGAR_CHEENT').Clear ;
    TEdtSaiGar_CheEnt.Clear ;
    DSProg.DataSet.Post ;
    PerForm(WM_NEXTDLGCTL,0,0) ;
  End ; // If (Trim(edtCodMotorista.Text) = '') Or (...
end;

procedure TFrmCGSContProgramacaoDeContainer.DEdtSaiGar_CheEntExit(Sender: TObject);
Var vCritica : Integer ;
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) and (vTAB)) Then
  Begin
    vEsc := False ;
    Exit ;
  End ; // If vEsc Or (...

  If vAbandonaExit Or
     Gravar1.FocuSed Or
     Limpar1.FocuSed Then
  Begin
    vAbandonaExit := False ;
    Exit ;
  End ; // If vAbandonaExit Or ...

  vCritica := 0 ;
  If DEdtSaiGar_CheEnt.Date <> 0 Then
    If Sender = DEdtSaiGar_CheEnt Then
    Begin
      If vCritica = 0 Then
        vCritica := IIf(DEdtSaiGar_CheEnt.Text < FormatDateTime('dd/mm/yyyy',MDProg.FieldByName('DATAHORA_ABERTURA').AsDateTime),2,0) ;
      If vCritica = 0 Then
        vCritica := IIf(DEdtSaiGar_CheEnt.Text > FormatDateTime('dd/mm/yyyy',MDProg.FieldByName('DATAHORA_DEADLINE').AsDateTime),3,0) ;
    End Else // If Sender = DEdtSaiGar_CheEnt Then
    Begin
      vCritica   := IIf(StrToDateTime(DEdtSaiGar_CheEnt.Text +' '+ TEdtSaiGar_CheEnt.Text) < MDProg.FieldByName('DATAHORA_ABERTURA').AsDateTime,3,0) ;
      If vCritica = 0 Then
        vCritica := IIf(StrToDateTime(DEdtSaiGar_CheEnt.Text +' '+ TEdtSaiGar_CheEnt.Text) > MDProg.FieldByName('DATAHORA_DEADLINE').AsDateTime,3,0) ;
    End ; // End Else // If Sender = DEdtSaiGar_CheEnt Then

  If vCritica <> 0 Then
  Begin
    If vCritica <> 1 Then
      MensagemDLG('A data/hora de saída não pode ser '+ IIf(vCritica = 2,'menor que a data/hora de abertura'
                                                                        ,'maior que a data/hora do dead line') +'.', mtInformacao, mbok) ;
    TWinControl(Sender).SetFocus ;
  End ; // If vCritica <> 0 Then
end;

procedure TFrmCGSContProgramacaoDeContainer.CBoxDBBaixaAutoExit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) and (vTAB)) Then
  Begin
    vEsc := False ;
    If ((Sender = CBoxDBImpServ) And (Not CBoxDBBaixaAuto.Enabled) Or (Sender = CBoxDBBaixaAuto)) And ((Trim(edtCodMotorista.Text) = '') Or (Trim(edtVeiculo.Text) = '')) Then
      edtCodTipodeVeiculo.SetFocus ;
  End ; // If vEsc Or (...
end;

function TFrmCGSContProgramacaoDeContainer.ProcuraServComNumContainer(pCodIntPedido, pCodIntItemPedido : Integer ) : TDadosCont;
begin
  With QryPesquisa do
  Begin
    Close ;
    Sql.Clear ;
    Sql.Add('  SELECT NUMCONTAINER') ;
    Sql.Add('       , TARA') ;
    Sql.Add('       , NUM_LACRE') ;
    Sql.Add('    FROM CGS_CONTSERVICOS') ;
    Sql.Add('   WHERE CODINTPEDIDO     = :P_CODINTPEDIDO    ') ;
    Sql.Add('     AND CODINTITEMPEDIDO = :P_CODINTITEMPEDIDO') ;
    Sql.Add('     AND NOT NUMCONTAINER IS NULL') ;
    Sql.Add('GROUP BY NUMCONTAINER') ;
    Sql.Add('       , TARA') ;
    Sql.Add('       , NUM_LACRE') ;
    ParamByName('P_CODINTPEDIDO'    ).AsInteger := pCodIntPedido ;
    ParamByName('P_CODINTITEMPEDIDO').AsInteger := pCodIntItemPedido ;
    AbrirQuery(QryPesquisa,'Pesq') ;
    Result.NumContainer := FieldByName('NUMCONTAINER').AsString ;
    Result.Num_Lacre    := FieldByName('TARA'        ).AsString ;
    Result.Tara         := FieldByName('NUM_LACRE'   ).AsFloat ;
  End ; // With QryPesquisa do
end;

//
//
// --------------------------- INICIO MODELO PEDIDO ----------------------------
//procedure TFrmCGSContProgramacaoDeContainer.ImpPedidoModelo_000(pQryCab, pQryItens : TQuery) ;
//begin
//
//end;
// --------------------------- FINAL MODELO PEDIDO -----------------------------
//
//
// --------------------------- INICIO MODELO APANHA ----------------------------
procedure TFrmCGSContProgramacaoDeContainer.ImpApanhaModelo_000(pQryCab, pQryItens : TQuery) ;
Var
  vCabecalho : String ;
  vDadosCont : TDadosCont ;
begin
  With RDprint1, QryCab do
  Begin
    vDadosCont.NumContainer := Trim(FieldByName('NUMCONTAINER'   ).AsString) ;
    vDadosCont.Num_Lacre    :=      FieldByName('NUM_LACRE'      ).AsString ;
    vDadosCont.Tara         :=      FieldByName('TARA'           ).AsFloat ;
    If vDadosCont.NumContainer = '' Then
      vDadosCont := ProcuraServComNumContainer(FieldByName('CODINTPEDIDO'    ).AsInteger
                                              ,FieldByName('CODINTITEMPEDIDO').AsInteger) ;
    If pQryItens.IsEmpty Then
    Begin
      vDadosNFCont.Varios         := '' ;
      vDadosNFCont.Descricao_Prod := FieldByName('MERCADORIA').AsString ;
    End Else // If pQryItens.IsEmpty Then
      vDadosNFCont := DadosNF(pQryItens,'/','NS') ;

    ImpF(ProxLinha,Trunc((TamanhoQteColunas - Length(Trim(vcGaragem.Filial.Nomefantasiaempresa))) / 3),vcGaragem.Filial.Nomefantasiaempresa,[Expandido]) ;
    Imp(ProxLinha,1,Pad(vcGaragem.Filial.Enderecofl
                   + IIf(Trim(vcGaragem.Filial.Numeroendfl)='','',', ') + vcGaragem.Filial.Numeroendfl
                   + 'CEP ' + vcGaragem.Filial.Cepfl
                   + vcGaragem.Filial.Bairrofl
                   + '-' + vcGaragem.Filial.UF.CodigoUF
                   ,TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Pad('TELEFAX ' + vcGaragem.Filial.Fonefl
                   +' - TEl/FAX' + vcGaragem.Filial.Faxfl
                   ,TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Pad('E-MAIL:' + vcGaragem.Filial.Emailfl
                   ,TamanhoQteColunas,'C')) ;
    ImpF(ProxLinha,TamanhoQteColunas-13,StrZero(FieldByName('NUMERO_DOCTO').AsInteger,7),[Expandido]) ;
    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;
    ProxLinha ;
    vCabecalho := 'Retirada do Container ' + IIf(FieldByName('TIPO_PEDIDO').AsString = 'I','Cheio','Vazio') ;
    ImpF(ProxLinha,Trunc((TamanhoQteColunas - Length(vCabecalho)) / 3), vCabecalho ,[Expandido]) ;
    ProxLinha ;
    Imp(ProxLinha,1,Pad(vcGaragem.Filial.UF.DescricaoUF
                   +', '   + FormatDateTime('DD',Now)
                   +' de ' + cMes[StrToInt(FormatDateTime('MM',Now))]
                   +' de ' + FormatDateTime('YYYY',Now),TamanhoQteColunas,'D')
                     ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'AO TERMINAL DE CONTAINERS: ' + FieldByName('DESCTERMINAL'   ).AsString ) ;

    ProxLinha ;
    Imp(ProxLinha,1,'Cliente      : ' + FieldByName('RSOCIALCLI'     ).AsString ) ;
    Imp(ProxLinha,1,'Armador      : ' + FieldByName('NOME_AGENCIA'   ).AsString ) ;
    Imp(ProxLinha,1,'Navio        : ' + FieldByName('NOMENAVIO'      ).AsString ) ;
    Imp(ProxLinha,1,'Booking      : ' + FieldByName('NUMBOOKING'     ).AsString ) ;
    Imp(ProxLinha,1,'Destino      : ' + FieldByName('DESTMERCADORIA' ).AsString ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'CNTR         : ' + vDadosCont.NumContainer ) ;
    Imp(ProxLinha,1,'Tara         : ' + FloatToStr(vDadosCont.Tara) ) ;
    Imp(ProxLinha,1,'Lacre        : ' + vDadosCont.Num_Lacre ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'N. Fiscal    : ' + vDadosNFCont.Varios) ;
    Imp(ProxLinha,1,'Mercadoria   : ' + vDadosNFCont.Descricao_Prod ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'Motorista    : ' + FieldByName('NOME_MOTORISTA' ).AsString ) ;
    Imp(ProxLinha,1,'Veiculo\Placa: ' + FieldByName('PREFIXO_VEICULO').AsString
                   +'\'               + FieldByName('PLACA_VEICULO'  ).AsString
                                      + IIf(Trim(FieldByName('PREFIXO_CARRETA'  ).AsString) ='','',' Carreta\Placa: '   + FieldByName('PREFIXO_CARRETA'  ).AsString
                                                                                                                    +'\'+ FieldByName('PLACA_CARRETA'    ).AsString)
                                      + IIf(Trim(FieldByName('PREFIXO_CARRETA_2').AsString) ='','',' Carreta 2\Placa: ' + FieldByName('PREFIXO_CARRETA_2').AsString
                                                                                                                    +'\'+ FieldByName('PLACA_CARRETA_2'  ).AsString) ) ;
    Inc(vLinha,15) ;
    Imp(ProxLinha,1,'Observacao   : ' + Copy(FieldByName('OBSERVACAO').AsString,1,TamanhoQteColunas-16) ) ;
    If Trim(Copy(FieldByName('OBSERVACAO').AsString,16,TamanhoQteColunas)) <> '' Then
      Imp(ProxLinha,1,Copy(FieldByName('OBSERVACAO').AsString,16,TamanhoQteColunas) ) ;

    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;

    Inc(vLinha,5) ;
    Imp(ProxLinha,1,'Atenciosamente,') ;

    Inc(vLinha,3) ;
    Imp(ProxLinha,1,Pad('--------------------------------------',TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Pad(vcGaragem.Filial.Nomefantasiaempresa,    TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Pad('Divisao de Logistica e Transporte',     TamanhoQteColunas,'C')) ;
  End ; // With RDprint1, QryCab do
end;
// --------------------------- FINAL MODELO APANHA -----------------------------
//
//
// --------------------------- INICIO MODELO EMBARQUE ----------------------------
procedure TFrmCGSContProgramacaoDeContainer.ImpEmbarqueModelo_000(pQryCab, pQryItens : TQuery) ;
Var vDadosCont : TDadosCont ;
begin
  With RDprint1, QryCab do
  Begin
    vDadosCont.NumContainer := Trim(FieldByName('NUMCONTAINER'   ).AsString) ;
    vDadosCont.Num_Lacre    :=      FieldByName('NUM_LACRE'      ).AsString ;
    vDadosCont.Tara         :=      FieldByName('TARA'           ).AsFloat ;
    If vDadosCont.NumContainer = '' Then
      vDadosCont := ProcuraServComNumContainer(FieldByName('CODINTPEDIDO'    ).AsInteger
                                              ,FieldByName('CODINTITEMPEDIDO').AsInteger) ;

    If pQryItens.IsEmpty Then
    Begin
      vDadosNFCont.Varios         := '' ;
      vDadosNFCont.Descricao_Prod := FieldByName('MERCADORIA').AsString ;
    End Else // If pQryItens.IsEmpty Then
      vDadosNFCont := DadosNF(pQryItens,'/','NS') ;

    ImpF(ProxLinha,Trunc((TamanhoQteColunas - Length(Trim(vcGaragem.Filial.Nomefantasiaempresa))) / 3),vcGaragem.Filial.Nomefantasiaempresa,[Expandido]) ;
    Imp(ProxLinha,1,Pad(vcGaragem.Filial.Enderecofl
                   + IIf(Trim(vcGaragem.Filial.Numeroendfl)='','',', ') + vcGaragem.Filial.Numeroendfl
                   + 'CEP ' + vcGaragem.Filial.Cepfl
                   + vcGaragem.Filial.Bairrofl
                   + '-' + vcGaragem.Filial.UF.CodigoUF
                   ,TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Pad('TELEFAX ' + vcGaragem.Filial.Fonefl
                   +' - TEl/FAX' + vcGaragem.Filial.Faxfl
                   ,TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Pad('E-MAIL:' + vcGaragem.Filial.Emailfl
                   ,TamanhoQteColunas,'C')) ;
    ImpF(ProxLinha,TamanhoQteColunas-13,StrZero(FieldByName('NUMERO_DOCTO').AsInteger,7),[Expandido]) ;
    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;
    ProxLinha ;
    ImpF(ProxLinha,Trunc((TamanhoQteColunas - 16) / 3),'Ordem de Servico',[Expandido]) ;
    ProxLinha ;
    Imp(ProxLinha,1,Pad(vcGaragem.Filial.UF.DescricaoUF
                   +', '   + FormatDateTime('DD',Now)
                   +' de ' + cMes[StrToInt(FormatDateTime('MM',Now))]
                   +' de ' + FormatDateTime('YYYY',Now),TamanhoQteColunas,'D')
                     ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'Cliente          : ' + FieldByName('RSOCIALCLI'     ).AsString ) ;
    Imp(ProxLinha,1,'Armador          : ' + FieldByName('NOME_AGENCIA'   ).AsString ) ;
    Imp(ProxLinha,1,'Navio            : ' + FieldByName('NOMENAVIO'      ).AsString ) ;
    Imp(ProxLinha,1,'Booking          : ' + FieldByName('NUMBOOKING'     ).AsString ) ;
    Imp(ProxLinha,1,'Destino          : ' + FieldByName('DESTMERCADORIA' ).AsString ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'CNTR             : ' + vDadosCont.NumContainer ) ;
    Imp(ProxLinha,1,'Tara             : ' + FloatToStr(vDadosCont.Tara) ) ;
    Imp(ProxLinha,1,'Lacre            : ' + vDadosCont.Num_Lacre ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'N. Fiscal        : ' + vDadosNFCont.Varios) ;
    Imp(ProxLinha,1,'Mercadoria       : ' + vDadosNFCont.Descricao_Prod ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'Motorista        : ' + FieldByName('NOME_MOTORISTA' ).AsString ) ;
    Imp(ProxLinha,1,'Veiculo\Placa    : ' + FieldByName('PREFIXO_VEICULO').AsString
                   +'\'                   + FieldByName('PLACA_VEICULO'  ).AsString
                                          + IIf(Trim(FieldByName('PREFIXO_CARRETA'  ).AsString) ='','',' Carreta\Placa: '   + FieldByName('PREFIXO_CARRETA'  ).AsString
                                                                                                                        +'\'+ FieldByName('PLACA_CARRETA'    ).AsString)
                                          + IIf(Trim(FieldByName('PREFIXO_CARRETA_2').AsString) ='','',' Carreta 2\Placa: ' + FieldByName('PREFIXO_CARRETA_2').AsString
                                                                                                                        +'\'+ FieldByName('PLACA_CARRETA_2'  ).AsString) ) ;
    Imp(ProxLinha,1,'Local de Carga   : ' + FieldByName('REM_ENDERECO'   ).AsString
                   +', '                  + FieldByName('REM_NUM_END'    ).AsString) ;
    Imp(ProxLinha,1,'Bairro           : ' + FieldByName('REM_BAIRRO'     ).AsString) ;
    Imp(ProxLinha,1,'Cidade           : ' + FieldByName('REM_MUNIC_ORI'  ).AsString
                  + '  UF : '             + FieldByName('REM_UF_ORI'     ).AsString) ;
    Imp(ProxLinha,1,'CEP              : ' + FieldByName('REM_LOCALIDADE' ).AsString) ;
    ProxLinha ;
    Imp(ProxLinha,1,'Local de Entrega : ' + FieldByName('DEST_ENDERECO'  ).AsString
                   +', '                  + FieldByName('DEST_NUM_END'   ).AsString) ;
    Imp(ProxLinha,1,'Bairro           : ' + FieldByName('DEST_BAIRRO'    ).AsString) ;
    Imp(ProxLinha,1,'Cidade           : ' + FieldByName('DEST_MUNIC_ORI' ).AsString
                  + '  UF : '             + FieldByName('DEST_UF_ORI'    ).AsString) ;
    Imp(ProxLinha,1,'CEP              : ' + FieldByName('DEST_LOCALIDADE').AsString) ;
    Inc(vLinha,5) ;
    Imp(ProxLinha,1,'Observacao       : ' + Copy(FieldByName('OBSERVACAO').AsString,1,TamanhoQteColunas-19) ) ;
    If Trim(Copy(FieldByName('OBSERVACAO').AsString,19,TamanhoQteColunas)) <> '' Then
      Imp(ProxLinha,1,Copy(FieldByName('OBSERVACAO').AsString,16,TamanhoQteColunas) ) ;

    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;

    Imp(ProxLinha,1,Pad('REGISTRO DE TRANSITO',TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;
    Imp(ProxLinha,1,'CLIENTE             DATA     HORA    PORTO              DATA      HORA   KM                     ') ;
    Imp(ProxLinha,1,'Saida Terminal: ___/___/___ ___:___  Cheg. Porto...: ___/___/___ ___:___ Saida Terminal.: ______') ;
    Imp(ProxLinha,1,'Cheg. Cliente.: ___/___/___ ___:___  In. Des.......: ___/___/___ ___:___ Chegada Cliente: ______') ;
    Imp(ProxLinha,1,'In. Operacao..: ___/___/___ ___:___  Fin. Dese.....: ___/___/___ ___:___ Chegada Porto..: ______') ;
    Imp(ProxLinha,1,'Final Operacao: ___/___/___ ___:___  Saida Porto...: ___/___/___ ___:___ Saida Porto....: ______') ;
    Imp(ProxLinha,1,'Saida Cliente.: ___/___/___ ___:___  Cheg. Terminal: ___/___/___ ___:___ Chegada Trminal: ______') ;
    Imp(ProxLinha,1,'Perm. Cliente.: ___/___/___ ___:___  Per. Porto....: ___/___/___ ___:___ Total KM.......: ______') ;

    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;
    Inc(vLinha,3) ;
    Imp(ProxLinha,1,Pad('--------------------',TamanhoQteColunas,'D')) ;
    Imp(ProxLinha,1,Pad('Carimbo e assinatura',TamanhoQteColunas,'D')) ;
  End ; // With RDprint1, QryCab do
end;
// --------------------------- FINAL MODELO EMBARQUE ----------------------------
//
//
// --------------------------- INICIO MODELO DTR ---------------------------
procedure TFrmCGSContProgramacaoDeContainer.ImpDTRModelo_000(pQryCab, pQryItens : TQuery) ;
Var vDadosCont : TDadosCont ;
begin
  With RDprint1, QryCab do
  Begin
    vDadosCont.NumContainer := Trim(FieldByName('NUMCONTAINER'   ).AsString) ;
    vDadosCont.Num_Lacre    :=      FieldByName('NUM_LACRE'      ).AsString ;
    vDadosCont.Tara         :=      FieldByName('TARA'           ).AsFloat ;
    If vDadosCont.NumContainer = '' Then
      vDadosCont := ProcuraServComNumContainer(FieldByName('CODINTPEDIDO'    ).AsInteger
                                              ,FieldByName('CODINTITEMPEDIDO').AsInteger) ;

    If pQryItens.IsEmpty Then
    Begin
      vDadosNFCont.Varios         := '' ;
      vDadosNFCont.Descricao_Prod := FieldByName('MERCADORIA').AsString ;
    End Else // If pQryItens.IsEmpty Then
      vDadosNFCont := DadosNF(pQryItens,'/','NS') ;

    Imp(ProxLinha,01,FieldByName('DESCTIPO_CONTAINER').AsString ) ;
    Imp(vLinha,   80,vDadosCont.NumContainer ) ;
    Imp(ProxLinha,01,FieldByName('RSOCIALCLI'        ).AsString ) ;
    Imp(ProxLinha,01,FloatToStr(vDadosCont.Tara) ) ;
    Imp(ProxLinha,01,vDadosCont.Num_Lacre ) ;
    Imp(ProxLinha,01,vDadosNFCont.Descricao_Prod ) ;

    Imp(ProxLinha,01,vcGaragem.Filial.Empresa.Rsocialempresa    ) ;

    Imp(ProxLinha,01,FieldByName('DESCRICAO_NATUREZA').AsString ) ;
    Imp(ProxLinha,01,FieldByName('NOME_AGENCIA'      ).AsString ) ;
    Imp(ProxLinha,01,FieldByName('DESCTERMINAL'      ).AsString ) ;

    Imp(ProxLinha,01,FieldByName('NUMBOOKING'        ).AsString ) ;
  End ; // With RDprint1, QryCab do
end;
// --------------------------- FINAL MODELO DTR ---------------------------
//
//
// --------------------------- INICIO MODELO RETIRADA ----------------------------
procedure TFrmCGSContProgramacaoDeContainer.ImpRetiradaModelo_000(pQryCab, pQryItens : TQuery) ;
Var vDadosCont : TDadosCont ;
begin
  With RDprint1, QryCab do
  Begin
    vDadosCont.NumContainer := Trim(FieldByName('NUMCONTAINER'   ).AsString) ;
    vDadosCont.Num_Lacre    :=      FieldByName('NUM_LACRE'      ).AsString ;
    vDadosCont.Tara         :=      FieldByName('TARA'           ).AsFloat ;
    If vDadosCont.NumContainer = '' Then
      vDadosCont := ProcuraServComNumContainer(FieldByName('CODINTPEDIDO'    ).AsInteger
                                              ,FieldByName('CODINTITEMPEDIDO').AsInteger) ;

    If pQryItens.IsEmpty Then
    Begin
      vDadosNFCont.Varios         := '' ;
      vDadosNFCont.Descricao_Prod := FieldByName('MERCADORIA').AsString ;
    End Else // If pQryItens.IsEmpty Then
      vDadosNFCont := DadosNF(pQryItens,'/','NS') ;

    ImpF(ProxLinha,Trunc((TamanhoQteColunas - Length(Trim(vcGaragem.Filial.Nomefantasiaempresa))) / 3),vcGaragem.Filial.Nomefantasiaempresa,[Expandido]) ;
    Imp(ProxLinha,1,Pad(vcGaragem.Filial.Enderecofl
                   + IIf(Trim(vcGaragem.Filial.Numeroendfl)='','',', ') + vcGaragem.Filial.Numeroendfl
                   + 'CEP ' + vcGaragem.Filial.Cepfl
                   + vcGaragem.Filial.Bairrofl
                   + '-' + vcGaragem.Filial.UF.CodigoUF
                   ,TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Pad('TELEFAX ' + vcGaragem.Filial.Fonefl
                   +' - TEl/FAX' + vcGaragem.Filial.Faxfl
                   ,TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Pad('E-MAIL:' + vcGaragem.Filial.Emailfl
                   ,TamanhoQteColunas,'C')) ;
    ImpF(ProxLinha,TamanhoQteColunas-13,StrZero(FieldByName('NUMERO_DOCTO').AsInteger,7),[Expandido]) ;
    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;
    ProxLinha ;
    ImpF(ProxLinha,Trunc((TamanhoQteColunas - 16) / 3),'Ordem de Servico',[Expandido]) ;
    ProxLinha ;
    Imp(ProxLinha,1,Pad(vcGaragem.Filial.UF.DescricaoUF
                   +', '   + FormatDateTime('DD',Now)
                   +' de ' + cMes[StrToInt(FormatDateTime('MM',Now))]
                   +' de ' + FormatDateTime('YYYY',Now),TamanhoQteColunas,'D')
                     ) ;
    ProxLinha ;

    Imp(ProxLinha,1,'Cliente          : ' + FieldByName('RSOCIALCLI'     ).AsString ) ;
    Imp(ProxLinha,1,'Armador          : ' + FieldByName('NOME_AGENCIA'   ).AsString ) ;
    Imp(ProxLinha,1,'Navio            : ' + FieldByName('NOMENAVIO'      ).AsString ) ;
    Imp(ProxLinha,1,'Booking          : ' + FieldByName('NUMBOOKING'     ).AsString ) ;
    Imp(ProxLinha,1,'Destino          : ' + FieldByName('DESTMERCADORIA' ).AsString ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'CNTR             : ' + vDadosCont.NumContainer ) ;
    Imp(ProxLinha,1,'Tara             : ' + FloatToStr(vDadosCont.Tara) ) ;
    Imp(ProxLinha,1,'Lacre            : ' + vDadosCont.Num_Lacre ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'N. Fiscal        : ' + vDadosNFCont.Varios ) ;
    Imp(ProxLinha,1,'Mercadoria       : ' + vDadosNFCont.Descricao_Prod ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'Motorista        : ' + FieldByName('NOME_MOTORISTA' ).AsString ) ;
    Imp(ProxLinha,1,'Veiculo\Placa    : ' + FieldByName('PREFIXO_VEICULO').AsString
                   +'\'                   + FieldByName('PLACA_VEICULO'  ).AsString
                                          + IIf(Trim(FieldByName('PREFIXO_CARRETA'  ).AsString) ='','',' Carreta\Placa: '   + FieldByName('PREFIXO_CARRETA'  ).AsString
                                                                                                                        +'\'+ FieldByName('PLACA_CARRETA'    ).AsString)
                                          + IIf(Trim(FieldByName('PREFIXO_CARRETA_2').AsString) ='','',' Carreta 2\Placa: ' + FieldByName('PREFIXO_CARRETA_2').AsString
                                                                                                                        +'\'+ FieldByName('PLACA_CARRETA_2'  ).AsString) ) ;
    Imp(ProxLinha,1,'Local de Carga   : ' + FieldByName('REM_ENDERECO'   ).AsString
                   +', '                  + FieldByName('REM_NUM_END'    ).AsString) ;
    Imp(ProxLinha,1,'Bairro           : ' + FieldByName('REM_BAIRRO'     ).AsString) ;
    Imp(ProxLinha,1,'Cidade           : ' + FieldByName('REM_MUNIC_ORI'  ).AsString
                  + '  UF : '             + FieldByName('REM_UF_ORI'     ).AsString) ;
    Imp(ProxLinha,1,'CEP              : ' + FieldByName('REM_LOCALIDADE' ).AsString) ;
    ProxLinha ;
    Imp(ProxLinha,1,'Local de Entrega : ' + FieldByName('DEST_ENDERECO'  ).AsString
                   +', '                  + FieldByName('DEST_NUM_END'   ).AsString) ;
    Imp(ProxLinha,1,'Bairro           : ' + FieldByName('DEST_BAIRRO'    ).AsString) ;
    Imp(ProxLinha,1,'Cidade           : ' + FieldByName('DEST_MUNIC_ORI' ).AsString
                  + '  UF : '             + FieldByName('DEST_UF_ORI'    ).AsString) ;
    Imp(ProxLinha,1,'CEP              : ' + FieldByName('DEST_LOCALIDADE').AsString) ;
    Inc(vLinha,05) ;
    Imp(ProxLinha,1,'Observacao       : ' + Copy(FieldByName('OBSERVACAO').AsString,1,TamanhoQteColunas-19) ) ;
    If Trim(Copy(FieldByName('OBSERVACAO').AsString,19,TamanhoQteColunas)) <> '' Then
      Imp(ProxLinha,1,Copy(FieldByName('OBSERVACAO').AsString,16,TamanhoQteColunas) ) ;

    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;

    Imp(ProxLinha,1,Pad('REGISTRO DE TRANSITO',TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;
    Imp(ProxLinha,1,'CLIENTE             DATA     HORA    PORTO              DATA      HORA   KM                     ') ;
    Imp(ProxLinha,1,'Saida Terminal: ___/___/___ ___:___  Cheg. Porto...: ___/___/___ ___:___ Saida Terminal.: ______') ;
    Imp(ProxLinha,1,'Cheg. Cliente.: ___/___/___ ___:___  In. Des.......: ___/___/___ ___:___ Chegada Cliente: ______') ;
    Imp(ProxLinha,1,'In. Operacao..: ___/___/___ ___:___  Fin. Dese.....: ___/___/___ ___:___ Chegada Porto..: ______') ;
    Imp(ProxLinha,1,'Final Operacao: ___/___/___ ___:___  Saida Porto...: ___/___/___ ___:___ Saida Porto....: ______') ;
    Imp(ProxLinha,1,'Saida Cliente.: ___/___/___ ___:___  Cheg. Terminal: ___/___/___ ___:___ Chegada Trminal: ______') ;
    Imp(ProxLinha,1,'Perm. Cliente.: ___/___/___ ___:___  Per. Porto....: ___/___/___ ___:___ Total KM.......: ______') ;

    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;
    Inc(vLinha,3) ;
    Imp(ProxLinha,1,Pad('--------------------',TamanhoQteColunas,'D')) ;
    Imp(ProxLinha,1,Pad('Carimbo e assinatura',TamanhoQteColunas,'D')) ;
  End ; // With RDprint1, QryCab do
end;
// --------------------------- FINAL MODELO RETIRADA ----------------------------
//
//
// --------------------------- INICIO MODELO DEVOLUCAO ----------------------------
procedure TFrmCGSContProgramacaoDeContainer.ImpDevolucaoModelo_000(pQryCab, pQryItens : TQuery) ;
Var vDadosCont : TDadosCont ;
begin
  With RDprint1, QryCab do
  Begin
    vDadosCont.NumContainer := Trim(FieldByName('NUMCONTAINER'   ).AsString) ;
    vDadosCont.Num_Lacre    :=      FieldByName('NUM_LACRE'      ).AsString ;
    vDadosCont.Tara         :=      FieldByName('TARA'           ).AsFloat ;
    If vDadosCont.NumContainer = '' Then
      vDadosCont := ProcuraServComNumContainer(FieldByName('CODINTPEDIDO'    ).AsInteger
                                              ,FieldByName('CODINTITEMPEDIDO').AsInteger) ;

    If pQryItens.IsEmpty Then
    Begin
      vDadosNFCont.Varios         := '' ;
      vDadosNFCont.Descricao_Prod := FieldByName('MERCADORIA').AsString ;
    End Else // If pQryItens.IsEmpty Then
      vDadosNFCont := DadosNF(pQryItens,'/','NS') ;

    ImpF(ProxLinha,Trunc((TamanhoQteColunas - Length(Trim(vcGaragem.Filial.Nomefantasiaempresa))) / 3),vcGaragem.Filial.Nomefantasiaempresa,[Expandido]) ;
    Imp(ProxLinha,1,Pad(vcGaragem.Filial.Enderecofl
                   + IIf(Trim(vcGaragem.Filial.Numeroendfl)='','',', ') + vcGaragem.Filial.Numeroendfl
                   + 'CEP ' + vcGaragem.Filial.Cepfl
                   + vcGaragem.Filial.Bairrofl
                   + '-' + vcGaragem.Filial.UF.CodigoUF
                   ,TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Pad('TELEFAX ' + vcGaragem.Filial.Fonefl
                   +' - TEl/FAX' + vcGaragem.Filial.Faxfl
                   ,TamanhoQteColunas,'C')) ;
    Imp(ProxLinha,1,Pad('E-MAIL:' + vcGaragem.Filial.Emailfl
                   ,TamanhoQteColunas,'C')) ;
    ImpF(ProxLinha,TamanhoQteColunas-13,StrZero(FieldByName('NUMERO_DOCTO').AsInteger,7),[Expandido]) ;
    Imp(ProxLinha,1,Replicate('-',TamanhoQteColunas)) ;
    ProxLinha ;
    ImpF(ProxLinha,Trunc((TamanhoQteColunas - 16) / 3),'Ordem de Entrega',[Expandido]) ;
    ProxLinha ;
    Imp(ProxLinha,1,Pad(vcGaragem.Filial.UF.DescricaoUF
                   +', '   + FormatDateTime('DD',Now)
                   +' de ' + cMes[StrToInt(FormatDateTime('MM',Now))]
                   +' de ' + FormatDateTime('YYYY',Now),TamanhoQteColunas,'D')
                     ) ;
    ProxLinha ;

    Imp(ProxLinha,1,'Cliente          : ' + FieldByName('RSOCIALCLI'     ).AsString ) ;
    Imp(ProxLinha,1,'Armador          : ' + FieldByName('NOME_AGENCIA'   ).AsString ) ;
    Imp(ProxLinha,1,'Navio            : ' + FieldByName('NOMENAVIO'      ).AsString ) ;
    Imp(ProxLinha,1,'Booking          : ' + FieldByName('NUMBOOKING'     ).AsString ) ;
    Imp(ProxLinha,1,'Destino          : ' + FieldByName('DESTMERCADORIA' ).AsString ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'CNTR             : ' + vDadosCont.NumContainer ) ;
    Imp(ProxLinha,1,'Tara             : ' + FloatToStr(vDadosCont.Tara) ) ;
    Imp(ProxLinha,1,'Lacre            : ' + vDadosCont.Num_Lacre ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'N. Fiscal        : ' + vDadosNFCont.Varios) ;
    Imp(ProxLinha,1,'Mercadoria       : ' + vDadosNFCont.Descricao_Prod ) ;
    ProxLinha ;
    Imp(ProxLinha,1,'Motorista        : ' + FieldByName('NOME_MOTORISTA' ).AsString ) ;
    Imp(ProxLinha,1,'Veiculo\Placa    : ' + FieldByName('PREFIXO_VEICULO').AsString
                   +'\'                   + FieldByName('PLACA_VEICULO'  ).AsString
                                          + IIf(Trim(FieldByName('PREFIXO_CARRETA'  ).AsString) ='','',' Carreta\Placa: '   + FieldByName('PREFIXO_CARRETA'  ).AsString
                                                                                                                        +'\'+ FieldByName('PLACA_CARRETA'    ).AsString)
                                          + IIf(Trim(FieldByName('PREFIXO_CARRETA_2').AsString) ='','',' Carreta 2\Placa: ' + FieldByName('PREFIXO_CARRETA_2').AsString
                                                                                                                        +'\'+ FieldByName('PLACA_CARRETA_2'  ).AsString) ) ;
    Imp(ProxLinha,1,'Local de Carga   : ' + FieldByName('REM_ENDERECO'   ).AsString
                   +', '                  + FieldByName('REM_NUM_END'    ).AsString) ;
    Imp(ProxLinha,1,'Bairro           : ' + FieldByName('REM_BAIRRO'     ).AsString) ;
    Imp(ProxLinha,1,'Cidade           : ' + FieldByName('REM_MUNIC_ORI'  ).AsString
                  + '  UF : '             + FieldByName('REM_UF_ORI'     ).AsString) ;
    Imp(ProxLinha,1,'CEP              : ' + FieldByName('REM_LOCALIDADE' ).AsString) ;
    ProxLinha ;
    Imp(ProxLinha,1,'Local de Entrega : ' + FieldByName('DEST_ENDERECO'  ).AsString
                   +', '                  + FieldByName('DEST_NUM_END'   ).AsString) ;
    Imp(ProxLinha,1,'Bairro           : ' + FieldByName('DEST_BAIRRO'    ).AsString) ;
    Imp(ProxLinha,1,'Cidade           : ' + FieldByName('DEST_MUNIC_ORI' ).AsString
                  + '  UF : '             + FieldByName('DEST_UF_ORI'    ).AsString) ;
    Imp(ProxLinha,1,'CEP              : ' + FieldByName('DEST_LOCALIDADE').AsString) ;
    Inc(vLinha,05) ;
    Imp(ProxLinha,1,'Observacao       : ' + Copy(FieldByName('OBSERVACAO').AsString,1,TamanhoQteColunas-19) ) ;
    If Trim(Copy(FieldByName('OBSERVACAO').AsString,19,TamanhoQteColunas)) <> '' Then
      Imp(ProxLinha,1,Copy(FieldByName('OBSERVACAO').AsString,16,TamanhoQteColunas) ) ;

    Imp(ProxLinha,1,Pad('REGISTRO DE TRANSITO',TamanhoQteColunas,'C')) ;
  End ; // With RDprint1, QryCab do
end;
// --------------------------- FINAL MODELO DEVOLUCAO ----------------------------
//
//

end.
