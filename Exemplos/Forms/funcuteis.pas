unit funcuteis;

interface
  uses Menus;

    procedure CriaItemMenu(ItemJanelas, ItemMenu : tMenuItem);
    function achaItemMenu(ItemJanelas : tMenuItem; nome : string) : boolean;
    function DeletaItemMenu(ItemJanelas : tMenuItem; nome : string) : boolean;

implementation

    procedure CriaItemMenu(ItemJanelas, ItemMenu : tMenuItem);
    Var
     ItemDoMenu : tMenuItem;
    begin
     if not achaItemMenu(ItemJanelas, ItemMenu.Caption) Then
     Begin
       //Cria o item do menu em forms abertos
       ItemDoMenu :=tMenuItem.Create(ItemJanelas);
       //Iguala ao item de menu original
       ItemDoMenu.OnClick :=ItemMenu.OnClick;
       ItemDoMenu.Caption :=ItemMenu.Caption;
       //Insere o item de menu novo em forms abertos
       ItemJanelas.Insert(0,ItemDoMenu); // Insere item no item do menu (Janelas abertas).
      End;
    End;

    function achaItemMenu(ItemJanelas : tMenuItem; nome : string) : boolean;
    Var
    i : integer;
    begin
      result := false;
      for i:=0 to ItemJanelas.Count - 1 do
      Begin
        //muda para não checado
        ItemJanelas.Items[i].Checked:=False;
        if ItemJanelas.Items[i].Caption = nome Then
        Begin
          //muda para checado
          ItemJanelas.Items[i].Checked:=True;
          result := true;
        End;
      End;
    end;
    function DeletaItemMenu(ItemJanelas : tMenuItem; nome : string) : boolean;
    Var i : Integer;
    Begin
      result := false;
      for i:=0 to ItemJanelas.Count - 1 do
        if ItemJanelas.Items[i].Caption = nome Then
        Begin
          //Destroi o item de menu da janela que foi fechada
          ItemJanelas.Items[i].Destroy;
          result := true;
          Exit;
        End
    End;
end.
