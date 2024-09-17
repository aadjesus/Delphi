unit CompTab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, CheckLst, Buttons, ComCtrls, RXCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
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

{


  Database1.Session.GetDriverParams GetDriverParams('ORACLE',ListBox1.Items)
// Database1.Session.GetDriverParams('ORACLE',ListBox1.Items)
//  GetDriverNames(
//  Databases[1]. GetAliasNames(ListBox1.Items);


  List.BeginUpdate;
  try
    List.Clear;
    LockSession;
    try
      Check(DbiOpenDatabaseList(Cursor));
    finally
      UnlockSession;
    end;
    try
      while DbiGetNextRecord(Cursor, dbiNOLOCK, @Desc, nil) = 0 do
      begin
        OemToChar(Desc.szName, Desc.szName);
        List.Add(Desc.szName);
      end;
    finally
      DbiCloseCursor(Cursor);
    end;
  finally
    List.EndUpdate;
  end;


SELECT USERNAME
     , CREATED
  FROM (  SELECT USERNAME
               , CREATED
            FROM DBA_USERS
           WHERE DEFAULT_TABLESPACE = 'GLOBUS_TABLE'
        ORDER BY CREATED DESC)
 WHERE ROWNUM <= 5

select 
*
from all_tables a where a.tablespace_name = 'GLOBUS_TABLE' 
  }


