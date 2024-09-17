unit insapi;

{

OLE Inserter for Delphi v 1.0

uses .ols-files. you can make such files using
OLEContainer.SaveToFile method. You can use OLE Inserter for presenting files
that can't be shown in OLE-Containers (excel for example), the ones that were
saved using OLEDocument.SaveToFile because .SaveAsDocument didn't work
properly with them. For example, bitmaps (pbrush) can't be properly saved
using the latter method, so you call SaveToFile and then use OLE Inserter.

OLE Inserter replace itself with the
original compound document, so that you don't need more this .dll and can
use the document with ole-document from delphi without any another application ...(such ole viewer)

Copyright © 2001 Alexandre Rai
Written by Alexandre Rai

Please send questions, bug reports and suggestions
regarding this code to: riccio@gmx.at
or ICQ :13125582

This code is provided "as is" without express or
implied warranty of any kind. Use it at your own risk.


}

interface

uses ActiveX, ComObj, Windows, Classes,Messages;

function DllRegisterServer: HResult; stdcall;
function DllUnregisterServer: HResult; stdcall;
function DllGetClassObject(const CLSID, IID: TGUID; var Obj): HResult; stdcall;
function DllCanUnloadNow: HResult; stdcall;


const

{ Komponentenklassen-GUIDs }

  ClassGUID: TGUID = '{7A0CA2E0-03DA-11D5-B9A2-0008C7C3F7AE}';


type

  TOleTestImp = class(TComObject,
    IPersistStorage,
    IDataObject,
    IOleObject,
    IPersistFile,
    IOleClientSite)
  private
    FMyOleObject :  IOleObject;
    procedure LoadFromStream(Stream: TStream);
    procedure DestroyObject;
  protected { Interfaces }
    { Renamed methods }
    function IPersistStorage.InitNew = PersistStorageInitNew;
    function IPersistStorage.Load = PersistStorageLoad;
    function IPersistStorage.Save = PersistStorageSave;
    function IPersistFile.SaveCompleted = PersistFileSaveCompleted;
    function IOleClientSite.GetMoniker = OleClientSiteGetMoniker;
   { IPersistStorage }
    function PersistStorageInitNew(const stg: IStorage): HResult; stdcall;
    function PersistStorageLoad(const stg: IStorage): HResult; stdcall;
    function PersistStorageSave(const stgSave: IStorage; fSameAsLoad: BOOL): HResult; stdcall;
    function SaveCompleted(const stgNew: IStorage): HResult; stdcall;
    function HandsOffStorage: HResult; stdcall;
    function GetClassID(out classID: TCLSID): HResult; stdcall;
    function IsDirty: HResult; stdcall;
   { IPersistFile }
    function Load(pszFileName: POleStr; dwMode: Longint): HResult;  stdcall;
    function Save(pszFileName: POleStr; fRemember: BOOL): HResult;  stdcall;
    function PersistFileSaveCompleted(pszFileName: POleStr): HResult;  stdcall;
    function GetCurFile(out pszFileName: POleStr): HResult;  stdcall;
   { IDataObject }
    function GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function QueryGetData(const formatetc: TFormatEtc): HResult; stdcall;
    function GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult; stdcall;
    function SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult; stdcall;
    function EnumFormatEtc(dwDirection: Longint; out enumFormatEtc: IEnumFormatEtc): HResult; stdcall;
    function DAdvise(const formatetc: TFormatEtc; advf: Longint; const advSink: IAdviseSink; out dwConnection: Longint): HResult; stdcall;
    function DUnadvise(dwConnection: Longint): HResult; stdcall;
    function EnumDAdvise(out enumAdvise: IEnumStatData): HResult; stdcall;
    { IOleObject }
    function SetClientSite(const clientSite: IOleClientSite): HResult; stdcall;
    function GetClientSite(out clientSite: IOleClientSite): HResult; stdcall;
    function SetHostNames(szContainerApp: POleStr;  szContainerObj: POleStr): HResult; stdcall;
    function Close(dwSaveOption: Longint): HResult; stdcall;
    function SetMoniker(dwWhichMoniker: Longint; const mk: IMoniker): HResult;  stdcall;
    function GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint; out mk: IMoniker): HResult; stdcall;
    function InitFromData(const dataObject: IDataObject; fCreation: BOOL; dwReserved: Longint): HResult; stdcall;
    function GetClipboardData(dwReserved: Longint; out dataObject: IDataObject): HResult; stdcall;
    function DoVerb(iVerb: Longint; msg: PMsg; const activeSite: IOleClientSite;
      lindex: Longint; hwndParent: HWND; const posRect: TRect): HResult; stdcall;
    function EnumVerbs(out enumOleVerb: IEnumOleVerb): HResult; stdcall;
    function Update: HResult; stdcall;
    function IsUpToDate: HResult; stdcall;
    function GetUserClassID(out clsid: TCLSID): HResult; stdcall;
    function GetUserType(dwFormOfType: Longint; out pszUserType: POleStr): HResult;  stdcall;
    function SetExtent(dwDrawAspect: Longint; const size: TPoint): HResult;  stdcall;
    function GetExtent(dwDrawAspect: Longint; out size: TPoint): HResult; stdcall;
    function Advise(const advSink: IAdviseSink; out dwConnection: Longint): HResult; stdcall;
    function Unadvise(dwConnection: Longint): HResult; stdcall;
    function EnumAdvise(out enumAdvise: IEnumStatData): HResult; stdcall;
    function GetMiscStatus(dwAspect: Longint; out dwStatus: Longint): HResult; stdcall;
    function SetColorScheme(const logpal: TLogPalette): HResult; stdcall;
    { IOleClientSite }
    function SaveObject: HResult; stdcall;
    function OleClientSiteGetMoniker(dwAssign: Longint; dwWhichMoniker: Longint; out mk: IMoniker): HResult; stdcall;
    function GetContainer(out container: IOleContainer): HResult; stdcall;
    function ShowObject: HResult; stdcall;
    function OnShowWindow(fShow: BOOL): HResult; stdcall;
    function RequestNewObjectLayout: HResult; stdcall;
  public
    procedure Initialize; override;
    destructor Destroy; override;
    property OleObject : IOleObject read FMyOleObject;
  end;

  TOLETestImpFactory = class(TComObjectFactory)
  public
  
    procedure UpdateRegistry(Register : boolean); override;
  end;

implementation

uses ComServ, SysUtils;

const
  DataFormatCount = 2;
  StreamSignature = $434F4442; {'BDOC'}

type
  TStreamHeader = record
    case Integer of
      0: ( { New }
        Signature: Integer;
        DrawAspect: Integer;
        DataSize: Integer);
      1: ( { Old }
        PartRect: TSmallRect);
  end;


function LongToShortFileName(const LongName: string): string; // from RXLib
var
  Temp: TWIN32FindData;
  SearchHandle: THandle;
begin
  SearchHandle := FindFirstFile(PChar(LongName), Temp);
  if SearchHandle <> ERROR_INVALID_HANDLE then begin
    Result := string(Temp.cAlternateFileName);
    if Result = '' then Result := string(Temp.cFileName);
  end
  else Result := '';
  Windows.FindClose(SearchHandle);
end;

function LongToShortPath(const LongName: string): string; // from RXLib
var
  LastSlash: PChar;
  TempPathPtr: PChar;
begin
  Result := '';
  TempPathPtr := PChar(LongName);
  LastSlash := StrRScan(TempPathPtr, '\');
  while LastSlash <> nil do begin
    Result := '\' + LongToShortFileName(TempPathPtr) + Result;
    if LastSlash <> nil then begin
      LastSlash^ := char(0);
      LastSlash := StrRScan(TempPathPtr, '\');
    end;
  end;
  Result := TempPathPtr + Result;
end;

function HandleException: HResult;
var
  E: TObject;
begin
  E := ExceptObject;
  if (E is EOleSysError) and (EOleSysError(E).ErrorCode < 0) then
    Result := EOleSysError(E).ErrorCode else
    Result := E_UNEXPECTED;
end;


function TOleTestImp.PersistStorageInitNew(const stg: IStorage): HResult;
begin
  try
    Result := (FMyOleObject as IPersistStorage).InitNew(Stg);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.PersistStorageLoad(const stg: IStorage): HResult;
begin
  try
    Result := (FMyOleObject as IPersistStorage).Load(stg);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.PersistStorageSave(const stgSave: IStorage; fSameAsLoad: BOOL): HResult;
begin
  try
    Result := (FMyOleObject as IPersistStorage).Save(stgSave, fSameAsLoad);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.SaveCompleted(const stgNew: IStorage): HResult;
begin
  try
    Result := (FMyOleObject as IPersistStorage).SaveCompleted(stgNew);
//    PostMessage(HWindow,WM_CLOSE,0,0);
  except
    Result := HandleException;
  end;
//  MessageBox(0, 'aaaa', 'aaaa', 0);
//  Free;
//  Factory.Free;
end;

function TOleTestImp.HandsOffStorage: HResult;
begin
  try
    Result := (FMyOleObject as IPersistStorage).HandsOffStorage;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetClassID(out classID: TCLSID): HResult;
begin
  try
    Result := (FMyOleObject as IPersistStorage).GetClassID(classID);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.IsDirty: HResult;
begin
  try
    Result := (FMyOleObject as IPersistStorage).IsDirty;
  except
    Result := HandleException;
  end;
end;

{ IPersistFile }

function TOleTestImp.Load(pszFileName: POleStr; dwMode: Longint): HResult;
var
  Stream: TStream;
begin
  try
    Stream := TFileStream.Create(pszFileName, fmOpenRead);
    try
      LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.Save(pszFileName: POleStr; fRemember: BOOL): HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.PersistFileSaveCompleted(pszFileName: POleStr): HResult;
begin
  Result := S_OK;
end;

function TOleTestImp.GetCurFile(out pszFileName: POleStr): HResult;
begin
  Result := E_NOTIMPL;
end;


{ IDataObject }

function TOleTestImp.GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult;
begin
  try
    Result := (FMyOleObject as IDataObject).GetData(formatetcIn, medium);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult;
begin
  try
    Result := (FMyOleObject as IDataObject).GetDataHere(formatetc, medium);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.QueryGetData(const formatetc: TFormatEtc): HResult;
begin
  try
    Result := (FMyOleObject as IDataObject).QueryGetData(formatetc);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult;
begin
  try
    Result := (FMyOleObject as IDataObject).GetCanonicalFormatEtc(formatetc, formatetcOut);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult;
begin
  try
    Result := (FMyOleObject as IDataObject).SetData(formatetc, medium, fRelease);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.EnumFormatEtc(dwDirection: Longint; out enumFormatEtc: IEnumFormatEtc): HResult;
begin
  try
    Result := (FMyOleObject as IDataObject).EnumFormatEtc(dwDirection, enumFormatEtc);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.DAdvise(const formatetc: TFormatEtc; advf: Longint; const advSink: IAdviseSink; out dwConnection: Longint): HResult;
begin
  try
    Result := (FMyOleObject as IDataObject).DAdvise(formatetc, advf, advSink, dwConnection);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.DUnadvise(dwConnection: Longint): HResult;
begin
  try
    Result := (FMyOleObject as IDataObject).DUnadvise(dwConnection);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.EnumDAdvise(out enumAdvise: IEnumStatData): HResult;
begin
  try
    Result := (FMyOleObject as IDataObject).EnumDAdvise(enumAdvise);
  except
    Result := HandleException;
  end;
end;

{ IOleObject }

function TOleTestImp.SetClientSite(const clientSite: IOleClientSite): HResult;
begin
  try
    Result := FMyOleObject.SetClientSite(clientSite);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetClientSite(out clientSite: IOleClientSite): HResult;
begin
  try
    Result := FMyOleObject.GetClientSite(clientSite);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.SetHostNames(szContainerApp: POleStr;  szContainerObj: POleStr): HResult;
begin
  try
    Result := FMyOleObject.SetHostNames(szContainerApp, szContainerObj);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.Close(dwSaveOption: Longint): HResult;
begin
  try
    Result := FMyOleObject.Close(dwSaveOption);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.SetMoniker(dwWhichMoniker: Longint; const mk: IMoniker): HResult;
begin
  try
    Result := FMyOleObject.SetMoniker(dwWhichMoniker, mk);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint; out mk: IMoniker): HResult;
begin
  try
    Result := FMyOleObject.GetMoniker(dwAssign, dwWhichMoniker, mk);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.InitFromData(const dataObject: IDataObject; fCreation: BOOL; dwReserved: Longint): HResult;
begin
  try
    Result := FMyOleObject.InitFromData(dataObject, fCreation, dwReserved);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetClipboardData(dwReserved: Longint; out dataObject: IDataObject): HResult;
begin
  try
    Result := FMyOleObject.GetClipboardData(dwReserved, dataObject);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.DoVerb(iVerb: Longint; msg: PMsg; const activeSite: IOleClientSite;
  lindex: Longint; hwndParent: HWND; const posRect: TRect): HResult;
begin
  try
    Result := FMyOleObject.DoVerb(iVerb, msg, activeSite, lindex, hwndParent, posRect);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.EnumVerbs(out enumOleVerb: IEnumOleVerb): HResult;
begin
  try
    Result := FMyOleObject.EnumVerbs(enumOleVerb);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.Update: HResult;
begin
  try
    Result := FMyOleObject.Update;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.IsUpToDate: HResult;
begin
  try
    Result := FMyOleObject.IsUpToDate;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetUserClassID(out clsid: TCLSID): HResult;
begin
  try
    Result := FMyOleObject.GetUserClassID(clsid);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetUserType(dwFormOfType: Longint; out pszUserType: POleStr): HResult;
begin
  try
    Result := FMyOleObject.GetUserType(dwFormOfType, pszUserType);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.SetExtent(dwDrawAspect: Longint; const size: TPoint): HResult;
begin
  try
    Result := FMyOleObject.SetExtent(dwDrawAspect, size);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetExtent(dwDrawAspect: Longint; out size: TPoint): HResult;
begin
  try
    Result := FMyOleObject.GetExtent(dwDrawAspect, size);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.Advise(const advSink: IAdviseSink; out dwConnection: Longint): HResult;
begin
  try
    Result := FMyOleObject.Advise(advSink, dwConnection);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.Unadvise(dwConnection: Longint): HResult;
begin
  try
    Result := FMyOleObject.Unadvise(dwConnection);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.EnumAdvise(out enumAdvise: IEnumStatData): HResult;
begin
  try
    Result := FMyOleObject.EnumAdvise(enumAdvise);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetMiscStatus(dwAspect: Longint; out dwStatus: Longint): HResult;
begin
  try
    Result := FMyOleObject.GetMiscStatus(dwAspect, dwStatus);
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.SetColorScheme(const logpal: TLogPalette): HResult;
begin
  try
    Result := FMyOleObject.SetColorScheme(logpal);
  except
    Result := HandleException;
  end;
end;

{ IOleClientSite }

function TOleTestImp.SaveObject: HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.OleClientSiteGetMoniker(dwAssign: Longint; dwWhichMoniker: Longint; out mk: IMoniker): HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.GetContainer(out container: IOleContainer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.ShowObject: HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.OnShowWindow(fShow: BOOL): HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.RequestNewObjectLayout: HResult;
begin
  Result := E_NOTIMPL;
end;

{ Sonst }

procedure TOleTestImp.Initialize;
begin
  inherited;
end;

destructor TOleTestImp.Destroy;
begin
  if Assigned(FMyOleObject) then DestroyObject;
  inherited;
end;

procedure TOleTestImp.LoadFromStream(Stream: TStream);
var
  DataHandle: HGlobal;
  Buffer: Pointer;
  Header: TStreamHeader;
  FLockBytes : ILockBytes;
  FStorage : IStorage;
begin
  Stream.ReadBuffer(Header, SizeOf(Header));
  if (Header.Signature <> StreamSignature) then raise EOleError.Create('Invalid Stream Fromat');
  DataHandle := GlobalAlloc(GMEM_MOVEABLE, Header.DataSize);
  if DataHandle = 0 then OutOfMemoryError;
  try
    Buffer := GlobalLock(DataHandle);
    try
      Stream.Read(Buffer^, Header.DataSize);
    finally
      GlobalUnlock(DataHandle);
    end;
    OleCheck(CreateILockBytesOnHGlobal(DataHandle, True, FLockBytes));
    DataHandle := 0;
    OleCheck(StgOpenStorageOnILockBytes(FLockBytes, nil, STGM_READWRITE or
      STGM_SHARE_EXCLUSIVE, nil, 0, FStorage));
    OleCheck(OleLoad(FStorage, IOleObject, Self, FMyOleObject));
  except
    if DataHandle <> 0 then GlobalFree(DataHandle);
    DestroyObject;
    raise;
  end;
end;

procedure TOleTestImp.DestroyObject;
begin
  if FMyOleObject <> nil then
    FMyOleObject.Close(OLECLOSE_NOSAVE);
  FMYOleObject := nil;
end;

{ TOLETestImpFactory }

procedure TOLETestImpFactory.UpdateRegistry(Register : boolean);
var
  sClassID, ProgID, ServerKeyName, ShortFileName: string;
begin
  sClassID := GUIDToString(ClassID);
  ProgID := GetProgID;
  ServerKeyName := 'CLSID\' + sClassID + '\' + ComServer.ServerKey;
  if Register then
  begin
    CreateRegKey('CLSID\' + sClassID, '', Description);
    ShortFileName := ComServer.ServerFileName;
    if AnsiPos(' ', ShortFileName) <> 0 then
      ShortFileName := LongToShortPath(ShortFileName);
    CreateRegKey(ServerKeyName, '', ShortFileName);
    CreateRegKey('CLSID\' + sClassID + '\InprocHandler32', '', 'OLE32.DLL');
    CreateRegKey('CLSID\' + sClassID + '\Insertable' ,'','');
    CreateRegKey('CLSID\' + sClassID + '\Verb', '', '');
    CreateRegKey('CLSID\' + sClassID + '\Verb\0', '', '&Show,0,2');
    CreateRegKey('CLSID\' + sClassID + '\MiscStatus', '', '0');

    if ProgID <> '' then
    begin
      CreateRegKey(ProgID, '', Description);
      CreateRegKey(ProgID + '\Clsid', '', sClassID);
      CreateRegKey('CLSID\' + sClassID + '\ProgID', '', ProgID);
    end;
    CreateRegKey('.ols','',ProgID);
    CreateRegKey('.ols','Content Type', 'OLE/Object');

  end else
  begin
    if ProgID <> '' then
    begin
      DeleteRegKey(ProgID + '\Clsid');
      DeleteRegKey(ProgID);
    end;
    DeleteRegKey(ServerKeyName);
    DeleteRegKey('CLSID\' + sClassID + '\ProgID');
    DeleteRegKey('CLSID\' + sClassID + '\Verb\0');
    DeleteRegKey('CLSID\' + sClassID + '\Verb');
    DeleteRegKey('CLSID\' + sClassID + '\MiscStatus');
    DeleteRegKey('CLSID\' + sClassID + '\InprocHandler32');
    DeleteRegKey('CLSID\' + sClassID + '\Insertable');    
    DeleteRegKey('CLSID\' + sClassID);
  end;
end;

var MyFactory : TComObjectFactory;

function DllRegisterServer: HResult;
begin
  Result := S_OK;
  try
    MyFactory.UpdateRegistry(True);
  except
    Result := E_FAIL;
  end;
end;

function DllUnregisterServer: HResult;
begin
  Result := S_OK;
  try
    MyFactory.UpdateRegistry(False);
  except
    Result := E_FAIL;
  end;
end;

function DllGetClassObject(const CLSID, IID: TGUID; var Obj): HResult;
begin
  Result := ComServ.DllGetClassObject(CLSID, IID, Obj);
end;

function DllCanUnloadNow: HResult;
begin
  Result := ComServ.DllCanUnloadNow;
end;

initialization
 MyFactory := TOLETestImpFactory.Create(ComServer,TOLETestImp,ClassGUID,'OLEInserter1','Delphi *.ols File Inserter',ciInternal);
end.

