#include "Audio.au3"
;Map
Global $jumping = 0
;Global $walkspeed = "220"
;Global $runspeed =" 140"
Func playstep($tile, $steps, $sFormat, $walkspeed, $runspeed)
;Loadsounds:
$tilesound = $device.opensound ("sounds/" &$tile &"step" &Random(1, $steps, 1) &"." &$sFormat, 0)
$tilesound.play
Switch @HotKeyPressed
Case "{LEFT}" or Case "{RIGHT}"
Sleep($walkspeed)
Case "^LEFT" or Case "^RIGHT"
Sleep($runspeed)
EndSwitch
EndFunc
Func colocarpared($maxy)
if $x_Pos =$maxy then
$wallsound = $device.opensound ("sounds/wallgeneric.ogg", 0)
$wallsound.play
EndIf
EndFunc
Func Jump($tile, $sFormat)
$Jump = $device.opensound ("sounds/jump.ogg" , 0)
$jump.play
EndFunc