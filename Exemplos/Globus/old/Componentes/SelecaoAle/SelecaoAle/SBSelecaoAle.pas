
unit SBSelecaoAle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Grids,
  Buttons,StdCtrls, ExtCtrls, DBGrids, Db, RxMemDS, Menus, Wordcap,dbtables,Mask,
  dbctrls, NumEdit, ToolEdit, AboutBgmRodotec,
  {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt},
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TOperadorLogico = (olNenhum ,olAndL, olOrL, olAndR, olOrR) ;
  TTipoRetorno = (trIn, trOr) ;

  TSBSelecaoAle = class ;

  TPropriedades = class(TPersistent)
  private
    { Private declarations }
    FOwner         : TSBSelecaoAle ;
    FInicial,
    FFinal         : TCustomEdit ;
    FTitulo,
    FCabecalho,
    FCampos,
    FTabela,
    FCondicao,
    FColunaRetorno,
    FFiltroRetorno : String ;
    FTipoRetorno   : TTipoRetorno ;
    FDataBase      : TDataBase ;
    procedure SetCabecalho(const Valor: String);
    procedure SetFinal(const Valor: TCustomEdit);
    procedure SetInicial(const Valor: TCustomEdit);
    procedure SetTitulo(const Valor: String);
    Procedure SetDataBase(Const Valor: TDataBase);
    procedure SetColunaRetorno(const Valor: String);
    procedure SetCampos(const Valor: String);
    procedure SetTabela(const Valor: String);
    procedure SetCondicao(const Valor: String);
    procedure SetFiltroRetorno(const Valor: String);
    procedure SetTipoRetorno(const Value: TTipoRetorno);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TSBSelecaoAle );  virtual;
    destructor  Destroy; override;
  published
    { Published declarations }
    Property DataBaseName   : TDataBase    read FDataBase       write SetDataBase;
    Property ColunaRetorno  : String       read FColunaRetorno  write SetColunaRetorno ;
    Property Titulo         : String       read FTitulo         write SetTitulo;
    Property Cabecalho      : String       read FCabecalho      write SetCabecalho;
    Property Tabela         : String       read FTabela         write SetTabela;
    Property Condicao       : String       read FCondicao       write SetCondicao;
    Property Campos         : String       read FCampos         write SetCampos;
    Property FiltroInicial  : TCustomEdit  read FInicial        write SetInicial;
    Property FiltroFinal    : TCustomEdit  read FFinal          write SetFinal;
    Property FiltroRetorno  : String       read FFiltroRetorno  write SetFiltroRetorno;
    Property TipoRetorno    : TTipoRetorno read FTipoRetorno    write SetTipoRetorno default trIn ;
  end ; // TPropriedades = class(TPersistent)

  TSBSelecaoAle = class(TSpeedButton)
  private
    FAbout              : TAboutProperty ;
    FPropriedades       : TPropriedades ;
    FStringRetorno,
    FStringRetornoLog   : AnsiString ;
    FForm               : TForm ;
    FAbandonaExit,
    FOrdem,
    FEsc                : Boolean ;
    FColuna             : Integer ;
    FNomeCampo          : String ;
    FMDataCompara,
    FMDataDispo,
    FMDataAssoc         : TRxMemoryData ;
    FPanelGridDispo,
    FPanelGridAssoc,
    FPanelDispo,
    FPanelAssoc,
    FPanelBotoes,
    FPanelPesquisa,
    FPanelTituloPesquisa,
    FPanelTelaPesquisa  : TPanel ;
    FLblPesquisa        : TLabel ;
    FEdtPesquisa,
    FEdtFoco            : TEdit ;
    FSplitter           : TSplitter ;
    FBitBtnConfirma,
    FBitBtnFechar       : TBitBtn ;
    FDBGridDispo,
    FDBGridAssoc        : TDBGrid ;
    FDSourceDispo,
    FDSourceAssoc       : TDataSource ;
    FMainMenu           : TMainMenu ;
    FSaida              : TMenuItem ;
    FPopupMenu          : TPopupMenu ;
    FPMenuAdiciona,
    FPMenuAdicionaTodos,
    FPMenuRevoga,
    FPMenuRevogaTodos,
    FPMenuPesquisa      : TMenuItem ;
    FCampoData          : Boolean ;
    FQryPesquisa        : TQuery ;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SaidaClick(Sender: TObject);
    procedure ItemPopupMenuClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DBGridKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEnter(Sender: TObject) ;
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    Procedure DBGridOnTitleClick(Column: TColumn) ;
    procedure FEdtPesquisaExit(Sender: TObject);
    procedure FEdtPesquisaChange(Sender: TObject);
    procedure FEdtPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OrdenaEPesquisaColunas(pColuna: TColumn) ;
    procedure FSplitterMoved(Sender: TObject) ;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy; override;
    procedure   Click ; override ;
    Function    StringRetorno(pAlias : String = '' ; pOperLog : TOperadorLogico=olNenhum ) : AnsiString  ;
    Function    IgnoraSelecao : Boolean  ;
    Procedure   LimpaRetorno;
    Function    StringRetornoLog: AnsiString;
    Function    BuscaOL(pOp : String) : TOperadorLogico ;
  published
    { Published declarations }
    property About      : TAboutProperty read FAbout        write FAbout ;
    property SelecaoAle : TPropriedades  read FPropriedades write FPropriedades ;
  end ; // TSBSelecaoAle = class(TSpeedButton)

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('BGM', [TSBSelecaoAle]);
end;

Constructor TPropriedades.Create(AOwner:TSBSelecaoAle);
Begin
  { Instância }
  inherited Create ;
  FOwner := AOwner ;
End;

Destructor TPropriedades.Destroy ;
Begin
  inherited Destroy ;
End;

procedure TPropriedades.SetCabecalho(const Valor: String);
begin
  FCabecalho := Trim(Valor) ;
end;

procedure TPropriedades.SetColunaRetorno(const Valor: String);
begin
  FColunaRetorno := UpperCase(Trim(Valor)) ;
  If Trim(FFiltroRetorno) = '' Then
    SetFiltroRetorno(FColunaRetorno) ;
end;

procedure TPropriedades.SetFiltroRetorno(const Valor: String);
begin
  FFiltroRetorno := UpperCase(Trim(Valor)) ;
end;

procedure TPropriedades.SetFinal(const Valor: TCustomEdit);
begin
  FFinal := Valor ;
end;

procedure TPropriedades.SetInicial(const Valor: TCustomEdit);
begin
  FInicial := Valor ;
end;

procedure TPropriedades.SetTitulo(const Valor: String);
begin
  FTitulo := Trim(Valor) ;
end;

procedure TPropriedades.SetCondicao(const Valor: String);
begin
  FCondicao := Trim(Valor) ;
end;

procedure TPropriedades.SetCampos(const Valor: String);
begin
  FCampos := UpperCase(Trim(Valor)) ;
end;

procedure TPropriedades.SetTabela(const Valor: String);
begin
  FTabela := UpperCase(Trim(Valor)) ;
end;

constructor TSBSelecaoAle.Create(AOwner: TComponent); // override;
begin
  inherited Create(AOwner);
  FPropriedades := TPropriedades.Create(Self) ;

  FQryPesquisa := TQuery.Create(Nil) ;
  FQryPesquisa.DatabaseName := cDatabaseName ;

  Caption      := '···' ;
  Font.Style   := [fsBold] ;
  Hint         := 'Pesquisa aleatória' ;
  FPropriedades.FTitulo := 'Seleção aleatória'  ;
  ShowHint     := True ;
  Height       := 22 ;
  Width        := 23 ;

  cAboutNomeComponente := 'SBSelecaoAle' ;
  cAboutAutor          := 'Alessando A.J - 19/12/2006' ;
  cAboutVersao         := '3.0.0' ; // 1º propriedade nova ( zera o 2 e 3)
                                    // 2º Propriedades, funcões ou procedures novas ( zera o 3)
                                    // 3º controles e ajustes
end;

destructor TSBSelecaoAle.Destroy;
begin
  FPropriedades.Free ;
  FAbout.Free ;
  FQryPesquisa.Free ;
  inherited destroy ;
end;

procedure TSBSelecaoAle.Click ;
Var
  vFazFiltro : Boolean ;
Begin
  Down := True ;
  With FPropriedades do
  Begin
    If (Trim(FTabela)        <> '') And
       (Trim(FColunaRetorno) <> '') Then
    Begin
      If (TControl(FInicial) Is TDateEdit) And
         (TControl(FFinal)   Is TDateEdit) Then
        vFazFiltro := (TDateEdit(FInicial).Date <> 0) And
                      (TDateEdit(FFinal).Date   <> 0) And
                      (TDateEdit(FInicial).Date <> TDateEdit(FFinal).Date)
      Else // If (TControl(Inicial) Is TDateEdit) And (...
        vFazFiltro := (Trim(FInicial.Text) <> '') And (Trim(FInicial.Text) <> '0') And
                      (Trim(FFinal.Text)   <> '') And (Trim(FFinal.Text)   <> '0') And
                      (Trim(FInicial.Text) <> Trim(FFinal.Text)) ;

      With FQryPesquisa do
      Begin
        Close ;
        Sql.Clear ;
        Sql.Add(' SELECT ' + IIf(Trim(FCampos)='','*', FCampos) ) ;
        Sql.Add(' FROM '   + FTabela ) ;
        Sql.Add(IIf( Trim(FCondicao) <> '',' WHERE ' + FCondicao,'')) ;

        If vFazFiltro Then
        Begin
          Sql.Add(IIf( Trim(FCondicao) = '',' WHERE ',' AND ') + FColunaRetorno + ' BETWEEN :P_INICIAL AND :P_FINAL') ;

          If (TControl(FInicial) Is TDateEdit) And
             (TControl(FFinal)   Is TDateEdit) Then
          Begin
            ParamByName('P_INICIAL').AsDate   := TDateEdit(FInicial).Date ;
            ParamByName('P_FINAL'  ).AsDate   := TDateEdit(FFinal).Date ;
          End Else // If (TControl(FInicial) Is TDateEdit) And (...
          Begin
            ParamByName('P_INICIAL').AsString := FInicial.Text ;
            ParamByName('P_FINAL'  ).AsString := FFinal.Text ;
          End ; // End Else // If (TControl(FInicial) Is TDateEdit) And (...
        End ; // If vFazFiltro Then

        Try
          Open ;
        Except
          On E:EDBEngineError Do
          Begin
            ShowMessage('Erro 0: ' + IntToStr(E.Errors[0].ErrorCode) + ' / ' + E.Errors[0].Message + #13#10 +
                        'Erro 1: ' + E.Errors[1].Message) ;
          End ;
        End ; // // Try - Except

        If (Not IsEmpty) And (RecordCount >= 3) Then
        Begin
          FForm := TForm.Create(Application) ;
          With FForm do
          Begin
            Try
              // Define as propriedades e eventos do form
              KeyPreview  := True ;
              Position    := poScreenCenter ;
//              BorderIcons := [biSystemMenu,biMaximize] ;
              BorderIcons := [biSystemMenu] ;
              BorderStyle := bsSingle ;
              OnShow      := FormShow ;
              OnResize    := FormResize ;
              OnClose     := FormClose ;
              OnKeyDown   := FormKeyDown ;
              OnKeyPress  := FormKeyPress ;
              Height      := 285 ;
              Width       := 600 ;
              Caption     := vcSistema + ' - ' + FTitulo;
              ShowModal   ;
            Finally
              FForm.Release ;
              FForm := Nil ;
            End ;
          End ; // With FForm do
        End ; // If (Not IsEmpty) And (...
      End ; // FQryPesquisa
    End ; // If (Trim(FTabela) <> '') And (...
  End ; // With FPropriedades do
  Down := False ;

  { Executa evento informado pelo programador (externo) }
  Inherited ;
End;

procedure TSBSelecaoAle.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action       := Cafree ;
  FPanelDispo  := Nil ;
  FPanelAssoc  := Nil ;
  FPanelBotoes := Nil ;
  FSplitter    := Nil ;
end;

procedure TSBSelecaoAle.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState) ;
begin
  If Shift = [ssalt] Then FAbandonaExit := Key in [67,99,70,102] ; // C,c,F,f

  If (Shift = [ssCtrl]) And
     (Key In [88,120]) Then // X,x
    FForm.WindowState := IIf(FForm.WindowState = wsNormal,wsMaximized,wsNormal) ;
end;

procedure TSBSelecaoAle.FormKeyPress(Sender: TObject; var Key: Char);
begin
  FEsc          := False ;
  FAbandonaExit := False ;
  If key = #13 Then // ENTER
  Begin
    Key := #0 ;
    FForm.Perform(WM_NextDlgCtl,0,0) ;
  End ; // If key = #13 Then // ENTER

  If Key = #27 Then // ESC
  Begin
    Key  := #0 ;
    FEsc := True ;
    FForm.Perform(WM_NextDlgCtl,1,0) ;
  End ; // If Key = #27 Then // ESC
end;

procedure TSBSelecaoAle.FormShow(Sender: TObject);
  Procedure DefineGrid(pGrid : TDBGrid) ;
  Var
    i,
    vCol       : Integer ;
    vCar,
    FTituloCol : String[20] ;
  Begin
    With FPropriedades do
    Begin
      pGrid.Align        := alClient ;
      pGrid.OnDblClick   := DBGridDblClick ;
      pGrid.OnKeyPress   := DBGridKeyPress ;
      pGrid.OnEnter      := DBGridEnter ;
      pGrid.OnKeyDown    := DBGridKeyDown ;
      pGrid.OnTitleClick := DBGridOnTitleClick ;
      pGrid.PopupMenu    := FPopupMenu ;
      pGrid.Hint         := 'Utilize a barra de espaço ou o botão direito do mouse para '+ IIf(pGrid = FDBGridDispo,'adicionar','revogar') + '.' ;
      pGrid.ShowHint     := True ;
      If Trim(FCabecalho) = '' Then
        pGrid.Options := [dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection]
      Else // If Trim(FCabecalho) = '' Then
      Begin
        vCol       := 0 ;
        FTituloCol := '' ;
        FColuna    := -1 ;
        For i := 1 To Length(Trim(FCabecalho))  Do
        Begin
          vCar       := Copy(FCabecalho,i,1) ;
          FTituloCol := FTituloCol + IIf(vCar=',','',vCar) ;
          If (vCar = ',') Or (i = Length(Trim(FCabecalho))) Then
          Begin
            pGrid.Columns[vCol].Title.Caption := FTituloCol ;
            If pGrid.DataSource.DataSet.Fields[vCol].FieldName = FColunaRetorno Then
            Begin
              FOrdem  := True ;
              FColuna := vCol ;
              OrdenaEPesquisaColunas(pGrid.Columns.Items[vCol] ) ;
            End ; // If pGrid.DataSource.DataSet.Fields[vCol].FieldName = FColunaRetorno Then
            FTituloCol := '' ;
            Inc(vCol) ;
            If vCol = pGrid.DataSource.DataSet.Fields.Count Then
              Break ;
          End ; // If (vCar = ',') Or (...
        End ; // For i := 0 To Length(Trim(FCabecalho))  Do
        pGrid.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgAlwaysShowSelection] ;
      End ; // Else // If Trim(FCabecalho) = '' Then
    End ; // With FPropriedades do
  End ; // Procedure NomeDasColunas(...
begin
  // Cria menu de saida
  FMainMenu := TMainMenu.Create(FForm) ;
  FSaida         := TMenuItem.Create(FMainMenu) ;
  FSaida.Name    := 'FSaida' ;
  FSaida.Caption := '&Saída' ;
  FMainMenu.Items.Insert(0,FSaida) ;
  FMainMenu.Items[0].OnClick := SaidaClick ;

  // Cria PopMenu
  FPopupMenu := TPopupMenu.Create(FForm) ;
  // Cria item 'Adiciona' no PopMenu
  FPMenuAdiciona          := TMenuItem.Create(FPopupMenu) ;
  FPMenuAdiciona.Name     := 'FPMenuAdiciona' ;
  FPMenuAdiciona.Caption  := 'Adiciona' ;
  FPMenuAdiciona.ShortCut := 16449 ; // Ctrl + A
  FPopupMenu.Items.Insert(0,FPMenuAdiciona) ;
  FPopupMenu.Items[0].OnClick := ItemPopupMenuClick ;

  // Cria item 'Adiciona todos' no PopMenu
  FPMenuAdicionaTodos          := TMenuItem.Create(FPopupMenu) ;
  FPMenuAdicionaTodos.Name     := 'FPMenuAdicionaTodos' ;
  FPMenuAdicionaTodos.Caption  := 'Adiciona todos' ;
  FPMenuAdicionaTodos.ShortCut := 16452 ; // Ctrl + D
  FPopupMenu.Items.Insert(1,FPMenuAdicionaTodos) ;
  FPopupMenu.Items[1].OnClick := ItemPopupMenuClick ;

  // Cria item 'Revoga' no PopMenu
  FPMenuRevoga          := TMenuItem.Create(FPopupMenu) ;
  FPMenuRevoga.Name     := 'FPMenuRevoga' ;
  FPMenuRevoga.Caption  := 'Revoga' ;
  FPMenuRevoga.ShortCut := 16466 ; // Ctrl + R  ;
  FPopupMenu.Items.Insert(2,FPMenuRevoga) ;
  FPopupMenu.Items[2].OnClick := ItemPopupMenuClick ;

  // Cria item 'Revoga todos' no PopMenu
  FPMenuRevogaTodos          := TMenuItem.Create(FPopupMenu) ;
  FPMenuRevogaTodos.Name     := 'FPMenuRevogaTodos' ;
  FPMenuRevogaTodos.Caption  := 'Revoga todos' ;
  FPMenuRevogaTodos.ShortCut := 16468 ; // Ctrl + T
  FPopupMenu.Items.Insert(3,FPMenuRevogaTodos) ;
  FPopupMenu.Items[3].OnClick := ItemPopupMenuClick ;

  // Cria item 'Pesquisa pesquisa' no PopMenu
  FPMenuPesquisa          := TMenuItem.Create(FPopupMenu) ;
  FPMenuPesquisa.Name     := 'FPMenuPesquisa' ;
  FPMenuPesquisa.Caption  := 'Pesquisa' ;
  FPMenuPesquisa.ShortCut := 16464 ;
  FPopupMenu.Items.Insert(4,FPMenuPesquisa) ;
  FPopupMenu.Items[4].OnClick := ItemPopupMenuClick ;

  // Cria MemoryData e DataSource disponiveis
  FMDataDispo             := TRxMemoryData.Create(FForm) ;
  FMDataDispo.Name        := 'FMDataDispo' ;
  FDSourceDispo           := TDataSource.Create(FForm) ;
  FDSourceDispo.Name      := 'FDSourceDispo' ;
  FDSourceDispo.DataSet   := FMDataDispo ;
  FMDataDispo.LoadFromDataSet(FQryPesquisa,0,lmCopy) ;
  FCampoData := FMDataDispo.FieldByName(FPropriedades.FColunaRetorno).DataType In [ftDateTime, ftDate] ;

  // Cria MemoryData e DataSource associados
  FMDataAssoc             := TRxMemoryData.Create(FForm) ;
  FMDataAssoc.Name        := 'FMDataAssoc' ;
  FDSourceAssoc           := TDataSource.Create(FForm) ;
  FDSourceAssoc.Name      := 'FDSourceAssoc' ;
  FDSourceAssoc.DataSet   := FMDataAssoc ;
  FMDataAssoc.CopyStructure(FMDataDispo) ;
  FMDataAssoc.Open ;

  // Cria MemoryData p/ verificar se foi selecionado algum registro aleatorio
  FMDataCompara      := TRxMemoryData.Create(FForm) ;
  FMDataCompara.Name := 'FMDataCompara' ;
  FMDataCompara.LoadFromDataSet(FQryPesquisa,0,lmCopy) ;

  // Cria panel disponiveis
  FPanelDispo := TPanel.Create(FForm) ;
  With FPanelDispo do
  Begin
    Align      := alLeft ;
    BevelOuter := bvNone ;
    TabOrder   := 0 ;
    Parent     := FForm ;
    // Cria panel para o grid de itens disponiveis
    FPanelGridDispo := TPanel.Create(FPanelDispo) ;
    With FPanelGridDispo do
    Begin
      Align      := alClient ;
      BevelInner := bvLowered ;
      Parent     := FPanelDispo ;

      // Cria panel de Pesquisa
      FPanelPesquisa := TPanel.Create(FPanelDispo) ;
      With FPanelPesquisa do
      Begin
        Height     := 55 ;
        Align      := alBottom ;
        Parent     := FPanelDispo ;
        Visible    := False ;
        BevelInner := bvLowered ;

        // Cria panel para o titulo da Pesquisa
        FPanelTituloPesquisa := TPanel.Create(FPanelPesquisa) ;
        With FPanelTituloPesquisa do
        Begin
          Parent     := FPanelPesquisa ;
          Height     := 20 ;
          Align      := alTop ;
          BevelOuter := bvNone ;
          Alignment  := taLeftJustify ;
          Caption    := ' Pesquisa' ;
        End ; // With FPanelTituloPesquisa do

        // Cria panel para a tela da Pesquisa
        FPanelTelaPesquisa := TPanel.Create(FPanelPesquisa) ;
        With FPanelTelaPesquisa do
        Begin
          Parent     := FPanelPesquisa ;
          Align      := alClient ;
          BevelOuter := bvNone ;

          FLblPesquisa := TLabel.Create(FPanelTelaPesquisa) ;
          With FLblPesquisa do
          Begin
            Parent  := FPanelTelaPesquisa ;
            Left    := 4 ;
            Top     := 8 ;
            Caption := '1 Definido conforme a coluna selecionada' ;
          End ; // With FLblPesquisa do

          // Cria edit para Pesquisa
          FEdtPesquisa := TEdit.Create(FPanelTelaPesquisa) ;
          With FEdtPesquisa do
          Begin
            Parent    := FPanelTelaPesquisa ;
            Top       := FLblPesquisa.Top - 3 ;
            OnExit    := FEdtPesquisaExit ;
            OnChange  := FEdtPesquisaChange ;
            OnKeyDown := FEdtPesquisaKeyDown ;
          End ; // With FEdtPesquisa do

          FEdtFoco := TEdit.Create(FPanelTelaPesquisa) ;
          With FEdtFoco do
          Begin
            Parent    := FPanelTelaPesquisa ;
            Left      := 4 ;
            Top       := 5 ;
            Height    := 21 ;
            Width     := 0 ;
          End ; // With FEdtFoco do
        End ; // With FPanelTelaPesquisa do
      End ; // With vPanelPesquisa do

      // Cria grid de itens disponiveis
      FDBGridDispo := TDBGrid.Create(FPanelGridDispo) ;
      With FDBGridDispo do
      Begin
        Name       := 'FDBGridDispo' ;
        Parent     := FPanelGridDispo ;
        DataSource := FDSourceDispo ;
        DefineGrid(FDBGridDispo) ;
      End ; // With FDBGridDispo do
    End ; // With FPanelGridDispo do
  End ; // With FPanelDispo do

  // Cria panel associados
  FPanelAssoc := TPanel.Create(FForm) ;
  With FPanelAssoc do
  Begin
    Align      := alClient ;
    BevelOuter := bvNone ;
    TabOrder   := 2 ;
    Parent     := FForm ;
    // Cria panel para o grid de itens associados
    FPanelGridAssoc := TPanel.Create(FPanelAssoc) ;
    With FPanelGridAssoc do
    Begin
      Align      := alClient ;
      BevelInner := bvLowered ;
      Parent     := FPanelAssoc ;
      // Cria grid de itens associados
      FDBGridAssoc := TDBGrid.Create(FPanelGridAssoc) ;
      With FDBGridAssoc do
      Begin
        Name       := 'FDBGridAssoc' ;
        Parent     := FPanelGridAssoc ;
        DataSource := FDSourceAssoc ;
        DefineGrid(FDBGridAssoc) ;
      End ; // With FDBGridAssoc do
    End ; // With FPanelGridAssoc do
  End ; // With FPanelAssoc do

  // Cria splitter
  FSplitter := TSplitter.Create(FForm) ;
  With FSplitter do
  Begin
    Align   := alLeft ;
    Parent  := FForm ;
    Beveled := True ;
    Left    := FPanelDispo.Width + 1 ;
    OnMoved := FSplitterMoved ;
  End ; // With FSplitter do

  // Cria panel para os botoes
  FPanelBotoes := TPanel.Create(FForm) ;
  With FPanelBotoes do
  Begin
    Align      := alBottom ;
    BevelInner := bvLowered ;
    TabOrder   := 3 ;
    Parent     := FForm ;
    Height     := 55 ;

    // Cria botao confirma
    FBitBtnConfirma := TBitBtn.Create(FPanelBotoes) ;
    With FBitBtnConfirma do
    Begin
      Name       := 'FBitBtnConfirma' ;
      TabOrder   := 0 ;
      Height     := 30 ;
      width      := 85 ;
      Top        := 13 ;
      Parent     := FPanelBotoes ;
      Kind       := bkOK ;
      Font.size  := 8;
      Font.Style := [fsBold];
      Caption    := '&Confirma' ;
      OnClick    := SaidaClick ;
      Enabled    := False ;
    End ; // With FBitBtnConfirma do

    // Cria botao fechar
    FBitBtnFechar := TBitBtn.Create(FPanelBotoes) ;
    With FBitBtnFechar do
    Begin
      Name       := 'FBitBtnFechar' ;
      TabOrder   := 1 ;
      Height     := 30 ;
      Width      := 85 ;
      Top        := 13 ;
      Parent     := FPanelBotoes ;
      Caption    := '&Fechar' ;
      Font.Size  := 8 ;
      Font.Style := [fsBold] ;
      OnClick    := SaidaClick ;
      Try
        Glyph.LoadFromResourceName(HInstance,'FECHAR') ;
      Except
      End ; // Try - Except
    End ; // With FBitBtnFechar do
  End ; // With FPanelBotoes do

  FMDataDispo.First ;
end;

procedure TSBSelecaoAle.FormResize(Sender: TObject);
Const MinTela = 240 ;
begin
  If (FForm <> Nil) And (FPanelDispo <> Nil) Then
  Begin
    FPanelDispo.Width := Trunc(FForm.width/ 2) ;

    If FForm.Height < MinTela Then FForm.Height := MinTela ;
    If FForm.Width  < MinTela Then FForm.Width  := MinTela ;

    PosicionaBotoes(FPanelBotoes) ;
    FSplitterMoved(Sender) ;
  End ; // If (FForm <> Nil) And (...
end;

procedure TSBSelecaoAle.FSplitterMoved(Sender: TObject);
begin
  If FPanelDispo.Width < 70 Then FPanelDispo.Width := 70 ;
  If FPanelAssoc.Width < 70 Then FPanelDispo.Width := FPanelDispo.Width - 10 ;

  If FPanelPesquisa.Visible Then // Se estiver visible redimenciona
  Begin
    FEdtPesquisa.Left  := FLblPesquisa.Left + FLblPesquisa.Width + 3 ;
    FEdtPesquisa.Width := FPanelTelaPesquisa.Width - FEdtPesquisa.Left - 4 ;
  End ; // If FPanelPesquisa.Visible Then
end;

procedure TSBSelecaoAle.SaidaClick(Sender: TObject);
Var
  vCampo,
  vCampoRetono     : String ;
  vAchouSelecaoAle : Boolean ;
  Function StrZero( nNum : Real;iTam : Byte;iPrec : Byte = 0): String;
  Var I    : Byte ;
      sAux : String ;
  Begin
    Str( nNum:iTam:iPrec, sAux ) ;
    I := 1 ;
    While sAux[I] = ' ' Do
    Begin
      sAux[I] := '0' ;
      Inc( I ) ;
    End ; // While sAux[I] = ' ' Do
    Result := sAux ;
  End ; // Function StrZero(...
begin
  With FPropriedades do
  Begin
    FAbandonaExit  := True ;
    FStringRetorno := '' ;
    FStringRetornoLog := '' ;
    If TComponent(Sender) = FBitBtnConfirma Then
    Begin
      vCampo := '' ;
      FMDataAssoc.DisableControls ;
      FMDataAssoc.SortOnFields(FColunaRetorno) ;
      FMDataAssoc.First ;

      FMDataCompara.SortOnFields(FColunaRetorno) ;
      FMDataCompara.First ;
      // Posiciona no registro da memory principal conforme o 1º registro da memory selecionada
      If FMDataAssoc.FieldByName(FColunaRetorno).DataType In [ftDateTime, ftDate] Then
        FMDataCompara.Locate(FColunaRetorno,FMDataAssoc.FieldByName(FColunaRetorno).DataType,[LocaseInsensitive])
      Else
        FMDataCompara.Locate(FColunaRetorno,FMDataAssoc.FieldByName(FColunaRetorno).AsString,[LocaseInsensitive]) ;

      vCampoRetono := IIf(Trim(FFiltroRetorno)='',FColunaRetorno,FFiltroRetorno) ;

      If TControl(FInicial) Is TEdit Then
        TEdit(FInicial).Text      := FMDataAssoc.FieldByName(vCampoRetono).AsString
      Else
      If TControl(FInicial) Is TMaskEdit Then
        TMaskEdit(FInicial).Text  := FMDataAssoc.FieldByName(vCampoRetono).AsString
      Else
      If TControl(FInicial) Is TDateEdit Then
        TDateEdit(FInicial).Date  := FMDataAssoc.FieldByName(vCampoRetono).AsDateTime
      Else
      If TControl(FInicial) Is TNumEdit Then
        TNumEdit(FInicial).Value  := FMDataAssoc.FieldByName(vCampoRetono).AsInteger ;

      vAchouSelecaoAle := False ;
      While Not FMDataAssoc.Eof do
      Begin
        If FMDataAssoc.FieldByName(FColunaRetorno).DataType In [ftDateTime, ftDate] Then
          vCampo := QuotedStr(FormatDateTime('dd/mm/yyyy',FMDataAssoc.FieldByName(FColunaRetorno).AsDateTime))
        Else
        If FMDataAssoc.FieldByName(FColunaRetorno).DataType In [ftString] Then
          vCampo := QuotedStr(FMDataAssoc.FieldByName(FColunaRetorno).AsString)
        Else
        If FMDataAssoc.FieldByName(FColunaRetorno).DataType In [ftFloat] Then
          vCampo := FMDataAssoc.FieldByName(FColunaRetorno).AsString  ;

        // Verifica se os registro estao andando juntos (Quando fcar diferente é q existe selecao aleatoria)
        If FMDataAssoc.FieldByName(FColunaRetorno).AsString <> FMDataCompara.FieldByName(FColunaRetorno).AsString Then
          vAchouSelecaoAle := True ;

        FMDataAssoc.Next ;
        FMDataCompara.Next ;
        If FPropriedades.FTipoRetorno = trOr Then
          FStringRetorno  := FStringRetorno + ' _#_CAMPO_#_ = ' + vCampo + IIf(FMDataAssoc.Eof,'',' OR ')
        Else
          FStringRetorno  := FStringRetorno + vCampo + IIf(FMDataAssoc.Eof,'',',') ;

        FStringRetornoLog := FStringRetornoLog + StringReplace(vCampo, Chr(39),'', [rfReplaceAll]) + IIf(FMDataAssoc.Eof,'',',') ;
      End ; // While Not FMDataAssoc.Eof do

      FMDataAssoc.Last ; // Retorna p/ o ultimo registro
      If TControl(FFinal) Is TEdit Then
        TEdit(FFinal).Text      := FMDataAssoc.FieldByName(vCampoRetono).AsString
      Else
      If TControl(FFinal) Is TMaskEdit Then
        TMaskEdit(FFinal).Text  := FMDataAssoc.FieldByName(vCampoRetono).AsString
      Else
      If TControl(FFinal) Is TDateEdit Then
        TDateEdit(FFinal).Date  := FMDataAssoc.FieldByName(vCampoRetono).AsDateTime
      Else
      If TControl(FFinal) Is TNumEdit Then
        TNumEdit(FFinal).Value  := FMDataAssoc.FieldByName(vCampoRetono).AsInteger ;

      // Se ñ achou selecao ale limpa retorno
      If Not vAchouSelecaoAle Then
        FStringRetorno := '' ;

      FMDataAssoc.EnableControls ;
    End ; // If TComponent(Sender) = FBitBtnConfirma Then
    FForm.Close ;
  End ; // With FPropriedades do
end;

function TSBSelecaoAle.StringRetorno(pAlias : String = '' ; pOperLog : TOperadorLogico=olNenhum ) : AnsiString  ;
Var
  vColunaRetono : String ;
begin
  Result := '' ;
  If Not IgnoraSelecao Then
  Begin

    vColunaRetono  := IIf(FCampoData,'TO_CHAR(','')                                   + ' ' +
                      IIf(Trim(pAlias)='','',pAlias + '.') + FPropriedades.FColunaRetorno + ' ' +
                      IIf(FCampoData, QuotedStr('DD/MM/YYYY') + ')','') ;

    Result := ' ' + IIf(pOperLog=olAndL,'AND',IIf(pOperLog=olOrL,'OR','')) +
              ' ' + IIf(FPropriedades.FTipoRetorno = trOr,'( ' + StringReplace(FStringRetorno,'_#_CAMPO_#_',vColunaRetono, [rfReplaceAll])
                                                         ,vColunaRetono + ' IN ( ' + FStringRetorno ) +
              ' )' +
              ' ' + IIf(pOperLog=olAndR,'AND',IIf(pOperLog=olOrR,'OR','')) ;
  End ; // If Not IgnoraSelecao Then
end;

function TSBSelecaoAle.IgnoraSelecao: Boolean;
begin
  Result := Trim(FStringRetorno) = '' ;
end;

procedure TSBSelecaoAle.OrdenaEPesquisaColunas(pColuna: TColumn) ;
Var
  i      : Integer ;
  vGrid  : TCustomDBGrid ;
  vPanel : TPanel ;
  vImage : TImage ;
  Procedure DesenhaSetas(pDecrescente : Boolean) ;
  Var
    Lin,Col,Ini,Fin : Integer ;
  Begin
    // Verifica se o componenet PanelSeta ja existe
    If vGrid.FindComponent('PanelSeta') = Nil Then
    Begin
      vPanel := TPanel.Create(vGrid) ;
      vPanel.Parent  := vGrid ;
      vPanel.Name    := 'PanelSeta' ;
      vPanel.Left    := 0 ;
      vPanel.Top     := 0 ;
      vPanel.Height  := 17 ;
      vPanel.Width   := 11 ;
      vPanel.Caption := '' ;

      vImage := TImage.Create(vPanel) ;
      vImage.Name        := 'ImageSeta' ;
      vImage.Parent      := vPanel ;
      vImage.Align       := alClient ;
      vImage.Transparent := True ;
    End Else // If vGrid.FindComponent('PanelSeta') = Nil Then
    Begin // Caso existe atribui o valor na variavel
      vPanel := TPanel(vGrid.FindComponent( 'PanelSeta')) ;
      vImage := TImage(vPanel.FindComponent('ImageSeta')) ;
    End ; // End Else

    // Limpa o componente image
    vImage.Canvas.Brush.color := clMenu ;
    vImage.Canvas.Rectangle(0,0,vImage.Width,vImage.Height) ;

    Ini := IIf(pDecrescente,4,0) ;
    Fin := IIf(pDecrescente,3,7) ;
    For Lin := 5 to 9 do
    Begin
      For Col := Ini to Fin do // Desenha seta
        vImage.Canvas.Pixels[ Col , Lin] := clBlue ;

      Ini := IIf(pDecrescente, Ini - 1, Ini + 1 ) ;
      Fin := IIf(pDecrescente, Fin + 1, Fin - 1 ) ;
    End ; // For Lin := 8 to 12 do
    vImage.Hint := IIf(pDecrescente,'Decrescente','Crescente') ;
  End ; // Procedure DesenhaSetas(pTipo : String) ;
Begin
  vGrid := pColuna.Grid ;

  If TDBGrid(vGrid).DataSource.DataSet.RecordCount <= 1 Then Exit ;

  FOrdem  := (FColuna = pColuna.Index) And (Not FOrdem);
  FColuna := pColuna.Index ;
  For i := 0 to TDBGrid(vGrid).Columns.Count-1 do
    TDBGrid(vGrid).Columns[i].Title.Font.Color := ClBlack ;

  TDBGrid(vGrid).Columns[pColuna.Index].Title.Font.Color := ClBlue ;
  TRxMemoryData(TDBGrid(vGrid).DataSource.DataSet).SortOnFields(pColuna.FieldName,True,FOrdem) ;
  FNomeCampo           := TDBGrid(vGrid).Columns[pColuna.Index].FieldName ;
  FLblPesquisa.Caption := TDBGrid(vGrid).Columns[pColuna.Index].Title.Caption ;

  // So desenha a seta se o dgIndicator estiver true
  If dgIndicator In TDBGrid(vGrid).Options Then
    DesenhaSetas(FOrdem) ;
End;

procedure TSBSelecaoAle.ItemPopupMenuClick(Sender: TObject);
  Procedure MudaRegistros(pMD1, pMD2 : TRxMemoryData ) ;
  Var
    vTodos : Boolean ;
  Begin
    If pMD1.Eof Then pMD1.Prior
    Else
    If pMD1.Bof Then pMD1.First ;

    vTodos := Pos('Todos',TMenuItem(Sender).Name) > 0 ;

    pMD2.LoadFromDataSet(pMD1,IIf(vTodos,0,1),lmAppend) ;

    If vTodos Then
    Begin
      pMD1.Close ;
      pMD1.Open ;
    End Else // If vTodos Then
      pMD1.Delete
  End ; // Procedure MudaRegistros(pMD1, pMD2 : TRxMemoryData ) ;
begin
  If Not TMenuItem(Sender).Visible Then Exit ;

  If TMenuItem(Sender) = FPMenuPesquisa Then
  Begin
    FPanelPesquisa.Visible := True ;
    If FDBGridDispo.Focused Then
      FPanelPesquisa.Parent := FPanelDispo
    Else
      FPanelPesquisa.Parent := FPanelAssoc ;

    FEdtPesquisa.Clear ;
    FEdtPesquisa.SetFocus ;
    FSplitterMoved(Sender) ; // P/ Atualizar o tamanho do campo
    FBitBtnConfirma.Enabled := False ;
  End Else // If TMenuItem(Sender) = FPMenuPesquisa Then
  Begin
    If Pos('Adiciona',TMenuItem(Sender).Name) > 0 Then
    Begin
      MudaRegistros(FMDataDispo, FMDataAssoc) ;
      DBGridEnter(FDBGridDispo) ;
    End Else
    Begin
      MudaRegistros(FMDataAssoc, FMDataDispo) ;
      DBGridEnter(FDBGridAssoc) ;
    End ;
  End ; // End Else // If TMenuItem(Sender) = FPMenuPesquisa Then
end;

procedure TSBSelecaoAle.DBGridEnter(Sender: TObject);
Var
  i : Integer;
begin
  FPMenuAdiciona.Visible      := (TDBGrid(Sender) = FDBGridDispo) And (FMDataDispo.RecordCount <> 1) And IIf(FPropriedades.FTipoRetorno = trOr,True,(FMDataAssoc.RecordCount < 1000)) ;
  FPMenuAdicionaTodos.Visible := (FPropriedades.FTipoRetorno = trOr) And FPMenuAdiciona.Visible ;
  FPMenuRevoga.Visible        := (TDBGrid(Sender) = FDBGridAssoc) And (FMDataAssoc.RecordCount <> 0) ;
  FPMenuRevogaTodos.Visible   := FPMenuRevoga.Visible ;

  FNomeCampo := '' ;
  For I := 0 to TDBGrid(Sender).Columns.Count-1 do
    If TDBGrid(Sender).Columns[I].Title.Font.Color = ClBlue then
    Begin
      FNomeCampo           := TDBGrid(Sender).Columns[I].FieldName ;
      FLblPesquisa.Caption := TDBGrid(Sender).Columns[I].Title.Caption ;
    End ; // If TDBGrid(Sender).Columns[I].Title.Font.Color = ClBlue then

  FPMenuPesquisa.Visible    := (Trim(FNomeCampo) <> '') And
                               ((TDBGrid(Sender) = FDBGridDispo) And (FMDataDispo.RecordCount > 1) Or
                                (TDBGrid(Sender) = FDBGridAssoc) And (FMDataAssoc.RecordCount > 1)) ;
  FBitBtnConfirma.Enabled   := (FMDataAssoc.RecordCount > 1) And (FMDataDispo.RecordCount <> 0) ;
end;

procedure TSBSelecaoAle.DBGridDblClick(Sender: TObject);
begin
  If TDBGrid(Sender) = FDBGridDispo Then
    ItemPopupMenuClick(FPMenuAdiciona)
  Else
    ItemPopupMenuClick(FPMenuRevoga) ;
end;

procedure TSBSelecaoAle.DBGridKeyPress(Sender: TObject; var Key: Char);
begin
  If Key <> #32 Then Exit ;  // Tecla ESPACO

  DBGridDblClick(Sender) ;
end;

procedure TSBSelecaoAle.DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If (Shift = [ssCtrl]) And
     (Key In [37,39]) Then  // Ctrl + Setas (Esquerda, Direita)
  Begin
    Case Key Of
      37 : If FColuna-1 <= 0                               Then FColuna := 0                               Else Dec(FColuna) ;
      39 : If FColuna+1 >= TDBGrid(Sender).Columns.Count-1 Then FColuna := TDBGrid(Sender).Columns.Count-1 Else Inc(FColuna) ;
    End ; // Case Key Of

    DBGridEnter(Sender) ;
    FOrdem := False ;
    OrdenaEPesquisaColunas(TDBGrid(Sender).Columns.Items[FColuna]) ;
  End ; // If (Shift = [ssCtrl]) And (...
end;

procedure TSBSelecaoAle.DBGridOnTitleClick(Column: TColumn);
begin
  OrdenaEPesquisaColunas(Column) ;
  If Column.Grid = FDBGridDispo Then
    DBGridEnter(FDBGridDispo)
  Else // If Column.Grid = FDBGridDispo Then
    DBGridEnter(FDBGridAssoc) ;
end;

procedure TSBSelecaoAle.FEdtPesquisaExit(Sender: TObject);
begin
  FPanelPesquisa.Visible := False ;
  If (FEsc) Or
     (FAbandonaExit) Or
     (FDBGridDispo.FocuSed)    Or
     (FDBGridAssoc.FocuSed)    Or
     (FBitBtnConfirma.FocuSed) Or
     (FBitBtnFechar.FocuSed)   Then
  Begin
    FEsc := False ;
    Exit ;
  End ; // If (FEsc) Or (...

  If FPanelPesquisa.Parent = FPanelDispo Then
    FDBGridDispo.SetFocus
  Else // If FPanelPesquisa.Parent = FPanelDispo Then
    FDBGridAssoc.SetFocus ;
end;

procedure TSBSelecaoAle.FEdtPesquisaChange(Sender: TObject);
begin
  If Trim(FEdtPesquisa.Text) = '' Then Exit ;

  Try
    If FPanelPesquisa.Parent = FPanelDispo Then
      Try
        DateTimeToStr(FMDataDispo.FieldByName(FNomeCampo).AsDateTime) ;
        FMDataDispo.Locate(FNomeCampo,StrToDate(FEdtPesquisa.Text),[loPartialKey,loCaseInsensitive])
      Except
        FMDataDispo.Locate(FNomeCampo,FEdtPesquisa.Text,[loPartialKey,loCaseInsensitive]) ;
      End  // Try - Except
    Else // If FPanelPesquisa.Parent = FPanelDispo Then
      Try
        DateTimeToStr(FMDataAssoc.FieldByName(FNomeCampo).AsDateTime) ;
        FMDataAssoc.Locate(FNomeCampo,StrToDate(FEdtPesquisa.Text),[loPartialKey,loCaseInsensitive]) ;
      Except
        FMDataAssoc.Locate(FNomeCampo,Trim(FEdtPesquisa.Text),[loPartialKey,loCaseInsensitive]) ;
      End ; // Try - Except
  Except
  End ;  // Try - Except
end;

procedure TSBSelecaoAle.FEdtPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  Procedure NavegaNoGrid(pMD : TRxMemoryData) ;
  Begin
    With pMD do
    Begin
      If IsEmpty Then Exit ;

      If Not Bof Then
        Case Key Of
          38 : Prior ;                                             // Seta para cima (Volta um registro)
          33 : If RecNo-10 < 0 Then First Else RecNo := RecNo-10 ; // Page Up        (Volta 10 registros)
          36 : If Shift=[ssCtrl] Then First ;                      // Ctrl + Home    (Volta p/ o inicio)
        End ; // Case Key Of

      If Not Eof Then
        Case Key Of
          40 : Next ;                                                         // Seta para baixo (Vai p/ o proximo registro)
          34 : If RecNo+10 > RecordCount Then Last Else RecNo := RecNo + 10 ; // Page Down       (Pula 10 registros)
          35 : If Shift=[ssCtrl] Then Last ;                                  // Ctrl + End      (Vai p/ o fim)
        End ; // Case Key Of

      If Shift = [ssCtrl] Then
        Case Key Of
          65,97  : If FPanelPesquisa.Parent = FPanelDispo Then ItemPopupMenuClick(FPMenuAdiciona) ;    // A,a (Adiciona)
          82,114 : If FPanelPesquisa.Parent = FPanelAssoc Then ItemPopupMenuClick(FPMenuRevoga) ;      // R,r (Revoga)
          84,116 : If FPanelPesquisa.Parent = FPanelAssoc Then ItemPopupMenuClick(FPMenuRevogaTodos) ; // T,t (Revoga todos)
        End ; // Case Key Of
    End ; // With pMD do
  End ; // Procedure NavegaNoGrid(pMD : TRxMemoryData ) ;
begin
  If FPanelPesquisa.Parent = FPanelDispo Then
    NavegaNoGrid(FMDataDispo)
  Else
    NavegaNoGrid(FMDataAssoc) ;
end;

procedure TSBSelecaoAle.LimpaRetorno;
begin
  FStringRetorno := '';
end;

function TSBSelecaoAle.StringRetornoLog: AnsiString;
begin
  Result := FStringRetornoLog;
end;

function TSBSelecaoAle.BuscaOL(pOp: String): TOperadorLogico;
begin
       If pOp = 'AL' Then
    Result := olAndL
  Else If pOp = 'AR' Then
    Result := olAndR
  Else If pOp = 'OL' Then
    Result := olOrL
  Else If pOp = 'Or' Then
    Result := olOrR
  Else
    Result := olNenhum ;
end;

procedure TPropriedades.SetTipoRetorno(const Value: TTipoRetorno);
begin
  FTipoRetorno := Value ;
end;

procedure TPropriedades.SetDataBase(const Valor: TDataBase);
begin
  FDataBase := Valor ;
end;


end.


