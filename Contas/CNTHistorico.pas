unit CNTHistorico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, jpeg;

type
  TCNTFormHistorico = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    LabCodigo: TLabel;
    LabDescricao: TLabel;
    SpePesquisaHistorico: TSpeedButton;
    SpeProximoHistorico: TSpeedButton;
    EdiCodigo: TEdit;
    EdiDescricao: TEdit;
    RadTipoDC: TRadioGroup;
    CheckBoxComplemento: TCheckBox;
    Panel2: TPanel;
    BitGrava: TBitBtn;
    BitLimpa: TBitBtn;
    BitFecha: TBitBtn;
    BitExclui: TBitBtn;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure EdiCodigoChange(Sender: TObject);
    procedure BitGravaClick(Sender: TObject);
    procedure BitLimpaClick(Sender: TObject);
    procedure BitFechaClick(Sender: TObject);
    procedure BitExcluiClick(Sender: TObject);
    procedure SpePesquisaHistoricoClick(Sender: TObject);
    procedure EdiCodigoExit(Sender: TObject);
    procedure SpeProximoHistoricoClick(Sender: TObject);
  private
    { Private declarations }

    procedure HabilitaBotoes  ;
    procedure LimpaTela       ;
    procedure TrazPesquisa    ;
    procedure MostraHistorico ;

  public
    { Public declarations }
  end;

var
  CNTFormHistorico : TCNTFormHistorico ;
  achou            : Boolean          ;

implementation

{$R *.DFM}

uses CNTPesquisaHistorico, CNTDataModuleContas;

//-------- Simula Enter ao inves de Tab ( Evento KeyPress ) ----------\\
procedure TCNTFormHistorico.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
  Begin
    Key := #0;
    Perform( WM_NEXTDLGCTL, 0, 0 );
  end;
end;

//---------------- Evento OnShow ------------------\\
procedure TCNTFormHistorico.FormShow(Sender: TObject);
begin
  HabilitaBotoes();
end;

//-------------------- Evento OnChange -------------------\\
procedure TCNTFormHistorico.EdiCodigoChange(Sender: TObject);
begin
  HabilitaBotoes;
end;

//------------------- Evento OnExit --------------------\\
procedure TCNTFormHistorico.EdiCodigoExit(Sender: TObject);
begin
  If BitFecha.Focused then Exit ;

  // Tranz o Form da Pesquisa se o codigo
  If EdiCodigo.Text = '' then TrazPesquisa()
  Else
    begin // Pesquisa se ja nao existe o usuario
      With DMContas.TbHistorico do
      begin
        Active         := True  ;
        EdiCodigo.Text := Copy( '0000', 1, 4-Length(Trim(EdiCodigo.Text))) + Trim(EdiCodigo.Text);
        If FindKey([ EdiCodigo.Text ]) then
          begin
            Achou   := True   ;
            MostraHistorico() ;
          end
        else Close;
      end;
    end;

  If Trim( EdiCodigo.Text ) <> '' then
    begin
      SpePesquisaHistorico.Enabled := False ;
      SpePesquisaHistorico.Flat    := True  ;
      SpeProximoHistorico.Enabled  := False ;
      SpeProximoHistorico.Flat     := True  ;
      EdiCodigo.Enabled            := False ;
      EdiDescricao.SetFocus        ;
    end
  else EdiCodigo.SetFocus   ;

  HabilitaBotoes() ;
end;

//--------------------- Botao Pesquisa Historico -------------------\\
procedure TCNTFormHistorico.SpePesquisaHistoricoClick(Sender: TObject);
begin
  If not Achou then TrazPesquisa()
end;

//-------------------- Proximo Historico ---------------------------\\
procedure TCNTFormHistorico.SpeProximoHistoricoClick(Sender: TObject);
var
  CodHistorico : String ;
begin
  With DMContas.TbHistorico do
  Begin
    Active := True ;
    If RecordCount = 0 then EdiCodigo.Text := '0001'
    else
      Begin
        Last           ;
        CodHistorico   := IntToStr(FieldByName( 'CODIGO' ).AsInteger + 1) ;
        EdiCodigo.Text := Copy( '0000', 1, 4-Length(Trim(CodHistorico))) + Trim(CodHistorico);
        Close          ;
      end;
  end;
  EdiDescricao.SetFocus  ;
end;

//------------------ Grava Historico -------------------\\
procedure TCNTFormHistorico.BitGravaClick(Sender: TObject);
begin
  If Trim( EdiDescricao.Text ) = '' then
  begin
    MessageDlg('A descrição do histórico não pode ficar em branco ?', mtInformation, [mbOk], 0) ;
    EdiDescricao.SetFocus  ;
    Exit ;
  End ;

  With DMContas.TbHistorico do
  If achou then Edit
  else
  begin
    Open    ;
    Append  ;
  End;

  begin
    With DMContas.TbHistorico do
    begin
      EdiCodigo.Enabled := True ;
      FieldByName('CODIGO'     ).AsString  := EdiCodigo.Text              ;
      FieldByName('DESCRICAO'  ).AsString  := EdiDescricao.Text           ;
      FieldByName('COMPLEMENTO').AsBoolean := CheckBoxComplemento.Checked ;

      If RadTipoDC.ItemIndex = 0 then FieldByName('DEBITOCREDITO').AsString := 'D'
      else FieldByName('DEBITOCREDITO').AsString := 'C' ;
      Post         ;
      Close        ;
      LimpaTela()  ;
    end;
  end;
end;

//--------------------- Limpa tela ---------------------\\
procedure TCNTFormHistorico.BitLimpaClick(Sender: TObject);
begin
   LimpaTela();
end;

//-------------------- Fecha tela ----------------------\\
procedure TCNTFormHistorico.BitFechaClick(Sender: TObject);
begin
  achou := False ;
  Close;
end;

//---------------- Exclui Historico ---------------------\\
procedure TCNTFormHistorico.BitExcluiClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o histórico ?',mtconfirmation, [mbYes, mbNo],1) = mrYes then
     Begin
       With DMContas.TbHistorico do
       Begin
         Active := True              ;
         FindKey([ EdiCodigo.Text ]) ;
         Delete      ;
         Close       ;
         LimpaTela() ;
       end;
     end;
end;

//------ Tranz Form da Pesquisa --------\\
procedure TCNTFormHistorico.TrazPesquisa();
Begin
  With DMContas.TbHistorico do
  Active := True  ;
  Begin
    if DMContas.TbHistorico.Eof then
       MessageDlg('Nenhum histórico cadastrado ?', mtInformation, [mbOk], 0)
    else
    Begin
      With TCNTFormPesquisaHistorico.Create(Self) Do
      Begin
        ShowModal ;
        Free      ;
      end;
      If achou then MostraHistorico()
      else Exit;
    end;
  end;
end;

//------------ Mostra Historico -----------\\
procedure TCNTFormHistorico.MostraHistorico();
Begin
  With DMContas.TbHistorico do
  Begin
    EdiCodigo.Text              := FieldByName('CODIGO'     ).AsString  ;
    EdiDescricao.Text           := FieldByName('DESCRICAO'  ).AsString  ;
    CheckBoxComplemento.Checked := FieldByName('COMPLEMENTO').AsBoolean ;

    If FieldByName('DebitoCredito').AsString = 'D' then RadTipoDC.ItemIndex := 0
    else RadTipoDC.ItemIndex := 1;

    SpePesquisaHistorico.Enabled := False ;
    SpePesquisaHistorico.Flat    := True  ;
    SpeProximoHistorico.Enabled  := False ;
    SpeProximoHistorico.Flat     := True  ;
    EdiCodigo.Enabled            := False ;
    EdiDescricao.SetFocus                 ;
  end;
end;

//----------- Habilita Botoes ------------\\
procedure TCNTFormHistorico.HabilitaBotoes();
Begin
  BitExclui.Enabled  := False ;
  BitLimpa.Enabled   := False ;
  BitGrava.Enabled   := False ;
  If achou then BitExclui.Enabled := True ;
  If Trim( EdiCodigo.Text ) <> '' then
    begin
      BitLimpa.Enabled  := True ;
      BitGrava.Enabled  := True ;
    end;
end;

//---------- Limpa Tela -------------\\
procedure TCNTFormHistorico.LimpaTela();
begin
  // Limpa os Campos
  EdiCodigo.Text               := ''          ;
  EdiDescricao.Text            := ''          ;
  RadTipoDC.ItemIndex          := 0           ;

  // Controla os Botoes
  SpePesquisaHistorico.Enabled := True  ;
  SpePesquisaHistorico.Flat    := False ;
  SpeProximoHistorico.Enabled  := True  ;
  SpeProximoHistorico.Flat     := False ;
  EdiCodigo.Enabled            := True  ;
  achou                        := False ;
  EdiCodigo.SetFocus           ;
  HabilitaBotoes()             ;
end;


end.


