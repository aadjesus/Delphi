unit ULembra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, DB, RxMemDS;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    DBGridItens: TDBGrid;
    DBGridDescricao: TDBGrid;
    MemoDetalhe: TMemo;
    PnlItens: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    EdtItem: TEdit;
    EdtDescricao: TEdit;
    MemoDetanhe: TMemo;
    BitBtn1: TBitBtn;
    PopupMenu1: TPopupMenu;
    IMenuIncluir: TMenuItem;
    IMenuAlterar: TMenuItem;
    IMenuExcluir: TMenuItem;
    MDItens: TRxMemoryData;
    MDDescricao: TRxMemoryData;
    DSItens: TDataSource;
    DSDescricao: TDataSource;
    MDDescricaoDESCRICAO: TStringField;
    MDItensATUALIZA: TStringField;
    MDItensITEM: TStringField;
    MDDescricaoDETALHE: TStringField;
    MDItensCODIGO: TIntegerField;
    MDDescricaoCODIGO: TIntegerField;
    procedure IMenuIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure MDItensAfterScroll(DataSet: TDataSet);
    procedure MDDescricaoFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure MDDescricaoAfterScroll(DataSet: TDataSet);
    procedure PopupMenu1Popup(Sender: TObject);
  private
    { Private declarations }
    vCodigo : Integer ;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

Uses
  IniFiles ;
  
{$R *.dfm}

procedure TForm1.IMenuIncluirClick(Sender: TObject);
begin
  If Sender = IMenuExcluir Then
  Begin
  End Else // If Sender = IMenuExcluir Then
  Begin
    PnlItens.Visible := True ;
    PnlItens.BeginDrag(true) ;
    PnlItens.EndDrag(true) ;
    EdtItem.Enabled := 

    If Sender = IMenuAlterar Then
    Begin
      MDItens.Locate('CODIGO',vCodigo,[loCaseInsensitive]) ;

      EdtItem.Text      := MDItens.FieldByName('ITEM'    ).AsString  ;
      EdtDescricao.Text := MDDescricao.FieldByName('DESCRICAO').AsString;
      MemoDetanhe.Text  := MDDescricao.FieldByName('DETALHE'  ).AsString;
      EdtDescricao.SetFocus ;
    End Else // If Sender = IMenuAlterar Then
      EdtItem.SetFocus ;
  End ; // End Else // If Sender = IMenuExcluir Then
end;

procedure TForm1.FormShow(Sender: TObject);
var
  vArquivo  : TextFile ;
  vLinhaArq : String ;
begin
  MDItens.EmptyTable ;
  MDItens.Open ;
  MDDescricao.EmptyTable ;
  MDDescricao.Open ;
  If FileExists('Lembra.Ini') Then
  Begin
    AssignFile(vArquivo,'Lembra.Ini') ;
    Reset(vArquivo) ;
    While Not Eof(vArquivo) Do
    Begin
      ReadLn(vArquivo,vLinhaArq) ;
    End ; // While Not Eof(vArquivo) Do
    CloseFile(vArquivo) ;
  End Else // If FileExists('Config.Ini') Then

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  vArqLembras : TIniFile ;
  vItem       : Integer ;
begin
  With MDItens do
  Begin
    SortOnFields('ATUALIZA') ;
    First ;
    If Locate('ATUALIZA','S',[loCaseInsensitive]) Then
    Begin
      vArqLembras := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Lembra.Ini') ;
      vItem       := 0 ;
      While Not Eof do
      Begin
        Inc(vItem) ;

        vArqLembras.WriteString('Itens',FormatFloat('##',FieldByName('CODIGO').AsInteger),FieldByName('ITEM').AsString  ) ;
        vArqLembras.UpdateFile ;
        Next ;
      End ; // While Not Eof do
    End ; // If Locate(..
  End ; // With MDItens do

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  If (Trim(EdtItem.Text) <> '') And
     (Trim(EdtDescricao.Text) <> '') Then
  Begin
    MDDescricao.Filtered := False ;
    If MDItens.FieldByName('CODIGO'  ).AsInteger <> vCodigo Then
      MDItens.Append ;
    MDItens.Edit ;

    MDItens.FieldByName('CODIGO'  ).AsInteger := vCodigo ;
    MDItens.FieldByName('ATUALIZA').AsString  := 'S' ;
    MDItens.FieldByName('ITEM'    ).AsString  := EdtItem.Text ;
    MDItens.Post ;

    MDDescricao.Append ;
    MDDescricao.FieldByName('CODIGO'   ).AsInteger := vCodigo ;
    MDDescricao.FieldByName('DESCRICAO').AsString  := EdtDescricao.Text ;
    MDDescricao.FieldByName('DETALHE'  ).AsString  := MemoDetanhe.Text ;
    MDDescricao.Post ;
  End ; // If (Trim(EdtItem.Text) <> '') And
end;

procedure TForm1.MDItensAfterScroll(DataSet: TDataSet);
begin
  MDDescricao.Filtered := False ;
  MDDescricao.Filtered := True ;
  If MDDescricao.IsEmpty Then
    vCodigo := 1
  Else
    vCodigo := MDDescricao.FieldByName('CODIGO').AsInteger ;
end;

procedure TForm1.MDDescricaoFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept := MDItens.FieldByName('CODIGO').AsInteger =  MDDescricao.FieldByName('CODIGO').AsInteger ;
end;

procedure TForm1.MDDescricaoAfterScroll(DataSet: TDataSet);
begin
  MemoDetanhe.Text := MDDescricao.FieldByName('DETALHE'  ).AsString ;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  If PopupMenu1.PopupComponent = DBGridItens Then
    vCodigo := MDItens.RecordCount + 1
end;

end.
