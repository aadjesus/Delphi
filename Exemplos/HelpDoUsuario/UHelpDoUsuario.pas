unit UHelpDoUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, Menus;

type
  TForm1 = class(TForm)
    PnlTopicos: TPanel;
    PnlDescTopico: TPanel;
    DBGridTopicos: TDBGrid;
    MemoDescTopico: TMemo;
    Panel3: TPanel;
    PnlTituloTopico: TLabel;
    Panel4: TPanel;
    PMenuTopicos: TPopupMenu;
    IMenuIncluir: TMenuItem;
    IMenuAlterar: TMenuItem;
    IMenuExcluir: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
