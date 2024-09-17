unit OPColuna;

interface

uses
  SysUtils, Classes, ExtCtrls, StdCtrls, AboutBgmRodotec, DBGrids, DB, RxMemDS,

 {tmp} Dialogs
  ;

type
  thack = class(TCustomDBGrid) ;
  TOPColuna = class(TComponent)
  private
    { Private declarations }
    FAbout: TAboutProperty;
    FDBGrid: TCustomDBGrid;
    FOrdem: Boolean;
    FColuna: Integer;
    procedure SetDBGrid(const Value: TCustomDBGrid);
  protected
    { Protected declarations }
    procedure TitleClick(Column: TColumn); dynamic;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override ;
    destructor Destroy ; override ;
  published
    { Published declarations }
    property About  : TAboutProperty read FAbout  write FAbout ;
    property DBGrid : TCustomDBGrid  read FDBGrid write SetDBGrid ;
  end;

procedure Register;

implementation

uses Math, Controls;

procedure Register;
begin
  RegisterComponents('BGM', [TOPColuna]);
end;

{ TOPColuna }
constructor TOPColuna.Create(AOwner: TComponent);
begin
  inherited Create(AOwner) ;
  cAboutNomeComponente := 'OPColuna' ;
  cAboutAutor          := 'Alessando A.J - 20/12/2006' ;
  cAboutVersao         := '1.0.0' ;
end;

destructor TOPColuna.Destroy;
begin
  FAbout.Free ;
  inherited;
end;

procedure TOPColuna.SetDBGrid(const Value: TCustomDBGrid);
begin
  FDBGrid := Value;
//  If FDBGrid <> Nil Then
//    TDBGrid(DBGrid).OnTitleClick := TitleClick ;

THack(DBGrid).Controlstyle := THack(DBGrid.Owner).ControlStyle + [csClickEvents] ;
THack(DBGrid).OnTitleClick :=  Self.TitleClick  ;    //csClickEvents, csSetCaption, csDoubleClicks

end;

procedure TOPColuna.TitleClick(Column: TColumn);
begin
  ShowMessage('teste - 1 : ' +  TDBGrid(DBGrid).Columns[Column.Index].Title.Caption );

//  TDBGrid(vGrid).Columns[pColuna.Index].Title.Font.Color := ClBlue ;


end;

end.
