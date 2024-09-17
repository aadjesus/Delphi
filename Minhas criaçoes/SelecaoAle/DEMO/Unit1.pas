unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBTables, Buttons, Grids, DBGrids, Sim, Okk,
  Db, ToolEdit, RxMemDS, DBCtrls, SBSelecaoAle, ExtCtrls, Wordcap, Menus,
  NumEdit;

type
  TForm1 = class(TForm)
    db1: TDatabase;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    DBGrid1: TDBGrid;
    PanelProcura: TPanel;
    PanelTelaProcura: TPanel;
    EdtProcura: TEdit;
    PanelTituloProcura: TPanel;
    Splitter1: TSplitter;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    MainMenu1: TMainMenu;
    Saida: TMenuItem;
    MSOfficeCaption1: TMSOfficeCaption;
    DBGrid2: TDBGrid;
    GBoxCidade: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    SBSelecaoAle1: TSBSelecaoAle;
    EdtCidadeIni: TEdit;
    EdtCidadeFin: TEdit;
    Panel6: TPanel;
    procedure SBSelecaoAle1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.SBSelecaoAle1Click(Sender: TObject);
begin
  If SBSelecaoAle1.IgnoraSelecao Then
    ShowMessage('Nenhum item foi selecionado ou não foi confirmada a seleção.')
  Else
    ShowMessage(SBSelecaoAle1.StringRetorno) ;
end;

end.
