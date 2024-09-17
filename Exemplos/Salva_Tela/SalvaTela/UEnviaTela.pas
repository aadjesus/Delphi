unit UEnviaTela;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Menus;

type
  TFrmEnviaTela = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CBoxPara: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    EdtAssunto: TEdit;
    Panel3: TPanel;
    Memo1: TMemo;
    Label3: TLabel;
    PMenuAnexar: TPopupMenu;
    Adicionar1: TMenuItem;
    Rmover1: TMenuItem;
    Abrir1: TMenuItem;
    N1: TMenuItem;
    CBoxAnexar: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEnviaTela: TFrmEnviaTela;

implementation

{$R *.DFM}

end.
