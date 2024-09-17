unit SBSelecaoAle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Grids,
  Buttons,StdCtrls, ExtCtrls, DBGrids, Db, RxMemDS, Menus, Wordcap,dbtables,Mask,
  dbctrls, NumEdit, ToolEdit ;

type
  TOperadorLogico = (olNenhum ,olAndL, olOrL, olAndR, olOrR) ;
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
    FDataBase      : TDataBase ;
    FQryPesquisa   : TQuery ;
    procedure pCabecalho(const Valor: String);
    procedure pFinal(const Valor: TCustomEdit);
    procedure pInicial(const Valor: TCustomEdit);
    procedure pTitulo(const Valor: String);
    Procedure pDataBase(Const Valor: TDataBase);
    procedure pColunaRetorno(const Valor: String);
    procedure pCampos(const Valor: String);
    procedure pTabela(const Valor: String);
    procedure pCondicao(const Valor: String);
    procedure pFiltroRetorno(const Valor: String);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TSBSelecaoAle );  virtual;
    destructor  Destroy; override;
  published
    { Published declarations }
    Property DataBaseName  : TDataBase      read FDataBase      write pDataBase;
    Property ColunaRetorno : String         read FColunaRetorno write pColunaRetorno ;
    Property Titulo        : String         read FTitulo        write pTitulo;
    Property Cabecalho     : String         read FCabecalho     write pCabecalho;
    Property Tabela        : String         read FTabela        write pTabela;
    Property Condicao      : String         read FCondicao      write pCondicao;
    Property Campos        : String         read FCampos        write pCampos;
    Property FiltroInicial : TCustomEdit    read FInicial       write pInicial;
    Property FiltroFinal   : TCustomEdit    read FFinal         write pFinal;
    Property FiltroRetorno : String         read FFiltroRetorno write pFiltroRetorno;
  end ; // TPropriedades = class(TPersistent)

  TSBSelecaoAle = class(TSpeedButton)
  private
    FPropriedades       : TPropriedades ;
    FStringRetorno      : AnsiString ;
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
    FPMenuRevoga,
    FPMenuRevogaTodos,
    FPMenuPesquisa      : TMenuItem ;
    MSOfficeCaption1    : TMSOfficeCaption ;
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
    procedure OrdenaColunas(pColuna: TColumn) ;
    Procedure PosicionaBotoes ;
    Function  IIf(pCondicao: Boolean; pResultTrue, pResultFalse: Variant) : Variant ;
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
  published
    { Published declarations }
    property SelecaoAle : TPropriedades read FPropriedades write FPropriedades ;
  end ; // TSBSelecaoAle = class(TSpeedButton)

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Botoes', [TSBSelecaoAle]);
end;

Constructor TPropriedades.Create(AOwner:TSBSelecaoAle);
Begin
  { Instância }
  inherited Create ;
  FQryPesquisa := TQuery.Create(Nil) ;
  FOwner       := AOwner ;
End;

Destructor TPropriedades.Destroy ;
Begin
  FQryPesquisa.Free ;
  inherited Destroy ;
End;

procedure TPropriedades.pCabecalho(const Valor: String);
begin
  FCabecalho := Trim(Valor) ;
end;

Procedure TPropriedades.pDataBase(Const Valor: TDataBase);
Begin
  FDataBase := Valor ;
End;

procedure TPropriedades.pColunaRetorno(const Valor: String);
begin
  FColunaRetorno := UpperCase(Trim(Valor)) ;
  If Trim(FFiltroRetorno) = '' Then
    pFiltroRetorno(FColunaRetorno) ;
end;

procedure TPropriedades.pFiltroRetorno(const Valor: String);
begin
  FFiltroRetorno := UpperCase(Trim(Valor)) ;
end;

procedure TPropriedades.pFinal(const Valor: TCustomEdit);
begin
  FFinal := Valor ;
end;

procedure TPropriedades.pInicial(const Valor: TCustomEdit);
begin
  FInicial := Valor ;
end;

procedure TPropriedades.pTitulo(const Valor: String);
begin
  FTitulo := Trim(Valor) ;
end;

procedure TPropriedades.pCondicao(const Valor: String);
begin
  FCondicao := Trim(Valor) ;
end;

procedure TPropriedades.pCampos(const Valor: String);
begin
  FCampos := UpperCase(Trim(Valor)) ;
end;

procedure TPropriedades.pTabela(const Valor: String);
begin
  FTabela := UpperCase(Trim(Valor)) ;
end;

constructor TSBSelecaoAle.Create(AOwner: TComponent); // override;
begin
  inherited Create(AOwner);
  FPropriedades := TPropriedades.Create(Self) ;
  Caption      := '···' ; 
  Font.Style   := [fsBold] ;
  Hint         := 'Pesquisa aleatória' ;
  FPropriedades.Titulo := 'Seleção aleatória' ;
  ShowHint     := True ;
  Height       := 22 ;
  Width        := 23 ;
end;

destructor TSBSelecaoAle.Destroy;
begin
  FPropriedades.Free ;
  inherited destroy ;
end;

procedure TSBSelecaoAle.Click ;
Var
  vFiltroData : Boolean ;
Begin
  Down := True ;
  With FPropriedades do
  Begin

    Try
      vFiltroData := ((Trim(FInicial.Text) = '/  /') And (Trim(FFinal.Text) = '/  /')) Or ((Trim(DateToStr(StrToDate(FInicial.Text))) <> '') Or (Trim(DateToStr(StrToDate(FFinal.Text))) <> '')) ;
    Except
      vFiltroData := False ;
    End ; // Try - Except

    If (Trim(FTabela)        <> '') And
       (Trim(FColunaRetorno) <> '') And
       ((((Not vFiltroData) And (Trim(FInicial.Text) = '')     And (Trim(FFinal.Text) = '')) Or
         ((    vFiltroData) And (Trim(FInicial.Text) = '/  /') And (Trim(FFinal.Text) = '/  /')
          )) Or (Trim(FInicial.Text) <> Trim(FFinal.Text))) Then
    Begin
      With FQryPesquisa do
      Begin
        Try
          DatabaseName := FPropriedades.DataBaseName.Name ;
        Except
          Begin
            Down := False ;
            Inherited ; // P/ executar o om exit digitado
            Exit ;
          End ;
        End ; // Try - Except

        Close ;
        Sql.Clear ;
        Sql.Add(' SELECT ' + IIf(Trim(FCampos)='','*', FCampos) ) ;
        Sql.Add(' FROM '   + FTabela ) ;
        Sql.Add(IIf( Trim(FCondicao) <> '',' WHERE ' + FCondicao,'')) ; 

        If (Not vFiltroData And ((Trim(FInicial.Text) <> '')     And (Trim(FFinal.Text) <> '')))     Or
           (    vFiltroData And ((Trim(FInicial.Text) <> '/  /') And (Trim(FFinal.Text) <> '/  /'))) Then
        Begin
          Sql.Add(IIf( Trim(FCondicao) = '',' WHERE ',' AND ') + FColunaRetorno + ' BETWEEN :P_INICIAL AND :P_FINAL') ;

          If vFiltroData Then
          Begin
            ParamByName('P_INICIAL').AsDate   := StrToDate(FInicial.Text) ;
            ParamByName('P_FINAL'  ).AsDate   := StrToDate(FFinal.Text) ;
          End Else // If vFiltroData Then
          Begin
            ParamByName('P_INICIAL').AsString := FInicial.Text ;
            ParamByName('P_FINAL'  ).AsString := FFinal.Text ;
          End ; // End Else // If vFiltroData Then
        End ; // If (Not vFiltroData And (...
        
        Try
          Open ;
        Except
          On E:EDBEngineError Do
          Begin
            ShowMessage('Erro 0: ' + IntToStr(E.Errors[0].ErrorCode) + ' / ' + E.Errors[0].Message + #13#10 +
                        'Erro 1: ' + E.Errors[1].Message) ;
          End ;
        End ; // // Try - Except

        If (Not IsEmpty) And (FQryPesquisa.RecordCount >= 3) Then
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
      pGrid.Hint         := 'Utilize a barra de espaço ou o botão direito do mouse para '+ IIf(pGrid.Name= 'FDBGridDispo','adicionar','revogar') + '.' ;
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
              OrdenaColunas(pGrid.Columns.Items[vCol] ) ;
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

  // Cria item 'Revoga' no PopMenu
  FPMenuRevoga          := TMenuItem.Create(FPopupMenu) ;
  FPMenuRevoga.Name     := 'FPMenuRevoga' ;
  FPMenuRevoga.Caption  := 'Revoga' ;
  FPMenuRevoga.ShortCut := 16466 ; // Ctrl + R  ;
  FPopupMenu.Items.Insert(1,FPMenuRevoga) ;
  FPopupMenu.Items[1].OnClick := ItemPopupMenuClick ;

  // Cria item 'Revoga todos' no PopMenu
  FPMenuRevogaTodos          := TMenuItem.Create(FPopupMenu) ;
  FPMenuRevogaTodos.Name     := 'FPMenuRevogaTodos' ;
  FPMenuRevogaTodos.Caption  := 'Revoga todos' ;
  FPMenuRevogaTodos.ShortCut := 16468 ; // Ctrl + T
  FPopupMenu.Items.Insert(2,FPMenuRevogaTodos) ;
  FPopupMenu.Items[2].OnClick := ItemPopupMenuClick ;

  // Cria item 'Pesquisa pesquisa' no PopMenu
  FPMenuPesquisa          := TMenuItem.Create(FPopupMenu) ;
  FPMenuPesquisa.Name     := 'FPMenuPesquisa' ;
  FPMenuPesquisa.Caption  := 'Pesquisa' ;
  FPMenuPesquisa.ShortCut := 16464 ;
  FPopupMenu.Items.Insert(3,FPMenuPesquisa) ;
  FPopupMenu.Items[3].OnClick := ItemPopupMenuClick ;

  // Cria MemoryData e DataSource disponiveis
  FMDataDispo             := TRxMemoryData.Create(Nil) ;
  FMDataDispo.Name        := 'FMDataDispo' ;
  FDSourceDispo           := TDataSource.Create(Nil) ;
  FDSourceDispo.Name      := 'FDSourceDispo' ;
  FDSourceDispo.DataSet   := FMDataDispo ;
  FMDataDispo.LoadFromDataSet(FPropriedades.FQryPesquisa,0,lmCopy) ;

  // Cria MemoryData e DataSource associados
  FMDataAssoc             := TRxMemoryData.Create(Nil) ;
  FMDataAssoc.Name        := 'FMDataAssoc' ;
  FDSourceAssoc           := TDataSource.Create(Nil) ;
  FDSourceAssoc.Name      := 'FDSourceAssoc' ;
  FDSourceAssoc.DataSet   := FMDataAssoc ;
  FMDataAssoc.CopyStructure(FMDataDispo) ;
  FMDataAssoc.Open ;

  // Cria MemoryData p/ verificar se foi selecionado algum registro aleatorio
  FMDataCompara      := TRxMemoryData.Create(Nil) ;
  FMDataCompara.Name := 'FMDataCompara' ;
  FMDataCompara.LoadFromDataSet(FPropriedades.FQryPesquisa,0,lmCopy) ;

  // Cria MSOfficeCaption
  MSOfficeCaption1 := TMSOfficeCaption.Create(FForm) ;
  MSOfficeCaption1.CaptionText.Caption := FPropriedades.FTitulo ;

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
          Color      := MSOfficeCaption1.Color ;
          Font.Color := MSOfficeCaption1.CaptionText.ColorActive ;
          Font.Style := MSOfficeCaption1.CaptionText.Font.Style ;
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

    PosicionaBotoes ;
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
    If TComponent(Sender).Name = 'FBitBtnConfirma' Then
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

      If TControl(FiltroInicial) Is TEdit Then
        TEdit(FiltroInicial).Text      := FMDataAssoc.FieldByName(vCampoRetono).AsString
      Else
      If TControl(FiltroInicial) Is TMaskEdit Then
        TMaskEdit(FiltroInicial).Text  := FMDataAssoc.FieldByName(vCampoRetono).AsString
      Else
      If TControl(FiltroInicial) Is TDateEdit Then
        TDateEdit(FiltroInicial).Date  := FMDataAssoc.FieldByName(vCampoRetono).AsDateTime
      Else
      If TControl(FiltroInicial) Is TNumEdit Then
        TNumEdit(FiltroInicial).Value  := FMDataAssoc.FieldByName(vCampoRetono).AsInteger ;

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

        FStringRetorno := FStringRetorno + vCampo + IIf(FMDataAssoc.Eof,'',',') ;
      End ; // While Not FMDataAssoc.Eof do

      FMDataAssoc.Last ; // Retorna p/ o ultimo registro
      If TControl(FiltroFinal) Is TEdit Then
        TEdit(FiltroFinal).Text      := FMDataAssoc.FieldByName(vCampoRetono).AsString
      Else
      If TControl(FiltroFinal) Is TMaskEdit Then
        TMaskEdit(FiltroFinal).Text  := FMDataAssoc.FieldByName(vCampoRetono).AsString
      Else
      If TControl(FiltroFinal) Is TDateEdit Then
        TDateEdit(FiltroFinal).Date  := FMDataAssoc.FieldByName(vCampoRetono).AsDateTime
      Else
      If TControl(FiltroFinal) Is TNumEdit Then
        TNumEdit(FiltroFinal).Value  := FMDataAssoc.FieldByName(vCampoRetono).AsInteger ;

      // Se ñ achou selecao ale limpa retorno  
      If Not vAchouSelecaoAle Then
        FStringRetorno := '' ;

      FMDataAssoc.EnableControls ;
    End ; // If TComponent(Sender).Name = 'FBitBtnConfirma' Then
    FForm.Close ;
  End ; // With FPropriedades do
end;

function TSBSelecaoAle.StringRetorno(pAlias : String = '' ; pOperLog : TOperadorLogico=olNenhum ) : AnsiString  ;
Var
  vCampoRetEData : Boolean ;
begin
  Result := '' ;
  If Not IgnoraSelecao Then
  Begin
    vCampoRetEData := FMDataAssoc.FieldByName(FPropriedades.FColunaRetorno).DataType In [ftDateTime, ftDate] ;
    Result := ' ' + IIf(pOperLog=olAndL,'AND',IIf(pOperLog=olOrL,'OR','')) +
              ' ' + IIf(vCampoRetEData,'TO_CHAR(','') +
              ' ' + IIf(Trim(pAlias)='','',pAlias + '.') + FPropriedades.FColunaRetorno +
              ' ' + IIf(vCampoRetEData, QuotedStr('DD/MM/YYYY') + ')','') +
              ' ' + ' IN (' + FStringRetorno + ')' +
              ' ' + IIf(pOperLog=olAndR,'AND',IIf(pOperLog=olOrR,'OR','')) ;
  End ; // If Not IgnoraSelecao Then
end;

function TSBSelecaoAle.IgnoraSelecao: Boolean;
begin
  Result := Trim(FStringRetorno) = '' ;
end;

procedure TSBSelecaoAle.OrdenaColunas(pColuna: TColumn) ;
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

procedure TSBSelecaoAle.PosicionaBotoes;
var
  vEspaco : integer ;
begin
  With FPanelBotoes do
  Begin
    vEspaco := Trunc((Width-(2*85)) / 3) ;
    FBitBtnConfirma.Left := vEspaco ;
    FBitBtnFechar.Left   := vEspaco*2 + 85  ;
  End ; // With FPanelBotoes do
End ;

function TSBSelecaoAle.IIf( pCondicao : Boolean; pResultTrue, pResultFalse : Variant) : Variant;
Begin
  If pCondicao Then
    Result := pResultTrue
  else
    Result := pResultFalse;
End;

procedure TSBSelecaoAle.ItemPopupMenuClick(Sender: TObject);
  Procedure PosicionaMD(pMD : TRxMemoryData) ;
  Begin
    If pMD.Eof Then pMD.Prior
    Else
    If pMD.Bof Then pMD.First ;
  End ; // Procedure PosicionaMD(pMD : TRxMemoryData) ;
begin
  If Not TMenuItem(Sender).Visible Then Exit ;

  If TMenuItem(Sender).Name = 'FPMenuPesquisa' Then
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
    Exit ;
  End Else // If TMenuItem(Sender).Name = 'FPMenuPesquisa' Then
  If TMenuItem(Sender).Name = 'FPMenuAdiciona' Then
  Begin
    PosicionaMD(FMDataDispo) ;

    FMDataAssoc.LoadFromDataSet(FMDataDispo,1,lmAppend) ;
    FMDataDispo.Delete ;
  End Else // If TMenuItem(Sender).Name = 'FPMenuAdiciona' Then
  Begin
    PosicionaMD(FMDataAssoc) ;

    FMDataDispo.LoadFromDataSet(FMDataAssoc,IIf(TMenuItem(Sender).Name = 'FPMenuRevoga',1,0),lmAppend) ;
    If TMenuItem(Sender).Name = 'FPMenuRevoga' Then
      FMDataAssoc.Delete
    Else // If TMenuItem(Sender).Name = 'FPMenuRevoga' Then
    Begin
      FMDataAssoc.Close ;
      FMDataAssoc.Open ;
    End ; // Else // If TMenuItem(Sender).Name = 'FPMenuRevoga' Then
  End ; // End Else // If TMenuItem(Sender).Name = 'FPMenuAdiciona' Then

  If TMenuItem(Sender).Name = 'FPMenuAdiciona' Then
    DBGridEnter(FDBGridDispo)
  Else // If TMenuItem(Sender).Name = 'FPMenuAdiciona' Then
    DBGridEnter(FDBGridAssoc) ;
end;

procedure TSBSelecaoAle.DBGridEnter(Sender: TObject);
Var
  i : Integer;
begin
  FPMenuAdiciona.Visible    := (TDBGrid(Sender).Name = 'FDBGridDispo') And (FMDataDispo.RecordCount <> 1) And (FMDataAssoc.RecordCount < 1000) ;
  FPMenuRevoga.Visible      := (TDBGrid(Sender).Name = 'FDBGridAssoc') And (FMDataAssoc.RecordCount <> 0) ;
  FPMenuRevogaTodos.Visible := FPMenuRevoga.Visible ;

  FNomeCampo := '' ;
  For I := 0 to TDBGrid(Sender).Columns.Count-1 do
    If TDBGrid(Sender).Columns[I].Title.Font.Color = ClBlue then
    Begin
      FNomeCampo           := TDBGrid(Sender).Columns[I].FieldName ;
      FLblPesquisa.Caption := TDBGrid(Sender).Columns[I].Title.Caption ;
    End ; // If TDBGrid(Sender).Columns[I].Title.Font.Color = ClBlue then

  FPMenuPesquisa.Visible    := (Trim(FNomeCampo) <> '') And
                               ((TDBGrid(Sender).Name = 'FDBGridDispo') And (FMDataDispo.RecordCount > 1) Or
                                (TDBGrid(Sender).Name = 'FDBGridAssoc') And (FMDataAssoc.RecordCount > 1)) ;
  FBitBtnConfirma.Enabled   := FMDataAssoc.RecordCount > 1 ;
end;

procedure TSBSelecaoAle.DBGridDblClick(Sender: TObject);
begin
  If TDBGrid(Sender).Name = 'FDBGridDispo' Then
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
    OrdenaColunas(TDBGrid(Sender).Columns.Items[FColuna]) ;
  End ; // If (Shift = [ssCtrl]) And (...
end;

procedure TSBSelecaoAle.DBGridOnTitleClick(Column: TColumn);
begin
  OrdenaColunas(Column) ;
  If Column.Grid.Name = 'FDBGridDispo' Then
    DBGridEnter(FDBGridDispo)
  Else // If Column.Grid.Name = 'FDBGridDispo' Then
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

end.


