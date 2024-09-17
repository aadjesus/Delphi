unit MenuPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, ExtCtrls, Menus, DBTables, Db;

type
  TFrmMenuPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    mnCdDivisao: TMenuItem;
    cdUnidadeDeMedida: TMenuItem;
    CadastroDeFornecedores: TMenuItem;
    cdMarca: TMenuItem;
    ParmetrosContbeis1: TMenuItem;
    Parmentros1: TMenuItem;
    Tiposdedocumentos1: TMenuItem;
    ndices1: TMenuItem;
    Tiposdereceita1: TMenuItem;
    cdGrupos: TMenuItem;
    Analise1: TMenuItem;
    cdCompra: TMenuItem;
    cdDespesa: TMenuItem;
    cdEstoque: TMenuItem;
    cdRateio: TMenuItem;
    cdContabil: TMenuItem;
    Custo1: TMenuItem;
    mnControle: TMenuItem;
    Local1: TMenuItem;
    UF1: TMenuItem;
    cdMaterial: TMenuItem;
    cdHistorico: TMenuItem;
    mnPosicaodeMaterial: TMenuItem;
    mnAgrupamento: TMenuItem;
    AgrupamentodeCompas1: TMenuItem;
    mnAgFornGrpCpr: TMenuItem;
    Material1: TMenuItem;
    AssociaMarcaGrupodeCompras1: TMenuItem;
    AssocMatTpDespGrpCtb: TMenuItem;
    LeisVingentes1: TMenuItem;
    Contasreceber1: TMenuItem;
    Clientes1: TMenuItem;
    Tiposdereceitas1: TMenuItem;
    Contaspagar1: TMenuItem;
    Tiposdedespesa1: TMenuItem;
    TiposdeDocumento1: TMenuItem;
    N2: TMenuItem;
    Valoresdendices1: TMenuItem;
    CentrosDeCustosFinanceiros: TMenuItem;
    Escrituraofiscal1: TMenuItem;
    Classificacoesfiscais1: TMenuItem;
    Operacoesfiscais1: TMenuItem;
    Folha1: TMenuItem;
    CadastrodeFuncSimplificados1: TMenuItem;
    Setor1: TMenuItem;
    Condio1: TMenuItem;
    Funcao1: TMenuItem;
    Sindicatos1: TMenuItem;
    rea1: TMenuItem;
    Departamento1: TMenuItem;
    Seo1: TMenuItem;
    RegioGeogrfica1: TMenuItem;
    MotivoDeslig1: TMenuItem;
    CadastroQuitao1: TMenuItem;
    DVS1: TMenuItem;
    TipodeBem1: TMenuItem;
    Abastecimento1: TMenuItem;
    Tipodeleo1: TMenuItem;
    Frota1: TMenuItem;
    Veiculos1: TMenuItem;
    Banco1: TMenuItem;
    Bancos1: TMenuItem;
    Agncias1: TMenuItem;
    Editordetextos1: TMenuItem;
    N27: TMenuItem;
    Agenda1: TMenuItem;
    mnMovimentacaodiaria: TMenuItem;
    Entradas1: TMenuItem;
    porNotafiscal1: TMenuItem;
    porVale1: TMenuItem;
    N13: TMenuItem;
    DevoluodeSada1: TMenuItem;
    Sadas1: TMenuItem;
    porRequisiodemateriais1: TMenuItem;
    porVale2: TMenuItem;
    porSimplesRemessa1: TMenuItem;
    N12: TMenuItem;
    DevoluodeEntrada1: TMenuItem;
    N17: TMenuItem;
    LiberacaoRM: TMenuItem;
    NN2: TMenuItem;
    Cancelamento1: TMenuItem;
    Notafiscalentrada1: TMenuItem;
    Valeentrada1: TMenuItem;
    N4: TMenuItem;
    Requisiosada1: TMenuItem;
    Valesada1: TMenuItem;
    N5: TMenuItem;
    mnTransferencia: TMenuItem;
    N7: TMenuItem;
    mnContasPagar: TMenuItem;
    Manuteno1: TMenuItem;
    Autorizaodepagamento1: TMenuItem;
    Alteraodedocumentos1: TMenuItem;
    N23: TMenuItem;
    Enviomateriaisrecond: TMenuItem;
    mnProcedimentosMensais: TMenuItem;
    mnInventario: TMenuItem;
    mnInvLstContagem: TMenuItem;
    mnDigitacaoDeSaldos: TMenuItem;
    mnDiscordancias: TMenuItem;
    N15: TMenuItem;
    mnRetificacao: TMenuItem;
    Cancelamento2: TMenuItem;
    N6: TMenuItem;
    mnFechamentoMensal: TMenuItem;
    mnAberturaDoMes: TMenuItem;
    N8: TMenuItem;
    mnRateioDeMateriais: TMenuItem;
    GeraRateio1: TMenuItem;
    EstornodeRateio1: TMenuItem;
    N25: TMenuItem;
    Inventrioporetapas1: TMenuItem;
    Listagemparacontagem1: TMenuItem;
    Digitaodesaldos1: TMenuItem;
    Discordnciaentrecontagens1: TMenuItem;
    N24: TMenuItem;
    Retificao1: TMenuItem;
    Cancelamento3: TMenuItem;
    mnProcedimentosAuxiliares: TMenuItem;
    RecalculodeKardex1: TMenuItem;
    N10: TMenuItem;
    mnIntegeracaoCPGCTB: TMenuItem;
    mnGrvContasContabeis: TMenuItem;
    mnEmiteResumoContabil: TMenuItem;
    N3: TMenuItem;
    mnEfetuaIntegracao: TMenuItem;
    N16: TMenuItem;
    mnRetiraFlagIntegracao: TMenuItem;
    mnRetiraFlagIntegracaoVale: TMenuItem;
    mnRetiraFlagIntegracaoSaida: TMenuItem;
    N21: TMenuItem;
    Efetualanamentoscontbeis1: TMenuItem;
    N22: TMenuItem;
    EfetuaIntegraonotasada1: TMenuItem;
    N11: TMenuItem;
    mnTrocaCodigoInternoMaterial: TMenuItem;
    Itensabertosnasrequisies1: TMenuItem;
    TrocadatadeemissodaNotaFiscal1: TMenuItem;
    N14: TMenuItem;
    mnEntradaDeSaldos: TMenuItem;
    N9: TMenuItem;
    mnEmiteNFMaterialAvulso1: TMenuItem;
    mnCodigoBarras: TMenuItem;
    mnGeraEtiquetasAvulsas: TMenuItem;
    mnImprimeCodigoBarras: TMenuItem;
    mnApagaCodigoBarra: TMenuItem;
    N18: TMenuItem;
    TrocaSenhadoUsurio1: TMenuItem;
    N19: TMenuItem;
    Recculodeestoquemnimoemximo1: TMenuItem;
    N20: TMenuItem;
    Livrofiscalmodelo21: TMenuItem;
    Gerarmovimento1: TMenuItem;
    Cadastro1: TMenuItem;
    N26: TMenuItem;
    Globusreport1: TMenuItem;
    Consultas1: TMenuItem;
    ConsumoDireto1: TMenuItem;
    NFdeEntradaeSada1: TMenuItem;
    AssociaValeNotaFiscal1: TMenuItem;
    ConsultaSaldoMaterial1: TMenuItem;
    Pendenciatransfreq1: TMenuItem;
    mnListagens: TMenuItem;
    mnLstDivisoes: TMenuItem;
    GrupodeCompras1: TMenuItem;
    GrupodeDespesas1: TMenuItem;
    GrupodeEstoque1: TMenuItem;
    PosiodeMateriais1: TMenuItem;
    UnidadedeMedida1: TMenuItem;
    HistoricodeMovimentao1: TMenuItem;
    MarcadeMaterial1: TMenuItem;
    GrupodeRateio1: TMenuItem;
    AgrupamentodeCompras1: TMenuItem;
    GrupoContbil1: TMenuItem;
    ListagemGenrica1: TMenuItem;
    Construtor1: TMenuItem;
    Imprimir1: TMenuItem;
    Itensde1: TMenuItem;
    MaterialporContadeEstoque1: TMenuItem;
    Listagemdeconsumo1: TMenuItem;
    GrupodeAnlise1: TMenuItem;
    GrupodeCusto1: TMenuItem;
    frmEst_RelCustoPecasVeic: TMenuItem;
    Dirios1: TMenuItem;
    mnRelFaltasdoDia: TMenuItem;
    mnRelComparativoentreCompras: TMenuItem;
    mnRelMateriaissemMovimento: TMenuItem;
    Materiaiscommovimento1: TMenuItem;
    mnRelCriticadeConsumo: TMenuItem;
    RequisiodeMaterial1: TMenuItem;
    mnRelEmissaodeFichaKardex: TMenuItem;
    Empresa3: TMenuItem;
    Local3: TMenuItem;
    TransfernciasdeMateriais1: TMenuItem;
    mnPontoPedido: TMenuItem;
    mnControledeSadasFilial: TMenuItem;
    RelatriodeConferncia1: TMenuItem;
    RelatrioUltimasCompras1: TMenuItem;
    IntegraoEstoqueCPG: TMenuItem;
    NotasFiscaisdeServio1: TMenuItem;
    MapadeNotasFiscais1: TMenuItem;
    DurabilidadedePeas1: TMenuItem;
    MateriaiscomLocaisAgrupados: TMenuItem;
    AutorizaodePagamentos1: TMenuItem;
    MovItensNumerao1: TMenuItem;
    Entradadefornecedores1: TMenuItem;
    ConfereBaixasPendencias: TMenuItem;
    ItensPendentesReqTransf1: TMenuItem;
    Analtico1: TMenuItem;
    Sinttico1: TMenuItem;
    Vendaperdida1: TMenuItem;
    ItemsSaldobaixoCM1: TMenuItem;
    mnRelAnaliticos: TMenuItem;
    mnRelAnporCdigo: TMenuItem;
    mnRelAnporData: TMenuItem;
    mnRelAnporFornecedor: TMenuItem;
    mnRelAnporVeiculoCCusto: TMenuItem;
    mnRelAnporSetor: TMenuItem;
    porVencimento1: TMenuItem;
    mnRelAnConsumoPorSetor: TMenuItem;
    porModelodoChassi: TMenuItem;
    Vale1: TMenuItem;
    mnRelSinteticos: TMenuItem;
    mnRelSinporCodigo: TMenuItem;
    mnRelSinporData: TMenuItem;
    mnRelSinporFornecedor: TMenuItem;
    mnRelSinporVeiculoCCusto: TMenuItem;
    ResumoDirio1: TMenuItem;
    porSetor1: TMenuItem;
    porVencimento2: TMenuItem;
    porSilModelodoChassi: TMenuItem;
    Entradaporvale1: TMenuItem;
    Mensais1: TMenuItem;
    mnRelMateriaiscomsaldoZerado: TMenuItem;
    mnRelPosicaoDoEstoque: TMenuItem;
    mnRelGirodeEstoque: TMenuItem;
    mnRelPosicaoFinanceira: TMenuItem;
    Empresa2: TMenuItem;
    Local2: TMenuItem;
    GrficoPosioFinanceira1: TMenuItem;
    Imprime: TMenuItem;
    ImprimeGrficoAnual1: TMenuItem;
    ImprimeGrficoPorEmpresa1: TMenuItem;
    PosiofinanceiraCrystalReports1: TMenuItem;
    Empresa4: TMenuItem;
    Filial1: TMenuItem;
    LivroFiscal1: TMenuItem;
    Empresa1: TMenuItem;
    LvrFiscLocal: TMenuItem;
    mnCtrComprasEmp: TMenuItem;
    ConsumoporFilial1: TMenuItem;
    mnRelCurvaABC: TMenuItem;
    ConsumoOxigNitrgAcetil1: TMenuItem;
    GrupodeAnalise1: TMenuItem;
    Comprasefetuadasnoperodo1: TMenuItem;
    Demonstrativodeitens1: TMenuItem;
    Gerenciais1: TMenuItem;
    mnRelDemonstrativodeSaidas: TMenuItem;
    DemonstConsumoporLocal1: TMenuItem;
    CustoPrefixo: TMenuItem;
    porprefixo1: TMenuItem;
    porcentrodecusto1: TMenuItem;
    CustoporGrupo1: TMenuItem;
    Custoderodagem1: TMenuItem;
    Custosporgrupodeanlise1: TMenuItem;
    mnRelEmissaodeEtiquetas: TMenuItem;
    ImpressodeEtiquetas1: TMenuItem;
    Imprimir2: TMenuItem;
    Parmetros1: TMenuItem;
    Estoque1: TMenuItem;
    Saida: TMenuItem;
    Ajuda1: TMenuItem;
    AjudaDoModulo: TMenuItem;
    N1: TMenuItem;
    AjudaSobreSistema: TMenuItem;
    Image2: TImage;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    tbcdMaterial: TToolButton;
    BarraDeEstatus: TStatusBar;
    PopupMenu1: TPopupMenu;
    Checklist1: TMenuItem;
    Query1: TQuery;
    db1: TDatabase;
    procedure Checklist1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnCdDivisaoClick(Sender: TObject);
    procedure porNotafiscal1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenuPrincipal: TFrmMenuPrincipal;

implementation

Uses
  Checklist, Tela1, Tela2 ;

{$R *.DFM}

procedure TFrmMenuPrincipal.Checklist1Click(Sender: TObject);
begin
  With TFrmCheckList.Create(Self) Do
  Begin
    ShowModal;
    Free;
  End;
end;

procedure TFrmMenuPrincipal.FormShow(Sender: TObject);
begin
  db1.Connected := True ;
  With Query1 do
  Begin
    Close ;
    Sql.Clear ;
    Sql.Add(' SELECT       ') ;
    Sql.Add(' *            ') ;
    Sql.Add(' FROM         ') ;
    Sql.Add(' CTR_CheckList') ;
    Open ;
    If Not IsEmpty Then
      Checklist1Click(Sender) ;
  End ; // While Query1 do
end;

procedure TFrmMenuPrincipal.mnCdDivisaoClick(Sender: TObject);
begin
  With FrmTela1.Create(Self) Do
  Begin
    ShowModal;
    Free;
  End;
end;

procedure TFrmMenuPrincipal.porNotafiscal1Click(Sender: TObject);
begin
  With FrmTela2.Create(Self) Do
  Begin
    ShowModal;
    Free;
  End;
end;

end.
