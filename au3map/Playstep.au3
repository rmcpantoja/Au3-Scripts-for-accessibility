#include "include\map.au3"
#include <GuiConstantsEx.au3>
#INCLUDE "INCLUDE\reader.au3"
If not FileExists("Config\") Then
DirCreate("Config")
EndIf
Opt("SendKeyDelay", 200) ;5 milliseconds
Opt("SendKeyDownDelay", 200) ;1 millisecond
global $x_Pos = 0
global $y_Pos = 0
Global $xMax = "50"
Global $walks = "220"
Global $runs = "140"
hotkeyset("{Right}", "Move")
hotkeyset("{Left}", "Move")
hotkeyset("{^Right}", "Move")
hotkeyset("{^Left}", "Move")
hotkeyset("{Space}", "SaltaYa")
hotkeyset("c", "Getcoords")
guiCreate("Example 1 playstep")
GuiSetState(@SW_SHOW)
$wallsound = $device.opensound ("sounds/wallgeneric.ogg", 0)
While 1
Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE
Exit
EndSwitch
WEnd
Func move()
Switch @HotKeyPressed
Case "{LEFT}"
if $x_Pos >0 then
$x_Pos = $x_Pos -1
Sleep($walks)
playstep("terra2", "5", "ogg", $walks, $runs)
EndIf
Case "{RIGHT}"
if $x_Pos < $XMax then
$x_Pos = $x_Pos +1
playstep("terra2", "5", "ogg", $walks, $runs)
Else
Sleep($walks)
$wallsound.play
EndIf
Case "^LEFT"
if $x_Pos >0 then
$x_Pos = $x_Pos -1
Sleep($runs)
playstep("terra2", "5", "ogg", $walks, $runs)
EndIf
Case "^RIGHT"
if $x_Pos < $Xmax then
$x_Pos = $x_Pos +1
Sleep($runs)
playstep("terra2", "5", "ogg", $walks, $runs)
Else
$wallsound.play
EndIf
EndSwitch
EndFunc
Func getcoords()
Speaking($x_Pos &", " &$y_Pos)
EndFunc
Func Saltaya()
EndFunc