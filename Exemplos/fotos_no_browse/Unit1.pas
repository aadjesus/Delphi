unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, ExtCtrls, ComCtrls, StdCtrls, Db, Sim, Localizar, Buttons,
  Fechar, Grids, DBGrids;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Panel1: TPanel;
    FPnlFotos: TPanel;
    FPnlTitulo: TPanel;
    FPnlFecha: TPanel;
    FLabelFecha: TLabel;
    FPnlFecha2: TPanel;
    FPageControlFotos: TPageControl;
    FTabSFunc: TTabSheet;
    FPnlFunc: TPanel;
    FImageFunc: TImage;
    FTabSMat: TTabSheet;
    FPnlMat: TPanel;
    FImageMat: TImage;
    FTabSVeic: TTabSheet;
    FPnlVeic: TPanel;
    FImageVeic: TImage;
    FPnlBotoes: TPanel;
    FDBNavigatorFotos: TDBNavigator;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Edit5: TEdit;
    Fechar1: TFechar;
    Localizar1: TLocalizar;
    Sim1: TSim;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

end.
  