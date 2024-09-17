Unit CGSDocumentosTaxasDeServico;
(*
  cChamada_ServicoFrete, cChamada_Manutencao, cChamada_BaixaACT:
    'CGS_TAXAS_DOCTOS'  - 'CGS_TAXAS_DOCTOS_SOBRE'

  cChamada_Coleta:
    'CGS_TAXAS_COLETAS' - 'CGS_TAXAS_COLETAS_SOBRE'

  cChamada_Cotacao:
    'CGS_TAXAS_COTACAO' - 'CGS_TAXAS_COTACAO_SOBRE'

  cChamada_NegociacaoEspecial:
    'CGS_TAXAS_NE'      - 'CGS_TAXAS_NE_SOBRE'

  cChamada_EmissaoAutomaticaCTRCporNF:
    'CGS_TAXAS_RATEIO'

  cChamada_ContProgramacaoDeContainer, cChamada_ContBaixaDeContainer
    'CGS_TAXAS_CONTSERVICOS' -  'CGS_TAXAS_CONTSERVICOS_SOBRE'

*)
{
Data       Programador         Descrição
---------- ------------------- --------------------------------------------------------------
25/03/2005 Alan                Criação do Form
}

Interface

Uses
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt},
  {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt},
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, NumEdit, Buttons, RXDBCtrl, Grids, DBGrids, Db,
  RxMemDS, Menus, DBTables, MemTable, Bgm_Tela, Mask, DBCtrls,Confirma,
  ActnList, DBNumEdt, CGS_Cad_Classes, CRC_Cad_Classes ;

Type
  TfrmCGSDocumentosTaxasDeServico = Class(TForm)
    actAlterarTaxa: TAction;
    actExcluirTaxa: TAction;
    actGravarTaxa: TAction;
    actIncluirTaxa: TAction;
    ActionList1: TActionList;
    btnAdd: TBitBtn;
    btnAddSobre: TBitBtn;
    cbbReferenciaSobre: TDBLookupComboBox;
    cbbSobre: TComboBox;
    cbbTipo: TDBLookupComboBox;
    cbxReferenciaTaxas: TDBLookupComboBox;
    ckbPendente: TDBCheckBox;
    ckbSobre: TDBCheckBox;
    dsReferencia: TDataSource;
    dsTaxas: TDataSource;
    dsTaxasNE: TDataSource;
    dsTaxasSobre: TDataSource;
    dsTipo: TDataSource;
    edtCodigo: TEdit;
    edtDescricaoTaxas: TEdit;
    edtQtdeMinimaTaxas: TDBEdit;
    edtQtdeSolicTaxas: TDBNumEdit;
    edtValorMinimoTaxas: TDBEdit;
    edtValorTaxas: TDBEdit;
    gbxGrid: TGroupBox;
    gbxSobre: TGroupBox;
    gbxTaxas: TGroupBox;
    gridSobre: TDBGrid;
    gridTaxas: TRxDBGrid;
    Label1: TLabel;
    Label24: TLabel;
    Label6: TLabel;
    Label76: TLabel;
    Label8: TLabel;
    lblQtdSolic: TLabel;
    lblReferencia: TLabel;
    lblReferencia2: TLabel;
    lblValor: TLabel;
    lblValor2: TLabel;
    lblValorMinimo: TLabel;
    mdtLog: TRxMemoryData;
    mdtLogCODTAXAS: TStringField;
    mdtLogDescricao: TStringField;
    mdtLogDiaria: TStringField;
    mdtLogPendente: TStringField;
    mdtLogQtdMin: TFloatField;
    mdtLogQtdSolic: TFloatField;
    mdtLogReferencia: TStringField;
    mdtLogSobreValor: TStringField;
    mdtLogValor: TFloatField;
    mdtLogValorMin: TFloatField;
    nedTotalTaxas: TNumEdit;
    nedValorSobre: TDBEdit;
    pnlComum: TPanel;
    pnlPrincipal: TPanel;
    pnlSobre: TPanel;
    pnlTaxas: TPanel;
    pnlTotal: TPanel;
    popAlterar: TMenuItem;
    popExcluir: TMenuItem;
    popIncluir: TMenuItem;
    PopMenu1: TPopupMenu;
    qryReferencia: TQuery;
    qrySobre: TQuery;
    qryTaxas: TQuery;
    qryTipo: TQuery;
    rxTaxas: TRxMemoryData;
    rxTaxasNE: TRxMemoryData;
    rxTaxasSobre: TRxMemoryData;
    spbCodigoTaxas: TSpeedButton;
    actGravarSobre: TAction;
    actAlterarSobre: TAction;
    pmSobre: TPopupMenu;
    pmSobreAlterar: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Panel1: TPanel;
    rxTaxasSobreNE: TRxMemoryData;
    dsTaxasSobre2: TDataSource;
    rxTemp: TRxMemoryData;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    StringField6: TStringField;
    gridSobre2: TDBGrid;
    actIncluirSobre: TAction;
    edtFoco: TEdit;
    popSobre2: TPopupMenu;
    MenuItem4: TMenuItem;
    pnlObservacao: TPanel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    pnlTituloObservacao: TPanel;
    Image1: TImage;
    Panel5: TPanel;
    Label25: TLabel;
    Confirma2: TConfirma;
    Observacao: TMenuItem;
    EdtObservacao: TMemo;
    RxComparaTaxas: TRxMemoryData;
    RxComparaSobre: TRxMemoryData;
    rxComparaLog: TRxMemoryData;
    Query1: TQuery;
    MDConvTaxas: TRxMemoryData;
    MDConvTaxasCODTAXAS: TIntegerField;
    MDConvTaxasVALORINDICE: TFloatField;
    MDConvTaxasCONVVALOR: TStringField;
    MDConvTaxasCONVVLRMINIMO: TStringField;

    procedure actAlterarTaxaExecute(Sender: TObject);
    procedure actExcluirTaxaExecute(Sender: TObject);
    procedure actGravarTaxaExecute(Sender: TObject);
    procedure actIncluirTaxaExecute(Sender: TObject);
    procedure cbbSobreExit(Sender: TObject);
    procedure cbbSobreKeyPress(Sender: TObject; Var Key: Char);
    procedure cbbSobreKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
    procedure ckbSobreClick(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    procedure edtCodigoKeyPress(Sender: TObject; Var Key: Char);
    procedure edtCodigoKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
    procedure edtQtdeSolicTaxasExit(Sender: TObject);
    procedure edtQtdeSolicTaxasKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; Var Key: Char);
    procedure gridSobreExit(Sender: TObject);
    procedure gridTaxasKeyUp(Sender: TObject; Var Key: Word; Shift: TShiftState);
    procedure PopMenu1Popup(Sender: TObject);
    procedure rxTaxasAfterOpen(DataSet: TDataSet);
    procedure rxTaxasAfterScroll(DataSet: TDataSet);
    procedure rxTaxasSobreFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure spbCodigoTaxasClick(Sender: TObject);
    procedure cbbTipoExit(Sender: TObject);
    procedure rxTaxasSobreBeforePost(DataSet: TDataSet);
    procedure nedValorSobreChange(Sender: TObject);
    procedure nedValorSobreExit(Sender: TObject);
    procedure actGravarSobreExecute(Sender: TObject);
    procedure edtCodigoEnter(Sender: TObject);
    procedure gbxTaxasEnter(Sender: TObject);
    procedure gbxTaxasExit(Sender: TObject);
    procedure actAlterarSobreExecute(Sender: TObject);
    procedure gridTaxasKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    procedure gridTaxasExit(Sender: TObject);
    procedure gridTaxasKeyPress(Sender: TObject; Var Key: Char);
    procedure Panel1Enter(Sender: TObject);
    procedure edtQtdeMinimaTaxasExit(Sender: TObject);
    procedure cbxReferenciaTaxasExit(Sender: TObject);
    procedure edtCodigoClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure actIncluirSobreExecute(Sender: TObject);
    procedure rxTaxasAfterPost(DataSet: TDataSet);
    procedure edtQtdeMinimaTaxasKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtFocoEnter(Sender: TObject);
    procedure Confirma2Click(Sender: TObject);
    procedure ObservacaoClick(Sender: TObject);
    procedure PopMenu1Change(Sender: TObject; Source: TMenuItem;Rebuild: Boolean);
    procedure EdtObservacaoExit(Sender: TObject);
    procedure pnlPrincipalExit(Sender: TObject);
  Private
    vTaxaDiaria             : String[1];
    FExisteCampoTaxa_Pend   : Boolean;
    FExisteCampoQtdSolic    : Boolean;
    FExisteCampoValor_Total : Boolean;
    vObrigaObs              : Boolean;

    FBotaoGravar            : TButton;

    vClientes               : TClientes;
    vNegociacaoEspecial     : TNegociacaoEspecial;

    Function FocoEstaNesteForm: Boolean;
    Function LocalizouTaxa(vCodTaxas: String): Boolean;
    Function LogAlteracao(vDsTaxas: TDataSet; pFuncao: Char = 'C') : String;
    Function PodeAlterarRegistro: Boolean;

    Procedure CancelarInclusaoTaxa;
    Procedure CarregarCombos;
    Procedure ExibirPaineis(vExibir: Boolean);
    Procedure HabilitaBtnAdd;
    Procedure DefinirCampos(Var vTabela, vCampo: String; vChamada: Integer);
    Procedure ColocarFocoNoFormChamador(Sender: TObject);
    procedure AlterarFalse;
    procedure PesquisaValorIndice(pTaxa : Integer ) ;

  Public

    FocoAnterior  : TWinControl; // Identifica o componente a receber o foco na saída da tela de taxas.
    FocoPosterior : TWinControl; // Identifica o componente a receber o foco na saída da tela de taxas.
    vpChamada     : Integer; // cChamada_ - CGSComum
    Tabela        : String;
    Campo         : String;
    vLogTaxas     : String;

    constructor Create(AOwner: TComponent; pFocoAnterior, pFocoPosterior: TWinControl; pChamada: Integer; BotaoGravar: TButton = nil); reintroduce; overload;

    function CalculaTotalTaxas: Real;
    function Excluir(pRecnumDocto: Integer; vChamada: Integer = 0): Boolean;
    function Gravar(pRecnumDocto: Integer; vChamada: Integer = 0; vDsTaxas: TDataSet = nil; vDsSobre: TDataSet = nil): Boolean ;
    function SetFocusComp(pDestino: TWinControl = nil): Boolean;
    function VerificaParametroQtdeSolic: boolean;

    procedure CarregarTaxas(pRecnumDocto: Integer; vChamada: Integer = 0; pDataBase:TDateTime=0; pId_grupo: Integer=0);
    procedure Limpar(pClearAll: Boolean = True);
    procedure ValidaCampos;
    procedure IniciarEdicao(vIniciar: Boolean);
    Procedure CriaEstrutura_CopiaRegitros;
  end;

var
  frmCGSDocumentosTaxasDeServico : TfrmCGSDocumentosTaxasDeServico;

implementation

uses CGSComum, CGS_Funcoes, BGM_String, dmCGSDocumentos, CGSCalculosDeServico, CGSDocumentosDeServico ;

{$R *.DFM}

function ExecutaQuery(pQuery: TQuery; Tipo : Char = 'G'): Boolean;
begin
  Try
    pQuery.Execsql;
  Except
    On E:EDBEngineError Do
    begin
      if vcDatabase.InTransaction then
        vcDatabase.Rollback;
      if MensagemDLG( 'Problemas durante a '+IIF(Tipo='G','gravação','exclusão') +
                      ' das taxas de serviços. Deseja ver o erro ?'
                      , MtConfirmacao, MbSIM+MbNAO ) = MrSIM then
        MostraErrosQuery(E, True);
      Result := False;
      Exit;
    end;
  end; // end Try
  Result := True;
end;

constructor TfrmCGSDocumentosTaxasDeServico.Create(AOwner: TComponent; pFocoAnterior, pFocoPosterior: TWinControl; pChamada: Integer; BotaoGravar: TButton = nil);
begin

  if dmCGSDoc = nil then
    dmCGSDoc := TdmCGSDoc.Create(Application);

  inherited create(AOwner);

  if AOwner is TPanel then
  begin
    Self.Parent := TWinControl(AOwner);
    Self.Parent.TabStop := true;
  end

  else
    if AOwner <> nil then
    begin
      Self.BorderStyle := bsSingle;
      Self.Align := alNone;
      Self.ClientHeight := 350;
      Self.ClientWidth := 460;
      Self.Height := 350;
      Self.Width := 460;
    end;

  Self.FocoAnterior := pFocoAnterior;
  Self.FocoPosterior := pFocoPosterior;

  if pChamada = cChamada_EmissaoDocumento then
    vpChamada := cChamada_ServicoFrete
  else
    vpChamada := pChamada;

  FBotaoGravar := BotaoGravar;

  DefinirCampos(Self.Tabela, Self.Campo, vpChamada);

  FExisteCampoTaxa_Pend   := ExisteCampo(Self.Tabela, 'TAXA_PEND'  );
  FExisteCampoQtdSolic    := ExisteCampo(Self.Tabela, 'QTDSOLIC'   );
  FExisteCampoValor_Total := ExisteCampo(Self.Tabela, 'VALOR_TOTAL');

  // Desabilita os campos.
  if vpChamada = cChamada_Coleta then
    Self.ValidaCampos;

  if Not(VerificaParametroQtdeSolic) then
  begin
    Self.lblQtdSolic.Enabled := False;
    HabilitarComponente(Self.edtQtdeSolicTaxas, false);
    Self.gridTaxas.Columns[2].Visible := False; // Qtd Solic.
    Self.gridTaxas.Columns[1].Width   := 166;   // Descricao.
    pnlTotal.Visible := false;
  end;

  if vpChamada = cChamada_EmissaoAutomaticaCTRCporNF then
    Self.gridTaxas.Height    := 150;

  // Self.ckbPendente.Enabled := vpChamada = cChamada_BaixaACT;

  // Cria a estrutura das tabelas
  Self.CarregarTaxas(-1);
  TRxMemoryData(dsTaxasNE.DataSet).LoadFromDataSet(dsTaxas.DataSet, 0, lmCopy);
  TRxMemoryData(rxTaxasSobreNE).LoadFromDataSet(dsTaxasSobre.DataSet, 0, lmCopy);
  // CGSCalculosDeServico.CarregarTaxas(-1, TRxMemoryData(dsTaxasNE.DataSet), TRxMemoryData(dsTaxasSobre.DataSet));
  CarregarCombos;

  dsTaxas.Enabled := true;
  dsTaxasSobre.Enabled := true;
  if (AOwner <> nil) and
     (AOwner is TPanel) then
    Show;
end;

procedure TfrmCGSDocumentosTaxasDeServico.DefinirCampos(var vTabela, vCampo: String; vChamada: Integer);
begin

  case vChamada of

    cChamada_ServicoFrete,
    cChamada_Manutencao,
    cChamada_BaixaACT:
       vTabela := 'CGS_TAXAS_DOCTOS';

    cChamada_Coleta:
       vTabela := 'CGS_TAXAS_COLETAS';

    cChamada_Cotacao:
       vTabela := 'CGS_TAXAS_COTACAO';

    cChamada_NegociacaoEspecial:
       vTabela := 'CGS_TAXAS_NE';

    cChamada_EmissaoAutomaticaCTRCporNF:
       vTabela := 'CGS_TAXAS_RATEIO';

    cChamada_ContProgramacaoDeContainer,
    cChamada_ContBaixaDeContainer:

       vTabela := 'CGS_TAXAS_CONTSERVICOS';

    else
      vTabela := 'CGS_TAXAS_DOCTOS';
  end;

  case vChamada of
    cChamada_Cotacao:
      vCampo := 'CODCOTACAO';
    cChamada_NegociacaoEspecial:
      vCampo := 'CODNEGESP';
    cChamada_Coleta:
      vCampo := 'CODCOLETA';
    cChamada_EmissaoAutomaticaCTRCporNF:
      vCampo := 'GRUPO_RATEIO';
    cChamada_ContProgramacaoDeContainer,
    cChamada_ContBaixaDeContainer:
      vCampo := 'CODINTITEMPEDIDO' ;

    else
      vCampo := 'CODDOCTOCGS';
  end;

end;

procedure TfrmCGSDocumentosTaxasDeServico.CarregarCombos;
var
  i: Integer;
begin

  with qryReferencia do
  begin
    Close;
    SQL.Clear;
    for i := 0 to High(cCodTipoValorPercentual) do
    begin
      SQL.Add('SELECT ' + QuotedStr(cNomeTipoValorPercentual[i]) + ' DESCRICAO  ');
      SQL.Add('     , ' + QuotedStr(cCodTipoValorPercentual[i]) + '  CODIGO     ');
      SQL.Add('  FROM DUAL                                        ');
      if i <> High(cCodTipoValorPercentual) then
        SQL.Add(' UNION                                           ');
    end;
    Open;
  end;

  with qryTipo do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ''Acréscimo''  DESCRICAO  ');
    SQL.Add('     , ''A''          CODIGO     ');
    SQL.Add('  FROM DUAL                      ');
    SQL.Add(' UNION                           ');
    SQL.Add('SELECT ''Desconto ''  DESCRICAO  ');
    SQL.Add('     , ''D''          CODIGO     ');
    SQL.Add('  FROM DUAL                      ');
    Open;
  end;

  for i := Low(cNomeTaxasSobre) to High(cNomeTaxasSobre) Do
    Self.cbbSobre.Items.Add( cNomeTaxasSobre[i] );

end;

procedure TfrmCGSDocumentosTaxasDeServico.edtCodigoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
    spbCodigoTaxas.Enabled := false;

    with dsTaxas.DataSet do
      if State in [dsEdit, dsInsert] then
        Cancel;

    with dsTaxasSobre.DataSet do
      if State in [dsEdit, dsInsert] then
        Cancel;

    if dsTaxas.DataSet.IsEmpty then
    begin
      if not(Self.Owner is TPanel) then
      begin
        TForm(Self.Owner).Enabled := true;
        Self.Hide;
      end
      else
      begin
        If (vpChamada = cChamada_EmissaoAutomaticaCTRCporNF) Then
        Begin
          Limpar(False);
          edtCodigo.Enabled := True;
          pnlTaxas.Visible := False;
          pnlSobre.Visible := False;
          TForm(FocoPosterior.Owner).Enabled := true;
          TButton(FocoPosterior).Click;
          Exit;
        End
        else
        begin
          SetFocusComp( FocoPosterior );
          Limpar(False);
          edtCodigo.Enabled := True;
          pnlTaxas.Visible := False;
          pnlSobre.Visible := False;
        end;
      end;
      TRxMemoryData(dsTaxasSobre.DataSet).EmptyTable;
    end
    else
    begin
      edtCodigo.Clear;
      IniciarEdicao(false);
      ColocarFoco(gridTaxas);
    end;
    dsTaxas.Enabled := true;
    dsTaxasSobre.Enabled := true;
    rxTaxasAfterScroll(dsTaxas.DataSet);
  end;
end;

procedure TfrmCGSDocumentosTaxasDeServico.ckbSobreClick(Sender: TObject);
begin
  if ckbSobre.Checked then
    HabilitarComponente(edtQtdeSolicTaxas, False)
  else
    HabilitarComponente(edtQtdeSolicTaxas, VerificaParametroQtdeSolic );
end;

procedure TfrmCGSDocumentosTaxasDeServico.cbbSobreExit(Sender: TObject);
begin

  if not(FocoEstaNesteForm) or
    (cbbSobre.Text = '') Then
  Begin
    ColocarFoco(cbbSobre)
  End
  Else
  Begin

    With dsTaxasSobre.DataSet Do
      If Locate('CODTAXAS;SOBRE',
         VarArrayOf([edtCodigo.Text, cCodTaxasSobre[cbbSobre.ItemIndex] ]), []) Then
      Begin
        If (vpChamada <> cChamada_ServicoFrete) Then
        Begin
          If (vpChamada <> cChamada_Manutencao) Then
          Begin
            If (vpChamada <> cChamada_NegociacaoEspecial) And
               (FieldByName('ORIGEM').AsString = 'NE') Then
            Begin
              ColocarFoco(cbbSobre);
              Exit;
            End;
          End;
        End
        Else
          Edit
      End
      Else
      Begin
        Append;
        FieldByName('CODTAXAS'  ).AsString := edtCodigo.Text;
        FieldByName('DESCRICAO' ).AsString := cbbSobre.Text;
        FieldByName('SOBRE'     ).AsString := cCodTaxasSobre[cbbSobre.ItemIndex];
        FieldByName('TIPOTAXA'  ).AsString := 'A';
        FieldByName('REFERENCIA').AsString := cTipo_Cifrao;
        FieldByName('VALOR'     ).AsFloat  := 0;
      end;
    dsTaxasSobre.Enabled := true;
    HabilitarComponente(cbbSobre, false);
    GridSobre2.PopupMenu := nil;
    GridSobre2.Enabled := false;
    HabilitaBtnAdd;
  end;
end;

procedure TfrmCGSDocumentosTaxasDeServico.cbbSobreKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key in ['!'..'z',#8]) then
    key := #0;
end;

procedure TfrmCGSDocumentosTaxasDeServico.cbbSobreKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

  procedure DeletaItensSemTaxa(rxTaxas, rxSobre: TDataSet);
  begin

    if rxSobre.IsEmpty then
      Exit;

    rxTaxas.First ;

    with rxSobre do
      if not rxTaxas.Locate('CODTAXAS', FieldByName('CODTAXAS').AsInteger, []) then
        while not EOF Do
          Delete;

    rxTaxas.First;
  end;

begin

  if Key = VK_F8 then
  begin
    HabilitarComponente(cbbSobre, true);
    gridSobre2.Visible := false;

    with dsTaxas.DataSet do
      if State in [dsEdit, dsInsert] then
        Cancel;

    with dsTaxasSobre.DataSet do
      if State in [dsEdit, dsInsert] then
        Cancel;
    DeletaItensSemTaxa(dsTaxas.DataSet, dsTaxasSobre.DataSet);

    dsTaxasSobre.DataSet.Filtered := False;
    dsTaxasSobre.DataSet.Filtered := True;

    Limpar(false); { Limpa apenas os campos }
    dsTaxas.Enabled := false;
    pnlSobre.Visible := false;
    HabilitarComponente(edtCodigo, true);
    cbbSobre.OnExit := nil;
    ColocarFoco( edtCodigo );
    cbbSobre.OnExit := cbbSobreExit;
    GridSobre2.PopupMenu := pmSobre;
    GridSobre2.Enabled := true;
  end;

end;

procedure TfrmCGSDocumentosTaxasDeServico.edtCodigoExit(Sender: TObject);
begin

  Self.spbCodigoTaxas.Enabled := false;

  if dmCGSDoc.vpCamposEngessados then
  begin
    edtCodigo.Clear;
    if ( FocoEstaNesteForm ) then
      ColocarFoco(edtCodigo);
    Exit;
  end;

  If ((GetKeyState(VK_SHIFT) and $1000000) <> 0) and (vTAB) then {Alan}
  begin
    SetFocusComp( FocoAnterior );
    //IniciarEdicao(dsTaxas.DataSet.IsEmpty);
    //dsTaxasSobre.Enabled := true;
    //spbCodigoTaxas.Enabled := False;
    //exit;
  end;

  if ( Screen.ActiveControl = Self.edtFoco) or
     ( FocoEstaNesteForm ) or
     ( Screen.ActiveControl = FocoPosterior) or
     (Trim(TEdit(Sender).Text) <> '') then
  begin

    if Trim(edtCodigo.Text) = '' then
      spbCodigoTaxasClick(Sender)
    else
    begin

      edtCodigo.Text := FormatFloat('00000', StrToIntDef(edtCodigo.Text, 0));

      if LocalizouTaxa(edtCodigo.Text) then
      begin

        edtCodigo.Enabled      := false;
        spbCodigoTaxas.Enabled := false;
        HabilitarComponente(edtQtdeMinimaTaxas  , PodeAlterarRegistro);
        HabilitarComponente(edtValorMinimoTaxas , edtQtdeMinimaTaxas.Enabled);
        HabilitarComponente(edtValorTaxas       , edtQtdeMinimaTaxas.Enabled);
        HabilitarComponente(cbxReferenciaTaxas  , edtQtdeMinimaTaxas.Enabled);

        if (vpChamada = cChamada_BaixaACT) then
          ckbPendente.Enabled := dsTaxas.DataSet.FieldByName('DIARIA').AsString = 'S';

        spbCodigoTaxas.Enabled := false;
        cbbSobre.Enabled := true;
        if dsTaxasSobre.DataSet.FieldByName('SOBRE').AsInteger >= 0 then
          cbbSobre.ItemIndex := dsTaxasSobre.DataSet.FieldByName('SOBRE').AsInteger - 1;

        dsTaxas.Enabled := true;

        PesquisaValorIndice(StrToInt(edtCodigo.Text)) ;
        If MDConvTaxas.Locate('CODTAXAS',StrToInt(edtCodigo.Text),[loCaseInsensitive]) And
           (MDConvTaxas.FieldByName('VALORINDICE').AsFloat <> 0) Then
        Begin
          dsTaxas.DataSet.FieldByName('VLRMINIMO' ).AsFloat := dsTaxas.DataSet.FieldByName('VLRMINIMO').AsFloat / MDConvTaxas.FieldByName('VALORINDICE').AsFloat ;
          dsTaxas.DataSet.FieldByName('VALOR'     ).AsFloat := dsTaxas.DataSet.FieldByName('VALOR'    ).AsFloat / MDConvTaxas.FieldByName('VALORINDICE').AsFloat ;
        End ; // If MDConvTaxas.Locate('CODTAXAS',pTaxa,[loCaseInsensitive]) Then

        dsTaxasSobre.Enabled := false ;

        ExibirPaineis(true);
        HabilitaBtnAdd;
      end
      else
      begin
        edtCodigo.Clear;
        ColocarFoco(edtCodigo);
        Self.spbCodigoTaxas.Enabled := true;
      end;
    end;

  end
  else
  begin
    if FocoEstaNesteForm then
      edtCodigo.Enabled := false
    else
    begin
      if not dsTaxas.DataSet.IsEmpty then
        IniciarEdicao(false);
      if Screen.ActiveControl = Self.Owner then
      begin
        ColocarFocoNoFormChamador(FocoAnterior);
        spbCodigoTaxas.Enabled := false;
      end;
    end;
  end;

end;

Procedure TfrmCGSDocumentosTaxasDeServico.ExibirPaineis(vExibir: Boolean);
Begin
  If vExibir Then
  Begin
    pnlTaxas.Visible := dsTaxas.DataSet.FieldByName('SOBREVALOR').AsString = 'N';
    pnlSobre.Visible := not(pnlTaxas.Visible);
    If vpChamada In [cChamada_Coleta, cChamada_ServicoFrete,
                     cChamada_Manutencao, cChamada_BaixaACT] Then
      gridSobre2.Visible := pnlSobre.Visible;
    edtDescricaoTaxas.Text := dsTaxas.DataSet.FieldByName('DESCRICAO').AsString ;
    If pnlTaxas.Visible Then
    Begin
      edtQtdeSolicTaxas.DataSource := dsTaxas ;
      If edtQtdeSolicTaxas.Enabled Then
        Panel1.SetFocus
      Else
        ColocarFoco(edtQtdeMinimaTaxas);
      Application.ProcessMessages;
    End
    Else
    Begin
      edtQtdeSolicTaxas.DataSource := Nil;
      HabilitarComponente(cbbSobre, True);
      HabilitarComponente(cbbTipo, True);
      ColocarFoco(cbbSobre);
    End;
  End
  Else
  Begin
    pnlTaxas.Visible := false;
    pnlSobre.Visible := false;
  End;
End;

Procedure TfrmCGSDocumentosTaxasDeServico.gridTaxasKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
Begin
  If Key = VK_F8 then
  Begin
    If (vpChamada = cChamada_BaixaACT) And ( pnlObservacao.Visible ) Then
    Begin
      If (Trim(EdtObservacao.Text) = '') Then
      Begin
        MensagemDLG('Campo observação deve ser preenchido.', MtErro, MbOk);
        ColocarFoco(edtObservacao);
        Exit;
      End
    End;

    If (vpChamada = cChamada_EmissaoAutomaticaCTRCporNF) Then
    Begin
      TForm(FocoPosterior.Owner).Enabled := true;
      TButton(FocoPosterior).Click;
      Exit;
    End;

    If (TControl(sender).Name = 'gridSobre') And ( gridSobre.Parent = gbxSobre ) Then
    Begin
      SetFocusComp( edtCodigo );
      gridSobre.Parent := gbxGrid;
      Limpar(False);
      spbCodigoTaxas.Enabled := True;
    End
    Else
    Begin
      TForm(FocoPosterior.Owner).Enabled := true;
      SetFocusComp ( FocoPosterior );
    End;
  End;
End;

procedure TfrmCGSDocumentosTaxasDeServico.rxTaxasSobreFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  with DataSet do
    Accept :=  ( FieldByName('CODTAXAS').AsString =
                 dsTaxas.DataSet.FieldByName('CODTAXAS').AsString );
end;

procedure TfrmCGSDocumentosTaxasDeServico.edtCodigoChange(Sender: TObject);
begin
  spbCodigoTaxas.Enabled := Trim(edtCodigo.Text) = '';
  if Trim(edtCodigo.Text) = '' then
    edtDescricaoTaxas.Clear;
end;

{----------------------------------------------------------------------------------
SetFocusComp --> Força a saída do componente ativo na tela e retorna FALSE caso
                 não consiga focar o componente passado por parâmetro (pDestino).

pDestino = Componente que irá receber o foco. Caso não seja passado um componente,
           foca o próximo componente da lista do TabOrder.
----------------------------------------------------------------------------------}
function TfrmCGSDocumentosTaxasDeServico.SetFocusComp(pDestino: TWinControl = nil) : Boolean;
Var
  Evento : TNotifyEvent;
  Comp   : TWinControl;
begin
  Result := True;
  Evento := nil;
  Comp   := Screen.ActiveForm.ActiveControl;

  if pDestino = Nil then
  begin
    Screen.ActiveForm.Perform(WM_NEXTDLGCTL,0,0);
    Exit;
  end;

  Try
    if (Comp <> nil) then
    begin
      if Assigned(TEdit(Comp).OnExit) then
        Evento := TEdit(Comp).OnExit;
      TEdit(Comp).OnExit := Nil;
    end;
  Except
  end;

  Application.ProcessMessages;

  if pDestino.CanFocus then
    pDestino.SetFocus
  Else
    Result := False;

  Try
    if (Comp <> nil) and
       (Assigned(Evento)) then
      TEdit(Comp).OnExit := Evento;
  Except
  end;
end;

procedure TfrmCGSDocumentosTaxasDeServico.PopMenu1Popup(Sender: TObject);
var
  Habilita: Boolean;
begin
  dsTaxasSobre.DataSet.Active := true;
  if Screen.ActiveForm.ActiveControl.Name = 'gridSobre2' then
    Habilita := not(dsTaxasSobre.DataSet.IsEmpty) and
                not(dsTaxasSobre.DataSet.State in [dsEdit, dsInsert])
  else
    Habilita := ((Screen.ActiveForm.ActiveControl.Name = 'gridSobre') AND (not dsTaxasSobre.DataSet.IsEmpty)) OR
                ((Screen.ActiveForm.ActiveControl.Name = 'gridTaxas') AND (not dsTaxas.DataSet.IsEmpty));


  popAlterar.Enabled     := Habilita;
  pmSobreAlterar.Enabled := Habilita;
  popExcluir.Enabled     := Habilita;
end;

procedure TfrmCGSDocumentosTaxasDeServico.rxTaxasAfterScroll(DataSet: TDataSet);
begin
  dsTaxasSobre.DataSet.Filtered := False;
  dsTaxasSobre.DataSet.Filtered := True;

  if gbxGrid.Visible then
    HabilitarComponente(gridSobre, (Not dsTaxasSobre.DataSet.IsEmpty) );
end;

procedure TfrmCGSDocumentosTaxasDeServico.gridSobreExit(Sender: TObject);
begin
  if gridSobre.Parent.Name = 'gbxSobre' then
    gridSobre.SetFocus;
end;

procedure TfrmCGSDocumentosTaxasDeServico.CarregarTaxas(pRecnumDocto: Integer; vChamada: Integer = 0; pDataBase:TDateTime=0; pId_grupo: Integer=0);
var
  vTabela: String;
  vCampo: String;
  vExisteCampoTaxa_Pend: Boolean;
  vExisteCampoQtdSolic: Boolean;
  vExisteCampoValor_Total: Boolean;

  procedure AbrirQrySobre(vCodTaxas: Integer);
  begin

    with qrySobre do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT A.*                                  ');
      SQL.Add('     , LPAD('' '', 10, '' '') DESCRICAOTIPO ');
      SQL.Add('     , LPAD('' '', 30, '' '') DESCRICAO     ');
      SQL.Add('     , ''  '' ORIGEM                        ');

      if vChamada = cChamada_Coleta Then
        SQL.Add('   , ''S'' ALTERAR                        ')
      Else
        SQL.Add('   , ''N'' ALTERAR                        ');

      If vpChamada In [cChamada_ContProgramacaoDeContainer, cChamada_ContBaixaDeContainer] Then
        SQL.Add('   , A.' + Campo ) ;

      SQL.Add('  FROM ' + vTabela + '_SOBRE A              ');

      If vpChamada = cChamada_EmissaoAutomaticaCTRCporNF then
      begin
        SQL.Add(' WHERE A.CODTAXAS = :CODTAXAS  AND        ');
        SQL.Add('       A.DATA_GRUPO = :PDATABASE AND      ');
        If pRecnumDocto>0 then
          SQL.Add('   A.GRUPO_RATEIO = :RECNUMDOCTO        ')
        Else
          SQL.Add('   A.ID_GRUPO     = :RECNUMDOCTO        ');
        ParamByName('PDATABASE').AsDateTime := pDataBase;
      end
      else
      begin
        SQL.Add(' WHERE ' + vCampo + '= :RECNUMDOCTO         ');
        SQL.Add('       AND CODTAXAS = :CODTAXAS             ');
      end;

      ParamByName('RECNUMDOCTO').AsInteger := IIf(pRecnumDocto>0,pRecNumDocto,pId_grupo);
      ParamByName('CODTAXAS'   ).AsInteger := vCodTaxas;

      Open;

      With TRxMemoryData(dsTaxasSobre.DataSet) Do
        If Not Active Then
        Begin
          CopyStructure(qrySobre);
          Active := true;
        End;
        CriaEstrutura_CopiaRegitros ;
    end;

  End;
Begin
  TRxMemoryData(dsTaxas.DataSet).Close ;
  TRxMemoryData(dsTaxasSobre.DataSet).Close ;

  If vChamada <> 0 Then
  Begin
    DefinirCampos(vTabela, vCampo, vChamada) ;
    vExisteCampoTaxa_Pend   := ExisteCampo(vTabela,'TAXA_PEND'  );
    vExisteCampoQtdSolic    := ExisteCampo(vTabela,'QTDSOLIC'   );
    vExisteCampoValor_Total := ExisteCampo(vTabela,'VALOR_TOTAL');
  End
  Else
  Begin
    vCampo  := Self.Campo ;
    vTabela := Self.Tabela ;
    vExisteCampoTaxa_Pend   := FExisteCampoTaxa_Pend  ;
    vExisteCampoQtdSolic    := FExisteCampoQtdSolic   ;
    vExisteCampoValor_Total := FExisteCampoValor_Total ;
  End ;

  With qryTaxas Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT A.CODTAXAS                     ');
    SQL.Add('     , A.QTDMINIMA                    ');
    SQL.Add('     , A.VLRMINIMO                    ');
    SQL.Add('     , A.REFERENCIA                   ');
    SQL.Add('     , A.SOBREVALOR                   ');
    SQL.Add('     , A.VALOR                        ');
    SQL.Add('     , B.DIARIA                       ');
    SQL.Add('     , B.DESCRICAO                    ');
    SQL.Add('     , ''  '' ORIGEM                  ');

    if vChamada = cChamada_Coleta Then
      SQL.Add('   , ''S'' ALTERAR                  ')
    else
      SQL.Add('   , ''N'' ALTERAR                  ');

    if vpChamada = cChamada_BaixaACT Then
      SQL.Add('   , A.OBSERVACAO       ');

    If vExisteCampoQtdSolic then
      SQL.Add('     , A.QTDSOLIC                   ')
    else
      SQL.Add('     , 0 QTDSOLIC                   ');

    if vExisteCampoTaxa_Pend then
      SQL.Add('     , A.TAXA_PEND                  ')
    else
      SQL.Add('     , ''N'' TAXA_PEND              ');

    if vExisteCampoValor_Total then
      SQL.Add('     , A.VALOR_TOTAL                ')
    else
      SQL.Add('     , 0 VALOR_TOTAL                ');

    If vpChamada = cChamada_EmissaoAutomaticaCTRCporNF then
    begin
      SQL.Add('     , A.GRUPO_RATEIO               ');
      SQL.Add('     , A.DATA_GRUPO                 ');
      SQL.Add('     , A.ID_GRUPO                   ');
    end Else
    If vpChamada In [cChamada_ContProgramacaoDeContainer, cChamada_ContBaixaDeContainer] Then
      SQL.Add('     , A.' + Campo ) ;

    SQL.Add('  FROM ' + vTabela + ' A              ');
    SQL.Add('     , CGS_TAXASDESERVICOS B          ');
    SQL.Add(' WHERE B.CODIGO = A.CODTAXAS          ');

    If vpChamada = cChamada_EmissaoAutomaticaCTRCporNF then
    begin
      SQL.Add('   AND A.DATA_GRUPO = :PDATABASE AND ');
      If pRecnumDocto>0 then SQL.Add('   A.GRUPO_RATEIO = :RECNUMDOCTO        ')
      Else                   SQL.Add('   A.ID_GRUPO = :RECNUMDOCTO     ');
      ParamByName('PDATABASE').AsDateTime := pDataBase;
    end
    else
      SQL.Add('   AND A.' + vCampo + ' = :RECNUMDOCTO');

    ParamByName('RECNUMDOCTO').AsInteger := IIf(pRecnumDocto>0,pRecNumDocto,pId_grupo);
    GetSql(qryTaxas);
    Open ;
    // Guarda registros para futura comparação.
    TRxMemoryData(dsTaxas.DataSet).CopyStructure(qryTaxas) ;
    TRxMemoryData(dsTaxas.DataSet).Open ;
    RxComparaTaxas.Close ;
    RxComparaSobre.Close ;

    If IsEmpty Then
      AbrirQrySobre(-1) ;

    While Not EOF Do
    Begin
      With dsTaxas.DataSet Do
      Begin
        Open ;
        Append ;
        FieldByName('CODTAXAS'   ).AsString := StrZero(QryTaxas.FieldByName('CODTAXAS').AsInteger,5) ;
        FieldByName('DESCRICAO'  ).AsString := qryTaxas.FieldByName('DESCRICAO' ).AsString ;
        FieldByName('DIARIA'     ).AsString := qryTaxas.FieldByName('DIARIA'    ).AsString ;
        FieldByName('QTDMINIMA'  ).AsFloat  := qryTaxas.FieldByName('QTDMINIMA' ).AsFloat  ;
        FieldByName('VLRMINIMO'  ).AsFloat  := qryTaxas.FieldByName('VLRMINIMO' ).AsFloat  ;
        FieldByName('REFERENCIA' ).AsString := qryTaxas.FieldByName('REFERENCIA').AsString ;
        FieldByName('SOBREVALOR' ).AsString := qryTaxas.FieldByName('SOBREVALOR').AsString ;
        FieldByName('VALOR'      ).AsFloat  := qryTaxas.FieldByName('VALOR'     ).AsFloat  ;
        FieldByName('ALTERAR'    ).AsString := qryTaxas.FieldByName('ALTERAR'   ).AsString ;

        if vpChamada = cChamada_BaixaACT Then
          FieldByName('OBSERVACAO' ).AsString := qryTaxas.FieldByName('OBSERVACAO').AsString ;

        If vExisteCampoQtdSolic Then
          FieldByName('QTDSOLIC' ).AsFloat    := qryTaxas.FieldByName('QTDSOLIC'  ).AsFloat  ;

        If vExisteCampoTaxa_Pend Then
          FieldByName('TAXA_PEND').AsString   := qryTaxas.FieldByName('TAXA_PEND' ).AsString ;

        If vExisteCampoValor_Total Then
          FieldByName('VALOR_TOTAL').AsFloat  := qryTaxas.FieldByName('VALOR_TOTAL' ).AsFloat ;

        If vpChamada = cChamada_EmissaoAutomaticaCTRCporNF then
        begin
          FieldByName('GRUPO_RATEIO').AsInteger  := qryTaxas.FieldByName('GRUPO_RATEIO').AsInteger;
          FieldByName('DATA_GRUPO'  ).AsDateTime := qryTaxas.FieldByName('DATA_GRUPO'  ).AsDateTime;
          FieldByName('ID_GRUPO'    ).AsInteger  := qryTaxas.FieldByName('ID_GRUPO'    ).AsInteger;
        end Else
        If vpChamada In [cChamada_ContProgramacaoDeContainer, cChamada_ContBaixaDeContainer] Then
          FieldByName(Campo).AsInteger  := qryTaxas.FieldByName(Campo).AsInteger;

        Post;


        Case vpChamada Of
          cChamada_BaixaACT :
            RxComparaTaxas.LoadFromDataSet(dsTaxas.DataSet,1,lmAppend) ;
        End; // End Case vpChamada Of

        If (qryTaxas.FieldByName('SOBREVALOR').AsString  = 'S') Then
        Begin
          AbrirQrySobre(QryTaxas.FieldByName('CODTAXAS').AsInteger);

          dsTaxasSobre.DataSet.Filtered := False;
          While Not qrySobre.EOF Do
          Begin

            If dsTaxasSobre.DataSet.Locate('CODTAXAS;SOBRE',VarArrayOf([QryTaxas.FieldByName('CODTAXAS').AsInteger, qrySobre.FieldByName('SOBRE').AsInteger]),[]) then
            Begin
              qrySobre.Next;
              Continue;
            End;

            dsTaxasSobre.DataSet.Append ;
            dsTaxasSobre.DataSet.FieldByName('CODTAXAS'  ).AsString  := StrZero(qrySobre.FieldByName('CODTAXAS').AsInteger,5);
            dsTaxasSobre.DataSet.FieldByName('SOBRE'     ).AsInteger := qrySobre.FieldByName('SOBRE'     ).AsInteger;
            dsTaxasSobre.DataSet.FieldByName('REFERENCIA').AsString  := qrySobre.FieldByName('REFERENCIA').AsString ;
            dsTaxasSobre.DataSet.FieldByName('TIPOTAXA'  ).AsString  := qrySobre.FieldByName('TIPOTAXA'  ).AsString ;
            dsTaxasSobre.DataSet.FieldByName('VALOR'     ).AsFloat   := qrySobre.FieldByName('VALOR'     ).AsFloat  ;
            dsTaxasSobre.DataSet.FieldByName('DESCRICAO' ).AsString  := cNomeTaxasSobre[qrySobre.FieldByName('SOBRE').AsInteger - 1]; { CGSComum }
            dsTaxasSobre.DataSet.FieldByName('ALTERAR'   ).AsString  := qrySobre.FieldByName('ALTERAR'   ).AsString ;
            If vpChamada = cChamada_EmissaoAutomaticaCTRCporNF then
            begin
              dsTaxasSobre.DataSet.FieldByName('GRUPO_RATEIO').AsInteger  := qrySobre.FieldByName('GRUPO_RATEIO').AsInteger;
              dsTaxasSobre.DataSet.FieldByName('DATA_GRUPO'  ).AsDateTime := qrySobre.FieldByName('DATA_GRUPO'  ).AsDateTime;
              dsTaxasSobre.DataSet.FieldByName('ID_GRUPO'    ).AsInteger  := qrySobre.FieldByName('ID_GRUPO'    ).AsInteger;
            end Else
            If vpChamada In [cChamada_ContProgramacaoDeContainer, cChamada_ContBaixaDeContainer] Then
              dsTaxasSobre.DataSet.FieldByName(Campo).AsInteger  := qrySobre.FieldByName(Campo).AsInteger ;

            dsTaxasSobre.DataSet.Post ;

            Case vpChamada Of
              cChamada_BaixaACT :
                RxComparaSobre.LoadFromDataSet( dsTaxasSobre.DataSet,1,lmAppend );

            End; // End Case vpChamada Of

            qrySobre.Next ;

          End;
          dsTaxasSobre.DataSet.Filtered := True ;
          qrySobre.Close ;
        End;
      End;
      qryTaxas.Next;
    End
  End;

  RxComparaLog.LoadFromDataSet(dsTaxas.DataSet,0,lmCopy) ;

  If pRecnumDocto = -1 Then
    nedTotalTaxas.Value := 0
  Else
  Begin
    vLogTaxas := '';
    LogAlteracao(dsTaxas.DataSet, 'G');
    nedTotalTaxas.Value := CalculaTotalTaxas;
  End;

  if Not dsTaxas.DataSet.IsEmpty then
  begin
    dsTaxas.DataSet.First;
    gbxGrid.Visible  := True;
    gbxTaxas.Visible := False;
  end;

  if not dsTaxas.DataSet.IsEmpty then
  begin
    dsTaxas.Enabled := true;
    dsTaxasSobre.Enabled := true;
  end;
end;


function TfrmCGSDocumentosTaxasDeServico.Gravar(pRecnumDocto: Integer; vChamada: Integer = 0; vDsTaxas: TDataSet = nil; vDsSobre: TDataSet = nil): Boolean ;
var
  vTabela: String;
  vCampo: String;
  vExisteCampoTaxa_Pend: Boolean;
  vExisteCampoQtdSolic: Boolean;
  vExisteCampoValor_Total: Boolean;
  qryTaxas: TQuery;
  qrySobre: TQuery;

    function ExcluiuItensDaTaxa: Boolean;
    var
      K: Integer;
    begin

      with qryTaxas do
      begin
        Close;

        For K := 1 To 2 Do
        begin
        { Primeiro exclui os itens da taxa para depois excluir as taxas.}
          SQL.Clear;
          SQL.Add('DELETE FROM ' + vTabela + IIF(K=2,'','_SOBRE') );
          SQL.Add(' WHERE ' + vCampo + ' = :CODDOCTO             ');
          ParamByName('CODDOCTO').AsInteger := pRecNumDocto;
          Result := ExecutaQuery( qryTaxas );
        end;

      end;

    end;  // function ExcluiuItensDaTaxa: Boolean;

    procedure ScriptInsertTaxas;
    var
      i: Integer;
      S: String;
    begin

      with qryTaxas do
      begin
        Close;
        // Taxas
        SQL.Clear;
        SQL.Add('INSERT INTO ' + vTabela                );

        for i := 1 to 2 do
        begin

          S := iif(i = 1, '', ':');

          SQL.Add('     ( ' + S + vCampo                    );
          SQL.Add('     , ' + S + 'CODTAXAS                ');
          SQL.Add('     , ' + S + 'SOBREVALOR              ');
          SQL.Add('     , ' + S + 'QTDMINIMA               ');
          SQL.Add('     , ' + S + 'VLRMINIMO               ');
          SQL.Add('     , ' + S + 'REFERENCIA              ');
          SQL.Add('     , ' + S + 'VALOR                   ');

          If vpChamada = cChamada_BaixaACT Then
            SQL.Add('     , ' + S + 'OBSERVACAO            ');

          if vExisteCampoQtdSolic then
            SQL.Add('     , ' + S + 'QTDSOLIC              ');

          if vExisteCampoTaxa_Pend then
            SQL.Add('     , ' + S + 'TAXA_PEND             ');

          if vExisteCampoValor_Total then
            SQL.Add('     , ' + S + 'VALOR_TOTAL           ');

          SQL.Add('     )                                  ');

          if i = 1 then
            SQL.Add('VALUES                                ');

        end;
      end;
    end; // procedure ScriptInsertTaxas;

    procedure ScriptInsertTaxasSobre;
    var
      i: Integer;
      S: String;
    begin

      with qrySobre do
      begin
        Close;
        // Taxas
        SQL.Clear;
        SQL.Add('INSERT INTO ' + vTabela + '_SOBRE          ');
        for i := 1 to 2 do
        begin

          S := iif(i = 1, '', ':');

          SQL.Add('     ( ' + S + vCampo                    );
          SQL.Add('     , ' + S + 'CODTAXAS                ');
          SQL.Add('     , ' + S + 'SOBRE                   ');
          SQL.Add('     , ' + S + 'TIPOTAXA                ');
          SQL.Add('     , ' + S + 'REFERENCIA              ');
          SQL.Add('     , ' + S + 'VALOR                   ');
          SQL.Add('     )                                  ');

          if i = 1 then
            SQL.Add('VALUES                                  ');

        End;
      End;
    End; // procedure ScriptInsertTaxasSobre

    Function GravaOsItensDaTaxa: Boolean;
    Begin
      Result := True;
      With vdsTaxas Do
        If vdsTaxas.FieldByName('SOBREVALOR').AsString = 'S' Then
        Begin
          vdsSobre.Filtered := False ;
          vdsSobre.Filtered := True ;
          vdsSobre.First ;

          While Not vdsSobre.EOF Do
          Begin
            qrySobre.ParamByName(vCampo      ).AsInteger := pRecNumDocto;
            qrySobre.ParamByName('CODTAXAS'  ).AsInteger := vdsTaxas.FieldByName('CODTAXAS'  ).AsInteger;
            qrySobre.ParamByName('SOBRE'     ).AsInteger := vdsSobre.FieldByName('SOBRE'     ).AsInteger;
            qrySobre.ParamByName('REFERENCIA').AsString  := vdsSobre.FieldByName('REFERENCIA').AsString ;
            qrySobre.ParamByName('TIPOTAXA'  ).AsString  := vdsSobre.FieldByName('TIPOTAXA'  ).AsString[1];
            qrySobre.ParamByName('VALOR'     ).AsFloat   := vdsSobre.FieldByName('VALOR'     ).AsFloat ;

            If Not ExecutaQuery(qrySobre) Then
            Begin
              Result := False;
              Break ;
            End;

            vdsSobre.Next;
          End;

        End;

    End;  // function GravaOsItensDaTaxa: Boolean;

    Function InseriuTaxas: Boolean;
    Begin
      Result := True;
      With qryTaxas Do
      Begin
        Close ;

        // Taxas
        ScriptInsertTaxas ;
        // Itens da taxa
        ScriptInsertTaxasSobre ;

        vdsTaxas.Open ;
        vdsTaxas.First ;

        While Not vdsTaxas.EOF Do
        Begin

          ParamByName(vCampo      ).AsInteger := pRecNumDocto ;
          ParamByName('CODTAXAS'  ).AsInteger := vdsTaxas.FieldByName('CODTAXAS'  ).AsInteger;
          ParamByName('QTDMINIMA' ).AsFloat   := vdsTaxas.FieldByName('QTDMINIMA' ).AsFloat  ;
          ParamByName('REFERENCIA').AsString  := vdsTaxas.FieldByName('REFERENCIA').AsString ;
          ParamByName('VLRMINIMO' ).AsFloat   := vdsTaxas.FieldByName('VLRMINIMO' ).AsFloat  ;
          ParamByName('VALOR'     ).AsFloat   := vdsTaxas.FieldByName('VALOR'     ).AsFloat  ;
          ParamByName('SOBREVALOR').AsString  := vdsTaxas.FieldByName('SOBREVALOR').AsString ;

          If vpChamada = cChamada_BaixaACT Then
            ParamByName('OBSERVACAO').AsString  := vdsTaxas.FieldByName('OBSERVACAO').AsString ;

          If vExisteCampoQtdSolic Then
            ParamByName('QTDSOLIC').AsFloat   := vdsTaxas.FieldByName('QTDSOLIC').AsFloat ;

          If vExisteCampoTaxa_Pend Then
            ParamByName('TAXA_PEND').AsString  := vdsTaxas.FieldByName('TAXA_PEND').AsString ;

          If vExisteCampoValor_Total Then
            ParamByName('VALOR_TOTAL').AsFloat  := vdsTaxas.FieldByName('VALOR_TOTAL').AsFloat ;

          GetSql(qryTaxas);

          If Not( ExecutaQuery( qryTaxas )) Or
             Not( GravaOsItensDaTaxa ) Then
          Begin
            Result := False;
            Break;
          End;

          vdsTaxas.Next;
        End;
      End;
    End;  // function InseriuTaxas: Boolean;

begin
  Result := False;

  qryTaxas := TQuery.Create(nil);
  qrySobre := TQuery.Create(nil);
  qryTaxas.DatabaseName := cDatabaseName;
  qrySobre.DatabaseName := cDatabaseName;

  if vDsTaxas = nil then
    vDsTaxas := dsTaxas.DataSet;

  if vDsSobre = nil then
    vDsSobre := dsTaxasSobre.DataSet
  else
    vDsSobre.OnFilterRecord := rxTaxasSobreFilterRecord;

  if vChamada <> 0 then
  begin
    DefinirCampos(vTabela, vCampo, vChamada);
    vExisteCampoTaxa_Pend   := ExisteCampo(vTabela, 'TAXA_PEND'  );
    vExisteCampoQtdSolic    := ExisteCampo(vTabela, 'QTDSOLIC'   );
    vExisteCampoValor_Total := ExisteCampo(vTabela, 'VALOR_TOTAL');
  end
  else
  begin
    vCampo  := Self.Campo;
    vTabela := Self.Tabela;
    vExisteCampoTaxa_Pend   := FExisteCampoTaxa_Pend   ;
    vExisteCampoQtdSolic    := FExisteCampoQtdSolic    ;
    vExisteCampoValor_Total := FExisteCampoValor_Total ;
  end;

  if ExcluiuItensDaTaxa and
     InseriuTaxas then
  begin
    Result := True;
    try
      vLogTaxas := LogAlteracao(vDsTaxas);
    except
    end;
  end;

  qryTaxas.Free;
  qrySobre.Free;

  If vChamada <> cChamada_Coleta Then
    Limpar;
    
end;

procedure TfrmCGSDocumentosTaxasDeServico.Limpar(pClearAll: Boolean = True);
Var k : Integer;
begin
  vTaxaDiaria            := '';
  actGravarTaxa.Enabled  := false;
  actGravarSobre.Enabled  := false;
  Self.spbCodigoTaxas.Enabled := False;
  Self.gbxTaxas.Visible       := True;

  For k := 0 To ComponentCount - 1 Do
  begin
    if (TControl(Components[k]).Name = 'nedTotalTaxas') AND (Not pClearAll) then
      // Não faz nada
    else
    begin
      if (Components[k] is TComboBox) then TComboBox(Components[k]).ItemIndex := -1  Else
      if (Components[k] is TCheckBox) then TCheckBox(Components[k]).Checked := False Else
      if (Components[k] is TNumEdit ) then TNumEdit(Components[k]).Value := 0        Else
      if (Components[k] is TEdit    ) then TEdit(Components[k]).Clear                Else
      if (Components[k] is TRxMemoryData) AND (pClearAll) then
        TRxMemoryData(Components[k]).EmptyTable;
    end;
  end;

  Try
    pnlTaxas.Visible := False;
    pnlSobre.Visible := False;
    gbxGrid.Visible := False;
  Except
    ActiveControl   := Nil;
    gbxGrid.Visible := False;
  end;

end;

function TfrmCGSDocumentosTaxasDeServico.LogAlteracao(vDsTaxas: TDataSet; pFuncao: Char = 'C'): String;
var
  i,b, a: Integer;
  vLogExclusao,
  vLogInclusao,
  vLogAlteracao : String;
  rxLog: TRxMemoryData;

 function TiraZerosEsq( A : String ) : String;
 begin
   Try
     Result := IntToStr( StrToInt(A) );
   Except
     Result := A;
   end;
 end;

Begin
  Result := '';

  vLogExclusao  := '';
  vLogInclusao  := '';
  vLogAlteracao := '';
//vLogTaxas     := '';

  if vpChamada = cChamada_Coleta then
  Begin
    With vDsTaxas Do
    Begin
      First;
      {----- Log alteracao / exclusao -------}
      While Not EOF Do
      Begin
        If RxComparaLog.Locate('CODTAXAS',vdsTaxas.FieldByName('CODTAXAS' ).AsInteger,[]) then
        Begin
          b := 0;
          For i := 0 To Fields.Count - 1 Do // Compara campo a campo
          Begin
            If (RxComparaLog.Fields[i].Value <> Fields[i].Value) Then
            Begin
              If RxComparaLog.Fields[i].FieldName<>'VALOR_TOTAL' Then
              Begin
                Inc(b);
                If ( b = 1 ) Then // Pra colocar o nº da taxa só uma vez. ex: "5: Pendente de <vazio> para S, ..."
                  vLogAlteracao := vLogAlteracao + vdsTaxas.FieldByName('CODTAXAS').AsString + ': ';

                vLogAlteracao := vLogAlteracao + vdsTaxas.Fields[i].FieldName +
                                 ' de '  + IIF(RxComparaLog.Fields[i].AsString='','<vazio>',RxComparaLog.Fields[i].AsString) +
                                 ' para '+     IIF(vdsTaxas.Fields[i].AsString='','<vazio>',    vdsTaxas.Fields[i].AsString) +
                                 '. ';
              End;
            End;
          End;
        End
        Else
          vLogInclusao := vLogInclusao + TiraZerosEsq( vdsTaxas.FieldByName('CODTAXAS').AsString ) + ',';

        Next;
      End; // While

      rxComparaLog.First;
      While Not rxComparaLog.EOF Do
      Begin
        If Not vdsTaxas.Locate('CODTAXAS',rxComparaLog.FieldByName('CODTAXAS').AsString,[]) Then
          vLogExclusao := vLogExclusao + TiraZerosEsq( rxComparaLog.FieldByName('CODTAXAS').AsString ) + ',';
        rxComparaLog.Next;
      End;

    End; // With

    If vLogExclusao <> '' Then
      vLogExclusao := 'excluidas (Cod: ' + Copy(vLogExclusao,1,Length(vLogExclusao)-1) + '); '; {ex:  excluídas (1,2,3); }

    If vLogInclusao <> '' then
      vLogInclusao := 'incluidas (Cod: ' + Copy(vLogInclusao,1,Length(vLogInclusao)-1) + '); ';

    if vLogAlteracao <> '' then
      vLogAlteracao := 'alteradas (Cod: ' + Copy(vLogAlteracao,1,Length(vLogAlteracao)-2) + '); ';

    if vLogInclusao + vLogExclusao + vLogAlteracao <> '' then
      Result := ' Taxas de serviço ' + vLogInclusao + vLogExclusao + vLogAlteracao;

  End
  Else
  Begin
    rxLog := TRxMemoryData.Create(Nil);
    If pFuncao = 'G' Then       // Guarda registros atuais
    Begin
      rxLog.LoadFromDataSet(vDsTaxas, 0, lmCopy);
    End
    Else If pFuncao = 'C' Then  // Compara o que foi gravado com o estado anterior da tabela.
    Begin

      Try
        rxLog := Self.mdtLog;
      Except
        rxLog.LoadFromDataSet(vDsTaxas, 0, lmCopy);
      End;

      With vDsTaxas Do
      Begin
        First;
        {----- Log alteracao / exclusao -------}
        While Not EOF Do
        Begin

          If rxLog.Locate('CODTAXAS',FieldByName('CODTAXAS').AsString,[]) Then
          Begin
            A := 0;
            For i := 0 To Fields.Count - 1 Do // Compara campo a campo
              If (rxLog.Fields[i].Value <> Fields[i].Value) Then
              Begin
                Inc(A);

                If ( A = 1 ) Then // Pra colocar o nº da taxa só uma vez. ex: "5: Pendente de <vazio> para S, ..."
                  vLogAlteracao := vLogAlteracao + FieldByName('CODTAXAS').AsString + ': ';

                vLogAlteracao := vLogAlteracao + Fields[i].FieldName
                +' de '  + IIF(rxLog.Fields[i].AsString='','<vazio>',rxLog.Fields[i].AsString)
                +' para '+ IIF(Fields[i].AsString='','<vazio>',Fields[i].AsString) + '. ';
              End;

          End
          Else
            vLogInclusao := vLogInclusao + TiraZerosEsq( FieldByName('CODTAXAS').AsString ) + ',';

          Next;
        End; // While

        {----- Log exclusao -------}

        If rxLog <> Nil Then // Estava dando erro.
        Begin

          If Not(rxLog.EOF) Then
            rxLog.First;

          While Not rxLog.EOF Do
          Begin
            If Not Locate('CODTAXAS',rxLog.FieldByName('CODTAXAS').AsString,[]) Then
              vLogExclusao := vLogExclusao + TiraZerosEsq( rxLog.FieldByName('CODTAXAS').AsString ) + ',';
            rxLog.Next;
          End;

        End;
      End; // With
      If vLogExclusao <> '' Then
        vLogExclusao := 'excluidas (' + Copy(vLogExclusao,1,Length(vLogExclusao)-1) + '); '; {ex:  excluídas (1,2,3); }

      If vLogInclusao <> '' then
        vLogInclusao := 'incluidas (' + Copy(vLogInclusao,1,Length(vLogInclusao)-1) + '); ';

      if vLogAlteracao <> '' then
        vLogAlteracao := 'alteradas (' + Copy(vLogAlteracao,1,Length(vLogAlteracao)-2) + '); ';

      if vLogInclusao + vLogExclusao + vLogAlteracao <> '' then
        Result := ' Taxas de serviço ' + vLogInclusao + vLogExclusao + vLogAlteracao;
    end; // pFuncao = 'C'
    rxLog.Free;
  End;

end;

function TfrmCGSDocumentosTaxasDeServico.CalculaTotalTaxas : Real;
var
  bm: TBookMark;
begin
  bm := dsTaxas.DataSet.GetBookMark;

  Result := CalculaTaxasdeServicos( TRxMemoryData(dsTaxas.DataSet)
                                  , TRxMemoryData(dsTaxasSobre.DataSet)
                                  , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0).Vlr_TotalTaxa;

  Self.nedTotalTaxas.Value := Result;
  dsTaxas.DataSet.GotoBookMark(bm);
  dsTaxas.DataSet.FreeBookMark(bm);
end;
        
function TfrmCGSDocumentosTaxasDeServico.Excluir(pRecnumDocto: Integer; vChamada: Integer = 0): Boolean;
var
  k: Integer;
  vTabela: String;
  vCampo: String;
begin
  Result := True;

  if vChamada <> 0 then
    DefinirCampos(vTabela, vCampo, vChamada)
  else
  begin
    vTabela := Self.Tabela;
    vCampo := Self.Campo;
  end;

  with qryTaxas do
  begin
    Close;
    For K := 1 To 2 Do
    begin
      { Primeiro exclui os itens da taxa para depois excluir as taxas.}
      SQL.Clear;
      SQL.Add('DELETE FROM ' + vTabela + IIF(K=1,'_SOBRE','') + ' WHERE ' + vCampo+ '= :CODDOCTO' );
      ParamByName('CODDOCTO').AsInteger := pRecNumDocto;
      if Not ExecutaQuery( qryTaxas,'E' ) then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;

End;

procedure TfrmCGSDocumentosTaxasDeServico.FormCreate(Sender: TObject);
begin
  dsTaxas.DataSet.Open;
  dsTaxasSobre.DataSet.Open;
  mdtLog.Open;
  edtCodigo.OnChange := Nil;
  Self.Height        := 350;
  Self.Width         := 460;
  gbxTaxas.Align     := AlClient;
  gbxGrid.Align      := AlClient;
  pnlObservacao.Visible := False;
  IniciarEdicao(dsTaxas.DataSet.IsEmpty);
  vNegociacaoEspecial := TNegociacaoEspecial.Create;
  vClientes           := TClientes.Create;
End;

procedure TfrmCGSDocumentosTaxasDeServico.ValidaCampos;
Var
  vHabilita : Boolean;
Begin

  If vpChamada = cChamada_Coleta Then
  Begin
    vHabilita := False;
    HabilitarComponente(edtQtdeMinimaTaxas,True);
  End
  Else
  Begin
    vHabilita := PodeAlterarRegistro;
    HabilitarComponente(edtQtdeMinimaTaxas,vHabilita);
  End;

  HabilitarComponente(edtQtdeMinimaTaxas,vHabilita);
  HabilitarComponente(edtValorTaxas     ,vHabilita);
  HabilitarComponente(cbxReferenciaTaxas,vHabilita);
  HabilitarComponente(cbbTipo           ,vHabilita);
  HabilitarComponente(cbbSobre          ,vHabilita);

End;

Procedure TfrmCGSDocumentosTaxasDeServico.edtCodigoKeyPress(Sender: TObject; var Key: Char);
Begin
  If Not(Key in ['0'..'9',#8, #13]) Then
    Key := #0;
End;

procedure TfrmCGSDocumentosTaxasDeServico.edtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = 27) or
     ( (ssShift in Shift) and
       (key = VK_TAB)
     ) then
  begin
    // edtCodigo.Clear;
    CancelarInclusaoTaxa;
    if (FocoEstaNesteForm) and
       not(dsTaxas.DataSet.IsEmpty) then
      ColocarFoco(gridTaxas)
    else
      ColocarFocoNoFormChamador(FocoAnterior);
  end
  else

    if SaiuComSetaParaBaixo(Sender, key, '', Self) then
    begin
      edtCodigo.OnExit := nil;
      HabilitarComponente(edtCodigo, true);
      edtCodigo.Clear;
      edtCodigo.OnExit := edtCodigoExit;
      if dsTaxas.DataSet.IsEmpty then
        ColocarFocoNoFormChamador(FocoPosterior);
    end;

  if Screen.ActiveControl <> Self.edtCodigo then
    spbCodigoTaxas.Enabled := false;
end;

procedure TfrmCGSDocumentosTaxasDeServico.HabilitaBtnAdd;
var
  S: String;
begin

  if pnlTaxas.Visible then
    S := edtValorTaxas.Text
  else
    S := nedValorSobre.Text;
  if S = '' then
    S := '0';

  if pnlTaxas.Visible then
    with dsTaxas.DataSet do
      actGravarTaxa.Enabled := (Trim(edtCodigo.Text ) <> '') and
                               (Trim(cbxReferenciaTaxas.Text) <> '') and
                               (StrToIntDef(S, 1) > 0)
  else
    with dsTaxasSobre.DataSet do
      actGravarSobre.Enabled := (Trim(cbbSobre.Text) <> '') and
                               (Trim(cbbTipo.Text) <> '') and
                               (Trim(cbbReferenciaSobre.Text) <> '') And
                               (StrToIntDef(S, 1) > 0);
end;

procedure TfrmCGSDocumentosTaxasDeServico.FormClose(Sender: TObject; Var Action: TCloseAction);
begin

  If (vpChamada = cChamada_BaixaACT) and ( pnlObservacao.Visible ) Then
  Begin
    If (Trim(EdtObservacao.Text) <> '') Then
      Confirma2Click(Sender)
    else
    Begin
      MensagemDLG('Campo observação deve ser preenchido.', MtErro, MbOk);
      Action := caNone ;
      Exit;
    End;
  End;

  If Not(Self.Owner Is TPanel) Then
  Begin
    ActiveControl := Nil;
    CancelarInclusaoTaxa;
    Limpar(false); { Limpa apenas os campos }
    dsTaxas.Enabled  := False;
    pnlSobre.Visible := False;
    HabilitarComponente(edtCodigo, true);
    cbbSobre.OnExit := Nil;
    ColocarFoco( edtCodigo );
    cbbSobre.OnExit := cbbSobreExit;
    GridSobre2.PopupMenu := pmSobre;
    GridSobre2.Enabled   := True;

    If Not dsTaxas.DataSet.IsEmpty Then
    Begin
      dsTaxas.DataSet.First;
      gbxGrid.Visible  := True;
      gbxTaxas.Visible := False;
    End;
    If dmCGSDoc.vpRecalcular Then
    Begin
      dmCGSDoc.CalculouServico(True,False);
      dmCGSDoc.vpRecalcular := false;
      If (FBotaoGravar <> nil) Then
        FBotaoGravar.Enabled := True;
    End;
  End
  Else
  Begin
    rxTaxasNE.Close;
    rxTaxasSobreNE.Close;
    rxTaxas.Close;
    rxTaxasSobre.Close;
    mdtLog.Close;
  End;
  Self.spbCodigoTaxas.Enabled := False;
  pnlObservacao.Visible       := False;
  TForm(Self.Owner).Enabled   := True;
End;

procedure TfrmCGSDocumentosTaxasDeServico.edtQtdeSolicTaxasExit(Sender: TObject);
begin
  if (((GetKeyState(VK_SHIFT) and $1000000) <> 0 ) and (vTAB)) and
     (dsTaxas.State in [dsInsert, dsEdit]) then
    CancelarInclusaoTaxa
  else
  begin
    if not(FocoEstaNesteForm) then
      ColocarFoco(TEdit(Sender))
    else
      if not(edtQtdeMinimaTaxas.Enabled) then
        actGravarTaxa.Execute;
  end;
end;

procedure TfrmCGSDocumentosTaxasDeServico.CancelarInclusaoTaxa;
begin
  cbbSobre.ItemIndex := -1;
  with dsTaxas.DataSet do
    if State in [dsEdit, dsInsert] then
      Cancel;

  with dsTaxasSobre.DataSet do
    if State in [dsEdit, dsInsert] then
      Cancel;

  with dsTaxasSobre2.DataSet do
    if State in [dsEdit, dsInsert] then
      Cancel;
      
  HabilitarComponente(edtCodigo, true);
  ColocarFoco(edtCodigo);
  dsTaxas.Enabled := false;
  dsTaxasSobre.Enabled := false;
  edtCodigo.Clear;
  edtDescricaoTaxas.Clear;
  spbCodigoTaxas.Enabled := true;
end;

procedure TfrmCGSDocumentosTaxasDeServico.spbCodigoTaxasClick(Sender: TObject);
begin

  if Pesquisa('Pesquisa de taxas de serviços',                              // Titulo
              'Código,Descrição,Qtd. mínima,Valor mínimo,Referência,Valor', // Cabeçalho
              'CODIGO,DESCRICAO,QTDMINIMA,VALORMINIMO,REFERENCIA,VALOR',    // Coluna
              'Codigo','','Codigo',                                         // Ordem Default
              'CGS_TaxasDeServicos','',true,'','') = '' then                // Tabela e Condicao
    edtCodigo.SetFocus
  else
    edtCodigo.Text := vcRetorno1;

  if Trim(edtCodigo.Text) <> '' then
    edtCodigo.OnExit(Sender);

End;

Procedure TfrmCGSDocumentosTaxasDeServico.actGravarTaxaExecute(Sender: TObject);

  Function CamposPreenchidos: Boolean ;
  Begin

    With dsTaxas.DataSet Do
    Begin

      If ( FieldByName('REFERENCIA').AsString = '%' ) Then
      Begin
        Edit;
        FieldByName('QTDMINIMA').AsFloat := 0 ;
        FieldByName('QTDSOLIC' ).AsFloat := 0 ;
        FieldByName('VLRMINIMO').AsFloat := 0 ;
      End;

      If FieldByName('SOBREVALOR').AsString = 'S' Then
      Begin
        Result := False ;

        If FieldByName('VALOR').IsNull Then
        Begin
          MensagemDLG('Valor deve ser preenchido.',MtErro,MbOk);
          ColocarFoco(edtValorTaxas);
          Exit;
        End;

        If (FieldByName('VLRMINIMO').AsFloat = 0) And
           (FieldByName('QTDMINIMA').AsFloat > 0) Then
        Begin
          MensagemDLG('Valor mínimo deve ser preenchido.',MtErro,MbOk);
          ColocarFoco(edtValorMinimoTaxas);
          Exit;
        End;
      End;

    End;

    Result := True;
  End; // Function CamposPreenchidos: Boolean;

  Function ComparaValores : Boolean;
  Begin
    Result := False;
    If vpChamada <> cChamada_BaixaACT Then
      Exit;

    RxComparaTaxas.Open;
    If RxComparaTaxas.Locate('CODTAXAS', dsTaxas.DataSet.FieldByName('CODTAXAS').AsInteger, []) Then
    Begin
      If (( RxComparaTaxas.FieldByName('QTDMINIMA' ).AsFloat  <> dsTaxas.DataSet.FieldByName('QTDMINIMA' ).AsFloat  ) Or
          ( RxComparaTaxas.FieldByName('QTDSOLIC'  ).AsFloat  <> dsTaxas.DataSet.FieldByName('QTDSOLIC'  ).AsFloat  ) Or
          ( RxComparaTaxas.FieldByName('VLRMINIMO' ).AsFloat  <> dsTaxas.DataSet.FieldByName('VLRMINIMO' ).AsFloat  ) Or
          ( RxComparaTaxas.FieldByName('REFERENCIA').AsString <> dsTaxas.DataSet.FieldByName('REFERENCIA').AsString ) Or
          ( RxComparaTaxas.FieldByName('VALOR'     ).AsString <> dsTaxas.DataSet.FieldByName('VALOR'     ).AsString )
         ) And
          ( vObrigaObs ) Then
      Begin
        Result               := True ;
        dsTaxas.Enabled      := False ;
        dsTaxasSobre.Enabled := False ;
        IniciarEdicao(False) ;
        ObservacaoClick(Sender);
      End;
    End;
  End;

Begin

  If dmCGSDoc.vpCamposEngessados Then
    Exit;

  If CamposPreenchidos Then
  Begin

    If MDConvTaxas.Locate('CODTAXAS',StrToInt(Trim(edtCodigo.Text)),[loCaseInsensitive]) Then
    Begin
      dsTaxas.DataSet.FieldByName('VLRMINIMO' ).AsFloat :=  dsTaxas.DataSet.FieldByName('VLRMINIMO').AsFloat * MDConvTaxas.FieldByName('VALORINDICE').AsFloat ;
      dsTaxas.DataSet.FieldByName('VALOR'     ).AsFloat :=  dsTaxas.DataSet.FieldByName('VALOR'    ).AsFloat * MDConvTaxas.FieldByName('VALORINDICE').AsFloat ;
    End ; // If MDConvTaxas.Locate(...

    If Not(vpChamada In [cChamada_NegociacaoEspecial,
                         cChamada_Coleta
                         ]) Then
      DmCGSDoc.vpRecalcular := True ;

    If vpChamada = cChamada_EmissaoAutomaticaCTRCporNF then
    begin
      If dsTaxas.DataSet.State In [dsEdit, dsInsert] Then
        dsTaxas.DataSet.Post ;

      If dsTaxasSobre.DataSet.State In [dsEdit, dsInsert] Then
        dsTaxasSobre.DataSet.Post ;
    end;

    CalculaTotalTaxas;

    If dsTaxas.DataSet.State In [dsEdit, dsInsert] Then
      dsTaxas.DataSet.Post ;

    If dsTaxasSobre.DataSet.State In [dsEdit, dsInsert] Then
      dsTaxasSobre.DataSet.Post ;

    AlterarFalse;

    If Not ComparaValores Then
    Begin
      cbbSobre.ItemIndex     := -1 ;
      edtCodigo.Text         := '' ;
      edtDescricaoTaxas.Text := '' ;
      HabilitarComponente(edtCodigo,True) ;
      ColocarFoco(edtCodigo);
      ExibirPaineis(False)  ;
      dsTaxas.Enabled      := False;
      dsTaxasSobre.Enabled := False;
    End ;

  End ;
  dsTaxasSobre.DataSet.Filtered := True;
End;

Procedure TfrmCGSDocumentosTaxasDeServico.actIncluirTaxaExecute(Sender: TObject);
Begin
  if dmCGSDoc.vpCamposEngessados then
    Exit;

  HabilitarComponente(edtCodigo, true);
  edtCodigo.Clear;
  edtDescricaoTaxas.Clear;
  pnlTaxas.Visible := False;
  IniciarEdicao(true);
  dsTaxas.Enabled := false;
  dsTaxasSobre.Enabled := false;
  ColocarFoco(edtCodigo);
  spbCodigoTaxas.Enabled := true;
end;

procedure TfrmCGSDocumentosTaxasDeServico.actAlterarTaxaExecute(Sender: TObject);
begin
  if dmCGSDoc.vpCamposEngessados then
    Exit;

  If Not dsTaxas.DataSet.IsEmpty Then
  Begin
    //HabilitarComponente(edtCodigo, false);
    edtCodigo.OnChange   := edtCodigoChange;
    edtCodigo.Enabled    := False ;
    edtCodigo.Text       := FormatFloat('00000', dsTaxas.DataSet.FieldByName('CODTAXAS').AsFloat);

    dsTaxas.Enabled      := True ;
    dsTaxasSobre.Enabled := False ;
    dsTaxas.DataSet.Edit;

    PesquisaValorIndice(StrToInt(edtCodigo.Text)) ;
    If MDConvTaxas.Locate('CODTAXAS',StrToInt(edtCodigo.Text),[loCaseInsensitive]) And
       (MDConvTaxas.FieldByName('VALORINDICE').AsFloat <> 0) Then
    Begin
      dsTaxas.DataSet.FieldByName('VLRMINIMO' ).AsFloat := dsTaxas.DataSet.FieldByName('VLRMINIMO').AsFloat / MDConvTaxas.FieldByName('VALORINDICE').AsFloat ;
      dsTaxas.DataSet.FieldByName('VALOR'     ).AsFloat := dsTaxas.DataSet.FieldByName('VALOR'    ).AsFloat / MDConvTaxas.FieldByName('VALORINDICE').AsFloat ;
    End ; // If MDConvTaxas.Locate('CODTAXAS',pTaxa,[loCaseInsensitive]) Then

    HabilitarComponente(edtQtdeMinimaTaxas  , PodeAlterarRegistro       );
    HabilitarComponente(edtValorMinimoTaxas , edtQtdeMinimaTaxas.Enabled);
    HabilitarComponente(edtValorTaxas       , edtQtdeMinimaTaxas.Enabled);
    HabilitarComponente(cbxReferenciaTaxas  , edtQtdeMinimaTaxas.Enabled);

    If (vpChamada = cChamada_BaixaACT) Then
      ckbPendente.Enabled := dsTaxas.DataSet.FieldByName('DIARIA').AsString = 'S';

    ActiveControl := nil;
    IniciarEdicao(true);
    actGravarTaxa.Enabled := true;
    ExibirPaineis(true);
  end;

end;

procedure TfrmCGSDocumentosTaxasDeServico.actExcluirTaxaExecute(Sender: TObject);
  (*
  function TaxaDaNegociacaoEspecial: Boolean;
  begin
    // Se o item for da NE não deixa excluir.
    if Screen.ActiveForm.ActiveControl.Name = 'gridSobre' then
      Result := (vpChamada = cChamada_NegociacaoEspecial) or
                (dsTaxasSobre.DataSet.FieldByName('ORIGEM').AsString = 'NE')
    else
      Result := not PodeAlterarRegistro;

    if Result then
      MensagemDLG('Impossível excluir pois o item faz parte da negociação especial.', MtInformacao, mbOk);
  end;
  *)

begin
  if Screen.ActiveForm.ActiveControl.Name = 'gridSobre' then
    Sender := Self.gridSobre
  else
    Sender := Self.gridTaxas;

  dsTaxasSobre.DataSet.Active := true;

  if not(dmCGSDoc.vpCamposEngessados) and
     // not(TaxaDaNegociacaoEspecial) and
    (MensagemDLG('Confirma a exclusão ?', MtConfirmacao, MbSim + MbNao) = MrSim)  then
  begin
    if not(vpChamada in [cChamada_NegociacaoEspecial,
                         cChamada_Coleta]) then
      dmCGSDoc.vpRecalcular := True;

    If Screen.ActiveForm.ActiveControl.Name = 'gridSobre' Then
    Begin
      dsTaxasSobre.DataSet.Delete;
      if dsTaxasSobre.DataSet.IsEmpty then // Se não tiver mais itens pra taxa, exclui a taxa.
        dsTaxas.DataSet.Delete;
    end
    else
    begin
      // Primeiro exclui todos os itens da taxa para depois excluir a taxa.
      while dsTaxasSobre.DataSet.Locate('CODTAXAS', dsTaxas.DataSet.FieldByName('CODTAXAS').AsString,[]) do
        dsTaxasSobre.DataSet.Delete;
      dsTaxas.DataSet.Delete;
    end;

    nedTotalTaxas.Value := CalculaTotalTaxas;

    if dsTaxas.DataSet.IsEmpty then
    begin
      Limpar( False );
      IniciarEdicao(true);
      HabilitarComponente(edtCodigo, true);
      ColocarFoco(edtCodigo);
    end
    else
      ColocarFoco(TDBGrid(Sender));
  end;

end;

procedure TfrmCGSDocumentosTaxasDeServico.IniciarEdicao(vIniciar: Boolean);
begin
  gbxGrid.Visible := not(vIniciar);
  gbxTaxas.Visible := vIniciar;
  if gbxGrid.Visible then
  begin
    dsTaxas.Enabled := true;
    dsTaxasSobre.Enabled := true;
    if FocoEstaNesteForm then
      ColocarFoco(Self.gridTaxas);
  end;
end;

procedure TfrmCGSDocumentosTaxasDeServico.FormKeyPress(Sender: TObject; var Key: Char);
begin // vPassaFoco está sendo atribuída para compatibilidade com a forma de navegação anterior
  vPassaFoco := true;
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt}
end;

function TfrmCGSDocumentosTaxasDeServico.PodeAlterarRegistro: Boolean;
begin
  Result := (vpChamada = cChamada_NegociacaoEspecial) or
            (Not(dsTaxas.DataSet.FieldByName('ORIGEM').AsString = 'NE'));
end;

procedure TfrmCGSDocumentosTaxasDeServico.edtQtdeSolicTaxasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if (key = 27) and
     (dsTaxas.State in [dsInsert, dsEdit]) then
  begin
    Application.ProcessMessages;
    Key := 0;
    CancelarInclusaoTaxa;
  end;

end;

procedure TfrmCGSDocumentosTaxasDeServico.rxTaxasAfterOpen(DataSet: TDataSet);
var
  i: Integer;
begin

  with DataSet do
  begin
    for i := 0 to Fields.Count -1 do
      if (Fields[i] is TFloatField) and
         (Copy(Fields[i].FieldName, 1, 3) <> 'COD') then
      with TFloatField(Fields[i]) do
        begin
          EditFormat := '0.00';
          DisplayFormat := cFloat_Mask;
        end;
    with TFloatField(FieldByName('VALOR')) Do
      begin
        EditFormat    := '0.000000';
        DisplayFormat := '###,##0.000000';
      end;
  end;

end;

function TfrmCGSDocumentosTaxasDeServico.LocalizouTaxa(vCodTaxas: String): Boolean;
var
  rxTempTaxasNE, rxTempSobreNE: TRxMemoryData;

  function ExisteTaxa: Boolean;
  begin

    Result := false;

    with qryTaxas do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CODIGO          CODTAXAS         ');
      SQL.Add('     , DESCRICAO                        ');
      SQL.Add('     , QTDMINIMA                        ');
      SQL.Add('     , SOBREVALOR                       ');
      SQL.Add('     , REFERENCIA                       ');
      SQL.Add('     , VALORMINIMO     VLRMINIMO        ');
      SQL.Add('     , VALOR                            ') ;
      SQL.Add('     , ''  '' ORIGEM                    ');
      SQL.Add('     , DIARIA                           ');
      SQL.Add('     , 1 QTDSOLIC                       ');
      SQL.Add('     , ''N'' TAXA_PEND                  ');
      SQL.Add('     , ''N'' ALTERAR                    ');

      SQL.Add('  FROM CGS_TAXASDESERVICOS              ');

      SQL.Add(' WHERE CODIGO = :P_CODIGO               ');

      ParamByName('P_CODIGO').AsString := vCodTaxas;
      Open;
      if not IsEmpty then
      begin
        Result := true;
        qrySobre.Close;          // Traz do cadastro de taxas.
        qrySobre.SQL.Clear;
        qrySobre.SQL.Add('SELECT CODTAXAS                             ');
        qrySobre.SQL.Add('     , SOBRE                                ');
        qrySobre.SQL.Add('     , REFERENCIA                           ');
        qrySobre.SQL.Add('     , TIPOTAXA                             ');
        qrySobre.SQL.Add('     , VALOR                                ');
        qrySobre.SQL.Add('     , LPAD('' '', 10, '' '') DESCRICAOTIPO ');
        qrySobre.SQL.Add('     , LPAD('' '', 30, '' '') DESCRICAO     ');
        qrySobre.SQL.Add('     , ''  '' ORIGEM                        ');
        qrySobre.SQL.Add('     , ''N'' ALTERAR                        ');
        qrySobre.SQL.Add('  FROM CGS_TAXASDESERVICOS_SOBRE   ');
        qrySobre.SQL.Add(' WHERE CODTAXAS = :CODTAXAS        ');
        qrySobre.ParamByName('CODTAXAS').AsString := vCodTaxas;
        qrySobre.Open;
      end

      else
        MensagemDlg('Taxa não encontrada.', mtErro, mbOk);
    end;

  end;

  procedure Inserir;
  begin
    dsTaxas.DataSet.Append;
    dsTaxas.DataSet.FieldByName('CODTAXAS').AsString:= vCodTaxas;
    dsTaxas.DataSet.FieldByName('QTDSOLIC').AsInteger:= 1;
  end;

  function LocalizouEm(DataSet: TDataSet): Boolean;
  begin
    DataSet.Open;
    Result := DataSet.Locate('CODTAXAS', vCodTaxas, []);

    if Result then
    begin
      if DataSet = dsTaxas.DataSet then
        dsTaxas.DataSet.Edit
      else
        Inserir;
    end;
  end;

  procedure CarregarQtdes(vOrigem: TDataSet);
  begin

    if vOrigem.Active then

      with dsTaxas.DataSet do
      begin
        FieldByName('DESCRICAO').AsString := vOrigem.FieldByName('DESCRICAO').AsString;
        FieldByName('QTDMINIMA').AsFloat  := vOrigem.FieldByName('QTDMINIMA').AsFloat ;
        FieldByName('QTDSOLIC' ).AsFloat  := vOrigem.FieldByName('QTDSOLIC' ).AsFloat ;
        FieldByName('ALTERAR'  ).AsString := vOrigem.FieldByName('ALTERAR'  ).AsString;
        if (vOrigem = qryTaxas     ) or
           (vOrigem = rxTempTaxasNE) or
           (vOrigem = rxTaxasNE    ) then
          FieldByName('ORIGEM').AsString  := vOrigem.FieldByName('ORIGEM'   ).AsString;
      end;

  end;  /// procedure CarregarQtdes(vOrigem: TDataSet);

  procedure CarregarValores(vOrigem: TDataSet);
  var
    ds: TDataSet;
  begin

    if vOrigem.Active then
    begin

      with dsTaxas.DataSet do
      begin
        FieldByName('REFERENCIA').AsString := vOrigem.FieldByName('REFERENCIA').AsString;
        FieldByName('VLRMINIMO' ).AsFloat  := vOrigem.FieldByName('VLRMINIMO' ).AsFloat ;
        FieldByName('VALOR'     ).AsFloat  := vOrigem.FieldByName('VALOR'     ).AsFloat ;
        FieldByName('SOBREVALOR').AsString := vOrigem.FieldByName('SOBREVALOR').AsString;
        FieldByName('DIARIA'    ).AsString := vOrigem.FieldByName('DIARIA'    ).AsString;
        FieldByName('TAXA_PEND' ).AsString := vOrigem.FieldByName('TAXA_PEND' ).AsString;
      end;

      dsTaxasSobre.DataSet.Active := true;
      // rxTemp.LoadFromDataSet(qrySobre, 0, lmCopy);

      dsTaxasSobre.DataSet.Filtered := False;

      if (rxTempSobreNE.Locate('CODTAXAS', dsTaxas.DataSet.FieldByName('CODTAXAS').AsInteger, [])) then
        ds := rxTempSobreNE
      else
        ds := qrySobre;

      while not ds.eof do
      begin

        if not(dsTaxasSobre.DataSet.Locate('CODTAXAS;SOBRE',
               VarArrayOf([dsTaxas.DataSet.FieldByName('CODTAXAS').AsInteger,
                           ds.FieldByName('SOBRE').AsString]), [])) then
          TRxMemoryData(dsTaxasSobre.DataSet).LoadFromDataSet(ds, 1, lmAppend);

        ds.Next;
      end;
      dsTaxasSobre.DataSet.Filtered := True;

    end;
  end;  /// procedure CarregarValores(vOrigem: TDataSet);

  // Rotina para quando vier de uma coleta.
  procedure TratamentoParaQdoVierDeColeta;
  begin

    with dsTaxas.DataSet do
      if ( FieldByName('VLRMINIMO' ).AsFloat  = 0 ) and
         ( FieldByName('REFERENCIA').AsString = '') and
         ( FieldByName('VALOR'     ).AsFloat  = 0 ) then
      begin
        CarregarQtdes(qryTaxas);

        if LocalizouEm(dsTaxasNE.DataSet) then
          CarregarValores(dsTaxasNE.DataSet)
        else
          CarregarValores(qryTaxas);
      end;

  end; // procedure TratamentoParaQdoVirDeColeta;

  procedure LocalizarNE;
  var
    i, cont : Integer;
    S, vNegociacao, vVigencia ,
    vTabela, vCliente, vTabelaTela: String;
  begin
    Result := True;

    Cont := 1 ;
    i    := 1 ;
    S    := '';
    vTabelaTela := dmCGSDoc.rxCabecalho.FieldByName('TABELA_CALCULO').AsString;

    While (i < (Length(vTabelaTela) + 1)) And
               (Trim(vTabelaTela) <> '') Do
    Begin
      If ((vTabelaTela[i] = ' ') Or
          (i = (Length(vTabelaTela)))) Then
      Begin
        If i = (Length(vTabelaTela)) Then
           S := S + Trim(vTabelaTela[i]);
        Case Cont Of
          1: vNegociacao := S;
          2: vCliente    := S;
          3: vTabela     := S;
          4: vVigencia   := S;
        End;
        if cont in [1..4] then
          inc(Cont);
        S := '';
        Inc(i,3);
      End;
      S := S + Trim(vTabelaTela[i]);
      Inc(i);
    End;

    If vNegociacao = 'NE' Then
    Begin
      vClientes.Nr_Cliente := vCliente;
      vClientes.Atualizar;
      vNegociacaoEspecial.Cliente.Cod_Cliente := vClientes.Cod_Cliente;
      vNegociacaoEspecial.Vigencia            := StrToDateTime(vVigencia);
      vNegociacaoEspecial.Cod_Tabela          := StrToIntDef(vTabela, 0);
      vNegociacaoEspecial.Atualizar;
      cgsCalculosDeServico.vCodIntNE          := vNegociacaoEspecial.RecNum_CMA022;
    end;

  end;

begin

  rxTempTaxasNE := TRxMemoryData.Create(nil);
  rxTempSobreNE := TRxMemoryData.Create(nil);

  // CGSCalculosDeServico.CarregarTaxas(vCodigo: Integer; rx: TRxMemoryData; rxSobre: TRxMemoryData = nil)

  if not(ExisteTaxa) then
    Result := false
  else
                                     
  begin

    if (cgsCalculosDeServico.vCodIntNE = 0) and
       (vpChamada in [ cChamada_ServicoFrete, cChamada_Manutencao, cChamada_BaixaACT ]) and
       not(dmCGSDoc.rxCabecalho.IsEmpty) and
       (Pos('NE', dmCGSDoc.rxCabecalho.FieldByName('TABELA_CALCULO').AsString) <> 0)  then
      LocalizarNE;

    if (rxTaxasNE.IsEmpty) and (cgsCalculosDeServico.vCodIntNE <> 0) then
    begin
      cgsCalculosDeServico.CarregarTaxas(-1,
                                         rxTempTaxasNE, rxTempSobreNE);
      cgsCalculosDeServico.CarregarTaxas(cgsCalculosDeServico.vCodIntNE  ,
                                         rxTempTaxasNE, rxTempSobreNE);
    end
    else
    begin
      rxTempTaxasNE.LoadFromDataSet(rxTaxasNE, 0, lmCopy);
      rxTempSobreNE.LoadFromDataSet(rxTaxasSobreNE, 0, lmCopy);
    end;

    with rxTaxas do
    begin

      Result := true;
      DisableControls;

      (*
      Se existir em rxTaxas, traz desta tabela para alteração.
      --Senão, procura em rxTaxasNE  (pois este é o q está cadastrado na Negociação Especial e não deixa alterar).
      rxtaxasNE em 30/06 Rodrigo pediu para poder alterar
      Caso não existir em nenhum dos dois, traz do cadastro (rxTaxas) e permite alteração.
      *)

      if ( LocalizouEm(dsTaxas.DataSet) ) then
      begin

        if (dmCGSDoc.CGSDocumento1.Coleta.NumeroColeta <> 0) then
          TratamentoParaQdoVierDeColeta;

      end
      else
      begin

        if ( LocalizouEm(rxTempTaxasNE) ) then
        begin

          CarregarQtdes(rxTempTaxasNE);
          CarregarValores(rxTempTaxasNE);

//        *- SIM 19629 -> não é obrigatório informar a qtde minima
//          if FieldByName('QTDMINIMA').AsInteger  = 0 then
//             FieldByName('QTDMINIMA').AsInteger := 1 ;

          if FieldByName('QTDSOLIC').AsInteger   = 0 then
             FieldByName('QTDSOLIC').AsInteger  := 1 ;

{         with dsTaxas.DataSet do if State in [dsEdit, dsInsert] then Post;
          with dsTaxasSobre.DataSet do if State in [dsEdit, dsInsert] THen Post;
}              
        end
        else
        begin

          Inserir;
          CarregarQtdes(qryTaxas);
          CarregarValores(qryTaxas);
          
        end;

        if (FieldByName('QTDSOLIC').AsInteger = 0) then
          FieldByName('QTDSOLIC').AsInteger := 1;

      end;

      EnableControls;
    end;

  end; // else;

  rxTempTaxasNE.Free;
  rxTempSobreNE.Free;

end;

function TfrmCGSDocumentosTaxasDeServico.FocoEstaNesteForm: Boolean;
begin // Se o foco estiver dentro deste form...
  Result := ( (Screen.ActiveControl <> nil) and
              (Screen.ActiveControl <> self.edtFoco ) and
              (Screen.ActiveControl.Owner = Self) );
end;

procedure TfrmCGSDocumentosTaxasDeServico.cbbTipoExit(Sender: TObject);
begin

  if not(FocoEstaNesteForm) then
    ColocarFoco(cbbTipo)
  else
  begin
    if dsTaxasSobre.DataSet.State in [dsEdit, dsInsert] then
      with dsTaxasSobre.DataSet.FieldByName('DESCRICAOTIPO') do
        AsString := cbbTipo.Text;
    HabilitaBtnAdd;
  end;

end;

procedure TfrmCGSDocumentosTaxasDeServico.rxTaxasSobreBeforePost(DataSet: TDataSet);
begin

  with DataSet do
  begin
    FieldByName('DESCRICAOTIPO').AsString :=
       iif(FieldByName('TIPOTAXA').AsString = 'A', 'Acréscimo', 'Desconto');
    FieldByName('DESCRICAO').AsString :=
       cNomeTaxasSobre[FieldByName('SOBRE').AsInteger - 1];
  end;

end;

procedure TfrmCGSDocumentosTaxasDeServico.nedValorSobreChange(Sender: TObject);
begin
  HabilitaBtnAdd;
end;

procedure TfrmCGSDocumentosTaxasDeServico.nedValorSobreExit(Sender: TObject);
begin
  if not(FocoEstaNesteForm) then
  begin
    if not(ColocarFoco(btnAddSobre))  then
      ColocarFoco(nedValorSobre)
  end
  else
    if (Screen.ActiveControl <> cbbReferenciaSobre) and
       (Screen.ActiveControl <> cbbTipo) then
      ColocarFoco(btnAddSobre);
end;

procedure TfrmCGSDocumentosTaxasDeServico.actGravarSobreExecute(Sender: TObject);

  procedure CopiarTaxasSobre;
  begin
    dsTaxasSobre.DataSet.DisableControls;
    With rxTemp Do
    begin
      First;

      While Not EOF Do
      Begin
        if not(dsTaxasSobre.DataSet.Locate('CODTAXAS;SOBRE',
               VarArrayOf([dsTaxas.DataSet.FieldByName('CODTAXAS').AsInteger,
                           rxTemp.FieldByName('SOBRE').AsString]), [])) then
          TRxMemoryData(dsTaxasSobre.DataSet).LoadFromDataSet(rxTemp, 1, lmAppend);
        Next;
      end;

      EmptyTable;
    end;
    dsTaxasSobre.DataSet.EnableControls;
  end;

  Function ComparaValoresSobre : Boolean;
  Begin
    Result := False;
    If ( vpChamada <> cChamada_BaixaACT ) Or ( RxComparaSobre.IsEmpty ) Then
      Exit;

    RxComparaSobre.Open ;
    If RxComparaSobre.Locate('CODTAXAS;SOBRE',
       VarArrayOf([dsTaxasSobre.DataSet.FieldByName('CODTAXAS').AsInteger,
                   dsTaxasSobre.DataSet.FieldByName('SOBRE'   ).AsInteger ]),[]) then
    Begin
      If (//( RxComparaSobre.FieldByName('SOBRE'     ).AsInteger <> dsTaxasSobre.DataSet.FieldByName('SOBRE'     ).AsInteger) Or
          ( RxComparaSobre.FieldByName('REFERENCIA').AsString  <> dsTaxasSobre.DataSet.FieldByName('REFERENCIA').AsString ) Or
          ( RxComparaSobre.FieldByName('TIPOTAXA'  ).AsString  <> dsTaxasSobre.DataSet.FieldByName('TIPOTAXA'  ).AsString ) Or
          ( RxComparaSobre.FieldByName('VALOR'     ).AsFloat   <> dsTaxasSobre.DataSet.FieldByName('VALOR'     ).AsFloat)
          ) And
          ( vObrigaObs )Then
      Begin
        Result        := True ;
        dsTaxas.Enabled      := False ;
        dsTaxasSobre.Enabled := False ;
        IniciarEdicao(False) ;
        ObservacaoClick(Sender);
      End ;
    End ;
  End ;

Var
  BM: TBookMark ;

Begin

  If dmCGSDoc.vpCamposEngessados Then
    Exit;

  HabilitarComponente(cbbSobre,True) ;

  BM := dsTaxasSobre.DataSet.GetBookMark ;

  If MDConvTaxas.Locate('CODTAXAS',StrToInt(Trim(edtCodigo.Text)),[loCaseInsensitive]) Then
  Begin
    dsTaxas.DataSet.FieldByName('VLRMINIMO' ).AsFloat :=  dsTaxas.DataSet.FieldByName('VLRMINIMO').AsFloat * MDConvTaxas.FieldByName('VALORINDICE').AsFloat ;
    dsTaxas.DataSet.FieldByName('VALOR'     ).AsFloat :=  dsTaxas.DataSet.FieldByName('VALOR'    ).AsFloat * MDConvTaxas.FieldByName('VALORINDICE').AsFloat ;
  End ; // If MDConvTaxas.Locate(...

  If dsTaxas.DataSet.State In [dsEdit, dsInsert] Then
    dsTaxas.DataSet.Post ;

  If dsTaxasSobre.DataSet.State In [dsEdit,dsInsert] Then
    dsTaxasSobre.DataSet.Post ;

  AlterarFalse;

  If Not(vpChamada In [cChamada_NegociacaoEspecial,
                       cChamada_Coleta]) Then
    dmCGSDoc.vpRecalcular := True ;

  CalculaTotalTaxas ;

  dsTaxasSobre.DataSet.GotoBookMark(BM);

  If Not ComparaValoresSobre Then
  Begin
    cbbSobre.ItemIndex := -1 ;
    SetFocusComp(Self.cbbSobre) ;
    dsTaxasSobre.Enabled          := False;
    dsTaxasSobre.DataSet.Filtered := False;
    dsTaxasSobre.DataSet.Filtered := True;
    GridSobre2.PopupMenu          := pmSobre;
  End;

  dsTaxasSobre.DataSet.FreeBookMark(BM);
End;

Procedure TfrmCGSDocumentosTaxasDeServico.edtCodigoEnter(Sender: TObject);
Begin
  edtCodigo.OnChange := edtCodigoChange;
  edtCodigoChange(Sender);
End;

Procedure TfrmCGSDocumentosTaxasDeServico.gbxTaxasEnter(Sender: TObject);
Begin
  edtCodigo.OnChange := edtCodigoChange;
End;

Procedure TfrmCGSDocumentosTaxasDeServico.gbxTaxasExit(Sender: TObject);
Begin
  edtCodigo.OnChange := Nil;
End;

Procedure TfrmCGSDocumentosTaxasDeServico.actAlterarSobreExecute(Sender: TObject);
Begin

  If dmCGSDoc.vpCamposEngessados Then
    Exit ;

  If Not(dsTaxasSobre.DataSet.IsEmpty) And
     ( (vpChamada = cChamada_NegociacaoEspecial) Or
       (Not(dsTaxasSobre.DataSet.FieldByName('ORIGEM').AsString = 'NE')) ) Then
  Begin
    cbbSobre.ItemIndex := dsTaxasSobre.DataSet.FieldByName('SOBRE').AsInteger - 1;
    ActAlterarTaxa.Execute;
    ColocarFoco(cbbTipo);
  End;

End;

Procedure TfrmCGSDocumentosTaxasDeServico.gridTaxasKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
  If ( Key = 27 ) Then
    ColocarFocoNoFormChamador(FocoAnterior);// Else ColocarFocoNoFormChamador(FocoPosterior);
End;

Procedure TfrmCGSDocumentosTaxasDeServico.gridTaxasExit(Sender: TObject);
Begin // Se saiu com o Shift+Tab ou o Ctrl+Tab

  If (((GetKeyState(VK_SHIFT) And $1000000) <> 0 ) And (vTAB)) or vEsc Then
  Begin
    If (vpChamada = cChamada_BaixaACT) And ( pnlObservacao.Visible ) Then
    Begin
      If (Trim(EdtObservacao.Text) = '') Then
      Begin
        MensagemDLG('Campo observação deve ser preenchido.', MtErro, MbOk);
        ColocarFoco(edtObservacao);
        Exit;
      End
    End;
    ColocarFocoNoFormChamador(FocoAnterior);
  End;

End;

Procedure TfrmCGSDocumentosTaxasDeServico.ColocarFocoNoFormChamador(Sender: TObject);
Begin
  TForm(Self.Owner).Enabled := true;
  if (Sender = FocoAnterior) and
     (FocoAnterior <> nil) then
    SetFocusComp( FocoAnterior )
  else
    SetFocusComp( FocoPosterior );
End;

procedure TfrmCGSDocumentosTaxasDeServico.gridTaxasKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    ColocarFocoNoFormChamador(FocoPosterior);
end;

procedure TfrmCGSDocumentosTaxasDeServico.Panel1Enter(Sender: TObject);
begin
  ColocarFoco(edtQtdeSolicTaxas);
end;

procedure TfrmCGSDocumentosTaxasDeServico.edtQtdeMinimaTaxasExit(Sender: TObject);
begin
  if (Sender = edtQtdeMinimaTaxas ) And
     ((GetKeyState(VK_SHIFT) and $1000000) <> 0 ) and (vTAB) Then
    ColocarFoco(edtQtdeSolicTaxas);

  if not(FocoEstaNesteForm) then
    ColocarFoco(TEdit(Sender));
end;

Procedure TfrmCGSDocumentosTaxasDeServico.cbxReferenciaTaxasExit(Sender: TObject);
Begin
  If Not(FocoEstaNesteForm) Then
    ColocarFoco(cbxReferenciaTaxas)
  Else
    HabilitaBtnAdd;
//If (Pos('%', Trim(cbxReferenciaTaxas.Text) ) > 0) Then
End;

Procedure TfrmCGSDocumentosTaxasDeServico.edtCodigoClick(Sender: TObject);
Begin
  ColocarFoco(edtCodigo);
End;

Procedure TfrmCGSDocumentosTaxasDeServico.FormHide(Sender: TObject);
Begin
  TForm(Self.Owner).Enabled := true;
End;

Procedure TfrmCGSDocumentosTaxasDeServico.actIncluirSobreExecute(Sender: TObject);
Begin
  If dmCGSDoc.vpCamposEngessados Then
    Exit;

  cbbSobre.ItemIndex := - 1;
  ActAlterarTaxa.Execute;
  IniciarEdicao(true);
  ColocarFoco(cbbSobre);
End;

Procedure TfrmCGSDocumentosTaxasDeServico.rxTaxasAfterPost(DataSet: TDataSet);
Begin
  If (FBotaoGravar <> Nil) And
     (dmCGSDoc.vpRecalcular) Then
   FBotaoGravar.Enabled := False;
end;

procedure TfrmCGSDocumentosTaxasDeServico.edtQtdeMinimaTaxasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = 27 ) then
  begin
    key := 0;
    Application.ProcessMessages;
    ColocarFoco(edtQtdeSolicTaxas);
  end;
end;

procedure TfrmCGSDocumentosTaxasDeServico.FormDestroy(Sender: TObject);
begin

  If ( pnlObservacao.Visible ) And (Trim(EdtObservacao.Text) = '') Then
  Begin
    MensagemDLG('Campo observação deve ser preenchido.', MtErro, MbOk);
    Exit;
  End;

  vNegociacaoEspecial.Free;
  vClientes.Free;
end;

procedure TfrmCGSDocumentosTaxasDeServico.FormShow(Sender: TObject);
var vcolocaemedicao : boolean;
Begin
  Try
    pnlObservacao.Visible := False;
    gridTaxas.Columns[7].Visible := vpChamada = cChamada_BaixaACT;
  Except
  End;

  try
    vcolocaemedicao := not(frmCGSDocumentosTaxasDeServico.rxTaxas.IsEmpty);
  Except
    vcolocaemedicao := not(rxTaxas.IsEmpty);
  End;

  If vcolocaemedicao Then
    IniciarEdicao(False)
  else

  If gbxGrid.Visible Then
  Begin
    dsTaxas.Enabled      := True;
    dsTaxasSobre.Enabled := True;
  End
  Else
    If Not(Self.Owner Is TPanel) or (vpChamada = cChamada_EmissaoAutomaticaCTRCporNF) Then
      ColocarFoco(edtCodigo) ;

  If vpChamada = cChamada_BaixaACT Then
  begin
   { Verifica no cadastro de param. gerais a flag "Observação obrigatória na taxa de serviço". }
    vObrigaObs := Cgs_Parametros_Resposta(dmCGSDoc.rxCabecalho.FieldByName('EMPRESA').AsInteger,
                                          dmCGSDoc.rxCabecalho.FieldByName('FILIAL' ).AsInteger,403) = 'S';
  end;

  MDConvTaxas.EmptyTable ;
  MDConvTaxas.Open ;
End;

Procedure TfrmCGSDocumentosTaxasDeServico.edtFocoEnter(Sender: TObject);
Begin
  If edtCodigo.Enabled Then
    ColocarFoco(edtCodigo) ;
End;

Procedure TfrmCGSDocumentosTaxasDeServico.Confirma2Click(Sender: TObject);
Begin

  If Trim(EdtObservacao.Text) <> '' Then
  Begin
    With dsTaxas.DataSet Do
    Begin
      Locate('CodTaxas', dsTaxas.DataSet.FieldByName('CodTaxas').AsInteger,[]);
      Edit;
      FieldByName('OBSERVACAO'   ).AsString := Trim(EdtObservacao.Text);
      Post;
    End;
  End
  Else
  Begin
    MensagemDLG('O campo de observação é obrigatório e deve ser preenchido.', MtAtencao, MbOk) ;
    ColocarFoco(EdtObservacao) ;
    Exit ;
  End;

  If gridTaxas.CanFocus Then
    gridTaxas.SetFocus;

  Try
    pnlObservacao.Visible := False ;
  Except
  End;

End;

Procedure TfrmCGSDocumentosTaxasDeServico.ObservacaoClick(Sender: TObject);
Begin
  With pnlObservacao Do
  Begin
    Left    := 10 ;
    Top     := 91 ;
    Visible := True ;
    EdtObservacao.Clear ;
    With dsTaxas.DataSet Do
    Begin
      Locate('CodTaxas', dsTaxas.DataSet.FieldByName('CodTaxas').AsInteger,[]);
      EdtObservacao.Text := FieldByName('OBSERVACAO').AsString ;
    End;
    ColocarFoco(EdtObservacao);
  End;
End;

Procedure TfrmCGSDocumentosTaxasDeServico.PopMenu1Change(Sender: TObject;Source: TMenuItem; Rebuild: Boolean);
Begin
  Observacao.Enabled := vObrigaObs;
End;

Procedure TfrmCGSDocumentosTaxasDeServico.EdtObservacaoExit(Sender: TObject);
Begin
  If ((GetKeyState(VK_SHIFT) And $1000000) <> 0) And (vTAB) or vEsc Then
  Begin
    ColocarFoco(EdtObservacao) ;
    Exit ;
  End;
End;

procedure TfrmCGSDocumentosTaxasDeServico.CriaEstrutura_CopiaRegitros;
begin
  Case vpChamada Of
    cChamada_BaixaACT :
    Begin
      (* Se for diferente de 0 e q os campos ja estao criados. *)
      If RxComparaTaxas.Fields.Count <> 0 Then
        RxComparaTaxas.Open
      Else
        RxComparaTaxas.CopyStructure(dsTaxas.DataSet); // Copia a estrutura

      If RxComparaSobre.Fields.Count <> 0 Then
        RxComparaSobre.Open
      Else
        RxComparaSobre.CopyStructure(dsTaxasSobre.DataSet); // Copia a estrutura

       { Grava os valores iniciais para posterior comparação de valores, se caso for alterado as taxas.}
    End; // End cChamada_BaixaACT...
  End; // End Case vpChamada Of
end;

procedure TfrmCGSDocumentosTaxasDeServico.AlterarFalse;
begin // SIM 13113

  dsTaxas.DataSet.Edit;
  dsTaxas.DataSet.FieldByName('ALTERAR').AsString := 'N';
  dsTaxas.DataSet.Post;

  dsTaxasSobre.DataSet.Edit;
  dsTaxasSobre.DataSet.FieldByName('ALTERAR').AsString := 'N';
  dsTaxasSobre.DataSet.Post;

end;

procedure TfrmCGSDocumentosTaxasDeServico.pnlPrincipalExit(Sender: TObject);
begin
  edtCodigo.Enabled  := True;
end;

function TfrmCGSDocumentosTaxasDeServico.VerificaParametroQtdeSolic: boolean;
var vQryParam: TQuery;
begin

  Result := True;

  If (vpChamada <> cChamada_NegociacaoEspecial) Then
    Exit;

  vQryParam := TQuery.Create(nil);
  vQryParam.DatabaseName := cDatabaseName;
  vQryParam.Close;
  vQryParam.Sql.Clear;
  vQryParam.Sql.Add('SELECT QTDESOLICNE FROM CGS_PARAM_SISTEMA');
  vQryParam.Open;
  Result := vQryParam.FieldByName('QTDESOLICNE').AsString = 'S';
  vQryParam.Free;
end;

procedure TfrmCGSDocumentosTaxasDeServico.PesquisaValorIndice(pTaxa : Integer ) ;
Var vIndice     : String ;
    QryAuxiliar : TQuery ;
begin
  If Not MDConvTaxas.Locate('CODTAXAS',pTaxa,[loCaseInsensitive]) Then
  Begin
    QryAuxiliar := TQuery.Create(Self) ;
    With QryAuxiliar do
    Begin
      DatabaseName := cDatabaseName ;
      Close ;
      Sql.Clear ;
      Sql.Add('SELECT CODINDIC') ;
      Sql.Add('  FROM CGS_CONTTIPOCONTAINER') ;
      Sql.Add(' WHERE CODTAXAS = :P_CODTAXAS') ;
      ParamByName('P_CODTAXAS').AsInteger := pTaxa ;
      AbrirQuery(QryAuxiliar,'Pesq') ;
      vIndice := FieldByName('CODINDIC').AsString ;

      If Trim(vIndice) <> '' Then
      Begin
        Sql.Clear ;
        Sql.Add('SELECT A.VLINDIC') ;
        Sql.Add('  FROM FININDVL A') ;
        Sql.Add('     , (  SELECT MAX(DTINDIC) AS DTINDIC') ;
        Sql.Add('            FROM FININDVL') ;
        Sql.Add('           WHERE CODINDIC = :P_CODINDIC') ;
        Sql.Add('        GROUP BY CODINDIC) B') ;
        Sql.Add(' WHERE A.DTINDIC  = B.DTINDIC') ;
        Sql.Add('   AND A.CODINDIC = :P_CODINDIC') ;
        ParamByName('P_CODINDIC').AsString := vIndice ;
        AbrirQuery(QryAuxiliar,'PesqIndice') ;
        MDConvTaxas.Append ;
        MDConvTaxas.FieldByName('CODTAXAS'     ).AsInteger := pTaxa ;
        MDConvTaxas.FieldByName('VALORINDICE'  ).AsFloat   := FieldByName('VLINDIC').AsFloat ;
        MDConvTaxas.Post ;
      End ; // If Trim(vIndice) <> '' Then
      Free ;
    End ; // With QryAuxiliar do
  End ; // If Not MDConvTaxas.Locate(...
end;

End.




