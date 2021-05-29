#include-once
#include <keyinput.au3>
;#include "ecilib.au3"
Func ECI_create_menu($s_Language,$description,$options)
	If $description = "" Then Return 0
	If $s_language = "" Then Return 0
	If $options = "" Then Return 0
If not $s_language = "`l1" or $s_language = "`l1.1" or $s_language = "`l2" or $s_language = "`l2.1" or $s_language = "`l3" or $s_language = "`l3.1" or $s_language = "`l4" or $s_language = "`l5" or $s_language = "`l6" or $s_language = "`l7" or $s_language = "`l8" or $s_language = "`l9" or $s_language = "`l10" Then
EciSayEng("57", "main menu")
else
msgbox(4096, "Error", "The language parameter is not correct.")
exit
endIf
	$selection = 1
	$items = StringSplit($options, ",")
	If @error Then Return 0
	$menu_length = $items[0]
$rate="`vs50"
$volume="`vv100"
$final= ($s_language &$rate &$volume &$description)
eciAddText($h, $final)
eciSynthesize($h)
eciSynchronize($h)
	While 1
		$active_window = WinGetProcess("")
		If $active_window = @AutoItPID Then
		Else
			Sleep(10)
			ContinueLoop 
		EndIf
		$menu_key = ""
		$capt = check_key("26", 2)
		If $capt = 1 Then
			$menu_key = "up arrow"
		EndIf
		$capt = check_key("28", 3)
		If $capt = 1 Then
			$menu_key = "down arrow"
		EndIf
		$capt = check_key("0D", 5)
		If $capt = 1 Then
			$menu_key = "enter"
		EndIf
		If $menu_key = "" Then
			Sleep(10)
			ContinueLoop 
		EndIf
		If $menu_key = "enter" Then
			If $selection > 0 Then
				$menu = ""
				Return $selection
			EndIf
		EndIf
		If $menu_key = "up arrow" Then
			$selection = $selection - 1
			If $selection < 1 Then
				$selection = $menu_length
			EndIf
			$file_to_open = $items[$selection]
eciStop()
$final2= ($s_language &$rate &$volume &$file_to_open)
eciAddText($h, $final2)
eciSynthesize($h)
eciSynchronize($h)
		EndIf
		If $menu_key = "down arrow" Then
			$selection = $selection + 1
			$limit = $menu_length + 1
			If $selection = $limit Then
				$selection = 1
			EndIf
			$file_to_open = $items[$selection]
eciStop()
eciAddText($h, $final2)
eciSynthesize($h)
eciSynchronize($h)
		EndIf
		Sleep(10)
	WEnd
EndFunc