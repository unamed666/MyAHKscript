#NoEnv
#SingleInstance Force
SendMode Input
SetWorkingDir %A_ScriptDir%
IniFile := A_ScriptDir "\RAltToggle.ini"
IniRead, ToggleMediaLock, %IniFile%, State, ToggleMediaLock, 0
ToggleMediaLock := ToggleMediaLock ? true : false

; ===============================
; TOGGLE FN LOCK (RALT)
; ===============================
RAlt::
    ToggleMediaLock := !ToggleMediaLock	
    if (ToggleMediaLock) {
        ToolTip F-Media ON, 0, %A_ScreenHeight%
		IniWrite, % (ToggleMediaLock ? 1 : 0), %IniFile%, State, ToggleMediaLock
    } else {
        ToolTip F-Media OFF, 0, %A_ScreenHeight%
		IniWrite, % (ToggleMediaLock ? 1 : 0), %IniFile%, State, ToggleMediaLock
    }

    SetTimer, RemoveTip, -600
return

RemoveTip:
ToolTip
return


; ===============================
; MEDIA KEYS SAAT FN LOCK AKTIF
; ===============================
#If (ToggleMediaLock)

F1::Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Winamp\Winamp.lnk
F2::Send {Volume_Down}
F3::Send {Volume_Up}
F4::Send {Volume_Mute}
F5::Send {Media_Stop}
F6::Send {Media_Prev}
F7::Send {Media_Play_Pause}
F8::Send {Media_Next}
F9::Send {f15} 
;Brightness -
F10::Send {f16} 
;Brightness +
F11::Send {f17} 
; Contrast -
F12::Send {f18} 
; Contrast +

#If
