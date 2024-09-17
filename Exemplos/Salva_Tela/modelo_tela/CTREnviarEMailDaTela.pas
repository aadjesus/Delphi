unit CTREnviarEMailDaTela;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Menus, ExtCtrls, StdCtrls, Buttons, Mask, ToolEdit, RxRichEd;

type
  TFrmCTREnviarEMailDaTela = class(TForm)
    PnlAssunto: TPanel;
    PnlTela: TPanel;
    PnlBotoes: TPanel;
    LabAssunto: TLabel;
    EdtAssunto: TEdit;
    PnlTexto: TPanel;
    BBtnEnviar: TBitBtn;
    BBtnGravar: TBitBtn;
    PnlImagem: TPanel;
    REdtTexto: TRxRichEdit;
    SButPrioridade: TSpeedButton;
    SButPrioridades: TSpeedButton;
    SButAnexar: TSpeedButton;
    PopupMenuGeral: TPopupMenu;
    IMenuInsTexto: TMenuItem;
    IMenuDesRetangulo: TMenuItem;
    IMenuAlta: TMenuItem;
    IMenuNormal: TMenuItem;
    IMenuBaixa: TMenuItem;
    Image: TImage;
    CBoxTipoEMail: TComboBox;
    Label1: TLabel;
    OpenDialogAnexar: TOpenDialog;
    IMenuMostraArqivos: TMenuItem;
    PnlArquivos: TPanel;
    ListBoxArquivos: TListBox;
    IMenuApagaArquivos: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure SButPrioridadesClick(Sender: TObject);
    procedure PopupMenuGeralPopup(Sender: TObject);
    procedure IMenuInsTextoClick(Sender: TObject);
    procedure SButAnexarClick(Sender: TObject);
    procedure PnlArquivosExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCTREnviarEMailDaTela: TFrmCTREnviarEMailDaTela;

implementation

{$R *.DFM}

procedure TFrmCTREnviarEMailDaTela.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmCTREnviarEMailDaTela.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
end;

procedure TFrmCTREnviarEMailDaTela.FormShow(Sender: TObject);
var
  I: integer;
begin
//  PosicionaBotoes(PnlBotoes) ;
//  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt}
end;

procedure TFrmCTREnviarEMailDaTela.SButPrioridadesClick(Sender: TObject);
begin
  PopupMenuGeral.PopupComponent := SButPrioridades ;
  PopupMenuGeral.Popup(SButPrioridades.ClientOrigin.x+SButPrioridades.Width ,SButPrioridades.ClientOrigin.y+SButPrioridades.Height ) ;
end;

procedure TFrmCTREnviarEMailDaTela.PopupMenuGeralPopup(Sender: TObject);
begin
  IMenuInsTexto.Visible      := PopupMenuGeral.PopupComponent = Image ;
  IMenuDesRetangulo.Visible  := IMenuInsTexto.Visible ;
  IMenuAlta.Visible          := PopupMenuGeral.PopupComponent = SButPrioridades ;
  IMenuNormal.Visible        := IMenuAlta.Visible ;
  IMenuBaixa.Visible         := IMenuAlta.Visible ;
  IMenuMostraArqivos.Visible := (PopupMenuGeral.PopupComponent = SButAnexar) And (ListBoxArquivos.Items.Count > 0) ;
  IMenuApagaArquivos.Visible := IMenuMostraArqivos.Visible ;
end;

procedure TFrmCTREnviarEMailDaTela.IMenuInsTextoClick(Sender: TObject);
begin
  If Not TMenuItem(Sender).Visible then
    Exit ;

  If PopupMenuGeral.PopupComponent = SButPrioridades Then
  Begin
    IMenuAlta.Checked   := TMenuItem(Sender).Name = 'IMenuAlta' ;
    IMenuNormal.Checked := TMenuItem(Sender).Name = 'IMenuNormal' ;
    IMenuBaixa.Checked  := TMenuItem(Sender).Name = 'IMenuBaixa' ;
  End Else // If PopupMenuGeral.PopupComponent = SButPrioridades Then
  If PopupMenuGeral.PopupComponent = SButAnexar Then
  Begin
    If TMenuItem(Sender).Name = 'IMenuMostraArqivos' Then
    Begin
      PnlArquivos.Visible  := True ;
      PnlArquivos.SetFocus ;
    End Else
      ListBoxArquivos.Clear ;
  End ; // If PopupMenuGeral.PopupComponent = SButAnexar Then
end;

procedure TFrmCTREnviarEMailDaTela.SButAnexarClick(Sender: TObject);
begin
  If OpenDialogAnexar.Execute Then
    ListBoxArquivos.Items.Add(OpenDialogAnexar.FileName) ;
end;

procedure TFrmCTREnviarEMailDaTela.PnlArquivosExit(Sender: TObject);
begin
  PnlArquivos.Visible := False ;
end;

end.
