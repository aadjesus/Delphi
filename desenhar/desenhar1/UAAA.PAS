unit uaaa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Outline;

type
  TForm1 = class(TForm)
    PnlTelaImagem1: TPanel;
    PnlTelaImagem: TPanel;
    PnlImagem: TPanel;
    Image: TImage;
    SBarHorizontal: TScrollBar;
    SBarVertical: TScrollBar;
    ListBox1: TListBox;
    Outline1: TOutline;
    procedure FormShow(Sender: TObject);
    procedure SBarHorizontalScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
  PnlImagem.Width  := Image.Width ;
  PnlImagem.Height := Image.Height ;
  Image.Align      := alClient ;

  SBarHorizontal.Visible := PnlImagem.Width  > PnlTelaImagem.Width ;
  SBarVertical.Visible   := PnlImagem.Height > PnlTelaImagem.Height ;

  SBarHorizontal.Max := Trunc(PnlImagem.Width / 6) ;
  SBarVertical.Max   := Trunc(PnlImagem.Height / 2) ;

  PnlImagem.Top  := Trunc((PnlTelaImagem.Height-PnlImagem.Height-2) / 2) ;
  PnlImagem.Left := Trunc((PnlTelaImagem.Width -PnlImagem.Width -2) / 2) ;

  If PnlImagem.Top < 0 Then
    PnlImagem.Top  := 0 ;
  If PnlImagem.Left < 0 Then
    PnlImagem.Left := 0 ;
end;

procedure TForm1.SBarHorizontalScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  If TScrollBar(Sender).Name = 'SBarHorizontal' Then
    PnlImagem.left := ScrollPos*-1
  Else
    PnlImagem.Top  := ScrollPos*-1 ;

end;

end.
