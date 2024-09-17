unit UEstrai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Shellapi, FileCtrl, Menus;

type
  TForm1 = class(TForm)
    Panel10: TPanel;
    Panel11: TPanel;
    DriveComboBox: TDriveComboBox;
    DirectoryListBox: TDirectoryListBox;
    Panel8: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    FListBoxArquivos: TFileListBox;
    Panel2: TPanel;
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    IMenuSalvarIcone: TMenuItem;
    procedure FListBoxArquivosChange(Sender: TObject);
    procedure IMenuSalvarIconeClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DirectoryListBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FListBoxArquivosChange(Sender: TObject);
begin
  If FileExists(FListBoxArquivos.FileName) Then
    Image1.Picture.Icon.Handle := ExtractIcon(Handle,PChar(FListBoxArquivos.FileName),0);
end;

procedure TForm1.IMenuSalvarIconeClick(Sender: TObject);
begin
  PopupMenu1Popup(Sender) ;
  If IMenuSalvarIcone.Enabled Then
    Image1.Picture.SaveToFile(StringReplace(FListBoxArquivos.FileName,ExtractFileExt(FListBoxArquivos.FileName),'.ico',[])) ;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  IMenuSalvarIcone.Enabled := FileExists(FListBoxArquivos.FileName) And (Not Image1.Picture.Icon.Empty) ;
end;

procedure TForm1.DirectoryListBoxChange(Sender: TObject);
begin
  If Trim(FListBoxArquivos.FileName) = '' Then
    Image1.Picture.Icon.Assign(Nil) ;
end;

end.
