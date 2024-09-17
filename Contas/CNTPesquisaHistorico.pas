unit CNTPesquisaHistorico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, ToolWin, ComCtrls, jpeg;

type
  TCNTFormPesquisaHistorico = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    LebDigitaPesquisa: TLabel;
    DBGridPesquisaHistorico: TDBGrid;
    CoolBar1: TCoolBar;
    SpeedButtonCodigo: TSpeedButton;
    SpeedButtonDescricao: TSpeedButton;
    LabOrdemdaPesquisa: TLabel;
    EdiPesquisa: TEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridPesquisaHistoricoExit(Sender: TObject);
    procedure DBGridPesquisaHistoricoDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButtonDescricaoClick(Sender: TObject);
    procedure SpeedButtonCodigoClick(Sender: TObject);
    procedure EdiPesquisaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CNTFormPesquisaHistorico: TCNTFormPesquisaHistorico;

implementation

{$R *.DFM}

Uses CNTHistorico, CNTDataModuleContas ;

//------------- Simula Enter ao inves de Tab ( Evento KeyPress ) ---------------\\
procedure TCNTFormPesquisaHistorico.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
  Begin
    Key := #0;
    Perform( WM_NEXTDLGCTL, 0, 0 );
  end;
  If Key = #27 then Close ;

end;

//------------------ Evento OnShow -------------------------\\
procedure TCNTFormPesquisaHistorico.FormShow(Sender: TObject);
begin
  With DMContas.TbHistorico do
  begin
    DMContas.TbHistorico.IndexName := 'IndexDescricao'  ;
    Active                         := True              ;
    First                          ;
    EdiPesquisa.SetFocus           ;
  end;
end;

//------------------ Pesquisa Nome digitado -------------------------\\
procedure TCNTFormPesquisaHistorico.EdiPesquisaChange(Sender: TObject);
begin
  DMContas.TbHistorico.FindNearEst( [EdiPesquisa.Text] ) ;
end;

//----------------------------- Evento OnDblClik ------------------------------\\
procedure TCNTFormPesquisaHistorico.DBGridPesquisaHistoricoDblClick(Sender: TObject);
begin
  With DMContas.TbHistorico do
  IndexName := ''                ;
  Close                          ;
  CNTFormPesquisaHistorico.Close ;
  achou   := True                ;
end;

//----------------------------- Evento OnExit ------------------------------\\
procedure TCNTFormPesquisaHistorico.DBGridPesquisaHistoricoExit(  Sender: TObject);
begin
  With DMContas.TbHistorico do
  IndexName := ''                ;
  Close                          ;
  achou     := True              ;
  CNTFormPesquisaHistorico.Close ;
end;

//--------------------- Botao Ordenar por Descricao -----------------------\\
procedure TCNTFormPesquisaHistorico.SpeedButtonDescricaoClick(Sender: TObject);
begin
  DMContas.TbHistorico.IndexName := 'IndexDescricao'       ;
  EdiPesquisa.MaxLength          := 40                     ;
  EdiPesquisa.SetFocus           ;
  EdiPesquisa.Text               := ''                     ;
  LebDigitaPesquisa.Caption      := 'Digite a descrição :' ;
  SpeedButtonDescricao.Enabled   := False                  ;
  SpeedButtonDescricao.Flat      := True                   ;
  SpeedButtonCodigo.Enabled      := True                   ;
  SpeedButtonCodigo.Flat         := False                  ;

  DBGridPesquisaHistorico.Columns[0].Title.Font.Style := [FsBold]    ;
  DBGridPesquisaHistorico.Columns[1].Title.Font.Style := []          ;
  DBGridPesquisaHistorico.Columns[0].Font.Style       := [FsBold]    ;
  DBGridPesquisaHistorico.Columns[1].Font.Style       := []          ;
end;

//----------------------- Botao Ordenar por Codigo ---------------------\\
procedure TCNTFormPesquisaHistorico.SpeedButtonCodigoClick(Sender: TObject);
begin
  DMContas.TbHistorico.IndexName := ''                     ;
  EdiPesquisa.MaxLength          := 4                      ;
  EdiPesquisa.SetFocus           ;
  EdiPesquisa.Text               := ''                     ;
  LebDigitaPesquisa.Caption      := 'Digite o código :'    ;
  SpeedButtonDescricao.Enabled   := True                   ;
  SpeedButtonDescricao.Flat      := False                  ;
  SpeedButtonCodigo.Enabled      := False                  ;
  SpeedButtonCodigo.Flat         := True                   ;

  DBGridPesquisaHistorico.Columns[1].Title.Font.Style := [FsBold]    ;
  DBGridPesquisaHistorico.Columns[0].Title.Font.Style := []          ;
  DBGridPesquisaHistorico.Columns[1].Font.Style       := [FsBold]    ;
  DBGridPesquisaHistorico.Columns[0].Font.Style       := []          ;

end;

end.
