unit CTR_CadastroDeLembretes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Menus, ExtCtrls, DB, DBTables, Mask, ToolEdit,
  Confirma,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TFrmCTR_CadastroDeLembretes = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Sada1: TMenuItem;
    QryPesquisa: TQuery;
    PnlBotoes: TPanel;
    Confirma1: TConfirma;
    Label1: TLabel;
    Label2: TLabel;
    MemoLembrete: TMemo;
    DEdtAtencao: TDateEdit;
    DEdtValidade: TDateEdit;
    PMenuCores: TPopupMenu;
    IMenuCorDoFundo: TMenuItem;
    IMenuCorDoTexto: TMenuItem;
    ColorDialog1: TColorDialog;
    Panel2: TPanel;
    PnlCorAtencao: TPanel;
    PnlCorNormal: TPanel;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Sada1Click(Sender: TObject);
    procedure Confirma1Click(Sender: TObject);
    procedure DEdtAtencaoExit(Sender: TObject);
    procedure MemoLembreteExit(Sender: TObject);
    procedure IMenuCorDoFundoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vDataHora  : TDateTime ;
  end;

var
  FrmCTR_CadastroDeLembretes: TFrmCTR_CadastroDeLembretes;

implementation

uses Bgm_Tela,
     Bgm_String,
     Bgm_Dados,
     MenuPrincipal,
     {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{$R *.dfm}

procedure TFrmCTR_CadastroDeLembretes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree ;
end;

procedure TFrmCTR_CadastroDeLembretes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
end;

procedure TFrmCTR_CadastroDeLembretes.FormShow(Sender: TObject);
Var i : Integer ;
begin

  With QryPesquisa do
  Begin
    Close ;
    Sql.Clear ;
    SQL.Add(' SELECT'+
            '  A.LEMBRETE'+
            ' ,A.DATAVALIDADE'+
            ' ,A.DATAATENCAO'+
            ' ,A.CORLEMBRETE'+
            ' ,A.CORFONTLEMBRETE'+
            ' ,A.CORATENCAO'+
            ' ,A.CORFONTATENCAO'+
            '') ;
    SQL.Add(' FROM'+
            ' CTR_LEMBRETES A'+
            IIf(vDataHora = 0,',(SELECT MAX(DATALEMBRETE) AS DATALEMBRETE'
                             +'  FROM CTR_LEMBRETES'
                             +'  WHERE USUARIO = :P_USUARIO AND SISTEMA = :P_SISTEMA) B'
                             ,'')+
            '') ;
    SQL.Add(' WHERE'+
            '     A.USUARIO = :P_USUARIO'+
            ' AND A.SISTEMA = :P_SISTEMA'+
            '') ;
    If vDataHora = 0 Then
      SQL.Add(' AND A.DATALEMBRETE = B.DATALEMBRETE')
    Else // If vDataHora = 0 Then
    Begin
      SQL.Add(' AND A.DATALEMBRETE = :P_DATALEMBRETE') ;
      ParamByName('P_DATALEMBRETE').AsDateTime := vDataHora ;
    End ; // Else // If vDataHora = 0 Then
    ParamByName('P_USUARIO').AsString := vcUsuario ;
    ParamByName('P_SISTEMA').AsString := vcSistema ;

    If AbrirQuery(QryPesquisa,'PesqLenbrete').Achou Then
    Begin
      If vDataHora <> 0 Then
      Begin
        MemoLembrete.Text := FieldByName('LEMBRETE'    ).AsString ;
        DEdtAtencao.Date  := FieldByName('DATAATENCAO' ).AsDateTime ;
        DEdtValidade.Date := FieldByName('DATAVALIDADE').AsDateTime ;
      End ; // If vDataHora <> 0 Then
      PnlCorNormal.Color      := StringToColor(FieldByName('CORLEMBRETE'    ).AsString) ;
      PnlCorNormal.Font.Color := StringToColor(FieldByName('CORFONTLEMBRETE').AsString) ;
      If FieldByName('DATAATENCAO').AsDateTime <> 0 Then
      Begin
        PnlCorAtencao.Color      := StringToColor(FieldByName('CORATENCAO'     ).AsString) ;
        PnlCorAtencao.Font.Color := StringToColor(FieldByName('CORFONTATENCAO' ).AsString) ;
      End ; // If DEdtAtencao.Date <> 0 Then
    End ; // If AbrirQuery(...
  End ; // With QryPesquisa do

  PosicionaBotoes(PnlBotoes) ;
  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt }
end;

procedure TFrmCTR_CadastroDeLembretes.Sada1Click(Sender: TObject);
begin
  Close ;
end;

procedure TFrmCTR_CadastroDeLembretes.Confirma1Click(Sender: TObject);
begin
  If vcDataBase.InTransaction Then vcDataBase.Rollback ;
  vcDataBase.StartTransaction ;

  With QryPesquisa do
  Begin
    Close ;
    Sql.Clear ;
    If vDataHora = 0 Then
    Begin
      Sql.Add(' INSERT INTO CTR_LEMBRETES ('+
              '  USUARIO'+
              ' ,SISTEMA'+
              ' ,DATALEMBRETE'+
              ' ,LEMBRETE'+
              ' ,DATAVALIDADE'+
              ' ,DATAATENCAO'+
              ' ,CORLEMBRETE'+
              ' ,CORFONTLEMBRETE'+
              ' ,CORATENCAO'+
              ' ,CORFONTATENCAO'+
              ' ') ;
      Sql.Add(' ) VALUES ('+
              '  :P_USUARIO'+
              ' ,:P_SISTEMA'+
              ' ,:P_DATALEMBRETE'+
              ' ,:P_LEMBRETE'+
              ' ,:P_DATAVALIDADE'+
              ' ,:P_DATAATENCAO'+
              ' ,:P_CORLEMBRETE'+
              ' ,:P_CORFONTLEMBRETE'+
              ' ,:P_CORATENCAO'+
              ' ,:P_CORFONTATENCAO'+
              ' )') ;
      vDataHora := Now ;       
    End Else // If vDataHora = 0 Then
    Begin
      Sql.Add(' UPDATE CTR_LEMBRETES SET'+
              '  LEMBRETE        = :P_LEMBRETE'+
              ' ,DATAVALIDADE    = :P_DATAVALIDADE'+
              ' ,DATAATENCAO     = :P_DATAATENCAO'+
              ' ,CORLEMBRETE     = :P_CORLEMBRETE'+
              ' ,CORFONTLEMBRETE = :P_CORFONTLEMBRETE'+
              ' ,CORATENCAO      = :P_CORATENCAO'+
              ' ,CORFONTATENCAO  = :P_CORFONTATENCAO'+
              ' ') ;
      Sql.Add(' WHERE '+
              '     USUARIO      = :P_USUARIO'+
              ' AND SISTEMA      = :P_SISTEMA'+
              ' AND DATALEMBRETE = :P_DATALEMBRETE'+
              ' ') ;
    End ; // End Else // If vDataHora = 0 Then

    ParamByName('P_USUARIO'        ).AsString   := vcUsuario ;
    ParamByName('P_SISTEMA'        ).AsString   := vcSistema ;
    ParamByName('P_DATALEMBRETE'   ).AsDateTime := vDataHora ;
    ParamByName('P_LEMBRETE'       ).AsString   := StringReplace(MemoLembrete.Text, Chr(13) + Chr(10),'',[rfReplaceAll]) ;
    ParamByName('P_CORLEMBRETE'    ).AsString   := ColorToString(PnlCorNormal.Color) ;
    ParamByName('P_CORFONTLEMBRETE').AsString   := ColorToString(PnlCorNormal.Font.Color) ;
    If DEdtAtencao.Date = 0 Then
    Begin
      ParamByName('P_DATAATENCAO'   ).AsString  := '' ;
      ParamByName('P_CORATENCAO'    ).AsString  := '' ;
      ParamByName('P_CORFONTATENCAO').AsString  := '' ;
    End Else // If DEdtAtencao.Date = 0 Then
    Begin
      ParamByName('P_DATAATENCAO'   ).AsDateTime := DEdtAtencao.Date ;
      ParamByName('P_CORATENCAO'    ).AsString   := ColorToString(PnlCorAtencao.Color) ;
      ParamByName('P_CORFONTATENCAO').AsString   := ColorToString(PnlCorAtencao.Font.Color) ;
    End ; // End Else // If DEdtAtencao.Date = 0 Then

    If DEdtValidade.Date = 0 Then
      ParamByName('P_DATAVALIDADE').AsString   := ''
    Else
      ParamByName('P_DATAVALIDADE').AsDateTime := DEdtValidade.Date ;

    ExecSQL ;
  End ; // With QryPesquisa do

  vDataHora := -1 ;
  vcDataBase.Commit ;
  Sada1Click(Sender) ;
end;

procedure TFrmCTR_CadastroDeLembretes.DEdtAtencaoExit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) and (vTAB)) Then
  Begin
    vEsc := False ;
    Exit ;
  End ; // If vEsc Or (...

  If (TDateEdit(Sender).Date <> 0) And (TDateEdit(Sender).Date < Date) Then
  Begin
    MensagemDlg('A data não pode ser inferior à data atual.',mtInformacao,mbOk) ;
    TDateEdit(Sender).SetFocus ;
  End ; // If (TDateEdit(Sender).Date <> 0) And (...
end;

procedure TFrmCTR_CadastroDeLembretes.MemoLembreteExit(Sender: TObject);
begin
  If (vEsc) Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) and (vTAB)) Or (Trim(MemoLembrete.Text) = '')Then
  begin
    vEsc := False;
    MemoLembrete.SetFocus ;
  End ; // If (vEsc) Or (...
end;

procedure TFrmCTR_CadastroDeLembretes.IMenuCorDoFundoClick(Sender: TObject);
Var
  vNomePanel : String ;
  vNormal    : Boolean ;
begin
  If TMenuItem(Sender).Enabled And ColorDialog1.Execute Then
  Begin
    vNormal    := PMenuCores.PopupComponent = PnlCorNormal ;
    vNomePanel := 'PnlCor' + IIf(vNormal,'Normal','Atencao') ;

    If ColorDialog1.Color = TPanel(FindComponent('PnlCor' + IIf(vNormal,'Atencao','Normal') )).Color Then
      MensagemDlg('A cor '  + IIf(vNormal,'normal'    ,'de atenção') + ' não pode ser a mesma '
                 +'da cor ' + IIf(vNormal,'de atenção','normal'    ) + '.',MtInformacao,MbOk)
    Else // If ColorDialog1.Color = TPanel(...
    Begin
      If TMenuItem(Sender) = IMenuCorDoFundo Then
        TPanel(FindComponent(vNomePanel)).Color      := ColorDialog1.Color
      Else
        TPanel(FindComponent(vNomePanel)).Font.Color := ColorDialog1.Color ;
    End ; // Else // If ColorDialog1.Color = TPanel(...
  End ; // If TMenuItem(Sender).Enabled And ...
end;

end.


