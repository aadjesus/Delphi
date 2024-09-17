unit CNTPesquisaUsuario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Grids, DBGrids, Menus, Buttons, ToolWin, ComCtrls,
  jpeg;

type
  TCNTFormPesquisaUsuario = class(TForm)
    Image1: TImage;
    PanelDBGridUsuario: TPanel;
    LabDigitaPesquisa: TLabel;
    DBGridPesquisaUsuario: TDBGrid;
    EdiPesquisa: TEdit;
    CoolBar1: TCoolBar;
    SpeedButtonCodigo: TSpeedButton;
    SpeedButtonNome: TSpeedButton;
    LabOrdemdaPesquisa: TLabel;
    procedure FormShow(Sender: TObject);
    procedure EdiPesquisaChange(Sender: TObject);
    procedure TranzUsuarioDupluClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridPesquisaUsuarioExit(Sender: TObject);
    procedure SpeedButtonCodigoClick(Sender: TObject);
    procedure SpeedButtonNomeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CNTFormPesquisaUsuario: TCNTFormPesquisaUsuario ;
implementation

{$R *.DFM}

Uses CNTUsuarios, CNTDataModuleContas ;

//---------- Simula Enter ao inves de Tab ( Evento KeyPress ) ---------------\\
procedure TCNTFormPesquisaUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
  Begin
    Key := #0;
    Perform( WM_NEXTDLGCTL, 0, 0 );
  end;
  If Key = #27 then Close ;

end;

//------------------- Evento OnShow ----------------------\\
procedure TCNTFormPesquisaUsuario.FormShow(Sender: TObject);
begin
  With DMContas.TbUsuarios do
  begin
    DMContas.TbUsuarios.IndexName := 'IndexNome' ;
    Active                        := True        ;
    First                         ;
    EdiPesquisa.SetFocus          ;
  end;
end;

//------------------ Pesquisa Nome digitado -----------------------\\
procedure TCNTFormPesquisaUsuario.EdiPesquisaChange(Sender: TObject);
begin
  DMContas.TbUsuarios.FindNearEst( [EdiPesquisa.Text] ) ;
end;

//---------------------- Evento OnDblClik --------------------------\\
procedure TCNTFormPesquisaUsuario.TranzUsuarioDupluClick(Sender: TObject);
begin
  With DMContas.TbUsuarios do
  IndexName := ''              ;
  Close                        ;
  Achou     := True            ;
  CNTFormPesquisaUsuario.Close ;
end;

//--------------------------- Evento OnExit -------------------------------\\
procedure TCNTFormPesquisaUsuario.DBGridPesquisaUsuarioExit(Sender: TObject);
begin
  With DMContas.TbUsuarios do
  IndexName := ''              ;
  Close                        ;
  Achou     := True            ;
  CNTFormPesquisaUsuario.Close ;
end;

//--------------------- Botao Ordenar por Nome -----------------------\\
procedure TCNTFormPesquisaUsuario.SpeedButtonNomeClick(Sender: TObject);
begin
  DMContas.TbUsuarios.IndexName := 'IndexNome' ;
  EdiPesquisa.MaxLength         := 40          ;
  EdiPesquisa.SetFocus                         ;
  EdiPesquisa.Text              := ''          ;
  LabDigitaPesquisa.Caption     := 'Digite o nome :' ;
  SpeedButtonNome.Enabled       := False       ;
  SpeedButtonNome.Flat          := True        ;
  SpeedButtonCodigo.Enabled     := True        ;
  SpeedButtonCodigo.Flat        := False       ;
  DBGridPesquisaUsuario.Columns[0].Title.Font.Style := [FsBold]    ;
  DBGridPesquisaUsuario.Columns[1].Title.Font.Style := []          ;
  DBGridPesquisaUsuario.Columns[0].Font.Style       := [FsBold]    ;
  DBGridPesquisaUsuario.Columns[1].Font.Style       := []          ;
end;

//----------------------- Botao Ordenar por Codigo ---------------------\\
procedure TCNTFormPesquisaUsuario.SpeedButtonCodigoClick(Sender: TObject);
begin
  DMContas.TbUsuarios.IndexName := ''          ;
  EdiPesquisa.MaxLength         := 5           ;
  EdiPesquisa.SetFocus                         ;
  EdiPesquisa.Text              := ''          ;
  LabDigitaPesquisa.Caption     := 'Digite o código :' ;
  SpeedButtonNome.Enabled       := True        ;
  SpeedButtonNome.Flat          := False       ;
  SpeedButtonCodigo.Enabled     := False       ;
  SpeedButtonCodigo.Flat        := True        ;

  DBGridPesquisaUsuario.Columns[1].Title.Font.Style := [FsBold]    ;
  DBGridPesquisaUsuario.Columns[0].Title.Font.Style := []          ;
  DBGridPesquisaUsuario.Columns[1].Font.Style       := [FsBold]    ;
  DBGridPesquisaUsuario.Columns[0].Font.Style       := []          ;
end;


end.


