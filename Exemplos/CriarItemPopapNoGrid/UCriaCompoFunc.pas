unit UCriaCompoFunc;

interface

Uses
  Menus, dbgrids, Dialogs, Classes, Graphics, extctrls, stdctrls, Controls, SysUtils,
  DB, RxMemDS, Windows ;

Type
  TDBGridClickEvent = procedure (Column: TColumn) of object;

  TItemPesquisa = class(TMenuItem)
  Private
    FColuna             : TColumn ;
    FDBGrid             : TDBGrid ;
    FOnTitleClick       : TDBGridClickEvent ;
    FPanelPesquisa,
    FPanelTituloPesquisa,
    FPanelTelaPesquisa  : TPanel ;
    FLblPesquisa        : TLabel ;
    FEdtPesquisa,
    FEdtFoco            : TEdit ;
  public
    constructor Create(AOwner: TComponent) ; override;
    destructor  Destroy ; override ;
    procedure   Click ; override;
    procedure   FEdtPesquisaExit(Sender: TObject) ;
    procedure   FEdtPesquisaChange(Sender: TObject);
    procedure   ColunaPesquisa(const pCuluna : TColumn) ;
  End ; // TItemPesquisa = class(TMenuItem)

Var
  vColuna : Integer;
  vOrdem  : Boolean;
  PMenuPesquisa : TPopupMenu ;
  IMenuPesquisa : TItemPesquisa ;

procedure OrdenaColunas(pColuna: TColumn) ;

implementation

procedure OrdenaColunas(pColuna: TColumn) ;
Var
  vGrid         : TCustomDBGrid ;
  i             : Integer ;
  vNomeItemMenu : String ;
Begin
  vGrid := pColuna.Grid ;

  vOrdem  := (vColuna = pColuna.Index) And (Not vOrdem);
  vColuna := pColuna.Index ;

  For i := 0 to TDBGrid(vGrid).Columns.Count-1 do
    TDBGrid(vGrid).Columns[i].Title.Font.Color := ClBlack ;

  TDBGrid(vGrid).Columns[pColuna.Index].Title.Font.Color := ClBlue ;
  TRxMemoryData(TDBGrid(vGrid).DataSource.DataSet).SortOnFields(pColuna.FieldName,True,vOrdem) ;

  // Cria menu
  If TDBGrid(vGrid).PopupMenu = Nil Then
  Begin
    PMenuPesquisa      := TPopupMenu.Create(TDBGrid(vGrid)) ;
    PMenuPesquisa.Name := 'PMenuPesquisa' ;
    TDBGrid(vGrid).PopupMenu := PMenuPesquisa ;
  End ; // If vGrid.FindComponent('PMenuPesquisa') = Nil Then

  // Cria item de menu (No menu criado ou no ja existente)
  vNomeItemMenu := TDBGrid(vGrid).Name +'_'+ 'IMenuPesquisa' ;
  If TDBGrid(vGrid).FindComponent(vNomeItemMenu) = Nil Then
  Begin
    IMenuPesquisa      := TItemPesquisa.Create(TDBGrid(vGrid)) ;
    IMenuPesquisa.Name := vNomeItemMenu ;
    TPopupMenu(TDBGrid(vGrid).PopupMenu).Items.Add(IMenuPesquisa) ;
  End ; // If TDBGrid(vGrid).FindComponent(vNomeItemMenu) = Nil Then

  IMenuPesquisa.ColunaPesquisa(pColuna) ;
End ;

{ TItemPesquisa }

constructor TItemPesquisa.Create(AOwner: TComponent) ;
begin
  inherited Create(AOwner) ;
  FDBGrid := TDBGrid(AOwner) ;
  Caption := 'Pesquisa' ;

  FPanelPesquisa := TPanel.Create( TControl(FDBGrid).Parent) ;
  With FPanelPesquisa do
  Begin
    Height     := 55 ;
    Visible    := False ;
    BevelInner := bvLowered ;
    Parent     := TControl(FDBGrid).Parent ;
    Width      := FDBGrid.Width - 50 ;
    Left       := FDBGrid.Left  + 15 ;
    Top        := FDBGrid.Top   + 20 ;

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
        Parent   := FPanelTelaPesquisa ;
        Top      := FLblPesquisa.Top - 3 ;
        OnExit   := FEdtPesquisaExit ;
        OnChange := FEdtPesquisaChange ;
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

end;

destructor TItemPesquisa.Destroy;
begin
  inherited ;
end;

procedure TItemPesquisa.Click;
begin
  FPanelPesquisa.Visible := True ;
  FLblPesquisa.Caption   := FColuna.Title.Caption ;
  FEdtPesquisa.Left      := FLblPesquisa.Left + FLblPesquisa.Width + 3 ;
  FEdtPesquisa.Width     := FPanelTelaPesquisa.Width - FEdtPesquisa.Left - 4 ;
  FEdtPesquisa.Clear     ;
  FEdtPesquisa.SetFocus  ;
  inherited ;
end;

procedure TItemPesquisa.FEdtPesquisaChange(Sender: TObject);
begin
  If Trim(FEdtPesquisa.Text) <> '' Then
  Begin
    Try
      DateTimeToStr( FDBGrid.DataSource.DataSet.Fields[FColuna.Index].AsDateTime ) ;
      FDBGrid.DataSource.DataSet.Locate(FColuna.FieldName,StrToDate(FEdtPesquisa.Text),[loPartialKey,loCaseInsensitive]) ;
    Except
      FDBGrid.DataSource.DataSet.Locate(FColuna.FieldName,Trim(FEdtPesquisa.Text),[loPartialKey,loCaseInsensitive]) ;
    End ; // Try - Except
  End ; // If Trim(FEdtPesquisa.Text) <> '' Then
end;

procedure TItemPesquisa.FEdtPesquisaExit(Sender: TObject);
begin
  FPanelPesquisa.Visible := False ;
  FDBGrid.SetFocus ;
end;

procedure TItemPesquisa.ColunaPesquisa(const pCuluna : TColumn) ;
begin
  FColuna := pCuluna ;
end;

end.
