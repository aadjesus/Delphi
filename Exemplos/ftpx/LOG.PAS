unit log;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TLogSheet = class(TForm)
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LogSheet: TLogSheet;

implementation

{$R *.DFM}

end.
