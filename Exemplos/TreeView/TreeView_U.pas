unit TreeView_U;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button4: TButton;
    Panel2: TPanel;
    TreeView1: TTreeView;
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MontaTreeViewEditor(pTabelas: String ; pColunas : Array Of String; pNivel : String = '') ;
  end;

var
  Form1: TForm1;

  MyTreeNode1, MyTreeNode2 : TTreeNode;

implementation

{$R *.DFM}

procedure TForm1.MontaTreeViewEditor(pTabelas: String ; pColunas : Array Of String; pNivel : String = '') ;
Var
  i, j : Integer ;
begin
  // Cria sub níveis
  If pNivel <> '' Then
  Begin
    For i := 0 To TreeView1.Items.Count-1 Do
      If TreeView1.Items.Item[i].Text = pNivel Then
      Begin
        MyTreeNode1 := TreeView1.Items[TreeView1.Items.Item[i].AbsoluteIndex] ;
        MyTreeNode1 := TreeView1.Items.AddChild(MyTreeNode1,pTabelas ) ;

        For j := 0 To Length(pColunas)-1 Do
          TreeView1.Items.AddChild(MyTreeNode1, pColunas[j] + '-' + IntToStr(j) ) ;
      End ; // If TreeView1.Items.Item[i].Text = pNivel Then
    Exit ;
  End ; // If pNivel <> '' Then

  // Cria o nível na raiz
  MyTreeNode1 := TreeView1.Items.Add(Nil,pTabelas) ;
  With TreeView1.Items do
  Begin
    For i := 0 To Length(pColunas)-1 Do
      MyTreeNode2 := AddChild(MyTreeNode1, pColunas[i] + '-' + IntToStr(i) ) ;

    TreeView1.Refresh ;
  End ; // With TViewColunas.Items do
end ;

procedure TForm1.Button4Click(Sender: TObject);
begin
  TreeView1.Items.Clear ;
  MontaTreeViewEditor('a.1',['1','2','3','4','5','6','7','8']) ;
  MontaTreeViewEditor('b.1',['1','2','3','4','5','6'        ]) ;
  MontaTreeViewEditor('c.1',['c.1','2','3','4','5','6','7','8']) ;

  MontaTreeViewEditor('b.2',['1','2'],'c.1') ;

  MontaTreeViewEditor('b.2',['1','2'],'b.1') ;
  MontaTreeViewEditor('a.2',['1','2','3'],'a.1') ;
  MontaTreeViewEditor('a.3',['1','2','3'],'a.2') ;
  MontaTreeViewEditor('a.4',['1','2','3'],'a.3') ;
  MontaTreeViewEditor('a.5',['1','2','3'],'b.1') ;
  MontaTreeViewEditor('a.6',['1','2','3'],'a.3') ;
  MontaTreeViewEditor('a.7',['1','2','3'],'a.3') ;
end;

end.
