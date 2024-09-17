unit Unit2;

interface

uses
  Forms ;

type
  TfrmTela = class(TForm)
  private
    FOwner : TfrmTela ;
    { Private declarations }
    Function AttribuPanel(pTitulo : String ; pPanel : Pointer ) : Boolean ;
  protected
    { Protected declarations }
  public
    { Public declarations }
  published

  end;

var
  frmTela : TfrmTela ;

implementation

{ TfrmTela }

function TfrmTela.AttribuPanel(pTitulo: String; pPanel: Pointer): Boolean;
begin
//
end;

end.
 