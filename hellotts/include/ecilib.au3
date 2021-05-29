global $eciDll = dllOpen("eci.dll")
enum $eciSynthMode, $eciInputType, $eciTextMode, $eciDictionary
func eciNew()
$r = dllCall($eciDll, "long", "eciNew")
return $r[0]
endFunc
func eciAddText($h, $text)
dllCall($eciDll, "long", "eciAddText", "long", $h, "str", $text)
endFunc
func eciSynthesize($h)
dllCall($eciDll, "long", "eciSynthesize", "long", $h)
endFunc
func eciSynchronize($h)
dllCall($eciDll, "long", "eciSynchronize", "long", $h)
endFunc
func eciSetParam($h, $p, $v)
$r = dllCall($eciDll, "long", "eciSetParam", "long", $h, "long", $p, "long", $v)
return $r[0]
endFunc
$h = eciNew()
;set input type to allow annotated commands
eciSetParam($h, $eciInputType, 1)
FUNC EciSayEng($rate,  $text)
eciAddText($h,"`vs"&$rate&$text)
eciSynthesize($h)
eciSynchronize($h)
endfunc
FUNC EciSaySp($rate,  $text)
eciAddText($h,"`vs"&$rate&"`l2"&$text)
eciSynthesize($h)
eciSynchronize($h)
endfunc
func eciStop()
$stop = dllCall($eciDll, "long", "eciStop")
if @error then return $stop
return 1
endFunc
