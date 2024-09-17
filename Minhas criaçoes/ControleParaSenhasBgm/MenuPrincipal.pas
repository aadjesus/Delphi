unit MenuPrincipal;

interface

uses
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt},
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Grids, DBGrids, StdCtrls, ExtCtrls, ControleParaSenhasBgm,
  ComCtrls, Bgm_Enter, OleCtrls, UCrpe32, jpeg, Gradient, BGM_Utils,  {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt},
  dbtables, RxMemDS, db;

type
  TfrmMenuPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Saida: TMenuItem;
    BarraDeEstatus: TStatusBar;
    ContSenhaBgm: TContSenhaBgm;
    Timer1: TTimer;
    Ajuda1: TMenuItem;
    AjudaDoModulo: TMenuItem;
    N1: TMenuItem;
    AjudaSobreSistema: TMenuItem;
    Cadastros1: TMenuItem;
    UF1: TMenuItem;
    Movimentos1: TMenuItem;
    lstListagens: TMenuItem;
    Superviso1: TMenuItem;
    PlanodeReviso1: TMenuItem;
    GrupodeReviso1: TMenuItem;
    Servios1: TMenuItem;
    GrupodeServio1: TMenuItem;
    Defeitos1: TMenuItem;
    cdMaterial: TMenuItem;
    KmReviso1: TMenuItem;
    lstGrupoDeRevisao: TMenuItem;
    CrRpt: TCrpe;
    mnTipoOperacaoServicos: TMenuItem;
    mnAssociaServicosAMateriais: TMenuItem;
    mnAssociaKmDeRevisaoAServicos: TMenuItem;
    mnOutros: TMenuItem;
    mnAberturaDeOSCorretiva: TMenuItem;
    mnAberturaDeOSPreventiva: TMenuItem;
    N3: TMenuItem;
    mnFechamentoDeOS: TMenuItem;
    mnProcedimentosAuxiliares: TMenuItem;
    mnGeraEscaladeServicos: TMenuItem;
    Image1: TImage;
    mnLstSupervisor: TMenuItem;
    mnLstGrupoDeServicos: TMenuItem;
    mnLstDefeitos: TMenuItem;
    mnLstServicos: TMenuItem;
    mnLstPlanoDeRevisao: TMenuItem;
    mnLstTipodeOperacaodeServicos: TMenuItem;
    mnLstKmRevisaoGrpPlan: TMenuItem;
    mnLstAssociaKmRevisaoAServicos: TMenuItem;
    mnLstAssociaServicosAMateriais: TMenuItem;
    Setor1: TMenuItem;
    FunoFixa1: TMenuItem;
    Relatrios1: TMenuItem;
    ServiosExecutados1: TMenuItem;
    RetrabalhodoCarro1: TMenuItem;
    AssociaPlanoaPlano1: TMenuItem;
    AtualizaoInicialReviso1: TMenuItem;
    RetrabalhodaOficina1: TMenuItem;
    ModeObra1: TMenuItem;
    mnEstatisticaServicos: TMenuItem;
    ResumodeOrdensdeServios1: TMenuItem;
    HistricodeVeculos1: TMenuItem;
    HistricosdeServiosExecutados1: TMenuItem;
    ResumodeServios1: TMenuItem;
    DurabilidadedePeas1: TMenuItem;
    Folha1: TMenuItem;
    CadastrodeFuncSimplificados1: TMenuItem;
    SolicitaoExecuo1: TMenuItem;
    ServiosporFuncionrios1: TMenuItem;
    Parametros1: TMenuItem;
    Frota1: TMenuItem;
    CadastrodeVeculos1: TMenuItem;
    N2: TMenuItem;
    EmiteRelatriodeOSCorr: TMenuItem;
    ImprimeSolicitaodeOSPrev: TMenuItem;
    mnServExec_Progr: TMenuItem;
    OsemAberto1: TMenuItem;
    Image2: TImage;
    mnKmAtualDosServicos: TMenuItem;
    N4: TMenuItem;
    ReservadeOS1: TMenuItem;
    OrigemdeOS1: TMenuItem;
    CustosGerais1: TMenuItem;
    GrficoGrupodeServio1: TMenuItem;
    ImprimeSolicitaoOSPreventiva2: TMenuItem;
    ListagemGenerica1: TMenuItem;
    Construtor1: TMenuItem;
    Imprimir1: TMenuItem;
    ControledeRevisaoporKm1: TMenuItem;
    ImprimeSolicitaodeOSCorreMod2: TMenuItem;
    ImpSolicOSCorrMod3: TMenuItem;
    ServiosAplicados1: TMenuItem;
    TrocaSenhadoUsurio1: TMenuItem;
    OsdoDia1: TMenuItem;
    ImprimeCdigodeBarrasdaOS1: TMenuItem;
    Consulta1: TMenuItem;
    Planosporveculo1: TMenuItem;
    EscalapordiasMdiadekm1: TMenuItem;
    Usurios1: TMenuItem;
    N5: TMenuItem;
    EscalaManual: TMenuItem;
    ImprimeOSCorretiva1: TMenuItem;
    ImprimeOSPreventiva1: TMenuItem;
    Modelo11: TMenuItem;
    Modelo21: TMenuItem;
    ImprimeFechOS1: TMenuItem;
    ServiosPendentes1: TMenuItem;
    Relatriodedefeitos1: TMenuItem;
    Manuteno1: TMenuItem;
    MnAlteraodeos: TMenuItem;
    OSModelo31: TMenuItem;
    ServiosdeTerceiros1: TMenuItem;
    PreodeMateriaisparaVenda1: TMenuItem;
    PlanodePagamento1: TMenuItem;
    N6: TMenuItem;
    AberturaFechamentodeOS1: TMenuItem;
    ImpressodeNotaFiscal1: TMenuItem;
    Oramentos1: TMenuItem;
    Cadastros2: TMenuItem;
    OrdemdeServioTerceiros1: TMenuItem;
    VendadeMateriais1: TMenuItem;
    ImpressodaOS1: TMenuItem;
    ImpressodeNotaFiscaldeVenda1: TMenuItem;
    VendadeMateriais2: TMenuItem;
    VendadeServios1: TMenuItem;
    AberturaFechamentodaVenda1: TMenuItem;
    ImpressodeNotaFiscaldeVenda2: TMenuItem;
    ImpressodoStatusdaOS1: TMenuItem;
    N7: TMenuItem;
    CancelaNotaFiscal1: TMenuItem;
    OSModelo51: TMenuItem;
    Controlegercustmanut1: TMenuItem;
    Modelo1231: TMenuItem;
    Modelo41: TMenuItem;
    TelaGerencial1: TMenuItem;
    RelatriodeOramentos1: TMenuItem;
    IntegraNF_CRCCTBESF: TMenuItem;
    Condio1: TMenuItem;
    Funcao1: TMenuItem;
    Sindicatos1: TMenuItem;
    rea1: TMenuItem;
    Departamento1: TMenuItem;
    Seo1: TMenuItem;
    RegioGeogrfica1: TMenuItem;
    Banco1: TMenuItem;
    Bancos1: TMenuItem;
    Agncias1: TMenuItem;
    Contabilidade1: TMenuItem;
    Tiposdedocumentos1: TMenuItem;
    ndices1: TMenuItem;
    Trfego1: TMenuItem;
    Linha3: TMenuItem;
    Estoque1: TMenuItem;
    porNotafiscal1: TMenuItem;
    Histricosdemovimento1: TMenuItem;
    cdMarca: TMenuItem;
    cdUnidadeDeMedida: TMenuItem;
    Contasareceber1: TMenuItem;
    Clientes1: TMenuItem;
    Tiposdereceitas1: TMenuItem;
    Contaspagar1: TMenuItem;
    CadastroDeFornecedores: TMenuItem;
    TiposdeDocumento1: TMenuItem;
    Escrituraofiscal1: TMenuItem;
    Classificaesfiscais1: TMenuItem;
    Operaesfiscais1: TMenuItem;
    Tiposdedespesa1: TMenuItem;
    Tiposdereceita1: TMenuItem;
    Local1: TMenuItem;
    DVS1: TMenuItem;
    Tipodebem1: TMenuItem;
    Abastecimento1: TMenuItem;
    Tipodeleo1: TMenuItem;
    Adiantamento1: TMenuItem;
    CadastrodeMensagensGerais1: TMenuItem;
    RelatoriosExternos: TMenuItem;
    AnaliseDeLog: TMenuItem;
    Valoresdamodeobra1: TMenuItem;
    MotivoDeslig1: TMenuItem;
    CadastroQuitao1: TMenuItem;
    N8: TMenuItem;
    Globusreport1: TMenuItem;
    procedure SaidaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BarraDeEstatusDblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure AjudaSobreSistemaClick(Sender: TObject);
    procedure UF1Click(Sender: TObject);
    procedure AtivaACalculadora(var Msg : TMsg; var handled : Boolean);
    procedure FormCreate(Sender: TObject);
    procedure PlanodeReviso1Click(Sender: TObject);
    procedure GrupodeReviso1Click(Sender: TObject);
    procedure GrupodeServio1Click(Sender: TObject);
    procedure Defeitos1Click(Sender: TObject);
    procedure Servios1Click(Sender: TObject);
    procedure KmReviso1Click(Sender: TObject);
    procedure Superviso1Click(Sender: TObject);
    procedure lstGrupoDeRevisaoClick(Sender: TObject);
    procedure mnTipoOperacaoServicosClick(Sender: TObject);
    procedure mnAssociaKmDeRevisaoAServicosClick(Sender: TObject);
    procedure mnAssociaServicosAMateriaisClick(Sender: TObject);
    procedure mnAberturaDeOSCorretivaClick(Sender: TObject);
    procedure mnAberturaDeOSPreventivaClick(Sender: TObject);
    procedure mnFechamentoDeOSClick(Sender: TObject);
    procedure mnLstGrupoDeServicosClick(Sender: TObject);
    procedure mnLstDefeitosClick(Sender: TObject);
    procedure mnLstServicosClick(Sender: TObject);
    procedure mnLstPlanoDeRevisaoClick(Sender: TObject);
    procedure mnLstTipodeOperacaodeServicosClick(Sender: TObject);
    procedure mnLstKmRevisaoGrpPlanClick(Sender: TObject);
    procedure mnLstAssociaKmRevisaoAServicosClick(Sender: TObject);
    procedure mnLstAssociaServicosAMateriaisClick(Sender: TObject);
    procedure mnLstSupervisorClick(Sender: TObject);
    procedure Setor1Click(Sender: TObject);
    procedure FunoFixa1Click(Sender: TObject);
    procedure ServiosExecutados1Click(Sender: TObject);
    procedure RetrabalhodoCarro1Click(Sender: TObject);
    procedure AssociaPlanoaPlano1Click(Sender: TObject);
    procedure AtualizaoInicialReviso1Click(Sender: TObject);
    procedure RetrabalhodaOficina1Click(Sender: TObject);
    procedure ModeObra1Click(Sender: TObject);
    procedure mnEstatisticaServicosClick(Sender: TObject);
    procedure ResumodeOrdensdeServios1Click(Sender: TObject);
    procedure HistricodeVeculos1Click(Sender: TObject);
    procedure HistricosdeServiosExecutados1Click(Sender: TObject);
    procedure ResumodeServios1Click(Sender: TObject);
    procedure DurabilidadedePeas1Click(Sender: TObject);
    procedure CadastrodeFuncSimplificados1Click(Sender: TObject);
    procedure SolicitaoExecuo1Click(Sender: TObject);
    procedure ServiosporFuncionrios1Click(Sender: TObject);
    procedure CadastrodeVeculos1Click(Sender: TObject);
    procedure EmiteRelatriodeOSCorrClick(Sender: TObject);
    procedure ImprimeSolicitaodeOSPrevClick(Sender: TObject);
    procedure mnServExec_ProgrClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OsemAberto1Click(Sender: TObject);
    procedure AjudaDoModuloClick(Sender: TObject);
    procedure mnKmAtualDosServicosClick(Sender: TObject);
    procedure ReservadeOS1Click(Sender: TObject);
    procedure mnGeraEscaladeServicosClick(Sender: TObject);
    procedure OrigemdeOS1Click(Sender: TObject);
    procedure CustosGerais1Click(Sender: TObject);
    procedure GrficoGrupodeServio1Click(Sender: TObject);
    procedure ImprimeSolicitaoOSPreventiva2Click(Sender: TObject);
    procedure Construtor1Click(Sender: TObject);
    procedure Imprimir1Click(Sender: TObject);
    procedure ImprimeSolicitaodeOSCorreMod2Click(Sender: TObject);
    procedure ImpSolicOSCorrMod3Click(Sender: TObject);
    procedure cascataClick(Sender: TObject);
    Procedure HabilitaMenusPorCliente;
    procedure ServiosAplicados1Click(Sender: TObject);
    procedure TrocaSenhadoUsurio1Click(Sender: TObject);
    procedure OsdoDia1Click(Sender: TObject);
    procedure ImprimeCdigodeBarrasdaOS1Click(Sender: TObject);
    procedure Planosporveculo1Click(Sender: TObject);
    procedure EscalapordiasMdiadekm1Click(Sender: TObject);
    procedure Usurios1Click(Sender: TObject);
    procedure EscalaManualClick(Sender: TObject);
    procedure Modelo11Click(Sender: TObject);
    procedure Modelo21Click(Sender: TObject);
    procedure ImprimeFechOS1Click(Sender: TObject);
    procedure OSModelo41Click(Sender: TObject);
    procedure ServiosPendentes1Click(Sender: TObject);
    procedure Relatriodedefeitos1Click(Sender: TObject);
    procedure Movimentos1Click(Sender: TObject);
    procedure Manuteno1Click(Sender: TObject);
    procedure MnAlteraodeosClick(Sender: TObject);
    procedure OSModelo31Click(Sender: TObject);
    procedure PreodeMateriaisparaVenda1Click(Sender: TObject);
    procedure PlanodePagamento1Click(Sender: TObject);
    procedure AberturaFechamentodeOS1Click(Sender: TObject);
    procedure ImpressodeNotaFiscal1Click(Sender: TObject);
    procedure Oramentos1Click(Sender: TObject);
    procedure ImpressodaOS1Click(Sender: TObject);
    procedure VendadeMateriais2Click(Sender: TObject);
    procedure ImpressodeNotaFiscaldeVenda1Click(Sender: TObject);
    procedure AberturaFechamentodaVenda1Click(Sender: TObject);
    procedure ImpressodeNotaFiscaldeVenda2Click(Sender: TObject);
    procedure ImpressodoStatusdaOS1Click(Sender: TObject);
    procedure CancelaNotaFiscal1Click(Sender: TObject);
    procedure OSModelo51Click(Sender: TObject);
    procedure Controlegercustmanut1Click(Sender: TObject);
//    procedure Telagerencial1Click(Sender: TObject);
    procedure Modelo1231Click(Sender: TObject);
    procedure Modelo41Click(Sender: TObject);
    procedure TelaGerencial1Click(Sender: TObject);
    procedure RelatriodeOramentos1Click(Sender: TObject);
    procedure IntegraNF_CRCCTBESFClick(Sender: TObject);
    procedure Condio1Click(Sender: TObject);
    procedure Funcao1Click(Sender: TObject);
    procedure Sindicatos1Click(Sender: TObject);
    procedure rea1Click(Sender: TObject);
    procedure Departamento1Click(Sender: TObject);
    procedure Seo1Click(Sender: TObject);
    procedure RegioGeogrfica1Click(Sender: TObject);
    procedure Bancos1Click(Sender: TObject);
    procedure Agncias1Click(Sender: TObject);
    procedure Tiposdedocumentos1Click(Sender: TObject);
    procedure ndices1Click(Sender: TObject);
    procedure Linha3Click(Sender: TObject);
    procedure Histricosdemovimento1Click(Sender: TObject);
    procedure cdMarcaClick(Sender: TObject);
    procedure cdUnidadeDeMedidaClick(Sender: TObject);
    procedure cdMaterialClick(Sender: TObject);
    procedure porNotafiscal1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Tiposdereceitas1Click(Sender: TObject);
    procedure CadastroDeFornecedoresClick(Sender: TObject);
    procedure TiposdeDocumento1Click(Sender: TObject);
    procedure Tiposdedespesa1Click(Sender: TObject);
    procedure Classificaesfiscais1Click(Sender: TObject);
    procedure Operaesfiscais1Click(Sender: TObject);
    procedure Tiposdereceita1Click(Sender: TObject);
    procedure Local1Click(Sender: TObject);
    procedure Tipodebem1Click(Sender: TObject);
    procedure Tipodeleo1Click(Sender: TObject);
    procedure Adiantamento1Click(Sender: TObject);
    procedure CadastrodeMensagensGerais1Click(Sender: TObject);
    procedure RelatoriosExternosClick(Sender: TObject);
    procedure AnaliseDeLogClick(Sender: TObject);
    procedure Valoresdamodeobra1Click(Sender: TObject);
    procedure MotivoDeslig1Click(Sender: TObject);
    procedure CadastroQuitao1Click(Sender: TObject);
    procedure Globusreport1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    {$INCLUDE \Globus\Sistemas\MenuPrincipalVariaveisComuns.txt}
    VdataFechamento      : TdateTime;
    // Verificar se há necessidade - Silvio - DVS
    vDataItParcela       : TStringList;
    vStgCalcProporcional : TStringGrid;
    HaParcelas           : Boolean;
    Rx_Parcelas          : TRxMemoryData;
  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;
//  VcontaForm             : Integer;

implementation

uses
                           dmControle,                   BGM_Tela,
  BGM_Dados,                       SobreOSistema,
  MANCadastroGrupoDeRevisao,       BGMCadastroDeUF,              ManAssociaServicosAMateriais,
  MANCadastroPlanoDeRevisao,       MANCadastroDefeitos,          ManCadTipoOperacaoServicos,
  MANCadastroGrupoDeServico,       MANCadastroDeServico,         ManAssociaKmRevAServicos ,
  MANCadastroKmRevisao,            MANCadastroSupervisao,        Man_LstComuns,
  MAN_LstComunsAssocia,            MAN_LstSupervisor,            ManAberturaDeOSCorretiva,
  flp_CadastroSetor,               ManAberturaDeOSPreventiva,    BGMCadastroDeFuncaoFixa,
  MAN_FechamentoDeOS,              MAN_EscalaDeServicos,         MANAssociaPlanoaPlano,
  MAN_CadastroRevisao,             MAN_RelRetrabalhoCarro ,      MAN_RelRetrabalhoOficina,
  MAN_RelMaoObra,                  MAN_RelEstatisticaServExec,   MAN_RelResumoOS,
  MAN_RelHistoricoVeiculos,        MAN_RelDurabilidadePecas,     MAN_RelHistoricoServicos,
  MAN_RelResumoServicos,           MAN_RelSolicitExec,           Flp_CadastroFuncionariosSimplificado,
  MAN_RelServFuncionario,          MAN_CadParametro,             FRTCadastroVeiculo,
  MAN_RelRelacaoFrota,             MAN_RelOsCorretiva,           MAN_RelOsPreventiva,
  MAN_RelServicosExecProgramado,   MAN_RelMANOsEmAberto,         CTRAjudaDoModulo,
  Man_RelKmAtualDeServico,         MAN_ReservaOS,                MAN_CadOrigemOS,
  MAN_RelCustoGeral,               MAN_RelGruposdeServico,       MAN_OrdemServPreventivoLondrina,
  MAN_ListagemGenerica2,           MAN_RelControleRevKM,         MAN_RelOsCorretivaMod2,
  Man_RelOsCorretivaMod3,          MAN_RelServicoAplic,          MAN_RelOsCorretivakwk,
  CTRTrocaSenhaDeUsuario,          MAN_RelServExecutados,        TelaInicializacao,
  MAN_RelOSCorretivaDia,           MAN_ImprimeCodigoBarras,      MAN_ConsultaPlano,
  MAN_RelEscalaMediaKm,            MAN_ImpressaoNFVendaServ,     MANCadastroDeUsuarios,
  MANEscalaManual,                 MAN_RelResumoServicos2,       MAN_RelOsCorretivaFech,
  Man_RelOsCorretivaMod4,          MAN_RelServicoPendente,       MAN_RelDefeitosRepetidos,
  MANRelOsPreventivaMod3,          MAN_ImpressaoNFServicos,      MAN_AberturaFechamentoOSTerceiro,
  MAN_PlanoPagamentoOS,            MAN_PrecoMaterialVenda,       MANCadastroDeOrcamentos,
  MAN_RelOsTerceiros,              MAN_VendaMateriaisTerceiro,   MAN_ImpressaoNFVendaMat,
  MAN_VendaServicosTerceiros,      MAN_RelStatusOS,              MAN_CancelaNotaFiscalTerc,
  MANRelCustosGerais,              MAN_RelOsCorretivaMod5,       MAN_RelControleGeralCustos,
  Man_TelaGerencial,               MAN_RelControleRevKMMod4,     MAN_RelOrcamento,
  MAN_IntegraNotaSaida,            CTBCdPlanoContas,             CTBCadastroCentrosdeCustos,
  utLinha,                         Flp_CadastroFuncao,           Flp_CadastroCondicao,
  Flp_CadastroSindicados2,         Flp_CadastroArea,             dmFolha,
  Flp_CadastroDepto,               Flp_CadastroSecao,            Flp_CadastroRegiaoGeografica,
  dmFolha2,                        BCOCadastroDeBancos,          BCOCadastroDeAgencias,
  dmContasPagar,                   DmFiscal,                     EstCdUnidadeMedida,
  ESTCdMarcaMaterial,              ESTHistoricoMovto,            ESTCdMaterial,
  CRCCadastroDeClientes,           CRCCadastroTipodeReceita,     DVS_TipoBem,
  CPGCadastroTipodeDocto,          CPGCadastroDeFornecedores,    CPGTipoDeDespesa,
  ESFClassificacaoFiscal,          ESFOperacaoFiscal,            CTBCadastrodeContas,
  BgmCadastroDeLocais,             AbaCadastroDeTipoOleo,        Flp_CadastroMensagem,
  Flp_CadastroMensagem2,           CPGRelatoriosExternos,        CTR_LstLog,
  MAN_CadastroValorMObra,          Flp_cadastroQuitacao,         Flp_CadastroMotivoDesligamento;

{$R *.DFM}
{$R Upgrades.Res} // Arquivo que contém os arquivos upgrade.txt e upgrade2.txt
{$R News.Res} // Arquivo que contém o texto das novidades

procedure TfrmMenuPrincipal.FormCreate(Sender: TObject);
begin
  {$Include \Globus\Sistemas\MenuPrincipalFormCreate.txt}
  vNumeroIP                      := LocalIP;
  vContaForm                     := 0;
end;

procedure TfrmMenuPrincipal.FormShow(Sender: TObject);
Var
  I : Integer;
begin
  {$Include \Globus\Sistemas\MenuPrincipalFormShow.txt}
  vPathRels := vDirRptMan;
end;

procedure TfrmMenuPrincipal.BarraDeEstatusDblClick(Sender: TObject);
begin
  ContSenhaBgm.Visible := True;
end;

procedure TfrmMenuPrincipal.SaidaClick(Sender: TObject);
begin
  {Fecha o Formulário}
  Close;
end;

procedure TfrmMenuPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := (Not FazPerguntaAoSair) Or MsgConfirmaFechamentoDoSistema;
end;

procedure TfrmMenuPrincipal.AjudaSobreSistemaClick(Sender: TObject);
begin
  With TAboutBox.Create(Application) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmMenuPrincipal.UF1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TBGMFrm_CadastroUF.Create(Application) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.AtivaACalculadora(var Msg : TMsg; var handled : Boolean);
begin
  {$Include \globus\sistemas\MenuPrincipalAtivaCalculadora.txt}
end;

procedure TfrmMenuPrincipal.PlanodeReviso1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANfrm_CadastroPlanoDeRevisao.Create(Application) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.GrupodeReviso1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANfrm_CadastroGrupoDeRevisao.Create(Application) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.GrupodeServio1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANfrm_CadastroGrupoDeServico.Create(Application) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.Defeitos1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANfrm_CadastroDefeitos.Create(Application) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.Servios1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANfrm_CadastroDeServicos.Create(application) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.KmReviso1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANfrm_CadastroKmRevisao.Create(application) do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.Superviso1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANfrm_CadastroSupervisao.Create(Application) do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.mnTipoOperacaoServicosClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMan_CadOperacaoDeServicos.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.mnAssociaKmDeRevisaoAServicosClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmManAssociaKmDeRevisaoAServicos.Create(Self) Do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnAssociaServicosAMateriaisClick( Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMANAssociaServAMateriais.Create(Self) Do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnAberturaDeOSCorretivaClick(Sender: TObject);
begin
  If vQuemAbreCorretiva <> 'T' Then vQuemAbreCorretiva := 'M';
  If vContaForm > 5 Then
  begin
    MensagemDlg('Quantidade de formulários de O.S. corretiva em abertos foi excedida.' ,mtInformacao,mbOK);
    Abort;
  end
  Else
  begin
    If vQuemAbreCorretiva = 'M' Then
    begin
      vItemDeMenuChamador := TComponent(Sender).Name;
      With TfrmMANAberturaDeOSCorretiva.Create(Self) Do
      begin
        vNomeRelatorio := 'LstManSolicServicoCorrKWK';
        vOperacao      := 'I';
        FormStyle      := FsStayOnTop;
        Show;
      end;
    end
    Else
    begin
      vItemDeMenuChamador := TComponent(Sender).Name;
      With TfrmMANAberturaDeOSCorretiva.Create(Self) Do
      begin
        vNomeRelatorio := 'LstManSolicServicoCorrKWK';
        vOperacao      := 'I';
        FormStyle      := FsNormal;
        ShowModal;
      end;
    end;
  end;
  vItemDeMenuChamador := '';
end;

procedure TfrmMenuPrincipal.mnAberturaDeOSPreventivaClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmManAbeturaOSPreventiva.Create(Self) Do
    begin
      try
        vNomeRelatorio := 'LstSolicServicoPrev';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnFechamentoDeOSClick(Sender: TObject);
begin
  { Tela de Fechamento de OS Nova }
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmMAN_FechamentoDeOS.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

{ Faz chamada das listagens }

procedure TfrmMenuPrincipal.lstGrupoDeRevisaoClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_LstComuns.Create(Self) Do
    begin
      HelpContext    := 21044;
      Caption        := 'Listagem de grupos de revisão';
      vNomeRelatorio := 'LstCadGrpRevisao';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnLstGrupoDeServicosClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_LstComuns.Create(Self) Do
    begin
      HelpContext    := 21042;
      Caption        := 'Listagem de grupos de serviços';
      vNomeRelatorio := 'LstCadGrpServico';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnLstDefeitosClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_LstComuns.Create(Self) Do
    begin
      HelpContext    := 21043;
      Caption        := 'Listagem de defeitos';
      vNomeRelatorio := 'LstCadDefeitos';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnLstServicosClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_LstComuns.Create(Self) Do
    begin
      HelpContext    := 21047;
      Caption        := 'Listagem de serviços';
      vNomeRelatorio := 'LstCadServico';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnLstPlanoDeRevisaoClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_LstComuns.Create(Self) Do
    begin
      HelpContext    := 21045;
      Caption        := 'Listagem de planos de revisão';
      vNomeRelatorio := 'LstPlanRevisao';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnLstTipodeOperacaodeServicosClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_LstComuns.Create(Self) Do
    begin
      HelpContext    := 21048;
      Caption        := 'Listagem de tipos de operação de serviços';
      vNomeRelatorio := 'LstCadTipOpeServico';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnLstKmRevisaoGrpPlanClick(Sender: TObject);
begin
  {Formulário 2}
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_LstComunsAssocia.Create(Self) Do
    begin
      HelpContext    := 21046;
      Caption        := 'Listagem de kms de revisão (grupo ao plano)';
      vNomeRelatorio := 'LstAssGrpPlanRev';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnLstAssociaKmRevisaoAServicosClick(Sender: TObject);
begin
  {Formulário 2}
   vItemDeMenuChamador := TComponent(Sender).Name;
   With TfrmMAN_LstComunsAssocia.Create(Self) Do
     begin
       HelpContext    := 21049;
       Caption        := 'MAN - Listagem de associação de Km de revisão aos serviços';
       vNomeRelatorio := 'LstAssKmRevServico';
       try
         ShowModal;
       finally
         Free;
         vItemDeMenuChamador := '';
       end;
     end;
end;

procedure TfrmMenuPrincipal.mnLstAssociaServicosAMateriaisClick(Sender: TObject);
begin
  {Formulário 2}
   vItemDeMenuChamador := TComponent(Sender).Name;
   With TfrmMAN_LstComunsAssocia.Create(Self) Do
     begin
       HelpContext    := 21050;
       Caption        := 'Listagem de associação de serviços aos materiais';
       vNomeRelatorio := 'LstAssServMaterial';
       try
         ShowModal;
       finally
         Free;
         vItemDeMenuChamador := '';
       end;
     end;
end;

procedure TfrmMenuPrincipal.mnLstSupervisorClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_LstSupervisor.Create(Self) Do
    begin
      HelpContext    := 21041;
      Caption        := 'Listagem de supervisor';
      vNomeRelatorio := 'LstSupervisor';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.Setor1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCadastroSetor.Create(Self) Do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.FunoFixa1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with Tfrm_FuncionarioFixo.Create(Self) do
    begin
      try
        HelpContext := 21016;
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.ServiosExecutados1Click(Sender: TObject);
begin
  { ok }
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmMan_RelServExecutados.Create(Self) Do
    Begin
      Try
        ShowModal;
      Finally
        Free;
        vItemDeMenuChamador := '';
      End;
    End;
end;

procedure TfrmMenuPrincipal.RetrabalhodoCarro1Click(Sender: TObject);
begin
  { ok }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TFrmMAN_RelRetrabalhoCarro.Create(Self) do
    begin
      try
        vNomeRElatorio := 'LstRetrabalhoVeiculo';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.AssociaPlanoaPlano1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TFrm_ManAssociaPlanoaPlano.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.AtualizaoInicialReviso1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANFrm_AtualizacaoInicialRevisao.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.RetrabalhodaOficina1Click(Sender: TObject);
begin
  { OK }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANFrm_RelRetrabalhoOficina.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstRetrabalhoOficina';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.ModeObra1Click(Sender: TObject);
begin
  { OK }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANFrm_RelMaoObra.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstMaoObra_ComResumo';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnEstatisticaServicosClick(
  Sender: TObject);
begin
  { OK }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANFrm_RelEstatisticaServExec.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstEstatisticaServicos';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.ResumodeOrdensdeServios1Click(Sender: TObject);
begin
  { OK }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANFrm_RelResumoOS.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstResumoOS';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.HistricodeVeculos1Click(Sender: TObject);
begin
  { OK }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANFrm_RelHistoricoVeiculos.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstHistoricoVeiculo';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.HistricosdeServiosExecutados1Click(
  Sender: TObject);
begin
  { OK }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANFrm_RelHistoricoServicos.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.ResumodeServios1Click(Sender: TObject);
begin
  { OK }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANFrm_RelResumoServicos.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstResumoServicos';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.DurabilidadedePeas1Click(Sender: TObject);
begin
  { ok }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANFrm_RelDurabilidadePecas.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstDurabilidadePecas';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.CadastrodeFuncSimplificados1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TFrm_CadastroFuncionariosSimplificado.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.SolicitaoExecuo1Click(Sender: TObject);
begin
  { OK }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANfrm_RelSolicitExec.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstSolicitExec';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.ServiosporFuncionrios1Click(Sender: TObject);
begin
  { OK }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TMANfrm_RelServFuncionario.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstServicosFuncionarios';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.CadastrodeVeculos1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmCadastroVeiculo.Create(Application) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.EmiteRelatriodeOSCorrClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANFrm_RelOsCorretiva.Create(Self) Do
    begin
      Try
        ShowModal;
      Finally
        Free;
        vItemDeMenuChamador := '';
      End;
    end;
end;

procedure TfrmMenuPrincipal.ImprimeSolicitaodeOSPrevClick(
  Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANFrm_RelOsPreventiva.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstSolicServicoPrev';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnServExec_ProgrClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmMAN_RelServicosExecProgramado.Create(Self) do
    begin
      try
        vNomeRelatorio := 'LstServicosExecProgramado';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$Include \Globus\Sistemas\MenuPrincipalFormClose.txt}
end;

procedure TfrmMenuPrincipal.OsemAberto1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANfrm_OsEmAberto.Create(Self) Do
    begin
      vNomeRelatorio := 'LstMANOsEmAberto';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.mnKmAtualDosServicosClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_RelKmAtualDeServico.Create(Self) Do
  begin
    vNomeRelatorio := 'LstMAN_RelKmAtualDeServico';
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.ReservadeOS1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmMAN_ReservaOS.Create(Self) do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.mnGeraEscaladeServicosClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmMAN_EscalaDeServicos.Create(Self) do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.OrigemdeOS1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrt_CadOrigemOS.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.CustosGerais1Click(Sender: TObject);
begin
  {
  With TFrmMAN_RelCustoGeral.Create(Self) do
    begin
        vNomeRelatorio := 'LstCustoGeral';
      try
        ShowModal;
      finally
        Free;
      end;
    end;
  }
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMANRelCustosGerais.Create(Nil) do
  Try
    ShowModal;
  finally
    Free;
    vItemDeMenuChamador := '';
  end;
end;

procedure TfrmMenuPrincipal.GrficoGrupodeServio1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmMAN_RelGruposdeServico.Create(Self) do
    begin
        vNomeRelatorio := 'LstGrupos';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.ImprimeSolicitaoOSPreventiva2Click(
  Sender: TObject);
begin
   vItemDeMenuChamador := TComponent(Sender).Name;
   With TFrmOSPrevLondrina.Create(Self) do
    begin
        vNomeRelatorio := 'LstSolicServicoPrevMod2';
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.AjudaDoModuloClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmAjudaDoModulo.Create(Self) Do
  begin
    Caption    := 'MAN - Manutenção';
    {$Include \Globus\Sistemas\DataHora.txt}
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.Construtor1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With Tfrm_ListagemGenerica2.Create(Self) Do
  begin
    try
      Execute('N');
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.Imprimir1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With Tfrm_ListagemGenerica2.Create(Self) Do
   begin
    try
      HelpContext := 21052;
      Execute('I');
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

//procedure TfrmMenuPrincipal.Timer1Timer(Sender: TObject);
{$Include \Globus\Sistemas\MenuPrincipalStatusBar.txt}

procedure TfrmMenuPrincipal.ImprimeSolicitaodeOSCorreMod2Click(
  Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANFrm_RelOsCorretivaMod2.Create(Self) do
  begin
    vNomeRelatorio := 'LstSolicServicoCorrMod2';
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.ImpSolicOSCorrMod3Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With Tfrm_ManRelSolicCorrMod3.Create(Self) do
  begin
    vNomeRelatorio := 'LstManSolicServicoCorrKWK';
    Try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.cascataClick(Sender: TObject);
begin
  cascade;
end;

Procedure TfrmMenuPrincipal.HabilitaMenusPorCliente;
Begin
  //
End;

procedure TfrmMenuPrincipal.ServiosAplicados1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_RelServicoAplic.Create(Self) do
  Begin
    Try
      ShowModal;
    Finally
      Free;
      vItemDeMenuChamador := '';
    End;
  End;
end;

procedure TfrmMenuPrincipal.TrocaSenhadoUsurio1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCTRTrocaSenhaDeUsuario.Create( Application ) do
  Begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.OsdoDia1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_RelOsCorretivaDia.Create( Application ) do
  Begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.ImprimeCdigodeBarrasdaOS1Click(
  Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_codigobarra.Create( Application ) do
  Begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.Planosporveculo1Click(Sender: TObject);
begin
  { Consulta planos por veiculos }
  vItemDeMenuChamador := TComponent(Sender).Name;
  Try
    With TFrmMAN_ConsultaPlano.Create(Self) do
      Begin
        ShowModal;
        Free;
      end;
  Except
    FrmMAN_ConsultaPlano.Free;
  End;
  vItemDeMenuChamador := '';
end;

procedure TfrmMenuPrincipal.EscalapordiasMdiadekm1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_RelEscalaMediaKm.Create( Application ) do
  Begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.Usurios1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmMANCadastroDeUsuarios.Create( Application ) do
  Begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.EscalaManualClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmMANEscalaManual.Create( Application ) do
  Begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.Modelo11Click(Sender: TObject);
begin
   vItemDeMenuChamador := TComponent(Sender).Name;
   with TMANFrm_RelResumoServicos.Create(Self) do
   begin
      try
        vNomeRelatorio := 'LstResumoServicos';
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
   end;
end;

procedure TfrmMenuPrincipal.Modelo21Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANFrm_RelResumoServicos2.Create( Application ) do
  Begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.ImprimeFechOS1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_RelOsCorretivaFech.Create ( Nil ) do
    Try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    End;
end;

procedure TfrmMenuPrincipal.OSModelo41Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMan_RelOsCorretivaMod4.Create ( Nil ) do
    Try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
end;

procedure TfrmMenuPrincipal.ServiosPendentes1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_RelServicoPendente.Create ( Nil ) do
    Try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    End;
end;

procedure TfrmMenuPrincipal.Relatriodedefeitos1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TMANFrm_RelDefRepetidos.Create ( Nil ) do
    Try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    End;
end;

procedure TfrmMenuPrincipal.Movimentos1Click(Sender: TObject);
begin
  // N2.Visible           := vCodigoCliente = 85 ; // AUTO VIACAO URUBUPUNGA
  // EscalaManual.Visible := vCodigoCliente = 85 ;
end;

procedure TfrmMenuPrincipal.Manuteno1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TFrmMan_CadParametro.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
        vItemDeMenuChamador := '';
      end;
    end;
end;

procedure TfrmMenuPrincipal.MnAlteraodeosClick(Sender: TObject);
begin
  If vQuemAbreCorretiva <> 'T' Then vQuemAbreCorretiva := 'M';
  If vContaForm > 5 Then
  begin
    MensagemDlg('Quantidade de formulários de O.S. corretiva em abertos foi excedida.' ,mtInformacao,mbOK);
    Abort;
  end
  Else
  begin
    If vQuemAbreCorretiva = 'M' Then
    begin
      vItemDeMenuChamador := TComponent(Sender).Name;
      With TfrmMANAberturaDeOSCorretiva.Create(Self) Do
      begin
        vNomeRelatorio := 'LstManSolicServicoCorrKWK';
        vOperacao      := 'A';
        FormStyle      := FsStayOnTop;
        Show;
      end;
    end
    Else
    begin
      vItemDeMenuChamador := TComponent(Sender).Name;
      With TfrmMANAberturaDeOSCorretiva.Create(Self) Do
      begin
        vNomeRelatorio := 'LstManSolicServicoCorrKWK';
        vOperacao      := 'A';
        FormStyle      := FsNormal;
        ShowModal;
      end;
    end;
    vItemDeMenuChamador := '';
  end;
end;

procedure TfrmMenuPrincipal.OSModelo31Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMANRelOsPreventivaMod3.Create(Self) Do
  begin
    Try
      ShowModal;
    Finally
      Release;
      vItemDeMenuChamador := '';
    End;
  end;
end;

procedure TfrmMenuPrincipal.PreodeMateriaisparaVenda1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMAN_PrecoMaterialVenda.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.PlanodePagamento1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMAN_PlanoPagamentoOS.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.AberturaFechamentodeOS1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMAN_AberturaFechamentoOSTerceiro.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.ImpressodeNotaFiscal1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMAN_ImpressaoNFServicos.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.Oramentos1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TFrmMANCadastroDeOrcamentos.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Release;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.ImpressodaOS1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TFrmMAN_RelOsTerceiros.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.VendadeMateriais2Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMAN_VendaMateriaisTerceiro.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.ImpressodeNotaFiscaldeVenda1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMAN_ImpressaoNFVendaMat.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.AberturaFechamentodaVenda1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMAN_VendaServicosTerceiros.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.ImpressodeNotaFiscaldeVenda2Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMAN_ImpressaoNFVendaServ.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.ImpressodoStatusdaOS1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TFrmMAN_RelStatusOS.Create(Nil) do
  begin
    Try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.CancelaNotaFiscal1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMAN_CancelaNotaFiscalTerc.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.OSModelo51Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_RelOsCorretivaMod5.Create(Self) Do
  begin
    Try
      ShowModal;
    Finally
      Free;
      vItemDeMenuChamador := '';
    End;
  end;
end;

procedure TfrmMenuPrincipal.Controlegercustmanut1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmMan_RelControleGeralCustos.Create(Self) Do
  begin
    Try
      ShowModal;
    Finally
      Release;
      vItemDeMenuChamador := '';
    End;
  end;
end;


procedure TfrmMenuPrincipal.Modelo1231Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_RelControleRevKm.Create(Self) do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.Modelo41Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_RelControleRevKmMod4.Create(Self) do
  begin
    try
      ShowModal;
    finally
      Release;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.TelaGerencial1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TManFrm_TelaGerencial.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.RelatriodeOramentos1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_RelOrcamento.Create(Self) Do
  begin
    Try
      ShowModal;
    Finally
      Release;
      vItemDeMenuChamador := '';
    End;
  end;
end;

procedure TfrmMenuPrincipal.IntegraNF_CRCCTBESFClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmMAN_IntegraNotaSaida.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.Condio1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCadastroCondicao.Create(Self) Do
  begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Funcao1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCadastroFuncao.Create(Self) Do
  begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Sindicatos1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmCadastroSindicatos2.Create(Self) do
  begin
    showmodal;
    free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.rea1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  dmflp.qrFlp_Area.close;//O cadastro possui componentes dbs.
  With TfrmCadastroArea.Create(Self) Do
  begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Departamento1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  dmflp.qrFlp_Depto.close;//O cadastro possui componentes dbs.
  With TfrmCadastroDepto.Create(Self) Do
  begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Seo1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  dmflp.qrFlp_Secao.close;//O cadastro possui componentes dbs.
  With TfrmCadastroSecao.Create(Self) Do
  begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.RegioGeogrfica1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  DmFlp2.qrFlp_RegiaoGeografica.close;//O cadastro possui componentes dbs.
  With TfrmCadastroRegiaoGeografica.Create(Self) Do
  begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Bancos1Click(Sender: TObject);
begin
 vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmBCOCadastroDeBancos.Create (Self) Do
  Begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  End;
end;

procedure TfrmMenuPrincipal.Agncias1Click(Sender: TObject);
begin
 vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmBCOCadastroDeAgencias.Create (Self) Do
  Begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;
end;

procedure TfrmMenuPrincipal.Tiposdedocumentos1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCTBCadastroPlanoDeContas.Create(Self) Do
  begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.ndices1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCadastroCentrosdeCustos.Create(Self) Do
  begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Linha3Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  If frmLinha = Nil Then
     frmLinha:= TfrmLinha.Create(Self);
  frmLinha.showmodal;
  vItemDeMenuChamador := '';

end;

procedure TfrmMenuPrincipal.Histricosdemovimento1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with Tfrm_ESTCdHistoricoMovto.Create(Self) do
  try
    ShowModal;
  finally
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.cdMarcaClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With Tfrm_ESTCdMarcaMaterial.Create(Self) do
  try
    ShowModal;
  finally
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.cdUnidadeDeMedidaClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmEstCdUnidadeMedida.Create(Self) Do
  try
    ShowModal;
  finally
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.cdMaterialClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TFrm_ESTCdMaterial.Create(Self) do
  try
    ShowModal;
  finally
    Free;
    vItemDeMenuChamador := '';
  end; // try - finally

end;

procedure TfrmMenuPrincipal.porNotafiscal1Click(Sender: TObject);
begin
  MensagemDLG('Esta opção deverá ser chamada a partir da tela:' + Chr(13) +
              'Fechamento de O.S.',mtInformacao,mbOk);

end;

procedure TfrmMenuPrincipal.Clientes1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCRCCadastroDeClientes.Create(Self) Do
  Begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Tiposdereceitas1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCRCCadastroTipodeReceita.Create(Self) Do
  Begin
    Try
      ShowModal;
    Finally
      Free;
    End;
  vItemDeMenuChamador := '';
  End;

end;

procedure TfrmMenuPrincipal.CadastroDeFornecedoresClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCPGCadastroDeFornecedores.Create(Application) Do
  begin
    Try
      dmCPG.dtsFornecedor.DataSet.Close;
      ShowModal;
    Finally
      Free;
      vItemDeMenuChamador := '';
    End;
  End;

end;

procedure TfrmMenuPrincipal.TiposdeDocumento1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCPGCadastroTipodeDocto.Create (Self) Do
  Begin
    dmCPG.dsCPRTpDoc.DataSet.Close;
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Tiposdedespesa1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCPGTipoDeDespesa.Create(Application) Do
  begin
    dmCPG.dsCPGTpDes.DataSet.Close;
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Classificaesfiscais1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmESFClassificacaoFiscal.Create(Self) Do
  Begin
    Try
      ShowModal;
    Finally
      Free;
      vItemDeMenuChamador := '';
    End;
  End;

end;

procedure TfrmMenuPrincipal.Operaesfiscais1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmESFOperacaoFiscal.Create(Application) Do
  begin
    dmESF.dsESFOpFis.DataSet.Close;
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Tiposdereceita1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TfrmCTBCadastrodeContas.Create(Nil) do
  try
    ShowModal;
  finally
    Release;
    frmCTBCadastrodeContas := Nil;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Local1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TbgmFrmCadastroLocais.Create(Self) Do
  try
    ShowModal;
  finally
    Free;
    vItemDeMenuChamador := '';
  end;

end;

procedure TfrmMenuPrincipal.Tipodebem1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  Try
    With TFrmDVS_TipodeBem.Create(Self) Do
      Begin
        ShowModal;
        Free;
      end;
  Except
    FrmDVS_TipodeBem.Free;
  End;
  vItemDeMenuChamador := TComponent(Sender).Name;

end;

procedure TfrmMenuPrincipal.Tipodeleo1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  with TABAFrm_CadastroDeTipoOleo.Create(Self) do
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    End;

end;

procedure TfrmMenuPrincipal.Adiantamento1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmCadastroMensagens.Create(Nil) Do
  Try
    ShowModal;
  Finally
    Release;
    vItemDeMenuChamador  := '';
    FrmCadastroMensagens := Nil;
  End;
end;

procedure TfrmMenuPrincipal.CadastrodeMensagensGerais1Click(
  Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmCadastroMensagem.Create(Nil) Do
  Try
    HelpContext := 11072;
    ShowModal;
  Finally
    Release;
    vItemDeMenuChamador := '';
    FrmCadastroMensagem := Nil;
  End;
end;

Procedure TfrmMenuPrincipal.RelatoriosExternosClick(Sender: TObject);
Begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCPGRelatoriosExternos.Create(Self) Do
  Begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  End;
End;

procedure TfrmMenuPrincipal.AnaliseDeLogClick(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCtr_LstLog.Create(Self) Do
  Begin
    ShowModal;
    Free;
    vItemDeMenuChamador := '';
  End;
end;

procedure TfrmMenuPrincipal.Valoresdamodeobra1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmMAN_CadastroValorMObra.Create(Application) do
  begin
    try
      ShowModal;
    finally
      Free;
      vItemDeMenuChamador := '';
    end;
  end;
end;

procedure TfrmMenuPrincipal.MotivoDeslig1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TfrmCadastroMotivoDeslig.Create(Self) Do
  begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
  vItemDeMenuChamador := '';
end;

procedure TfrmMenuPrincipal.CadastroQuitao1Click(Sender: TObject);
begin
  vItemDeMenuChamador := TComponent(Sender).Name;
  With TFrmCadastroQuitacao.Create(Self) Do
  begin
    try
      HelpContext := 11244;
      ShowModal;
    finally
      Free;
    end;
  end;
  vItemDeMenuChamador := '';
end;

procedure TfrmMenuPrincipal.Globusreport1Click(Sender: TObject);
begin
  ChamaGlobusReport; { Está na Global }
end;

procedure TfrmMenuPrincipal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  {$INCLUDE \Globus\Sistemas\MenuPrincipalTeclas.txt}
end;

end.
