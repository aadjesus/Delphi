unit Checklist;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Grids, DBGrids, ExtCtrls, ComCtrls, ToolWin, StdCtrls, Db,
  DBTables, RxMemDS, ImgList, RXSpin, Mask, ToolEdit;

type
  TFrmCheckList = class(TForm)
    MainMenu1: TMainMenu;
    Saida: TMenuItem;
    PopupMenu1: TPopupMenu;
    Criar1: TMenuItem;
    Apagar1: TMenuItem;
    Desmarcar1: TMenuItem;
    Programar1: TMenuItem;
    PnlTela: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Query1: TQuery;
    RxMemoryData1: TRxMemoryData;
    ImageList1: TImageList;
    PnlIncluir: TPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Edit1: TEdit;
    PnlProgramar: TPanel;
    Label3: TLabel;
    DateEdit1: TDateEdit;
    Label4: TLabel;
    RxSpinEdit1: TRxSpinEdit;
    CheckBox1: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SaidaClick(Sender: TObject);
    procedure Criar1Click(Sender: TObject);
    procedure Programar1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function IIf(pCondicao: Boolean; pResultTrue, pResultFalse: Variant): Variant ;
  end;

var
  FrmCheckList: TFrmCheckList;

implementation

Uses
  MenuPrincipal ;


{$R *.DFM}

procedure TFrmCheckList.FormShow(Sender: TObject);
begin
  With Query1 do
  Begin
    Close ;
    Sql.Clear ;
    Sql.Add(' SELECT       ') ;
    Sql.Add(' *            ') ;
    Sql.Add(' FROM         ') ;
    Sql.Add(' CTR_CheckList') ;
    Open ;
    RxMemoryData1.LoadFromDataSet(Query1,0,lmCopy) ;
  End ; // While Query1 do
end;

procedure TFrmCheckList.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  
begin
  If Column.Field.FieldName = 'EXECUTADO' Then
  Begin
    If Column.Width <> 17 Then Column.Width := 17 ;
    DBGrid1.Canvas.FillRect(Rect) ;
    ImageList1.Draw(TDBGrid(Sender).Canvas
                   ,Rect.Left+1
                   ,Rect.Top+1
                   ,IIf(RxMemoryData1.IsEmpty,-1,IIf(Trim(RxMemoryData1.FieldByName('EXECUTADO').AsString) = 'S',0,1))  ) ;
  End //Else // If Column.Field.FieldName = 'MARCO' Then
//    MudaACorDoGrid(Sender,Rect,DataCol,State,vMarco,IIf(vMarco,clBlack,clBlue),IIf(vMarco,$00FFFF80,clWhite)) ;
end;

function TFrmCheckList.IIf(pCondicao: Boolean; pResultTrue,
  pResultFalse: Variant): Variant;
begin
  If pCondicao Then
    Result := pResultTrue
  else
    Result := pResultFalse;
end;

procedure TFrmCheckList.DBGrid1DblClick(Sender: TObject);
begin
  If Length(Trim(RxMemoryData1.FieldByName('INDICEMENU').AsString)) = 4 Then
    FrmMenuPrincipal.MainMenu1.Items[StrToInt(Copy(RxMemoryData1.FieldByName('INDICEMENU').AsString,1,2))]
             .Items[StrToInt(Copy(RxMemoryData1.FieldByName('INDICEMENU').AsString,3,2))]
             .Click
  Else
  If Length(Trim(RxMemoryData1.FieldByName('INDICEMENU').AsString)) = 6 Then
    FrmMenuPrincipal.MainMenu1.Items[StrToInt(Copy(RxMemoryData1.FieldByName('INDICEMENU').AsString,1,2))]
             .Items[StrToInt(Copy(RxMemoryData1.FieldByName('INDICEMENU').AsString,3,2))]
             .Items[StrToInt(Copy(RxMemoryData1.FieldByName('INDICEMENU').AsString,5,2))]
             .Click ;

  RxMemoryData1.Edit ;
  RxMemoryData1.FieldByName('EXECUTADO').AsString := 'S' ;
  RxMemoryData1.Post ;
  If Not RxMemoryData1.Locate('EXECUTADO','N' ,[LocaseInsensitive]) Then
    SaidaClick(Sender) ;
end;

procedure TFrmCheckList.SaidaClick(Sender: TObject);
begin
  Close ;
end;

procedure TFrmCheckList.Criar1Click(Sender: TObject);
begin
  PnlIncluir.Visible := True ;
end;

procedure TFrmCheckList.Programar1Click(Sender: TObject);
begin
  PnlProgramar.Visible := True ;
end;

procedure TFrmCheckList.Edit1Exit(Sender: TObject);
begin
  PnlIncluir.Visible   := False ;
  PnlProgramar.Visible := False ;
end;

end.
