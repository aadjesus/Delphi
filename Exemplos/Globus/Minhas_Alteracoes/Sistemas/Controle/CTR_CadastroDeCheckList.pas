unit CTR_CadastroDeCheckList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Db, ImgList, DBTables, StdCtrls, RXSpin, Mask, ToolEdit, Grids,
  DBGrids, ExtCtrls, RxMemDS, BGMPedeFilialGaragem,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TFrmCTR_CadastroDeCheckList = class(TForm)
    PnlTela: TPanel;
    DBGridItens: TDBGrid;
    PnlProgramar: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    DateEdit1: TDateEdit;
    RxSpinEdit1: TRxSpinEdit;
    CheckBox1: TCheckBox;
    PnlIncluir: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    CBoxTela: TComboBox;
    EdtProcedimento: TEdit;
    MainMenu1: TMainMenu;
    Sada1: TMenuItem;
    QryPesquisa: TQuery;
    ImageList1: TImageList;
    DSItens: TDataSource;
    PMenuGeral: TPopupMenu;
    Criar1: TMenuItem;
    Apagar1: TMenuItem;
    Desmarcar1: TMenuItem;
    Programar1: TMenuItem;
    RMDTelas: TRxMemoryData;
    BGMPedeFilialGaragem1: TBGMPedeFilialGaragem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Sada1Click(Sender: TObject);
    procedure CBoxTelaExit(Sender: TObject);
    procedure EdtProcedimentoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCTR_CadastroDeCheckList: TFrmCTR_CadastroDeCheckList;

implementation

uses Bgm_Tela,
     Bgm_String,
     Bgm_Dados,
     MenuPrincipal,
     {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{$R *.DFM}

procedure TFrmCTR_CadastroDeCheckList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree ;
end;

procedure TFrmCTR_CadastroDeCheckList.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
end;

procedure TFrmCTR_CadastroDeCheckList.FormShow(Sender: TObject);
Var
  i : Integer ;
begin
  CBoxTela.Items.Add(' ') ;
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

               {
      If Length(FieldByName('INDICEMENU').AsString) = 2 Then
        Nivel0 := TViewMenu.Items.Add(Nil,vCaption)
      Else
      If Length(FieldByName('INDICEMENU').AsString) = 4 Then
        Nivel1 := TViewMenu.Items.AddChild(Nivel0,vCaption)
      Else
        TViewMenu.Items.AddChild(Nivel1,vCaption) ;

      RMDTelas.
      RMDTelas.

      FrmCTR_CadastroDeCheckList.CBoxTela.Items.Add(FieldByName('CAPTION').AsString) ;
                }
                
      Next ;
    End ; // While Not Eof do

    First ;
    EnableControls ;
  End ; // With RMDataTeclas do

  DBGridItens.SetFocus ;

  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt }
end;

procedure TFrmCTR_CadastroDeCheckList.Sada1Click(Sender: TObject);
begin
  Close ;
end;

procedure TFrmCTR_CadastroDeCheckList.CBoxTelaExit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) and (vTAB)) Then
  Begin
    vEsc := False ;
    CBoxTela.SetFocus;
  End ; // If vEsc Or (...
end;

procedure TFrmCTR_CadastroDeCheckList.EdtProcedimentoExit(Sender: TObject);
begin
  If vEsc Or (((GetKeyState(VK_SHIfT) and $1000000) <> 0) and (vTAB)) Then
  Begin
    vEsc := False ;
    CBoxTela.SetFocus ;
    Exit ;
  End ; // If vEsc Or (...

  If (Trim(CBoxTela.Text) <> '') Or (Trim(EdtProcedimento.Text) <>'') Then
  Begin

    With frmMenuPrincipal.ContSenhaBgm.vMDCheckList do
    Begin
      Edit ;
      FieldByName('TELA'        ).AsString := CBoxTela.Text ;
      FieldByName('PROCEDIMENTO').AsString := EdtProcedimento.Text ;
      Post ;
    End ; // With frmMenuPrincipal.ContSenhaBgm.vMDTeclas do
  End Else
    EdtProcedimento.SetFocus ;

end;

end.
