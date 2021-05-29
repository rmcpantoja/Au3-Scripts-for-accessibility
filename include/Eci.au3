; #SCRIPT# ;===============================================================================
;
; Name...........: ECI.au3
; Description ...: Support f�r Eloquence unter Autoit.
; Author ........: Timtam
;
; ;==========================================================================================
#include-once
dim $Err
dim $aDll_Return
;Konstanten
dim const $Eci_SynthMode = 0
dim const $Eci_InputType = 1
dim const $Eci_Pitch_BaseLine = 2
dim const $Eci_Dictionary = 3
dim const $Eci_Pitch_Fluctuation = 3
dim const $Eci_Rate = 6
dim const $Eci_Volume = 7
dim const $Eci_LanguageDialect = 9
dim const $Eci_Lang_Esm = 131073 ;Latin America Spanish
dim const $Eci_Lang_ESP = 131072 ;Castilian Spanish
dim const $Eci_Lang_PTB = 458752 ;Brazilian Portuguese
dim const $Eci_Lang_FRC = 196609 ;French Canadian
dim const $Eci_Lang_FRA = 196608 ;French
dim const $Eci_Lang_FIN = 589824 ;Finish
dim const $Eci_Lang_Deu = 262144 ;German
dim const $Eci_Lang_Ita = 327680 ;Italian
dim const $Eci_Lang_Enu = 65536 ;American English
dim const $Eci_Lang_Eng = 65537 ;British English
dim $_EloDll = -1
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_Startup()
; Description ...: Startet die Verwendung von Eloquence. Vorsicht: Diese Funktion muss direkt nach dem Include der eci.au3-Datei durchgef�hrt werden, da ansonsten Fehler auftreten.
; Syntax.........: _Eci_Startup([$sPath = ""])
; Parameters ....: $sPath - Pfad zu der eci.dll-Datei. Wird kein String angegeben, wird die eci.dll im Skriptverzeichnis gesucht.
; Return values .: Erfolg: 1
;                  Fehler: -1
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_Startup($sPath = "")
	if $sPath = "" then $sPath = @scriptdir & "\eci.dll"
	$_EloDll = dllopen($sPath)
	if $_EloDll <> 1 then
		seterror(-1)
		return -1
	endif
	return 1
endfunc   ;==>_Eci_Startup
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_New()
; Description ...: Erstellt ein Handle, um Eloquence verwenden zu k�nnen.
; Syntax.........: _Eci_New()
; Parameters ....: keine
; Return values .: Erfolg: Ein Handle
;                  Fehler: -1 und setzt @error (siehe DllCall f�r Error-Meldungen)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
; Example .......; no
;
; ;==========================================================================================
func _Eci_New()
	$aDll_Return = dllcall($_EloDll, "int", "eciNew")
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_New
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_SetParam()
; Description ...: Ver�ndert einen Wert eines eci Handles.
; Syntax.........: _Eci_SetParam($iEci_Handle, $iParam, $iValue)
; Parameters ....: $iEci_Handle 0 Handle einer Eci-Einheit (_Eci_New())
;                  $iParam - Zu ver�ndernder Wert (siehe obenstehende Konstanten)
;                  $iValue - Wert, der ge�ndert werden soll.
; Return values .: Erfolg: Vorherige Wert.
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-_erte)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_SetParam($iEci_Handle, $iParam, $iValue)
	$aDll_Return = dllcall($_EloDll, "int", "eciSetParam", "int", $iEci_Handle, "int", $iParam, "int", $iValue)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_SetParam
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_GetParam()
; Description ...: Gibt den gesetzten Wert einer Einstellung zur�ck.
; Syntax.........: _Eci_GetParam($iEci_Handle, $iParam)
; Parameters ....: $iEci_Handle - Handle (_Eci_New())
;                  $iParam - Parameter, von dem der gesetzte Wert zur�ckgegeben werden soll. (siehe obenstehende Konstanten)
; Return values .: Erfolg: der abzufragende Wert
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Werte)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_GetParam($iEci_Handle, $iParam)
	$aDll_Return = dllcall($_EloDll, "int", "eciGetParam", "int", $iEci_Handle, "int", $iParam)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_GetParam
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_AddText()
; Description ...: Setzt einen Text, der sp�ter synthetisiert werden kann.
; Syntax.........: _Eci_AddText($iEci_Handle, $sText)
; Parameters ....: $iEci_Handle - Handle (_Eci_New())
;                  $sText - Zu setzender Text
; Return values .: Erfolg: 1
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Wert)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_AddText($iEci_Handle, $sText)
	$aDll_Return = dllcall($_EloDll, "int", "eciAddText", "int", $iEci_Handle, "str", $sText)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_AddText
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_Synthesize()
; Description ...: Spricht den mit _Eci_AddText() gesetzten Text.
; Syntax.........: _Eci_Synthesize($iEci_Handle)
; Parameters ....: $iEci_Handle - Handle (_Eci_New())
; Return values .: Erfolg: 1
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Werte)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_Synthesize($iEci_Handle)
	$aDll_Return = dllcall($_EloDll, "int", "eciSynthesize", "int", $iEci_Handle)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_Synthesize
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_Stop()
; Description ...: Stoppt das Sprechen des Textes.
; Syntax.........: _Eci_Stop($iEci_Handle)
; Parameters ....: $iEci_Handle - Handle (_Eci_New())
; Return values .: Erfolg: 1
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Werte)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_Stop($iEci_Handle)
	$aDll_Return = dllcall($_EloDll, "int", "eciStop", "int", $iEci_Handle)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_Stop
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_Delete()
; Description ...: L�scht ein Handle und entwertet es.
; Syntax.........: _Eci_Delete($iEci_Handle)
; Parameters ....: $iEci_Handle - Handle (_Eci_New())
; Return values .: Erfolg: 1
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Wert)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_Delete($iEci_Handle)
	$aDll_Return = dllcall($_EloDll, "int", "eciDelete", "int", $iEci_Handle)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_Delete
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_Speaking()
; Description ...: Ermittelt, ob Eloquence gerade einen Text spricht.
; Syntax.........: _Eci_Speaking($iEci_Handle)
; Parameters ....: $iEci_Handle - Handle (_Eci_New())
; Return values .: Erfolg: 1
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Wert)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_Speaking($iEci_Handle)
	$aDll_Return = dllcall($_EloDll, "int", "eciSpeaking", "int", $iEci_Handle)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_Speaking
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_NewDict()
; Description ...: Erstellt ein neues W�rterbuch.
; Syntax.........: _Eci_NewDict($iEci_Handle)
; Parameters ....: $iEci_Handle - Handle (_Eci_New())
; Return values .: Erfolg: ein W�rterbuchhandle
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Wert)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_NewDict($iEci_Handle)
	$aDll_Return = dllcall($_EloDll, "int", "eciNewDict", "int", $iEci_Handle)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_NewDict
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_SetDict()
; Description ...: Bindet ein W�rterbuchhandle an ein Eloquence-Handle
; Syntax.........:  _Eci_SetDict($iEci_Handle, $iDict_Handle)
; Parameters ....: $iEci_Handle - Handle (siehe DllCall f�r @error-Wert)
;                  $iDict_Handle - W�rterbuchhandle (e.g. _Eci_NewDict)
; Return values .: Erfolg: 1
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Wert)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_SetDict($iEci_Handle, $iDict_Handle)
	$aDll_Return = dllcall($_EloDll, "int", "eciSetDict", "int", $iEci_Handle, "int", $iDict_Handle)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_SetDict
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_LoadDict()
; Description ...: L�dt ein W�rterbuch aus einer Datei.
; Syntax.........: _Eci_LoadDict($iEci_Handle, $iDict_Handle, $iIndex, $sPath, $sFilename)
; Parameters ....: $iEci_Handle - Handle (_Eci_New())
;                  $iDict_Handle - W�rterbuchhandle (e.g. _Eci_NewDict())
;                  $iIndex - Index, auf dem das W�rterbuch abgelegt werden soll (beginnend mit 0, zweites W�rterbuch 1 usw.)
;                  $sPath - Pfad zu der W�rterbuchdatei (ohne Datei anzugeben (e.g. Autoitmakros wie @scriptdir))
;                  $sFilename - Dateiname des W�rterbuches
; Return values .: Erfolg: 1
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Wert)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_LoadDict($iEci_Handle, $iDict_Handle, $iIndex, $sPath, $sFilename)
	$aDll_Return = dllcall($_EloDll, "int", "eciLoadDict", "int", $iEci_Handle, "int", $iDict_Handle, "int", $iIndex, "str", $sPath, "int", $sFilename)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_LoadDict
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_SetVoiceParam()
; Description ...: Setzt einen Parameter, der auf eine Stimme bezogen ist.
; Syntax.........: _Eci_SetVoiceParam($iEci_Handle, $iVoice, $iParam, $iValue)
; Parameters ....: $iEci_Handle - Handle (_Eci_New())
;                  $iVoice - Stimmenindex (0 =erste Stimme, 1 =zweite Stimme usw.)
;                  $iParam - Zu setzender Parameter (siehe obenstehende Konstanten)
;                  $iValue - Zu setzender Wert
; Return values .: Erfolg: vorheriger gesetzter Wert
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Wert)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_SetVoiceParam($iEci_Handle, $iVoice, $iParam, $iValue)
	$aDll_Return = dllcall($_EloDll, "int", "eciSetVoiceParam", "int", $iEci_Handle, "int", $iVoice, "int", $iParam, "int", $iValue)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_SetVoiceParam
; #FUNCTION# ;===============================================================================
;
; Name...........: _Eci_GetVoiceParam()
; Description ...: Gibt den Wert eines Parameters einer Stimme zur�ck.
; Syntax.........: _Eci_GetVoiceParam($iEci_Handle, $iVoice, $iParam)
; Parameters ....: $iEci_Handle - Handle (_Eci_New())
;                  $iVoice - Stimmenindex (0 =erste STimme, 1 =zweite Stimme usw.)
;                  $iParam - Parameter, von welchem der Wert zur�ckgegeben werden soll (siehe obenstehende Konstanten)
; Return values .: Erfolg: abgefragter Wert
;                  Fehler: -1 und setzt @error (siehe DllCall f�r @error-Wert)
; Author ........: Timtam
; Link ..........; http://tonisoft.square7.ch
;
; ;==========================================================================================
func _Eci_GetVoiceParam($iEci_Handle, $iVoice, $iParam)
	$aDll_Return = dllcall($_EloDll, "int", "eciGetVoiceParam", "int", $iEci_Handle, "int", $iVoice, "int", $iParam)
	$Err = @error
	if not isarray($aDll_Return) then
		seterror($Err)
		return -1
	endif
	return $aDll_Return[0]
endfunc   ;==>_Eci_GetVoiceParam
FUNC EciSayEng($rate,  $text)
_eci_AddText($h,"`vs"&$rate&$text)
eciSynthesize()
eciSynchronize($h)
endfunc
$h = _eci_New()
_eci_SetParam($h, $Eci_InputType, 1)
FUNC EciSaySp($rate,  $text)
_eci_AddText($h,"`vs"&$rate&"`l2"&$text)
_eci_Synthesize()
_eci_Synchronize($h)
endfunc
