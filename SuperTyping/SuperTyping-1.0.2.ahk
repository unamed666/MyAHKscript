#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%
IniFile := A_ScriptDir "\SuperTyping.ini"
IniRead, toggle, %IniFile%, State, Toggle, 0
toggle := toggle ? true : false

; ===============================
; CONFIG
; ===============================
MaxCols := 10
ButtonW := 50
ButtonH := 25
ButtonMargin := 2
MenuTimeout := 5000

; ===============================
; VARIAN ANGKA 0–9 (UNICODE)
; ===============================
NumVariants := []
NumVariants[0] := Array("0","⁰","₀")
NumVariants[1] := Array("1","¹","₁")
NumVariants[2] := Array("2","²","₂")
NumVariants[3] := Array("3","³","₃")
NumVariants[4] := Array("4","⁴","₄")
NumVariants[5] := Array("5","⁵","₅")
NumVariants[6] := Array("6","⁶","₆")
NumVariants[7] := Array("7","⁷","₇")
NumVariants[8] := Array("8","⁸","₈")
NumVariants[9] := Array("9","⁹","₉")

; ===============================
; VARIAN HURUF a–z + A–Z
; ===============================
CharVariants := []
CharVariants["a"] := Array("a","ā","ą","á","ä","ã","A","Ā","Ą","Á","Ä","Ã")
CharVariants["b"] := Array("b","B")
CharVariants["c"] := Array("c","ç","ć","č","C","Ç","Ć","Č")
CharVariants["d"] := Array("d","đ","ď","D","Đ","Ď")
CharVariants["e"] := Array("e","é","è","ê","ë","ē","ĕ","ė","ę","ě","E","É","È","Ê","Ë","Ē","Ĕ","Ė","Ę","Ě")
CharVariants["f"] := Array("f","F")
CharVariants["g"] := Array("g","ğ","ĝ","ġ","ģ","G","Ğ","Ĝ","Ġ","Ģ")
CharVariants["h"] := Array("h","ĥ","ħ","H","Ĥ","Ħ")
CharVariants["i"] := Array("i","í","ì","î","ï","ī","ĭ","į","ı","I","Í","Ì","Î","Ï","Ī","Ĭ","Į")
CharVariants["j"] := Array("j","ĵ","J","Ĵ")
CharVariants["k"] := Array("k","ķ","K","Ķ")
CharVariants["l"] := Array("l","ł","ľ","ĺ","ļ","L","Ł","Ľ","Ĺ","Ļ")
CharVariants["m"] := Array("m","M")
CharVariants["n"] := Array("n","ñ","ń","ň","ņ","ŋ","N","Ñ","Ń","Ň","Ņ")
CharVariants["o"] := Array("o","ó","ò","ô","ö","õ","ø","ō","ŏ","ő","œ","O","Ó","Ò","Ô","Ö","Õ","Ø","Ō","Ŏ","Ő","Œ")
CharVariants["p"] := Array("p","P")
CharVariants["q"] := Array("q","Q")
CharVariants["r"] := Array("r","ŕ","ř","ŗ","R","Ŕ","Ř","Ŗ")
CharVariants["s"] := Array("s","ś","š","ş","ŝ","ß","S","Ś","Š","Ş","Ŝ")
CharVariants["t"] := Array("t","ť","ţ","ŧ","T","Ť","Ţ","Ŧ")
CharVariants["u"] := Array("u","ú","ù","û","ü","ū","ŭ","ů","ű","ų","U","Ú","Ù","Û","Ü","Ū","Ŭ","Ů","Ű","Ų")
CharVariants["v"] := Array("v","V")
CharVariants["w"] := Array("w","ŵ","W","Ŵ")
CharVariants["x"] := Array("x","X")
CharVariants["y"] := Array("y","ý","ÿ","ŷ","Y","Ý","Ÿ","Ŷ")
CharVariants["z"] := Array("z","ź","ž","ż","Z","Ź","Ž","Ż")

; ===============================
; VARIAN TANDA BACA (UNICODE)
; ===============================
PuncVariants := []
PuncVariants["~!"] := Array("!","¡","‼")
PuncVariants["@"] := Array("@","Ⓐ")
PuncVariants["~#"] := Array("#","№")
PuncVariants["$"] := Array("$","₴","＄")
PuncVariants["%"] := Array("%","‰")
PuncVariants["~^"] := Array("^","⁑")
PuncVariants["&"] := Array("&","⅋")
PuncVariants["*"] := Array("*","※")
PuncVariants["("] := Array("(","❨")
PuncVariants[")"] := Array(")","❩")


; ===============================
; HOTKEY ANGKA 0–9
; ===============================


Loop, 10
{
    num := A_Index-1
    Hotkey, % "$" num, ShowNumPopup
}

; ===============================
; HOTKEY HURUF a–z
; ===============================
Loop, 26
{
    ch := Chr(96 + A_Index) ; huruf kecil a=97
    Hotkey, % "$" ch, ShowCharPopup
}


; ===============================
; Tombol untuk menutup semua GUI (tanpa memblokir fungsi asli)
; ===============================
CloseGuiKeys := ["Space","Enter","Tab","Esc","Backspace","CapsLock","Shift","Ctrl","Alt"
                ,"LButton","RButton","MButton","XButton1","XButton2","up","down","left","right"]

for index, key in CloseGuiKeys
{
    Hotkey, ~%key%, CloseAllGUI
}

; Fungsi untuk menutup semua GUI
CloseAllGUI:
	Sleep, 200  ; 0.2 second	
    GuiNames := ["num","chr","punc"]
    for index, name in GuiNames
        Gui, %name%:Destroy
return


; ===============================
; HOTKEY TANDA BACA
; ===============================
for key, _ in PuncVariants
{
    Hotkey, % "$" key, ShowPuncPopup
}

; ===============================
; TOGGLE
; ===============================

; Tangkap Right CTRL

~rctrl::
    if (toggle) {
        toggle := false ; Ubah toggle ke false
        Tooltip, SuperTyping OFF, 0, %A_ScreenHeight%
    } else {           
        toggle := true ; Ubah toggle ke true
        Tooltip, SuperTyping ON, 0, %A_ScreenHeight%
    }
	IniWrite, % (toggle ? 1 : 0), %IniFile%, State, Toggle
    SetTimer, RemoveTooltip, -2000 ; Hapus Tooltip setelah 2 detik
return

; Fungsi untuk menghapus Tooltip
RemoveTooltip:
    Tooltip
return

; ===============================
; CARET TRIGGER
; ===============================

GetDpi() {
	return DllCall("User32.dll\GetDpiForWindow", "Ptr", WinExist("A"))
}

GetCaret() {
	If (A_CaretX) {
		return { x: A_CaretX, y: A_CaretY }
	}
	Else {
		; should be long enough to ensure correct coords if caret has just moved
		Sleep, 20

		caret := Acc_ObjectFromWindow(WinExist("A"), OBJID_CARET := 0xFFFFFFF8)

		caretLocation := Acc_Location(caret)

		WinGetPos, winX, winY

		SysGet, monitorCount, MonitorCount

		multiplier := monitorCount > 1
			? 1 / (GetDpi() / 96)
			: 1

		x := (caretLocation.x - winX) * multiplier
		y := (caretLocation.y - winY) * multiplier

		return { x: x, y: y }
	}
}

HasActiveCaret() {
    pos := GetCaret()

    ; gagal ambil caret
    if !IsObject(pos)
        return false

    ; koordinat tidak valid
    if (pos.x = 0 && pos.y = 0)
        return false

    ; koordinat negatif tidak valid
    if (pos.x < 0 || pos.y < 0)
        return false

    return true
}

; ===============================
; HITUNG POSISI GUI (AMAN)
; ===============================
GetSafeGuiPos(ByRef outX, ByRef outY, guiW := 0, guiH := 0) {
    static lastX := "", lastY := ""

    ; ===============================
    ; Ambil posisi caret (sekali saja)
    ; ===============================
    hasCaret := HasActiveCaret()
    if (hasCaret)
        pos := GetCaret()

    ; ===============================
    ; X mengikuti caret
    ; ===============================
    if (hasCaret) {
        outX := pos.x
        lastX := outX
    } else if (lastX != "") {
        outX := lastX
    } else {
        outX := A_ScreenWidth // 2
    }

    ; ===============================
    ; Y mengikuti caret (offset ke atas)
    ; ===============================
    if (hasCaret) {
        outY := pos.y - 100
        lastY := outY
        return
    }

    if (lastY != "") {
        outY := lastY
        return
    }

    outY := (A_ScreenHeight - guiH) // 2
}



; ===============================
; SHOW POPUP ANGKA
; ===============================



ShowNumPopup:
        
    num := SubStr(A_ThisHotkey,2)
    Send, %num%
    WinGet, TargetWin, ID, A
    Gui, num:New, +AlwaysOnTop -SysMenu +ToolWindow +OwnDialogs    
    Gui, num:Margin, 2,2
    Gui, num:Font, s12
    col := 1
    row := 1
    Loop, % NumVariants[num].MaxIndex()
    {
        ch := NumVariants[num][A_Index]
        xPos := (col-1)*(ButtonW+ButtonMargin)
        yPos := (row-1)*(ButtonH+ButtonMargin)
        if (toggle && HasActiveCaret()){
            Gui, num:Add, Button, x%xPos% y%yPos% w%ButtonW% h%ButtonH% gPickChar, %ch%
        }
        col++
        if (col > MaxCols)
        {
            col := 1
            row++
        }
    }
    Gui, num:Show, AutoSize Hide
	WinGetPos,,, guiW, guiH, A
	GetSafeGuiPos(guiX, guiY, guiW, guiH)
	Gui, num:Show, x%guiX% y%guiY% NoActivate, Varian %num%

    SetTimer, CloseGui, %MenuTimeout%
return

; ===============================
; SHOW POPUP HURUF
; ===============================
ShowCharPopup:
	
    char := SubStr(A_ThisHotkey,2)
    Send, %char%
    WinGet, TargetWin, ID, A

    Gui, chr:New, +AlwaysOnTop -SysMenu +ToolWindow +OwnDialogs
    Gui, chr:Margin, 2,2
    Gui, chr:Font, s12 cred

    col := 1
    row := 1
    Loop, % CharVariants[char].MaxIndex()
    {
        ch := CharVariants[char][A_Index]
        xPos := (col-1)*(ButtonW+ButtonMargin)
        yPos := (row-1)*(ButtonH+ButtonMargin)
        yPos := (row-1)*(ButtonH+ButtonMargin)
        if (toggle && HasActiveCaret()){
            Gui, chr:Add, Button, x%xPos% y%yPos% w%ButtonW% h%ButtonH% gPickChar, %ch%
        }
        col++
        if (col > MaxCols)
        {
            col := 1
            row++
        }
    }
    Gui, chr:Show, AutoSize Hide
	WinGetPos,,, guiW, guiH, A
	GetSafeGuiPos(guiX, guiY, guiW, guiH)
	Gui, chr:Show, x%guiX% y%guiY% NoActivate, Varian %char%
	Gui, chr:Show, x%guiX% y%guiY% NoActivate, Varian %char%

    SetTimer, CloseGui, %MenuTimeout%
return

; ===============================
; SHOW POPUP TANDA BACA
; ===============================
ShowPuncPopup:
    char := SubStr(A_ThisHotkey,2)
    Send, %char%
	if (char = "~!" || char = "~#" || char = "~^")
        Send {BS}
    WinGet, TargetWin, ID, A

    Gui, punc:New, +AlwaysOnTop -SysMenu +ToolWindow +OwnDialogs
    Gui, punc:Margin, 2,2
    Gui, punc:Font, s12

    col := 1
    row := 1
    Loop, % PuncVariants[char].MaxIndex()
    {
        ch := PuncVariants[char][A_Index]
        xPos := (col-1)*(ButtonW+ButtonMargin)
        yPos := (row-1)*(ButtonH+ButtonMargin)
        if (toggle && HasActiveCaret()){
            Gui, punc:Add, Button, x%xPos% y%yPos% w%ButtonW% h%ButtonH% gPickChar, %ch%
        }
        col++
        if (col > MaxCols)
        {
            col := 1
            row++
        }
    }
    Gui, punc:Show, AutoSize Hide
	WinGetPos,,, guiW, guiH, A
	GetSafeGuiPos(guiX, guiY, guiW, guiH)
	Gui, punc:Show, x%guiX% y%guiY% NoActivate, Varian %char%

    SetTimer, CloseGui, %MenuTimeout%
return

; ===============================
; PICK KARAKTER
; ===============================
PickChar:
    GuiControlGet, btnText, , %A_GuiControl%
    Gui, num:Destroy
    Gui, chr:Destroy
    Gui, punc:Destroy

    IfWinExist, ahk_id %TargetWin%
    {
        WinActivate, ahk_id %TargetWin%
		 Send {BS}  ; hapus karakter terakhir sebelum menempel
        SendUnicode(btnText)
    }
return

; ===============================
; AUTO CLOSE GUI
; ===============================
CloseGui:
    SetTimer, CloseGui, Off
    Gui, num:Destroy
    Gui, chr:Destroy
    Gui, punc:Destroy
return

; ===============================
; SEND UNICODE AMAN (CLIPBOARD)
; ===============================
SendUnicode(text) {
    ClipSaved := ClipboardAll
    Clipboard := text
    Sleep 50
    Send ^v
    Sleep 50
    Clipboard := ClipSaved
}

; http://www.autohotkey.com/board/topic/77303-acc-library-ahk-l-updated-09272012/
; https://dl.dropbox.com/u/47573473/Web%20Server/AHK_L/Acc.ahk
;------------------------------------------------------------------------------
; Acc.ahk Standard Library
; by Sean
; Updated by jethrow:
; 	Modified ComObjEnwrap params from (9,pacc) --> (9,pacc,1)
; 	Changed ComObjUnwrap to ComObjValue in order to avoid AddRef (thanks fincs)
; 	Added Acc_GetRoleText & Acc_GetStateText
; 	Added additional functions - commented below
; 	Removed original Acc_Children function
; last updated 2/25/2010
;------------------------------------------------------------------------------

Acc_Init()
{
	Static	h
	If Not	h
		h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
}
Acc_ObjectFromEvent(ByRef _idChild_, hWnd, idObject, idChild)
{
	Acc_Init()
	If	DllCall("oleacc\AccessibleObjectFromEvent", "Ptr", hWnd, "UInt", idObject, "UInt", idChild, "Ptr*", pacc, "Ptr", VarSetCapacity(varChild,8+2*A_PtrSize,0)*0+&varChild)=0
	Return	ComObjEnwrap(9,pacc,1), _idChild_:=NumGet(varChild,8,"UInt")
}

Acc_ObjectFromPoint(ByRef _idChild_ = "", x = "", y = "")
{
	Acc_Init()
	If	DllCall("oleacc\AccessibleObjectFromPoint", "Int64", x==""||y==""?0*DllCall("GetCursorPos","Int64*",pt)+pt:x&0xFFFFFFFF|y<<32, "Ptr*", pacc, "Ptr", VarSetCapacity(varChild,8+2*A_PtrSize,0)*0+&varChild)=0
	Return	ComObjEnwrap(9,pacc,1), _idChild_:=NumGet(varChild,8,"UInt")
}

Acc_ObjectFromWindow(hWnd, idObject = -4)
{
	Acc_Init()
	If	DllCall("oleacc\AccessibleObjectFromWindow", "Ptr", hWnd, "UInt", idObject&=0xFFFFFFFF, "Ptr", -VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
	Return	ComObjEnwrap(9,pacc,1)
}

Acc_WindowFromObject(pacc)
{
	If	DllCall("oleacc\WindowFromAccessibleObject", "Ptr", IsObject(pacc)?ComObjValue(pacc):pacc, "Ptr*", hWnd)=0
	Return	hWnd
}

Acc_GetRoleText(nRole)
{
	nSize := DllCall("oleacc\GetRoleText", "Uint", nRole, "Ptr", 0, "Uint", 0)
	VarSetCapacity(sRole, (A_IsUnicode?2:1)*nSize)
	DllCall("oleacc\GetRoleText", "Uint", nRole, "str", sRole, "Uint", nSize+1)
	Return	sRole
}

Acc_GetStateText(nState)
{
	nSize := DllCall("oleacc\GetStateText", "Uint", nState, "Ptr", 0, "Uint", 0)
	VarSetCapacity(sState, (A_IsUnicode?2:1)*nSize)
	DllCall("oleacc\GetStateText", "Uint", nState, "str", sState, "Uint", nSize+1)
	Return	sState
}

Acc_SetWinEventHook(eventMin, eventMax, pCallback)
{
	Return	DllCall("SetWinEventHook", "Uint", eventMin, "Uint", eventMax, "Uint", 0, "Ptr", pCallback, "Uint", 0, "Uint", 0, "Uint", 0)
}

Acc_UnhookWinEvent(hHook)
{
	Return	DllCall("UnhookWinEvent", "Ptr", hHook)
}
/*	Win Events:

	pCallback := RegisterCallback("WinEventProc")
	WinEventProc(hHook, event, hWnd, idObject, idChild, eventThread, eventTime)
	{
		Critical
		Acc := Acc_ObjectFromEvent(_idChild_, hWnd, idObject, idChild)
		; Code Here:

	}
*/

; Written by jethrow
Acc_Role(Acc, ChildId=0) {
	try return ComObjType(Acc,"Name")="IAccessible"?Acc_GetRoleText(Acc.accRole(ChildId)):"invalid object"
}
Acc_State(Acc, ChildId=0) {
	try return ComObjType(Acc,"Name")="IAccessible"?Acc_GetStateText(Acc.accState(ChildId)):"invalid object"
}
Acc_Location(Acc, ChildId=0, byref Position="") { ; adapted from Sean's code
	try Acc.accLocation(ComObj(0x4003,&x:=0), ComObj(0x4003,&y:=0), ComObj(0x4003,&w:=0), ComObj(0x4003,&h:=0), ChildId)
	catch
		return
	Position := "x" NumGet(x,0,"int") " y" NumGet(y,0,"int") " w" NumGet(w,0,"int") " h" NumGet(h,0,"int")
	return	{x:NumGet(x,0,"int"), y:NumGet(y,0,"int"), w:NumGet(w,0,"int"), h:NumGet(h,0,"int")}
}
Acc_Parent(Acc) { 
	try parent:=Acc.accParent
	return parent?Acc_Query(parent):
}
Acc_Child(Acc, ChildId=0) {
	try child:=Acc.accChild(ChildId)
	return child?Acc_Query(child):
}
Acc_Query(Acc) { ; thanks Lexikos - www.autohotkey.com/forum/viewtopic.php?t=81731&p=509530#509530
	try return ComObj(9, ComObjQuery(Acc,"{618736e0-3c3d-11cf-810c-00aa00389b71}"), 1)
}
Acc_Error(p="") {
	static setting:=0
	return p=""?setting:setting:=p
}
Acc_Children(Acc) {
	if ComObjType(Acc,"Name") != "IAccessible"
		ErrorLevel := "Invalid IAccessible Object"
	else {
		Acc_Init(), cChildren:=Acc.accChildCount, Children:=[]
		if DllCall("oleacc\AccessibleChildren", "Ptr",ComObjValue(Acc), "Int",0, "Int",cChildren, "Ptr",VarSetCapacity(varChildren,cChildren*(8+2*A_PtrSize),0)*0+&varChildren, "Int*",cChildren)=0 {
			Loop %cChildren%
				i:=(A_Index-1)*(A_PtrSize*2+8)+8, child:=NumGet(varChildren,i), Children.Insert(NumGet(varChildren,i-8)=9?Acc_Query(child):child), NumGet(varChildren,i-8)=9?ObjRelease(child):
			return Children.MaxIndex()?Children:
		} else
			ErrorLevel := "AccessibleChildren DllCall Failed"
	}
	if Acc_Error()
		throw Exception(ErrorLevel,-1)
}
Acc_ChildrenByRole(Acc, Role) {
	if ComObjType(Acc,"Name")!="IAccessible"
		ErrorLevel := "Invalid IAccessible Object"
	else {
		Acc_Init(), cChildren:=Acc.accChildCount, Children:=[]
		if DllCall("oleacc\AccessibleChildren", "Ptr",ComObjValue(Acc), "Int",0, "Int",cChildren, "Ptr",VarSetCapacity(varChildren,cChildren*(8+2*A_PtrSize),0)*0+&varChildren, "Int*",cChildren)=0 {
			Loop %cChildren% {
				i:=(A_Index-1)*(A_PtrSize*2+8)+8, child:=NumGet(varChildren,i)
				if NumGet(varChildren,i-8)=9
					AccChild:=Acc_Query(child), ObjRelease(child), Acc_Role(AccChild)=Role?Children.Insert(AccChild):
				else
					Acc_Role(Acc, child)=Role?Children.Insert(child):
			}
			return Children.MaxIndex()?Children:, ErrorLevel:=0
		} else
			ErrorLevel := "AccessibleChildren DllCall Failed"
	}
	if Acc_Error()
		throw Exception(ErrorLevel,-1)
}
Acc_Get(Cmd, ChildPath="", ChildID=0, WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") {
	static properties := {Action:"DefaultAction", DoAction:"DoDefaultAction", Keyboard:"KeyboardShortcut"}
	AccObj :=   IsObject(WinTitle)? WinTitle
			:   Acc_ObjectFromWindow( WinExist(WinTitle, WinText, ExcludeTitle, ExcludeText), 0 )
	if ComObjType(AccObj, "Name") != "IAccessible"
		ErrorLevel := "Could not access an IAccessible Object"
	else {
		StringReplace, ChildPath, ChildPath, _, %A_Space%, All
		AccError:=Acc_Error(), Acc_Error(true)
		Loop Parse, ChildPath, ., %A_Space%
			try {
				if A_LoopField is digit
					Children:=Acc_Children(AccObj), m2:=A_LoopField ; mimic "m2" output in else-statement
				else
					RegExMatch(A_LoopField, "(\D*)(\d*)", m), Children:=Acc_ChildrenByRole(AccObj, m1), m2:=(m2?m2:1)
				if Not Children.HasKey(m2)
					throw
				AccObj := Children[m2]
			} catch {
				ErrorLevel:="Cannot access ChildPath Item #" A_Index " -> " A_LoopField, Acc_Error(AccError)
				if Acc_Error()
					throw Exception("Cannot access ChildPath Item", -1, "Item #" A_Index " -> " A_LoopField)
				return
			}
		Acc_Error(AccError)
		StringReplace, Cmd, Cmd, %A_Space%, , All
		properties.HasKey(Cmd)? Cmd:=properties[Cmd]:
		try {
			if (Cmd = "Location")
				AccObj.accLocation(ComObj(0x4003,&x:=0), ComObj(0x4003,&y:=0), ComObj(0x4003,&w:=0), ComObj(0x4003,&h:=0), ChildId)
			  , ret_val := "x" NumGet(x,0,"int") " y" NumGet(y,0,"int") " w" NumGet(w,0,"int") " h" NumGet(h,0,"int")
			else if (Cmd = "Object")
				ret_val := AccObj
			else if Cmd in Role,State
				ret_val := Acc_%Cmd%(AccObj, ChildID+0)
			else if Cmd in ChildCount,Selection,Focus
				ret_val := AccObj["acc" Cmd]
			else
				ret_val := AccObj["acc" Cmd](ChildID+0)
		} catch {
			ErrorLevel := """" Cmd """ Cmd Not Implemented"
			if Acc_Error()
				throw Exception("Cmd Not Implemented", -1, Cmd)
			return
		}
		return ret_val, ErrorLevel:=0
	}
	if Acc_Error()
		throw Exception(ErrorLevel,-1)
}