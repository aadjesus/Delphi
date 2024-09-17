unit CNTListagemCadastros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ToolWin, ComCtrls, ExtCtrls, jpeg;

type
  TCNTFormListagemCadastro = class(TForm)
    Image1: TImage;
    PanelDigitacao: TPanel;
    GroupBoxCodigo: TGroupBox;
    LabCodigoIni: TLabel;
    LabCodigoFin: TLabel;
    EdiCodigoIni: TEdit;
    EdiCodigoFin: TEdit;
    GroupBoxNome: TGroupBox;
    LabNomeIni: TLabel;
    LabNomeFin: TLabel;
    EdiNomeIni: TEdit;
    EdiNomeFin: TEdit;
    PanelBotoes: TPanel;
    BitLimpa: TBitBtn;
    BitVisualizar: TBitBtn;
    BitFechar: TBitBtn;
    CoolBar1: TCoolBar;
    SpeedButtonCodigo: TSpeedButton;
    SpeedButtonNome: TSpeedButton;
    LabOrdemdaPesquisa: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButtonCodigoClick(Sender: TObject);
    procedure SpeedButtonNomeClick(Sender: TObject);
    procedure BitFecharClick(Sender: TObject);
    procedure BitLimpaClick(Sender: TObject);
    procedure EdiCodigoIniExit(Sender: TObject);
    procedure EdiCodigoFinExit(Sender: TObject);
    procedure EdiNomeIniExit(Sender: TObject);
    procedure EdiNomeFinExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure LimpaTela      ;

  public
    { Public declarations }
  end;

var
  CNTFormListagemCadastro: TCNTFormListagemCadastro ;

implementation

uses CNTPrincipal ;

{$R *.DFM}

//--------- Simula Enter ao inves de Tab ( Evento KeyPress ) ---------\\
procedure TCNTFormListagemCadastro.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
  Begin
    Key := #0;
    Perform( WM_NEXTDLGCTL, 0, 0 );
  end;
  If Key = #27 then Close ;
end;

//---------------- Evento OnShow -------------------------\\
procedure TCNTFormListagemCadastro.FormShow(Sender: TObject);
begin
   LimpaTela() ;
   If UsuaOuHist = 'USU' then
     Begin
       CNTFormListagemCadastro.Caption                 := 'Listagem de Clientes' ;
       CNTFormListagemCadastro.EdiCodigoIni.MaxLength  := 5                      ;
       CNTFormListagemCadastro.EdiCodigoFin.MaxLength  := 5                      ;
       CNTFormListagemCadastro.GroupBoxNome.Caption    := 'Nome'                 ;

       CNTFormListagemCadastro.SpeedButtonNome.Caption := 'Nome'                 ;
       CNTFormListagemCadastro.EdiNomeIni.MaxLength    := 40                     ;
       CNTFormListagemCadastro.EdiNomeFin.MaxLength    := 40                     ;
    end
  else
    Begin
      CNTFormListagemCadastro.Caption                 := 'Listagem de Históricos' ;
      CNTFormListagemCadastro.EdiCodigoIni.MaxLength  := 4                        ;
      CNTFormListagemCadastro.EdiCodigoFin.MaxLength  := 4                        ;
      CNTFormListagemCadastro.GroupBoxNome.Caption    := 'Descrição'              ;
      CNTFormListagemCadastro.SpeedButtonNome.Caption := 'Descrição'              ;
      CNTFormListagemCadastro.EdiNomeIni.MaxLength    := 30                       ;
      CNTFormListagemCadastro.EdiNomeFin.MaxLength    := 30                       ;
  end ;
end;

//--------------------- Botao Ordenar por Nome -----------------------\\
procedure TCNTFormListagemCadastro.SpeedButtonNomeClick(Sender: TObject);
begin
  SpeedButtonNome.Enabled        := False                  ;
  SpeedButtonNome.Flat           := True                   ;
  SpeedButtonCodigo.Enabled      := True                   ;
  SpeedButtonCodigo.Flat         := False                  ;
  
  GroupBoxNome.Font.Style       := [FsBold]    ;
  GroupBoxCodigo.Font.Style     := []          ;
end;

//----------------------- Botao Ordenar por Codigo ---------------------\\
procedure TCNTFormListagemCadastro.SpeedButtonCodigoClick(Sender: TObject);
begin
  SpeedButtonNome.Enabled        := True                   ;
  SpeedButtonNome.Flat           := False                  ;
  SpeedButtonCodigo.Enabled      := False                  ;
  SpeedButtonCodigo.Flat         := True                   ;

  GroupBoxNome.Font.Style   := []          ;
  GroupBoxCodigo.Font.Style := [FsBold]    ;
end;

//------------------------ Botao Limpa -------------------------\\
procedure TCNTFormListagemCadastro.BitLimpaClick(Sender: TObject);
begin
  LimpaTela();
end;


//--------------------- Botao Fecha -----------------------------\\
procedure TCNTFormListagemCadastro.BitFecharClick(Sender: TObject);
begin
  Close       ;
end;

//--------------- Evento OnExit Codigo Ini ------------------------\\
procedure TCNTFormListagemCadastro.EdiCodigoIniExit(Sender: TObject);
begin
  If BitFechar.Focused then Exit ;

  If (UsuaOuHist = 'USU') then
    Begin
      If (Trim(EdiCodigoIni.Text ) <> '') Then
           EdiCodigoIni.Text := Copy( '00000', 1, 5-Length(Trim(EdiCodigoIni.Text))) + Trim(EdiCodigoIni.Text)
      else EdiCodigoIni.Text := '00000'  ;
    End
  else
    Begin
      If (Trim(EdiCodigoIni.Text ) <> '') Then
           EdiCodigoIni.Text := Copy( '0000', 1, 4-Length(Trim(EdiCodigoIni.Text))) + Trim(EdiCodigoIni.Text)
      else EdiCodigoIni.Text := '00000' ;
    End ;

    BitLimpa.Enabled := True ;
end;

//--------------- Evento OnExit Codigo Fin ------------------------\\
procedure TCNTFormListagemCadastro.EdiCodigoFinExit(Sender: TObject);
begin
  If (UsuaOuHist = 'USU') then
    Begin
      If (Trim(EdiCodigoFin.Text ) <> '') Then
           EdiCodigoFin.Text := Copy( '00000', 1, 5-Length(Trim(EdiCodigoFin.Text))) + Trim(EdiCodigoFin.Text)
      else EdiCodigoFin.Text := '99999'  ;
    End
  else
    Begin
      If (Trim(EdiCodigoFin.Text ) <> '') Then
           EdiCodigoFin.Text := Copy( '0000', 1, 4-Length(Trim(EdiCodigoFin.Text))) + Trim(EdiCodigoFin.Text)
      else EdiCodigoFin.Text := '9999' ;
    End ;
end;

//--------------- Evento OnExit Nome Ini ------------------------\\
procedure TCNTFormListagemCadastro.EdiNomeIniExit(Sender: TObject);
begin
  If BitFechar.Focused then Exit ;

  If (Trim(EdiNomeIni.Text ) <> '') Then
      EdiNomeIni.Text := EdiNomeIni.Text
  else EdiNomeIni.Text := ''  ;
end;

//--------------- Evento OnExit Nome Fin ------------------------\\
procedure TCNTFormListagemCadastro.EdiNomeFinExit(Sender: TObject);
begin
  If BitFechar.Focused then Exit ;

end;

//---------------- Limpa Tela ---------------\\
procedure TCNTFormListagemCadastro.LimpaTela();
begin
  BitVisualizar.Enabled := False ;
  BitLimpa.Enabled      := False ;
  EdiCodigoIni.Text     := ''    ;
  EdiCodigoFin.Text     := ''    ;
  EdiNomeIni.Text       := ''    ;
  EdiNomeFin.Text       := ''    ;
  EdiCodigoIni.SetFocus ;
end;


end.
