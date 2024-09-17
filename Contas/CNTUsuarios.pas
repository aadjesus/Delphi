unit CNTUsuarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, Menus, ActnList, jpeg;

type
  TCNTFormUsuario = class(TForm)
    ImagePrincipal: TImage;
    PanelBotoes: TPanel;
    BitGrava: TBitBtn;
    BitLimpa: TBitBtn;
    BitFecha: TBitBtn;
    BitExclui: TBitBtn;
    PanelUsuario: TPanel;
    LabCodigo: TLabel;
    LabNome: TLabel;
    SpePesquisaUsuario: TSpeedButton;
    SpeProximoUsuario: TSpeedButton;
    LadCidade: TLabel;
    LabUf: TLabel;
    LabCep: TLabel;
    LabEndereco: TLabel;
    LabBairro: TLabel;
    LabRg: TLabel;
    LabTelefone: TLabel;
    LabCpf: TLabel;
    LabFax: TLabel;
    EdiCodigo: TEdit;
    EdiNome: TEdit;
    EdiCidade: TEdit;
    EdiUf: TEdit;
    EdiCep: TEdit;
    EdiEndereco: TEdit;
    EdiBairro: TEdit;
    EdiRg: TEdit;
    EdiTelefone: TEdit;
    EdiCpf: TEdit;
    EdiFax: TEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BitLimpaClick(Sender: TObject);
    procedure BitFechaClick(Sender: TObject);
    procedure EdiCodigoExit(Sender: TObject);
    procedure BitGravaClick(Sender: TObject);
    procedure BitExcluiClick(Sender: TObject);
    procedure SpePesquisaUsuarioClick(Sender: TObject);
    procedure EdiCodigoChange(Sender: TObject);
    procedure SpeProximoUsuarioClick(Sender: TObject);
  private
    { Private declarations }

    procedure MostraUsuario  ;
    procedure HabilitaBotoes ;
    procedure LimpaTela      ;
    procedure TrazPesquisa   ;
  public
    { Public declarations }
  end;

var
  CNTFormUsuario: TCNTFormUsuario ;
  Achou         : Boolean         ;

implementation

{$R *.DFM}

uses CNTPesquisaUsuario, CNTDataModuleContas ;
{
//------- Evento OnCreate --------------------------\\
procedure TCNTFormUsuario.FormCreate(Sender: TObject);
begin
  left := Application.MainForm.Left;
  top  := Application.MainForm.top+41;
end;
}

//------- Simula Enter ao inves de Tab ( Evento KeyPress ) ----------\\
procedure TCNTFormUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
  Begin
    Key := #0;
    Perform( WM_NEXTDLGCTL, 0, 0 );
  end;
end;

//------- Evento OnShow --------------------------\\
procedure TCNTFormUsuario.FormShow(Sender: TObject);
begin
  EdiCodigo.SetFocus  ;
  HabilitaBotoes()    ;
end;

//------- Evento OnChange -------------------------------\\
procedure TCNTFormUsuario.EdiCodigoChange(Sender: TObject);
begin
  HabilitaBotoes() ;
end;

//------- Evento OnExit -------------------------------\\
procedure TCNTFormUsuario.EdiCodigoExit(Sender: TObject);
begin
  If BitFecha.Focused then Exit ;

  // Tranz o Form da Pesquisa se o codigo
  If EdiCodigo.Text = '' then TrazPesquisa()
  Else
    begin // Pesquisa se ja nao existe o usuario
      With DMContas.TbUsuarios do
      begin
        Active         := True  ;
        EdiCodigo.Text := Copy( '00000', 1, 5-Length(Trim(EdiCodigo.Text))) + Trim(EdiCodigo.Text);
        If FindKey([ EdiCodigo.Text ]) then
          begin
            Achou := True   ;
            MostraUsuario() ;
          end
        else Close ;
      end;
    end;

  If Trim( EdiCodigo.Text ) <> '' then
    Begin
      SpePesquisaUsuario.Enabled := False ;
      SpePesquisaUsuario.Flat    := True  ;
      SpeProximoUsuario.Enabled  := False ;
      SpeProximoUsuario.Flat     := True  ;
      EdiCodigo.Enabled          := False ;
      EdiNome.SetFocus                    ;
    end
  else EdiCodigo.SetFocus ;

  HabilitaBotoes() ;
end;

//------- Botao Pesquisa Usuario --------------------------------\\
procedure TCNTFormUsuario.SpePesquisaUsuarioClick(Sender: TObject);
Begin
  If not Achou then TrazPesquisa()
end;

//------- Proximo Usuario --------------------------------------\\
procedure TCNTFormUsuario.SpeProximoUsuarioClick(Sender: TObject);
var
  CodUsuario : String ;
begin
  With DMContas.TbUsuarios do
  Begin
    Active := True ;
    If RecordCount = 0 then EdiCodigo.Text := '00001'
    else
      Begin
        Last           ;
        CodUsuario     := IntToStr(FieldByName( 'CODIGO' ).AsInteger + 1) ;
        EdiCodigo.Text := Copy( '00000', 1, 5-Length(Trim(CodUsuario))) + Trim(CodUsuario);
        Close          ;
      end;
  end;
  EdiNome.SetFocus  ;
end;

//------- Botao Grava ---------------------------------\\
procedure TCNTFormUsuario.BitGravaClick(Sender: TObject);
begin
  If Trim( EdiNome.Text ) = '' then
  begin
    MessageDlg('O nome do usuário não pode ficar em branco ?', mtInformation, [mbOk], 0) ;
    EdiNome.SetFocus  ;
    Exit ;
  End ;

  With DMContas.TbUsuarios do
  If Achou then Edit
  else
  begin
    Open    ;
    Append  ;
  End;

  Begin
    With DMContas.TbUsuarios do
    begin
      EdiCodigo.Enabled := True ;
      FieldByName( 'CODIGO'  ).AsString := EdiCodigo.Text   ;
      FieldByName( 'NOME'    ).AsString := EdiNome.Text     ;
      FieldByName( 'ENDERECO').AsString := EdiEndereco.Text ;
      FieldByName( 'BAIRRO'  ).AsString := EdiBairro.Text   ;
      FieldByName( 'CIDADE'  ).AsString := EdiCidade.Text   ;
      FieldByName( 'UF'      ).AsString := EdiUf.Text       ;
      FieldByName( 'CEP'     ).AsString := EdiCep.Text      ;
      FieldByName( 'RG'      ).AsString := EdiRg.Text       ;
      FieldByName( 'CPF'     ).AsString := EdiCpf.Text      ;
      FieldByName( 'TELEFONE').AsString := EdiTelefone.Text ;
      Post         ;
      Close        ;
      LimpaTela()  ;
    end;
  end;
end;

//------- Botao Limpa ---------------------------------\\
procedure TCNTFormUsuario.BitLimpaClick(Sender: TObject);
begin
  LimpaTela();
end;

//------- Botao Fecha ---------------------------------\\
procedure TCNTFormUsuario.BitFechaClick(Sender: TObject);
begin
  Achou := False ;
  Close        ;
end;

//------- Botao Exclui ---------------------------------\\
procedure TCNTFormUsuario.BitExcluiClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o usuário ?',mtconfirmation, [mbYes, mbNo],1) = mrYes then
     Begin
       With DMContas.TbUsuarios do
       Begin
         Active := True              ;
         FindKey([ EdiCodigo.Text ]) ;
         Delete      ;
         Close       ;
         LimpaTela() ;
       end;
     end;
end;

//------- Tranz Form da Pesquisa ------\\
procedure TCNTFormUsuario.TrazPesquisa();
Begin
  With DMContas.TbUsuarios do
  Active := True  ;
  Begin
    if DMContas.TbUsuarios.Eof then
       MessageDlg('Nenhum usuário cadastrado ?', mtInformation, [mbOk], 0)
    else
    Begin
      With TCNTFormPesquisaUsuario.Create(Self) Do
      Begin
        ShowModal ;
        Free      ;
      end;
      If Achou then MostraUsuario()
      else Exit ;
    end;
  end;
end;

//------- Mostra Usuario ---------------\\
procedure TCNTFormUsuario.MostraUsuario();
Begin
  With DMContas.TbUsuarios do
  Begin
    EdiCodigo.Text   := FieldByName( 'CODIGO'  ).AsString ;
    EdiNome.Text     := FieldByName( 'NOME'    ).AsString ;
    EdiEndereco.Text := FieldByName( 'ENDERECO').AsString ;
    EdiBairro.Text   := FieldByName( 'BAIRRO'  ).AsString ;
    EdiCidade.Text   := FieldByName( 'CIDADE'  ).AsString ;
    EdiUf.Text       := FieldByName( 'UF'      ).AsString ;
    EdiCep.Text      := FieldByName( 'CEP'     ).AsString ;
    EdiRg.Text       := FieldByName( 'RG'      ).AsString ;
    EdiCpf.Text      := FieldByName( 'CPF'     ).AsString ;
    EdiTelefone.Text := FieldByName( 'TELEFONE').AsString ;

    SpePesquisaUsuario.Enabled := False ;
    SpePesquisaUsuario.Flat    := True  ;
    SpeProximoUsuario.Enabled  := False ;
    SpeProximoUsuario.Flat     := True  ;
    EdiCodigo.Enabled          := False ;
    EdiNome.SetFocus                    ;
  end;
end;

//------- Habilita Botoes ---------------\\
procedure TCNTFormUsuario.HabilitaBotoes();
Begin
  BitExclui.Enabled := False ;
  BitLimpa.Enabled  := False ;
  BitGrava.Enabled  := False ;
  If Achou then BitExclui.Enabled := True ;
  If Trim( EdiCodigo.Text ) <> '' then
    begin
      BitLimpa.Enabled  := True ;
      BitGrava.Enabled  := True ;
    end;
end;

//------- Limpa Tela ---------------\\
procedure TCNTFormUsuario.LimpaTela();
var I : Integer;
begin
  For i := 0 to ComponentCount - 1 do
  Begin
     If Components[i] is TEdit then TEdit(Components[i]).Text := '' ;
  End;
  SpePesquisaUsuario.Enabled := True  ;
  SpePesquisaUsuario.Flat    := False ;
  SpeProximoUsuario.Enabled  := True  ;
  SpeProximoUsuario.Flat     := False ;
  EdiCodigo.Enabled          := True  ;
  Achou                      := False ;
  EdiCodigo.SetFocus         ;
  HabilitaBotoes()           ;
end;

end.

