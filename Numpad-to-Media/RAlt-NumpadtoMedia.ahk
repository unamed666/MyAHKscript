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
        ToolTip Numpad-Media ON, 0, %A_ScreenHeight%
		IniWrite, % (ToggleMediaLock ? 1 : 0), %IniFile%, State, ToggleMediaLock
    } else {
        ToolTip Numpad-Media OFF, 0, %A_ScreenHeight%
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

Numpad2::Send {Volume_Down}
Numpad8::Send {Volume_Up}
Numpad0::Send {Volume_Mute}
Numpad4::Send {Media_Prev}
Numpad5::Send {Media_Play_Pause}
Numpad6::Send {Media_Next}
Numpad1::Send {f15} 
;Brightness -
Numpad3::Send {f16} 
;Brightness +
Numpad7::Send {f17} 
; Contrast -
Numpad9::Send {f18} 
; Contrast +

#If
