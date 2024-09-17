//---------------------------------------------------------------------------
//
// Ray Flat Controls v1.0
//
// FREEWARE COMPONENT.
//---------------------------------------------------------------------------
// Collection of Standart components with Office flat style
// TRFlatEdit
// TRFlatComboBox
//---------------------------------------------------------------------------
//
//  Copyright é 2000 Ray Adams
//  E-Mail: rayadams@writeme.com
//  WWW: http://rayadams.i.am
//  or
//  http://members.xoom.com/ray_adams
//
//                     IMPORTANT NOTE:
// This software is provided 'as-is', without any express or
// implied warranty. In no event will the author be held
// liable for any damages arising from the use of this
// software.
// Permission is granted to anyone to use this software for
// any purpose, including commercial applications, and to
// alter it and redistribute it freely, subject to the
// following restrictions:
// 1. The origin of this software must not be misrepresented,
//    you must not claim that you wrote the original software.
//    If you use this software in a product, an acknowledgment
//    in the product documentation would be appreciated but is
//    not required.
// 2. Altered source versions must be plainly marked as such,
//    and must not be misrepresented as being the original
//    software.
// 3. This notice may not be removed or altered from any
//    source distribution.
unit RFlatEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,comctrls;
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
type
  TRFlatEdit = class(TCustomEdit)
  private
    MouseInControl: Boolean;
    procedure RedrawBorder (const Clip: HRGN);
    procedure NewAdjustHeight;
    procedure CMEnabledChanged (var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged (var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave (var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMSetFocus (var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus (var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCalcSize (var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint (var Message: TMessage); message WM_NCPAINT;
  protected
    procedure Loaded; override;
  public
    constructor Create (AOwner: TComponent); override;
  published
    property Anchors;
    property CharCase;
    property DragCursor;
    property DragMode;
    property DragKind;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

  TRFlatComboBox=class(TCustomComboBox)
  protected
    MouseInControl: Boolean;
    procedure RedrawBorder (const Clip: HRGN);
    procedure NewAdjustHeight;
    procedure CMEnabledChanged (var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged (var Message: TMessage); message CM_FONTCHANGED;
    procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave (var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMSetFocus (var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus (var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCCalcSize (var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMNCPaint (var Message: TMessage); message WM_NCPAINT;
    procedure WMPaint(var Message: TMessage); message WM_PAINT;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;    
  protected
    procedure Loaded; override;
  public
    constructor Create (AOwner: TComponent); override;
  published
    property Style; {Must be published before Items}
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDock;
    property OnStartDrag;
    property Items; { Must be published after OnMeasureItem }
  end;
procedure Register;
implementation

{ TRFlatEdit }

constructor TRFlatEdit.Create (AOwner: TComponent);
begin
  inherited;
  AutoSize := False;
  Ctl3D := False;
  BorderStyle := bsNone;
  Height := 19;
end;

procedure TRFlatEdit.CMMouseEnter (var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
  RedrawBorder (0);
end;

procedure TRFlatEdit.CMMouseLeave (var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
  RedrawBorder (0);
end;

procedure TRFlatEdit.NewAdjustHeight;
var
  DC: HDC;
  SaveFont: HFONT;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics (DC, Metrics);
  SelectObject (DC, SaveFont);
  ReleaseDC (0, DC);
  Height := Metrics.tmHeight + 6;
end;

procedure TRFlatEdit.Loaded;
begin
  inherited;
  if not(csDesigning in ComponentState) then
    NewAdjustHeight;
end;

procedure TRFlatEdit.CMEnabledChanged (var Message: TMessage);
const
  EnableColors: array[Boolean] of TColor = (clBtnFace, clWindow);
begin
  inherited;
  Color := EnableColors[Enabled];
end;

procedure TRFlatEdit.CMFontChanged (var Message: TMessage);
begin
  inherited;
  if not((csDesigning in ComponentState) and (csLoading in ComponentState)) then
    NewAdjustHeight;
end;

procedure TRFlatEdit.WMSetFocus (var Message: TWMSetFocus);
begin
  inherited;
  if not(csDesigning in ComponentState) then
    RedrawBorder (0);
end;

procedure TRFlatEdit.WMKillFocus (var Message: TWMKillFocus);
begin
  inherited;
  if not(csDesigning in ComponentState) then
    begin
    MouseInControl:=false;
    RedrawBorder (0);
    end;
end;

procedure TRFlatEdit.WMNCCalcSize (var Message: TWMNCCalcSize);
begin
  inherited;
  InflateRect (Message.CalcSize_Params^.rgrc[0], -3, -3);
end;

procedure TRFlatEdit.WMNCPaint (var Message: TMessage);
begin
  inherited;
  RedrawBorder (Message.WParam);
end;

procedure TRFlatEdit.RedrawBorder (const Clip: HRGN);
var
  DC: HDC;
  R: TRect;
  NewClipRgn: HRGN;
  BtnFaceBrush, WindowBrush: HBRUSH;
begin
  DC := GetWindowDC(Handle);
  try
    { Use update region }
    if (Clip <> 0) and (Clip <> 1) then begin
      GetWindowRect (Handle, R);
      if SelectClipRgn(DC, Clip) = ERROR then begin
        NewClipRgn := CreateRectRgnIndirect(R);
        SelectClipRgn (DC, NewClipRgn);
        DeleteObject (NewClipRgn);
      end;
      OffsetClipRgn (DC, -R.Left, -R.Top);
    end;
    GetWindowRect (Handle, R);  OffsetRect (R, -R.Left, -R.Top);
    BtnFaceBrush := GetSysColorBrush(COLOR_BTNFACE);
    WindowBrush := GetSysColorBrush(COLOR_WINDOW);
    if ((csDesigning in ComponentState) and Enabled) or
       (not(csDesigning in ComponentState) and
        (Focused or MouseInControl)) then begin
      DrawEdge (DC, R,BDR_SUNKENOUTER, BF_RECT or BF_ADJUST);
      with R do begin
        FillRect (DC, Rect(Left, Top, Left+1, Bottom-1), BtnFaceBrush);
        FillRect (DC, Rect(Left, Top, Right-1, Top+1), BtnFaceBrush);
      end;
      DrawEdge (DC, R, BDR_SUNKENINNER, BF_BOTTOMRIGHT);
      InflateRect (R, -1, -1);
      FrameRect (DC, R, WindowBrush);
    end
    else begin
      FrameRect (DC, R, BtnFaceBrush);
      InflateRect (R, -1, -1);
      FrameRect (DC, R, BtnFaceBrush);
      InflateRect (R, -1, -1);
      FrameRect (DC, R, WindowBrush);
    end;
  finally
    ReleaseDC (Handle, DC);
  end;
end;

{ TRFlatComboBox}

constructor TRFlatComboBox.Create (AOwner: TComponent);
begin
  inherited;
  AutoSize := False;
  Ctl3D := False;
//  BorderStyle := bsNone;
  Height := 25;
//  RedrawBorder (0);
end;

procedure TRFlatComboBox.CMMouseEnter (var Message: TMessage);
begin
  inherited;
if not Focused then
   begin
   MouseInControl:=true;
   RedrawBorder (0);
   end;
end;

procedure TRFlatComboBox.CMMouseLeave (var Message: TMessage);
begin
  inherited;
if not Focused then
   begin
   MouseInControl:=false;
   RedrawBorder (0);
   end;
end;

procedure TRFlatComboBox.NewAdjustHeight;
var
  DC: HDC;
  SaveFont: HFONT;
  Metrics: TTextMetric;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics (DC, Metrics);
  SelectObject (DC, SaveFont);
  ReleaseDC (0, DC);
  Height := Metrics.tmHeight + 6;
end;

procedure TRFlatComboBox.Loaded;
begin
  inherited;
  if not(csDesigning in ComponentState) then
    begin
    NewAdjustHeight;
    end;
end;

procedure TRFlatComboBox.CMEnabledChanged (var Message: TMessage);
const
  EnableColors: array[Boolean] of TColor = (clBtnFace, clWindow);
begin
  inherited;
  Color := EnableColors[Enabled];
end;

procedure TRFlatComboBox.CMFontChanged (var Message: TMessage);
begin
  inherited;
  if not((csDesigning in ComponentState) and (csLoading in ComponentState)) then
    NewAdjustHeight;
end;

procedure TRFlatComboBox.WMSetFocus (var Message: TWMSetFocus);
begin
  inherited;
  if not(csDesigning in ComponentState) then
    RedrawBorder (0);
end;

procedure TRFlatComboBox.WMKillFocus (var Message: TWMKillFocus);
begin
  inherited;
  if not(csDesigning in ComponentState) then
    RedrawBorder (0);
end;

procedure TRFlatComboBox.WMNCCalcSize (var Message: TWMNCCalcSize);
begin
  inherited;
//  InflateRect (Message.CalcSize_Params^.rgrc[0], 0, 0);
end;

procedure TRFlatComboBox.WMNCPaint (var Message: TMessage);
begin
  inherited;
  RedrawBorder (Message.WParam);
end;

procedure TRFlatComboBox.RedrawBorder (const Clip: HRGN);
var
  DC: HDC;
  R: TRect;
  BtnFaceBrush, WindowBrush: HBRUSH;
  NewClipRgn:HRGN;
begin
  DC := GetWindowDC(Handle);
  try
    { Use update region }
    if (Clip <> 0) and (Clip <> 1) then begin
      GetWindowRect (Handle, R);
      if SelectClipRgn(DC, Clip) = ERROR then begin
        NewClipRgn := CreateRectRgnIndirect(R);
        SelectClipRgn (DC, NewClipRgn);
        DeleteObject (NewClipRgn);
      end;
      OffsetClipRgn (DC, -R.Left, -R.Top);
    end;
    GetWindowRect (Handle, R);
    OffsetRect (R, -R.Left, -R.Top);
    BtnFaceBrush := GetSysColorBrush(COLOR_BTNFACE);
    WindowBrush := GetSysColorBrush(COLOR_WINDOW);
    if ((csDesigning in ComponentState) and Enabled) or
       (not(csDesigning in ComponentState) and
        (Focused or (MouseInControl))) then begin
      DrawEdge (DC, R,BDR_SUNKENOUTER, BF_RECT or BF_ADJUST);
      with R do begin
        FillRect (DC, Rect(Left, Top, Left+1, Bottom-1), BtnFaceBrush);
        FillRect (DC, Rect(Left, Top, Right-1, Top+1), BtnFaceBrush);
      end;
      DrawEdge (DC, R, BDR_SUNKENINNER, BF_BOTTOMRIGHT);
      InflateRect (R, -1, -1);
      FrameRect (DC, R, WindowBrush);
    end
    else begin
      FrameRect (DC, R, BtnFaceBrush);
      InflateRect (R, -1, -1);
      FrameRect (DC, R, BtnFaceBrush);
      InflateRect (R, -1, -1);
      FrameRect (DC, R, WindowBrush);
    end;
  finally
    ReleaseDC (Handle, DC);
  end;
end;


procedure Register;
begin
  RegisterComponents ('Ray Adams',
    [TRFlatEdit,TRFlatComboBox]);
end;


procedure TRFlatComboBox.CreateParams(var Params: TCreateParams);
const
  ComboBoxStyles: array[TComboBoxStyle] of DWORD = (
    CBS_DROPDOWN, CBS_SIMPLE, CBS_DROPDOWNLIST,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWFIXED,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWVARIABLE);
  CharCases: array[TEditCharCase] of DWORD = (0, CBS_UPPERCASE, CBS_LOWERCASE);
  Sorts: array[Boolean] of DWORD = (0, CBS_SORT);
begin
  inherited CreateParams(Params);
end;

procedure TRFlatComboBox.WMPaint(var Message: TMessage);
begin
inherited;
RedrawBorder(0);
end;

procedure TRFlatComboBox.CMExit(var Message: TCMExit);
begin
MouseInControl:=false;
RedrawBorder(0);
end;

end.
