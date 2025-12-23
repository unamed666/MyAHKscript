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
HasActiveCaret() {
    ; Caret valid jika X dan Y tersedia dan bukan -1
    if (A_CaretX = "" || A_CaretY = "")
        return false
    if (A_CaretX < 0 || A_CaretY < 0)
        return false
    return true
}

; ===============================
; HITUNG POSISI GUI (AMAN)
; ===============================
GetSafeGuiPos(ByRef outX, ByRef outY, guiW := 0, guiH := 0) {
    static lastX := "", lastY := ""

    ; ===============================
    ; X mengikuti caret (pola sama dgn Y)
    ; ===============================
    if (HasActiveCaret()) {
        outX := A_CaretX
        lastX := outX
    } else if (lastX != "") {
        outX := lastX
    } else {
        outX := A_ScreenWidth // 2
    }

    ; ===============================
    ; Y (TIDAK DIUBAH)
    ; ===============================
    if (HasActiveCaret()) {
        outY := A_CaretY - 100
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
