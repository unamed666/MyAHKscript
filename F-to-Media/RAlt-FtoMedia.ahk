f15Locked := false

; ===============================
; TOGGLE FN LOCK (RALT)
; ===============================
RAlt::
    ToggleMediaLock := !ToggleMediaLock

    if (ToggleMediaLock) {
        ToolTip F-Media ON, 0, %A_ScreenHeight%
    } else {
        ToolTip F-Media OFF, 0, %A_ScreenHeight%
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

F2::Send {Volume_Down}
F3::Send {Volume_Up}
F4::Send {Volume_Mute}
F5::Send {Media_Stop}
F6::Send {Media_Prev}
F7::Send {Media_Play_Pause}
F8::Send {Media_Next}

#If
