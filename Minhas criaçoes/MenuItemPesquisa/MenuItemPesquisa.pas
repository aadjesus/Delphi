unit MenuItemPesquisa;

interface

Uses
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt},
  Menus, dbgrids, Dialogs, Classes, Graphics, extctrls, stdctrls, Controls,
  SysUtils, DB, RxMemDS, dbctrls ;

Type
  TMenuItemPesquisa = class(TMenuItem)
  Private
    FDBGrid             : TDBGrid ;
    FColuna             : TColumn ;
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
    procedure   FEdtPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure   ColunaPesquisa(const pCuluna : TColumn) ;
  End ; // TItemPesquisa = class(TMenuItem)

implementation

uses
  Bgm_Tela,
  {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{ TMenuItemPesquisa }

procedure TMenuItemPesquisa.Click;
begin
  FPanelPesquisa.Width   := FDBGrid.Width - 50 ;
  FPanelPesquisa.Left    := FDBGrid.Left  + 16 ;
//  FPanelPesquisa.Top     := FDBGrid.Height Top   + 20 ;
  FPanelPesquisa.Top     := FDBGrid.Height - FPanelPesquisa.Height - 10 ;
  FPanelPesquisa.Visible := True ;

  FEdtPesquisa.MaxLength := FColuna.Field.Size ;
  FLblPesquisa.Caption   := FColuna.Title.Caption ;
  FEdtPesquisa.Left      := FLblPesquisa.Left + FLblPesquisa.Width + 3 ;
  FEdtPesquisa.Width     := FPanelPesquisa.Width - FEdtPesquisa.Left - 4 ;

  FEdtPesquisa.Clear     ;
  FEdtPesquisa.SetFocus  ;
  inherited ;
end;

procedure TMenuItemPesquisa.ColunaPesquisa(const pCuluna: TColumn);
begin
  FColuna := pCuluna ;
end;

constructor TMenuItemPesquisa.Create(AOwner: TComponent);
begin
  inherited Create(AOwner) ;
  FDBGrid := TDBGrid(AOwner) ;
  Caption := Traduz('Pesquisa') ;

  FPanelPesquisa := TPanel.Create( TControl(FDBGrid).Parent) ;
  With FPanelPesquisa do
  Begin
    Height     := 55 ;
    Visible    := False ;
    BevelInner := bvNone ;
    Parent     := TControl(FDBGrid).Parent ;

    // Cria panel para o titulo da Pesquisa
    FPanelTituloPesquisa := TPanel.Create(FPanelPesquisa) ;
    With FPanelTituloPesquisa do
    Begin
      Parent     := FPanelPesquisa ;
      Height     := 20 ;
      Align      := alTop ;
      BevelOuter := bvLowered ;
      Alignment  := taLeftJustify ;
      Caption    := ' ' + Traduz('Pesquisa') ;
      Color      := clNavy ;
      Font.Color := (clCaptionText) ;
      Font.Style := [fsBold] ;
    End ; // With FPanelTituloPesquisa do

    // Cria panel para a tela da Pesquisa
    FPanelTelaPesquisa := TPanel.Create(FPanelPesquisa) ;
    With FPanelTelaPesquisa do
    Begin
      Parent     := FPanelPesquisa ;
      Align      := alClient ;
      BevelOuter := bvLowered ;

      FLblPesquisa := TLabel.Create(FPanelTelaPesquisa) ;
      With FLblPesquisa do
      Begin
        Parent  := FPanelTelaPesquisa ;
        Left    := 4 ;
        Top     := 8 ;
        Caption := 'Definido conforme a coluna selecionada' ;
      End ; // With FLblPesquisa do

      // Cria edit para Pesquisa
      FEdtPesquisa := TEdit.Create(FPanelTelaPesquisa) ;
      With FEdtPesquisa do
      Begin
        Parent    := FPanelTelaPesquisa ;
        Top       := FLblPesquisa.Top - 3 ;
        OnExit    := FEdtPesquisaExit ;
        OnChange  := FEdtPesquisaChange ;
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

destructor TMenuItemPesquisa.Destroy;
begin
  inherited ;
end;

procedure TMenuItemPesquisa.FEdtPesquisaChange(Sender: TObject);
begin
  If Trim(FEdtPesquisa.Text) <> '' Then
  Begin
    Try
      Try
        DateTimeToStr(FColuna.Field.AsDateTime) ;
        FDBGrid.DataSource.DataSet.Locate(FColuna.FieldName,StrToDate(Trim(FEdtPesquisa.Text)),[loPartialKey,loCaseInsensitive])
      Except
        FDBGrid.DataSource.DataSet.Locate(FColuna.FieldName,Trim(FEdtPesquisa.Text),[loPartialKey,loCaseInsensitive]) ;
      End ; // Try - Except
    Except
    End ; // Try - Except
  End ; // If Trim(FEdtPesquisa.Text) <> '' Then
end;

procedure TMenuItemPesquisa.FEdtPesquisaExit(Sender: TObject);
begin
  FPanelPesquisa.Visible := False ;
end;

procedure TMenuItemPesquisa.FEdtPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  With FDBGrid.DataSource.DataSet do
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
  End ; // With FDBGrid.DataSource.DataSet do
end;

end.




