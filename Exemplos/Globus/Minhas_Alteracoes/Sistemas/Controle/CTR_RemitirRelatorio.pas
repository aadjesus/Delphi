unit CTR_RemitirRelatorio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Db, ImgList, DBTables, StdCtrls, RXSpin, Mask, ToolEdit, Grids,
  DBGrids, ExtCtrls, RxMemDS, RDprint,
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TFrmCTR_RemitirRelatorio = class(TForm)
    PnlTela: TPanel;
    DBGridItens: TDBGrid;
    QryPesquisa: TQuery;
    ImageList1: TImageList;
    DSItens: TDataSource;
    PMenuGeral: TPopupMenu;
    Criar1: TMenuItem;
    Apagar1: TMenuItem;
    Desmarcar1: TMenuItem;
    Programar1: TMenuItem;
    RMDTelas: TRxMemoryData;
    MainMenu1: TMainMenu;
    Sada1: TMenuItem;
    Abrirsetupdeimpresso1: TMenuItem;
    RDprint1: TRDprint;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Sada1Click(Sender: TObject);
    procedure Abrirsetupdeimpresso1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCTR_RemitirRelatorio: TFrmCTR_RemitirRelatorio;

implementation

uses Bgm_Tela,
     Bgm_String,
     Bgm_Dados,
     MenuPrincipal,
     SetupRD,
     {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

{$R *.DFM}

procedure TFrmCTR_RemitirRelatorio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree ;
end;

procedure TFrmCTR_RemitirRelatorio.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  {$INCLUDE \Globus\Sistemas\FormKeyPressGenerico.txt }
end;

procedure TFrmCTR_RemitirRelatorio.FormShow(Sender: TObject);
Var
  i : Integer ;
begin
  DBGridItens.SetFocus ;
  {$INCLUDE \Globus\Sistemas\FormShowGenerico.txt }
end;

procedure TFrmCTR_RemitirRelatorio.Sada1Click(Sender: TObject);
begin
  Close ;
end;

procedure TFrmCTR_RemitirRelatorio.Abrirsetupdeimpresso1Click(
  Sender: TObject);
begin
//  RDprint1.SetupRD(@RDprint1,'GlobusM','RelConferenciaCTB',[rdVisualizar]) ;
{
        rdprint1.Abrir;
        rdprint1.LerRDP(opendialog1.filename);
        rdprint1.Fechar;
}
end;

end.
