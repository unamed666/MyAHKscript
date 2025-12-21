ScrollLockState := false

; Toggle Scroll Lock state and maintain its default functionality
ScrollLock::
    ScrollLockState := !ScrollLockState
    Send, {ScrollLock}  ; Preserve original Scroll Lock function
    if (ScrollLockState) {
        ToolTip, Horizontal Macro Mode Enabled, 0, %A_ScreenHeight%
    } else {
        ToolTip, Horizontal Macro Mode Disabled,0 ,%A_ScreenHeight%
    }
    SetTimer, RemoveToolTip, -1500
return

; Example macro buttons for horizontal scroll when Scroll Lock is active
#If (ScrollLockState)
XButton1::  ; Map the first side mouse button to scroll left
    Send, {WheelLeft}
return

XButton2::  ; Map the second side mouse button to scroll right
    Send, {WheelRight}
return
#If

; Function to remove the tooltip after a short delay
RemoveToolTip:
    ToolTip
return
