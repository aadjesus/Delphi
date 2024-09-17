unit CTR_CadastroDeAtalhos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Buttons, ComCtrls, ExtCtrls, StdCtrls, Db, RxMemDS, DBTables,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TFrmCTR_CadastroDeAtalhos = class(TForm)
    PnlMenus: TPanel;
    Pnl: TPanel;
    TViewMenu: TTreeView;
    Panel2: TPanel;
    MainMenu1: TMainMenu;
    Sada1: TMenuItem;
    Label1: TLabel;
    EdtTecla: TEdit;
    SButCopiar: TSpeedButton;
    SButLimpar: TSpeedButton;
    RMDataTeclas: TRxMemoryData;
    QryPesquisa: TQuery;
    Panel1: TPanel;
    SButExpande: TSpeedButton;
    SButCompacta: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Sada1Click(Sender: TObject);
    procedure TViewMenuChange(Sender: TObject; Node: TTreeNode);
    procedure TViewMenuExit(Sender: TObject);
    procedure SButExpandeClick(Sender: TObject);
    procedure EdtTeclaExit(Sender: TObject);
    procedure EdtTeclaKeyPress(Sender: TObject; var Key: Char);
    procedure EdtTeclaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SButCopiarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCTR_CadastroDeAtalhos: TFrmCTR_CadastroDeAtalhos;

implementation

uses Bgm_Tela,
     Bgm_String,
     Bgm_Dados,
     MenuPrincipal,
     {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{$R *.DFM}

procedure TFrmCTR_CadastroDeAtalhos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := Cafree ;
end;

procedure TFrmCTR_CadastroDeAtalhos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
end;

procedure TFrmCTR_CadastroDeAtalhos.FormShow(Sender: TObject);
Var
  i        : Integer ;
  Nivel0,
  Nivel1   : TTreeNode ;
  vCaption : String ;
begin
  Nivel0 := Nil ;
  Nivel1 := Nil ;
  With frmMenuPrincipal.ContSenhaBgm.vMDTeclas do
  Begin
    SortOnFields('INDICEMENU') ;
    DisableControls ;
    First ;
    While Not Eof do
    Begin
      If (Pos(UpperCase(FieldByName('CAPTION').AsString),'-'
                                                        +'SOBRE O SISTEMA')   > 0) Or
         (Pos(UpperCase(FieldByName('NOME'   ).AsString),'SAIDA'
                                                        +'AJUDA1'
                                                        +'AJUDADOMODULO'
                                                        +'AJUDASOBRESISTEMA') > 0) Then
      Begin
        Next ;
        Continue ;
      End ; // If (Pos(UpperCase(FieldByName('CAPTION').AsString),...

      vCaption := Pad(FieldByName('CAPTION').AsString,62 + IIf(Length(FieldByName('INDICEMENU').AsString) = 2,6,
                                                           IIf(Length(FieldByName('INDICEMENU').AsString) = 4,3,0)) ) + 
                  Pad(FieldByName('TECLAS' ).AsString,7) ;

      If Length(FieldByName('INDICEMENU').AsString) = 2 Then
        Nivel0 := TViewMenu.Items.Add(Nil,vCaption)
      Else
      If Length(FieldByName('INDICEMENU').AsString) = 4 Then
        Nivel1 := TViewMenu.Items.AddChild(Nivel0,vCaption)
      Else
        TViewMenu.Items.AddChild(Nivel1,vCaption) ;

      Edit ;
      FieldByName('ABSOLUTEINDEX').AsInteger := TViewMenu.Items[TViewMenu.Items.Count-1].AbsoluteIndex ;
      Post ;
      Next ;
    End ; // While Not Eof do

    First ;
    EnableControls ;
  End ; // With RMDataTeclas do

  TViewMenu.SetFocus ;

  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt }
end;

procedure TFrmCTR_CadastroDeAtalhos.Sada1Click(Sender: TObject);
Var
  vGravar : Boolean ;
begin
  Close ;

  frmMenuPrincipal.ContSenhaBgm.vMDTeclas.SortOnFields('GRAVATECLAS') ;
  frmMenuPrincipal.ContSenhaBgm.vMDTeclas.First ;
  If Not frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Locate('GRAVATECLAS','S',[LocaseInsensitive]) Then
    Exit ;

  vGravar := MensagemDlg('Confirma a gravação dos atalhos cadastrados?',mtConfirmacao,mbSim+mbNao) = mbSim ;

  If vGravar Then
  Begin
    If vcDataBase.InTransaction Then vcDataBase.Rollback ;
    vcDataBase.StartTransaction ;

    With QryPesquisa Do
    Begin
      Close ;
      Sql.Clear ;
      Sql.Add(' UPDATE CTR_MENUS' + IIf(frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FindField('USUARIO') <> Nil,'AOUSUARIO','DOSISTEMA') + ' SET'+
              ' TECLAS = :P_TECLAS') ;
      Sql.Add(' WHERE'+
              '     SISTEMA    = :P_SISTEMA'+
              ' AND INDICEMENU = :P_INDICEMENU'+
              ' AND NOME       = :P_NOME') ;
      If frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FindField('USUARIO') <> Nil Then
      Begin
        Sql.Add(' AND USUARIO = :P_USUARIO') ;
        ParamByName('P_USUARIO' ).AsString := frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('USUARIO').AsString ;
      End ; // If FindField('USUARIO') <> Nil Then
      ParamByName('P_SISTEMA'   ).AsString := vcSistema ;
    End ; // With QryPesquisa Do
  End ; // If vGravar Then

  While (Not frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Eof) And
        (frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('GRAVATECLAS').AsString = 'S') do
  Begin
    If vGravar Then
    Begin
      QryPesquisa.ParamByName('P_INDICEMENU').AsString := frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('INDICEMENU').AsString ;
      QryPesquisa.ParamByName('P_NOME'      ).AsString := frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('NOME'      ).AsString ;
      QryPesquisa.ParamByName('P_TECLAS'    ).AsString := frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS'    ).AsString ;
      QryPesquisa.ExecSql ;
    End ; // If vGravar Then

    frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Edit ;
    frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('GRAVATECLAS').AsString := 'N' ;
    If Not vGravar Then
      frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS'   ).AsString := frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('COPIATECLAS').AsString ;
    frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Post ;
    frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Next ;
  End ; // While (Not frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Eof) And (...

  If vGravar Then
    vcDataBase.Commit ;
end;

procedure TFrmCTR_CadastroDeAtalhos.TViewMenuChange(Sender: TObject; Node: TTreeNode);
begin
  If Trim(EdtTecla.Name) <> '' Then
  Begin
    frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Locate('ABSOLUTEINDEX',IntToStr(Node.AbsoluteIndex),[LocaseInsensitive]) ;
    EdtTecla.Text    := frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS').AsString ;
    EdtTecla.Enabled := TViewMenu.Items.Item[Node.AbsoluteIndex].Count = 0 ;
    EdtTecla.Color   := IIf(EdtTecla.Enabled,clWindow,clMenu) ;
  End ; // If Trim(EdtTecla.Name) <> '' Then
end;

procedure TFrmCTR_CadastroDeAtalhos.TViewMenuExit(Sender: TObject);
begin
  If (vEsc) Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) And (vTAB)) Or (Not EdtTecla.Enabled) Then
  Begin
    vEsc := False ;
    TViewMenu.SetFocus ;
  End ; // If (vEsc) Or (...
end;

procedure TFrmCTR_CadastroDeAtalhos.SButExpandeClick(Sender: TObject);
begin
  With TViewMenu Do
  Begin
    Items.BeginUpdate ;

    If TSpeedButton(Sender).Name = 'SButExpande' Then
    Begin
      FullExpand ;
      Items.Item[Items.Count-1].Selected := True ;
    End Else // If TSpeedButton(Sender).Name = 'FSButExpande' Then
      FullCollapse ;
    Items.EndUpdate ;
    Items.Item[0].Selected := True ;
  End ; // With TViewMenu Do
end;

procedure TFrmCTR_CadastroDeAtalhos.EdtTeclaExit(Sender: TObject);
begin
  If (vEsc) Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) and (vTAB)) Then
  Begin
    vEsc := False ;
    Exit ;
  End ; // If (vEsc) Or (...

  If Trim(EdtTecla.Text) <> '' Then
  Begin
    If (frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Locate('TECLAS',EdtTecla.Text,[LocaseInsensitive])) And
       (frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('ABSOLUTEINDEX').AsInteger <> TViewMenu.Selected.AbsoluteIndex) Then
    Begin
      MensagemDlg('Teclas já cadastradas.',mtInformacao,mbOK) ;
      EdtTecla.Clear ;
      EdtTecla.SetFocus ;
      Exit ;
    End ; // If (frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Locate('TECLAS',EdtTecla.Text ,[LocaseInsensitive])) And (...
  End ; // If Trim(EdtTecla.Text) <> '' Then

  frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Edit ;
  frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS'     ).AsString := EdtTecla.Text ;
  frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('GRAVATECLAS').AsString := 'S' ;
  frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Post ;

  TViewMenu.Items[TViewMenu.Selected.AbsoluteIndex].Text := Pad(frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('CAPTION').AsString,62 + IIf(Length(frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('INDICEMENU').AsString) = 2,6,
                                                                                                               IIf(Length(frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('INDICEMENU').AsString) = 4,3,0)) ) +
                                                            Pad(frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS' ).AsString,7) ;
  TViewMenu.Refresh ;
  TViewMenu.SetFocus ;
end;

procedure TFrmCTR_CadastroDeAtalhos.EdtTeclaKeyPress(Sender: TObject; var Key: Char);
begin
  If Not (Key In ['0'..'9','A'..'Z']) Then Key := #0 ;
end;

procedure TFrmCTR_CadastroDeAtalhos.EdtTeclaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If ((Shift = [ssShift])  Or
      (Shift = [ssCtrl] )) And
      (Chr(Key) In ['0'..'9','A'..'Z',#8])  Then   // #8 = BackSpace
  Begin
    If Shift = [ssCtrl] Then
      EdtTecla.Text := 'Ctrl+'  + Chr(Key)
    Else
      EdtTecla.Text := 'Shift+' + Chr(Key) ;
  End Else // If ((Shift = [ssShift]) Or (...
  If (Key = 8) Or
     (Key = 46) Or
     (Pos(Copy(EdtTecla.Text,1,Length(EdtTecla.Text)-1),'Shift+Ctrl+') = 0) Then
    EdtTecla.Clear ;
end;

procedure TFrmCTR_CadastroDeAtalhos.SButCopiarClick(Sender: TObject);
Var
  i : Integer ;
  vTeclas,
  vCaption : String ;
begin
  frmMenuPrincipal.ContSenhaBgm.vMDTeclas.DisableControls ;
  frmMenuPrincipal.ContSenhaBgm.vMDTeclas.First ;

  If TSpeedButton(Sender).Name = 'SButCopiar' Then
  Begin
    With QryPesquisa do
    Begin
      Close ;
      Sql.Clear;
      Sql.Add(' SELECT'+
              '  INDICEMENU'+
              ' ,TECLAS'+
              '') ;
      Sql.Add(' FROM'+
              ' CTR_MENUSDOSISTEMA'+
              '') ;
      Sql.Add(' WHERE'+
              '     SISTEMA = :P_SISTEMA'+
              ' AND NOT TECLAS IS NULL'+
              '') ;
      Sql.Add(' ORDER BY'+
              '  SISTEMA'+
              ' ,INDICEMENU'+
              ' ,CAPTION'+
              '') ;
      ParamByName('P_SISTEMA').AsString := vcSistema ;
      Open ;
      While Not Eof do
      Begin
        If frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Locate('INDICEMENU',FieldByName('INDICEMENU').AsString,[LocaseInsensitive]) Then
        Begin
          frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Edit ;
          frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('COPIATECLAS').AsString := frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS').AsString ;
          frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS'     ).AsString := FieldByName('TECLAS').AsString ;
          frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('GRAVATECLAS').AsString := 'S' ;
          frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Post ;
        End ; // If frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Locate(...
        Next ;
      End ; // While Not Eof do
    End ; // With QryPesquisa do
  End Else // If TSpeedButton(Sender).Name = 'SButCopiar' Then
  Begin
    While Not frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Eof Do
    Begin
      frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Edit ;
      frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('GRAVATECLAS').AsString := IIf(Trim(frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS').AsString)='','N','S') ;
      frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('COPIATECLAS').AsString := frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS').AsString ;
      frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS'     ).AsString := '' ;
      frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Post ;
      frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Next ;
    End ; // While Not frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Eof Do
  End ; // End Else // If TSpeedButton(Sender).Name = 'SButCopiar' Then

  TViewMenu.Items.BeginUpdate ;
  For i := 0 to TViewMenu.Items.Count-1 do
  Begin
    vCaption := Pad(TViewMenu.Items[i].Text,62) ;

    If TSpeedButton(Sender).Name = 'SButCopiar' Then
    Begin
      frmMenuPrincipal.ContSenhaBgm.vMDTeclas.Locate('ABSOLUTEINDEX',IntToStr(TViewMenu.Items[i].AbsoluteIndex),[LocaseInsensitive]) ;
      vTeclas := frmMenuPrincipal.ContSenhaBgm.vMDTeclas.FieldByName('TECLAS').AsString ;
    End Else // If TSpeedButton(Sender).Name = 'FSButCopiar' Then
      vTeclas := '' ;

    TViewMenu.Items[i].Text := Pad(vCaption,62 + IIf(TViewMenu.Items[i].Level = 0,6,
                                                 IIf(TViewMenu.Items[i].Level = 1,3,0))) +
                               Pad(vTeclas,7) ;
  End ; // For i := 0 to TViewMenu.Items.Count-1 do

  TViewMenu.FullCollapse ;
  TViewMenu.Items.EndUpdate ;
  TViewMenu.Items.Item[0].Selected := True ;

  frmMenuPrincipal.ContSenhaBgm.vMDTeclas.EnableControls ;

  TViewMenu.SetFocus ;
end;

end.
