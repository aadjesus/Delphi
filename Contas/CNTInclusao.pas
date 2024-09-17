unit CNTInclusao;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Menus, Mask, ToolWin, jpeg, Grids,
  DBGrids;

type
  TCNTMovDigIclusao = class(TForm)
    Image1: TImage;
    PanelBotoesIncAltPag: TPanel;
    SpeedButtonInclusao: TSpeedButton;
    SpeedButtonAlteracao: TSpeedButton;
    SpeedButtonPagamento: TSpeedButton;
    PanelInclusao: TPanel;
    PanelBotoes: TPanel;
    BitGrava: TBitBtn;
    BitLimpa: TBitBtn;
    BitFecha: TBitBtn;
    BitExclui: TBitBtn;
    StatusBar1: TStatusBar;
    MaskEdiEntrada: TMaskEdit;
    EdiDocumento: TEdit;
    EdiParcela: TEdit;
    DateTimePickerVencimento: TDateTimePicker;
    EdiHistorico: TEdit;
    LabEntrada: TLabel;
    LabDocumento: TLabel;
    LabParcelas: TLabel;
    LabVencimento: TLabel;
    LabHistorico: TLabel;
    GroupBoxValores: TGroupBox;
    MaskEdValorDoc: TMaskEdit;
    LabValorDocumento: TLabel;
    MaskEditDesconto: TMaskEdit;
    LabDesconto: TLabel;
    MaskEdiAcrescimo: TMaskEdit;
    LabAcrescimo: TLabel;
    EdiHistoricoCompe: TEdit;
    SpePesquisaHistorico: TSpeedButton;
    DBGriteste: TDBGrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BitGravaClick(Sender: TObject);
    procedure BitLimpaClick(Sender: TObject);
    procedure BitFechaClick(Sender: TObject);
    procedure Histrico1Click(Sender: TObject);
    procedure BitExcluiClick(Sender: TObject);
  private
    { Private declarations }
    procedure HabilitaBotoes ;
    procedure LimpaTela      ;

  public
    { Public declarations }
  end;

var
  CNTMovDigIclusao: TCNTMovDigIclusao ;
  achou           : Boolean           ;

implementation

{$R *.DFM}

uses CNTUsuarios, CNTHistorico, CNTDataModuleContas ;

//--------- Simula Enter ao inves de Tab ( Evento KeyPress ) ----------\\
procedure TCNTMovDigIclusao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
  Begin
    Key := #0;
    Perform( WM_NEXTDLGCTL, 0, 0 );
  End;
End;

//-------------- Cadastro de historico -------------------\\
procedure TCNTMovDigIclusao.Histrico1Click(Sender: TObject);
begin
  With TCNTFormHistorico.Create(Self) Do
  Begin
    ShowModal;
    Free;
  End;
End;

//-------------- Evento OnShow ---------------------\\
procedure TCNTMovDigIclusao.FormShow(Sender: TObject);
begin
  HabilitaBotoes();

  Begin
    With DMContas.TBMovimentacao do
    Active := True  ;
    Begin
      if DMContas.TBMovimentacao.Eof then
         Begin
           SpeedButtonAlteracao.Enabled := True  ;
           SpeedButtonAlteracao.Flat    := False ;
         end
       Else
         Begin
           SpeedButtonAlteracao.Enabled := False  ;
           SpeedButtonAlteracao.Flat    := True   ;
         end;
    end;
    Close ;
  end;

  Begin
    With DMContas.QueryPagamento Do
    Begin
      if DMContas.QueryPagamento.Eof then
        Begin
          SpeedButtonPagamento.Enabled := True  ;
          SpeedButtonPagamento.Flat    := False ;
        end
      Else
         Begin
           SpeedButtonPagamento.Enabled := False  ;
           SpeedButtonPagamento.Flat    := True   ;
         end;
    end;
    Close ;
  end;


End;

//------------------ Botao Grava -----------------------\\
procedure TCNTMovDigIclusao.BitGravaClick(Sender: TObject);
begin
  With DMContas.TBMovimentacao do
  If achou then Edit
  else
  begin
    Open    ;
    Append  ;
  End;

  begin
    With DMContas.TBMovimentacao do
    begin
      FieldByName('USUARIO'  ).AsString   := '0001'               ;
      FieldByName('DOCUMENTO').AsString   := EdiDocumento.Text    ;
      FieldByName('PARCELA'  ).AsString   := EdiParcela.Text      ;
      FieldByName('ENTRADA'  ).AsString   := MaskEdiEntrada.Text  ;

      Post         ;
      Close        ;
      LimpaTela()  ;
    end;
  end;

End;

//------------------ Botao Limpa -----------------------\\
procedure TCNTMovDigIclusao.BitLimpaClick(Sender: TObject);
begin
  LimpaTela() ;
End;

//------------------ Botao Fecha -----------------------\\
procedure TCNTMovDigIclusao.BitFechaClick(Sender: TObject);
Begin
  Close ;
End;

//--------------------- Botao Exclui ---------------------\\
procedure TCNTMovDigIclusao.BitExcluiClick(Sender: TObject);
Begin

End;

//----------- Habilita Botoes -------------\\
procedure TCNTMovDigIclusao.HabilitaBotoes();
Begin
  BitLimpa.Enabled := False ;
  BitGrava.Enabled := False ;
  BitLimpa.Enabled := True ;
  BitGrava.Enabled := True ;
End;

//----------- Limpa Tela -------------\\
procedure TCNTMovDigIclusao.LimpaTela();
var I : Integer;
begin
  For i := 0 to ComponentCount - 1 do
  Begin
     If Components[i] is TEdit     then TEdit(Components[i]).Text     := '' ;
     If Components[i] is TMaskEdit then TMaskEdit(Components[i]).Text := '' ;
  End;
  HabilitaBotoes() ;
End;


End.
