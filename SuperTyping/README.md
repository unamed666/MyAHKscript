# SuperTyping

**SuperTyping** is an AutoHotkey script that adds popup menus for letter, number, and punctuation variants while typing. It allows you to quickly insert alternative Unicode characters using an interactive GUI.

## Key Features

- **Character Variant Popups**  
  Shows a popup for every letter (a–z), number (0–9), and punctuation key with available Unicode variants.

- **Toggle On/Off**  
  Press **Right CTRL** to enable or disable the popup mode. The active mode is indicated by a tooltip.

- **Interactive GUI**  
  Click buttons in the popup to insert the selected variant into the active window.

- **Unicode Safe Input**  
  Uses the clipboard to reliably send Unicode characters to any application.

- **Easy Configuration**  
  Customize button size, number of columns, and popup timeout via `ButtonW`, `ButtonH`, `MaxCols`, and `MenuTimeout`.

## How to Use

1. Run the `.ahk` script with AutoHotkey v1.  
2. Press **Right CTRL** to activate SuperTyping mode.  
3. Press a letter, number, or punctuation key to display the variant popup.  
4. Click the desired character in the popup to send it to the active window.  
5. Press **Right CTRL** again to deactivate the mode.

## Configuration

- `MaxCols` : number of columns in the popup  
- `ButtonW` : button width  
- `ButtonH` : button height  
- `ButtonMargin` : spacing between buttons  
- `MenuTimeout` : auto-close time for popup in milliseconds  

## Notes

- The script temporarily uses the clipboard to insert Unicode characters.  
- Popups appear only when the toggle mode is active.  
- Tooltip appears at the bottom of the screen to indicate mode status.

