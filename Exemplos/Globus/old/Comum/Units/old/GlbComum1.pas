unit GlbComum;

// Vari�veis e constantes comuns ao pacote GLOBUS
// S� coloque fun��es que se refiram � essas vari�veis

{
Data       Programador         Descri��o
---------- ------------------- --------------------------------------------------------------
11/04/2006 Silvio              Movidas para c� as constantes com c�digos banc�rios.

03/03/2006 Ver�nica            Inclus�o das variaveis vcFilialCPG_Integracao_ESF,
                               vcFilialCPG_Integracao_CPG, vcFilialCPG_Integracao_CTB,
                               vcFilialCRC_Integracao_ESF, vcFilialCRC_Integracao_CRC,
                               vcFilialCRC_Integracao_CTB.

11/01/2005 Silvio              Inclus�o de constantes: cVersaoDoGlobus, cHomePageBgmRodotec e
                               cTabelaDeLicencas.

29/09/2004 Sila Ferrari        Cria��o da Unit.
}


interface

uses
  /// ATEN��O: N�o incluir units do GLOBUS
  SysUtils, dbtables, forms, SqlExpr, ComCtrls,ToolWin;


  var
    //// Vari�vel para armazenas Path�s do anexos de e-mail
    vcAnexosEmail : Array[1..10] Of String;

    //// Controle da navega��o
    vAbandonaExit: Boolean;
    vEsc: Boolean;
    vPassaFoco: Boolean;
    vTab: Boolean;
    //// Controle da navega��o


    ////////////////    Vari�veis do DMControle - IN�CIO  //////////////////////
    vcEncerraApl: Boolean;
    vcTemDireitoExclusao: Boolean;
    vcTemDireitoAlteracao: Boolean;
    vcTemDireitoInclusao: Boolean;
    vcBancoDeDados: String;
    vcDriveDosRelatorios : String;
    { Quando o usu�rio MANAGER tiver senha = "1", esta vari�vel ser� TRUE }
    vcUsuarioManagerComSenhaUm: Boolean;
    ////////////////    Vari�veis do DMControle - FIM    ///////////////////////

    vcMoedaSimbolo: String;
    vcMoedaNomeSingular: String;
    vcMoedaNomePlural: String;
    vcVersaoDesenvolvimento: String;

    /// ContSenha
    vcUsuario: String;
    vcSistema: String;
    vcCodigoCliente: Integer;

    vcEnviarEMailDaTela : Boolean;
    vcFazTraducaoDeInterface: Boolean;
    vcConcedente: String;

    // Conex�o do Database 
    vcServerName: String;
    vcUserName: String;
    vcUserSenha: String;

    /// Retornos das chamadas de pesquisa
    vcRetorno1: String;
    vcRetorno2: String;

    vcDatabase: TDatabase;

    // Vari�vel de controle de direitos de relat�rio da Arrecada��o
    vcItemDeMenuChamadorARR: String;
    vcArquivoRastreioSQL: String;
    vcArquivoRastreioSQLTela: String;
    ////

    // vari�veis para identificar qual a filial de integra��o/grava��o para o CPG e CRC
    vcFilialCPG_Integracao_ESF, vcFilialCPG_Integracao_CPG, vcFilialCPG_Integracao_CTB,
    vcFilialCRC_Integracao_ESF, vcFilialCRC_Integracao_CRC, vcFilialCRC_Integracao_CTB : Integer;
    //

    { Vari�veis que substituem equivalentes que pertenciam ao menu principal }
//    vcItemDeMenuChamador : String; // � preenchida no

    {Vari�veis para controlar os componentes de ultimo acesso aos menus, nos Form�s principais}
    vcTabSheetAcessoMenu1 : TTabSheet;
    vcTabSheetAcessoMenu2 : TTabSheet;
    vcPageControlAcessoMenu : TPageControl;
    vcToolButtonAcessoMenu : TToolButton;
    vcTreeViewAcessoMenu1 : TTreeView;
    vcTreeViewAcessoMenu2 : TTreeView;
        
  Const

    ////////// Clientes

    cCodCli_1001 = 81;
    cCodCli_Avoa = 176;
    cCodCli_ABCRJ = 96;
    cCodCli_Ajofer = 149;
    cCodCli_Amparo = 59;
    cCodCli_Andorinha = 30;
    cCodCli_Atlantico = 38;
    cCodCli_Aurea = 14;
    cCodCli_AutoDiesel = 92;
    cCodCli_Bangu = 101;
    cCodCli_Barcas = 95;
    cCodCli_BarraMansa = 199;
    cCodCli_BB = 24;
    cCodCli_BelTour = 163;
    cCodCli_Benfica = 232;
    cCodCli_Borelli = 29;
    cCodCli_BrasilSul = 129;
    cCodCli_Brida = 212;
    cCodCli_BTransportes = 158;
    cCodCli_Cajumar = 112;
    cCodCli_CampoBelo = 168;
    cCodCli_CampoGrande = 154;
    cCodCli_CapitalDoVale = 34;
    cCodCli_CargoSoft = 205;
    cCodCli_Catarinense = 15;
    cCodCli_Caxiense = 144;
    cCodCli_Ceam_Borgo = 106;  // 103
    cCodCli_CidadeMorena = 152;
    cCodCli_Circullare = 156;
    cCodCli_DanubioAzul = 177;
    cCodCli_DeFelippe = 200;
    cCodCli_DelRey = 43;
    cCodCli_Distribui = 119;
    cCodCli_EOG = 8;
    cCodCli_ETCD = 143;
    cCodCli_ExpressoAmericaDoSul = 16;
    cCodCli_ExpressoDoSul = 91;
    cCodCli_ExpressoLuxo = 181;
    cCodCli_Fadel = 198;
    cCodCli_Fetranspor = 88;
    cCodCli_GaloBranco = 172;
    cCodCli_GrandeLondrina = 20;
    cCodCli_GSilva = 173;
    cCodCli_Guarara = 93;
    cCodCli_Guaruja = 35;
    cCodCli_Hess = 46;
    cCodCli_Inga = 171;
    cCodCli_Ital = 98;
    cCodCli_Jaguar = 155;
    cCodCli_LogConsult = 116;
    cCodCli_Maringa = 19;
    cCodCli_Macaense = 105;
    cCodCli_ManoelRodrigues = 188;
    cCodCli_Metropolitana = 25;
    cCodCli_MirimdoSulTransp = 203;
    cCodCli_NoivaDoMar = 126;
    cCodCli_NovaCuiaba = 45;
    cCodCli_NPimenta = 86;
    cCodCli_Paranapuan = 157;
    cCodCli_Passaredo = 114;
    cCodCli_Pauliceia = 110;
    cCodCli_PlanetaTurismo = 195;
    cCodCli_Progresso = 69;
    cCodCli_RapidoDOeste = 131;
    cCodCli_Reunidas = 1;
    cCodCli_RiachoGrande  = 76;
    cCodCli_Rigras = 39;
    cCodCli_SaensPena = 60;
    cCodCli_SantaPaula = 122;
    cCodCli_SBCTrans = 71;
    cCodCli_StoIgnacio = 184;
    cCodCli_Stefani = 141;
    cCodCli_SUT = 153;
    cCodCli_SouzaAraujo = 215;
    cCodCli_Teresopolis = 61;
    cCodCli_Tex = 61;
    cCodCli_TLW = 104;
    cCodCli_Trampolim = 162;
    cCodCli_Transalvini = 99;
    cCodCli_Transfest = 159;
    cCodCli_Transfuturo = 222;
    cCodCli_Translitoral = 35;
    cCodCli_TransMagno = 216; 
    cCodCli_TransMarcos = 132;
    cCodCli_Transmimo = 118;
    cCodCli_TransPen = 185;
    cCodCli_TransRodoMac = 227;
    cCodCli_TransTestoni = 197;
    cCodCli_TransUrb = 58;
    cCodCli_TransVec = 123;
    cCodCli_Traziran = 231;
    cCodCli_Trel = 147;
    cCodCli_Tursan = 178;
    cCodCli_Uniao = 175;
    cCodCli_Univias = 181;
    cCodCli_Utinga = 186;
    cCodCli_VBTU = 68;
    cCodCli_VerdiLogistica = 228;
    cCodCli_ViacaoAbcSbc = 145;
    cCodCli_ViacaoEstrela = 133;
    cCodCli_VidaAzul = 83;
    cCodCli_VilaGalvao = 89;
    cCodCli_VIPE = 130;
    cCodCli_XVNovembro = 135;
    /////////  Clientes

    /////
    cDatabaseName = 'DbBGM';
    cDmName = 'DM';
    /////

    cVersaoDoGlobus = '4.1';
    cHomePageBgmRodotec = 'www.bgmrodotec.com.br';
    cTabelaDeLicencas = 'FINPARAN';
    cNomeSistema = 'Globus';

    //// Formul�rios
    cFormularios_EtiquetaFatura       = 1;
    cFormularios_EtiquetaFornecedores = 2;

    cFormulariosTipo_Formulario = 1;
    cFormulariosTipo_Exportacao = 2;
    cFormulariosTipo_Importacao = 3;
    //// Formul�rios

    cTempoDeConsultaParaLogar = 1/24/60/6;

   { Bancos - utilizados na cobran�a eletr�nica, pagamento eletr�nico, concilia��o e importa��o de
     dep�sitos }
    cBCO_Itau       = '341';           cBCO_Int_Itau       = 341;
    cBCO_Bradesco   = '237';           cBCO_Int_Bradesco   = 237;
    cBCO_Mercantil  = '389';           cBCO_Int_Mercantil  = 389;
    cBCO_Brasil     = '001';           cBCO_Int_Brasil     = 001;
    cBCO_Real       = '356';           cBCO_Int_Real       = 356;
    cBCO_Unibanco   = '409';           cBCO_Int_Unibanco   = 409;
    cBCO_HSBC       = '399';           cBCO_Int_HSBC       = 399;
    cBCO_BanriSul   = '041';           cBCO_Int_BanriSul   = 041;
    cBCO_Sicredi    = '748';           cBCO_Int_Sicredi    = 748;
    cBCO_Safra      = '422';           cBCO_Int_Safra      = 422;
    cBCO_CaixaEcon  = '104';           cBCO_Int_CaixaEcon  = 104;
    cBCO_Banespa    = '033';           cBCO_Int_Banespa    = 033;
    cBCO_Fibra      = '224';           cBCO_Int_Fibra      = 224;
    cBCO_Sudameris  = '347';           cBCO_Int_Sudameris  = 347;
    cBCO_BankBoston = '479';           cBCO_Int_BankBoston = 479;
    cBCO_Santander  = '353';           cBCO_Int_Santander  = 353;
    cBCO_Besc       = '027';           cBCO_Int_Besc       = 027;
   { Bancos }


implementation


begin
  vAbandonaExit := false;
  vEsc := false;
  vPassaFoco := true;
  vTab := false;
  vcVersaoDesenvolvimento := '';

end.

