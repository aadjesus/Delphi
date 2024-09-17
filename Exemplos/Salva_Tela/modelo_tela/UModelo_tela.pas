unit UModelo_tela;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Menus, ExtCtrls, StdCtrls, Buttons, Mask, ToolEdit, RxRichEd;

type
  TFrmEnviarEMailTela = class(TForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure SButPrioridadesClick(Sender: TObject);
    procedure PopupMenuGeralPopup(Sender: TObject);
    procedure IMenuInsTextoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEnviarEMailTela: TFrmEnviarEMailTela;

implementation

{$R *.DFM}

procedure TFrmEnviarEMailTela.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmEnviarEMailTela.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
end;

procedure TFrmEnviarEMailTela.FormShow(Sender: TObject);
var
  I: integer;
begin
//  PosicionaBotoes(PnlBotoes) ;
//  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt}
end;

procedure TFrmEnviarEMailTela.SButPrioridadesClick(Sender: TObject);
begin
  PopupMenuGeral.PopupComponent := SButPrioridades ;
  PopupMenuGeral.Popup(SButPrioridades.ClientOrigin.x+SButPrioridades.Width ,SButPrioridades.ClientOrigin.y+SButPrioridades.Height ) ;
end;

procedure TFrmEnviarEMailTela.PopupMenuGeralPopup(Sender: TObject);
begin
  IMenuInsTexto.Visible     := PopupMenuGeral.PopupComponent = Image ;
  IMenuDesRetangulo.Visible := IMenuInsTexto.Visible ;
  IMenuAlta.Visible         := PopupMenuGeral.PopupComponent = SButPrioridades ;
  IMenuNormal.Visible       := IMenuAlta.Visible ;
  IMenuBaixa.Visible        := IMenuAlta.Visible ;
end;

procedure TFrmEnviarEMailTela.IMenuInsTextoClick(Sender: TObject);
begin
  If Not TMenuItem(Sender).Visible then
    Exit ;

  If PopupMenuGeral.PopupComponent = SButPrioridades Then
  Begin
    IMenuAlta.Checked   := TMenuItem(Sender).Name = 'IMenuAlta' ;
    IMenuNormal.Checked := TMenuItem(Sender).Name = 'IMenuNormal' ;
    IMenuBaixa.Checked  := TMenuItem(Sender).Name = 'IMenuBaixa' ;
  End ;
end;

end.
