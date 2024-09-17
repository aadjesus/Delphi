unit CTR_HelpDoUsuario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, Menus, Buttons, Confirma,
  RxMemDS, DB, DBTables,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TFrmCTR_HelpDoUsuario = class(TForm)
    PnlTopicos: TPanel;
    DBGridTopicos: TDBGrid;
    PMenuTopicos: TPopupMenu;
    IMenuIncluir: TMenuItem;
    IMenuAlterar: TMenuItem;
    IMenuExcluir: TMenuItem;
    PnlTelaTopicos: TPanel;
    PnlBotoes: TPanel;
    PnlDadosTopico: TPanel;
    Confirma1: TConfirma;
    MemoTopico: TMemo;
    DSTopicos: TDataSource;
    QryPesquisa: TQuery;
    MDTopicos: TRxMemoryData;
    PnlTopico: TPanel;
    CBoxMostra: TCheckBox;
    Label1: TLabel;
    EdtTopico: TEdit;
    MainMenu1: TMainMenu;
    Sada1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure PMenuTopicosPopup(Sender: TObject);
    procedure IMenuIncluirClick(Sender: TObject);
    procedure DBGridTopicosTitleClick(Column: TColumn);
    procedure EdtTopicoExit(Sender: TObject);
    procedure Confirma1Click(Sender: TObject);
    procedure MDTopicosAfterScroll(DataSet: TDataSet);
    procedure Sada1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vNomeTela : String ;
    vNomeForm : String ;
  end;

var
  FrmCTR_HelpDoUsuario: TFrmCTR_HelpDoUsuario;

implementation

uses MenuPrincipal,
     BGM_String,
     BGM_Tela,
     BGM_Dados,
     {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{$R *.dfm}

procedure TFrmCTR_HelpDoUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmCTR_HelpDoUsuario.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
end;

procedure TFrmCTR_HelpDoUsuario.FormShow(Sender: TObject);
var
  I: integer;
begin
  Caption := vNomeTela ;

  With QryPesquisa do
  Begin
    Close ;
    SQL.Clear ;
    SQL.Add(' SELECT'+
            '  TOPICO'+
            ' ,TEXTOTOPICO'+
            ' ,MOSTRAPRATODOS'+
            '') ;
    SQL.Add(' FROM'+
            ' CTR_HELPDOUSUARIO') ;
    SQL.Add(' WHERE'+
            '     SISTEMA  = :P_SISTEMA'+
            ' AND FORM     = :P_FORM'+
            ' AND (USUARIO = :P_USUARIO'+
            ' OR   MOSTRAPRATODOS = ''S'') '+
            '') ;
    ParamByName('P_SISTEMA').AsString := vcSistema ;
    ParamByName('P_USUARIO').AsString := vcUsuario ;
    ParamByName('P_FORM'   ).AsString := vNomeForm ;
    AbrirQuery(QryPesquisa,'PesqHelpUsuario') ;
    MDTopicos.LoadFromDataSet(QryPesquisa,0,lmCopy) ;
  End ; // With QryPesquisa do

  PosicionaBotoes(PnlBotoes) ;
  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt}
end;

procedure TFrmCTR_HelpDoUsuario.PMenuTopicosPopup(Sender: TObject);
begin
  IMenuAlterar.Visible := Not MDTopicos.IsEmpty ;
  IMenuExcluir.Visible := IMenuAlterar.Visible ;
end;

procedure TFrmCTR_HelpDoUsuario.IMenuIncluirClick(Sender: TObject);
begin
  If Not TMenuItem(Sender).Visible Then Exit ;

  If Sender = IMenuExcluir Then
  Begin
    If vcDataBase.InTransaction Then vcDataBase.Rollback ;
    vcDataBase.StartTransaction ;

    With QryPesquisa Do
    Begin
      Close ;
      Sql.Clear ;
      SQL.Add(' DELETE'+
              ' CTR_HELPDOUSUARIO'+
              '') ;
      Sql.Add(' WHERE'+
              '     SISTEMA = :P_SISTEMA'+
              ' AND USUARIO = :P_USUARIO'+
              ' AND FORM    = :P_FORM'+
              ' AND TOPICO  = :P_TOPICO'+
              '') ;
      ParamByName('P_SISTEMA').AsString := vcSistema ;
      ParamByName('P_USUARIO').AsString := vcUsuario ;
      ParamByName('P_FORM'   ).AsString := vNomeForm ;
      ParamByName('P_TOPICO' ).AsString := Trim(EdtTopico.Text) ;
      ExecSql ;
    End ; // With QryPesquisa Do
    vcDataBase.Commit ;

    MDTopicos.DisableControls ;
    MDTopicos.Delete ;
    MDTopicos.EnableControls ;
  End Else // If Sender = IMenuExcluir Then
  Begin
    PnlBotoes.Visible  := True ;
    PnlTopico.Visible  := PnlBotoes.Visible ;
    PnlTopicos.Enabled := False ;
    If Sender = IMenuIncluir Then
    Begin
      EdtTopico.Clear ;
      MemoTopico.Clear ;
      CBoxMostra.Checked  := True ;
      EdtTopico.Enabled   := True ;
      MemoTopico.ReadOnly := False ;
      EdtTopico.SetFocus ;
    End Else // If Sender = IMenuIncluir Then
    Begin
      EdtTopico.Enabled   := False ;
      CBoxMostra.SetFocus ;
    End ; // End Else // If Sender = IMenuIncluir Then
  End ; // If Sender = IMenuIncluir Then
end;

procedure TFrmCTR_HelpDoUsuario.DBGridTopicosTitleClick(Column: TColumn);
begin
  OrdenaColunas(Column) ;
end;

procedure TFrmCTR_HelpDoUsuario.EdtTopicoExit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) And $1000000) <> 0) And (vTAB)) Then
  Begin
    vEsc := False ;
    If TComponent(Sender) = EdtTopico Then
    Begin
      PnlBotoes.Visible   := False ;
      PnlTopico.Visible   := PnlBotoes.Visible ;
      PnlTopicos.Enabled  := True ;
      MemoTopico.ReadOnly := True ;
      DBGridTopicos.SetFocus ;
    End ; // If TComponent(Sender) = EdtTopico Then
    Exit ;
  End ;  // If
  If Trim((Sender As TCustomEdit).Text) = '' Then (Sender As TCustomEdit).SetFocus ;
end;

procedure TFrmCTR_HelpDoUsuario.Confirma1Click(Sender: TObject);
Var
  vAchou : Boolean ;
begin
  With MDTopicos do
  Begin
    DisableControls ;
    vAchou := Locate('TOPICO',Trim(EdtTopico.Text),[loCaseInsensitive]) ;
    If Not vAchou Then
      Append ;
    Edit ;
    FieldByName('TOPICO'        ).AsString := Trim(EdtTopico.Text) ;
    FieldByName('TEXTOTOPICO'   ).AsString := MemoTopico.Text ;
    FieldByName('MOSTRAPRATODOS').AsString := IIf(CBoxMostra.Checked,'S','N') ;
    Post ;
    EnableControls ;

    If vcDataBase.InTransaction Then vcDataBase.Rollback ;
    vcDataBase.StartTransaction ;

    With QryPesquisa Do
    Begin
      Close ;
      Sql.Clear ;
      If vAchou Then
      Begin
        SQL.Add(' UPDATE'+
                ' CTR_HELPDOUSUARIO'+
                '') ;
        SQL.Add(' SET'+
                '  TEXTOTOPICO    = :P_TEXTOTOPICO'+
                ' ,MOSTRAPRATODOS = :P_MOSTRAPRATODOS'+
                '') ;
        Sql.Add(' WHERE'+
                '     SISTEMA = :P_SISTEMA'+
                ' AND USUARIO = :P_USUARIO'+
                ' AND FORM    = :P_FORM'+
                ' AND TOPICO  = :P_TOPICO'+
                '') ;
      End Else // If vAchou Then
      Begin
        SQL.Add(' INSERT INTO CTR_HELPDOUSUARIO ('+
                '  USUARIO'+
                ' ,SISTEMA'+
                ' ,FORM'+
                ' ,TOPICO'+
                ' ,TEXTOTOPICO'+
                ' ,MOSTRAPRATODOS'+
                '') ;
        SQL.Add(') VALUES ('+
                '  :P_USUARIO'+
                ' ,:P_SISTEMA'+
                ' ,:P_FORM'+
                ' ,:P_TOPICO'+
                ' ,:P_TEXTOTOPICO'+
                ' ,:P_MOSTRAPRATODOS'+
                ' )') ;
      End ; // End Else // If vAchou Then
      ParamByName('P_SISTEMA'       ).AsString := vcSistema ;
      ParamByName('P_USUARIO'       ).AsString := vcUsuario ;
      ParamByName('P_FORM'          ).AsString := vNomeForm ;
      ParamByName('P_TOPICO'        ).AsString := Trim(EdtTopico.Text) ;
      ParamByName('P_TEXTOTOPICO'   ).AsString := MemoTopico.Text ;
      ParamByName('P_MOSTRAPRATODOS').AsString := IIf(CBoxMostra.Checked,'S','N') ;
      ExecSql ;
    End ; // With QryPesquisa Do
    vcDataBase.Commit ;

    vEsc := True ;
    EdtTopicoExit(EdtTopico) ;
  End ; // With MDTopicos do
end;

procedure TFrmCTR_HelpDoUsuario.MDTopicosAfterScroll(DataSet: TDataSet);
begin
  If Not PnlBotoes.Visible Then
  Begin
    EdtTopico.Text      := MDTopicos.FieldByName('TOPICO'        ).AsString ;
    CBoxMostra.Checked  := MDTopicos.FieldByName('MOSTRAPRATODOS').AsString = 'S' ;
    MemoTopico.Text     := MDTopicos.FieldByName('TEXTOTOPICO'   ).AsString ;
  End ; // If Not PnlBotoes.Visible Then
end;

procedure TFrmCTR_HelpDoUsuario.Sada1Click(Sender: TObject);
begin
  Close ;
end;

end.
