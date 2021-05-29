#cs ----------------------------------------------------------------------------
*Spanish:
say UDF 0.6 abril 2021
Soporte para Sapi5 y JAWS usando el UDF "Reader".
Corrección de errores.
say UDF 0.5 enero 2021
Agregado el soporte para las teclas especiales.
Mejoras de estabilidad y rendimiento.
Reescrito este script. ahora se usan otros atrivutos para el UDF.
Ahora antes de anunciar cualquier texto, se cancela la voz primero.
Mejoras en verbalizar capturas de textos del portapapeles.
*ENglish:
say UDF 0.6 April 2021
Support for Sapi5 and JAWS using the "reader" UDF.
Error correction.
say UDF 0.5 January 2021
Added support for special keys.
Stability and performance improvements.
Rewritten this script. now other attributes are used for the UDF.
Now before announcing any text, the speech is canceled first.
Improvements in saying text captures from the clipboard.
#ce ----------------------------------------------------------------------------
$Say_UDfversion="0.6"
global $say="1"
$Lang = iniRead ("config\config.st", "General settings", "language", "")
func configure_key()
Switch @HotKeyPressed
Case "{f3}"
select
case $lang ="es"
speaking("Hablar mientras escribes desactivado")
case $lang ="eng"
speaking("speak while typing off")
endselect
$say="0"
Case "{f2}"
select
case $lang ="es"
speaking("Hablar mientras escribes activado")
case $lang ="eng"
speaking("speak while typing on")
endselect
$say="1"
EndSwitch
HotKeySet("{space}", "say")
HotKeySet("{del}", "say")
HotKeySet("{bs}", "say")
HotKeySet("a", "say")
HotKeySet("b", "say")
HotKeySet("c", "say")
HotKeySet("d", "say")
HotKeySet("e", "say")
HotKeySet("f", "say")
HotKeySet("g", "say")
HotKeySet("h", "say")
HotKeySet("i", "say")
HotKeySet("j", "say")
HotKeySet("k", "say")
HotKeySet("l", "say")
HotKeySet("m", "say")
HotKeySet("n", "say")
HotKeySet("ñ", "say")
HotKeySet("o", "say")
HotKeySet("p", "say")
HotKeySet("q", "say")
HotKeySet("r", "say")
HotKeySet("s", "say")
HotKeySet("t", "say")
HotKeySet("u", "say")
HotKeySet("v", "say")
HotKeySet("w", "say")
HotKeySet("x", "say")
HotKeySet("y", "say")
HotKeySet("z", "say")
HotKeySet("1", "say")
HotKeySet("2", "say")
HotKeySet("3", "say")
HotKeySet("4", "say")
HotKeySet("5", "say")
HotKeySet("6", "say")
HotKeySet("7", "say")
HotKeySet("8", "say")
HotKeySet("9", "say")
HotKeySet("0", "say")
HotKeySet("^z", "say")
HotKeySet("^x", "say")
HotKeySet("^c", "say")
HotKeySet("^v", "say")
HotKeySet("^a", "say")
HotKeySet("^y", "say")
endfunc
func say()
HotKeySet("{f2}", "configure_key")
HotKeySet("{f3}", "configure_key")
if $say="1" then
Switch @HotKeyPressed
Case "{space}"
select
case $lang ="es"
speaking("Espacio")
case $lang ="eng"
speaking("Space")
endselect
Case "{del}"
select
case $lang ="es"
speaking("Borrar")
case $lang ="eng"
speaking("Delete")
endselect
Case "a"
speaking("a")
case "b"
speaking("b")
case "c"
speaking("c")
case "d"
speaking("d")
case "e"
speaking("e")
case "f"
speaking("f")
case "g"
speaking("g")
case "h"
speaking("h")
case "i"
speaking("i")
case "j"
speaking("j")
case "k"
speaking("k")
case "l"
speaking("l")
case "m"
speaking("m")
case "n"
speaking("n")
case "ñ"
speaking("ñ")
case "o"
speaking("o")
case "p"
speaking("p")
case "q"
speaking("q")
case "r"
speaking("r")
case "s"
speaking("s")
case "t"
speaking("t")
case "u"
speaking("u")
case "v"
speaking("v")
case "w"
speaking("w")
case "x"
speaking("x")
case "y"
speaking("y")
case "z"
speaking("z")
case "1"
speaking("1")
case "2"
speaking("2")
case "3"
speaking("4")
case "4"
speaking("4")
case "5"
speaking("5")
case "6"
speaking("6")
case "7"
speaking("7")
case "8"
speaking("8")
case "9"
speaking("9")
case "0"
speaking("0")
case "^z"
sleep(100)
select
case $lang ="es"
speaking("Deshacer")
case $lang ="eng"
speaking("undo")
endselect
case "^x"
sleep(100)
Local $Clipdata1 = ClipGet()
select
case $lang ="es"
speaking("Se ha cortado " &$Clipdata1& " desde el portapapeles.")
case $lang ="eng"
speaking(&$clipdata1 &"it has been cut trom clipboard.")
endselect
case "^c"
sleep(100)
Local $Clipdata2 = ClipGet()
select
case $lang ="es"
speaking("Se copió " &$Clipdata2& " al portapapeles")
case $lang ="eng"
speaking($Clipdata2 &"Copied to clipboard.")
endselect
case "^v"
sleep(100)
Local $Clipdata3 = ClipGet()
select
case $lang ="es"
speaking($Clipdata3 &"pegado al campo de texto")
case $lang ="eng"
speaking($Clipdata3 &"Pasted into text box")
endselect
case "^a"
sleep(100)
select
case $lang ="es"
speaking("Seleccionar todo")
case $lang ="eng"
speaking("Select all")
endselect
case "^y"
sleep(100)
select
case $lang ="es"
speaking("Rehacer")
case $lang ="eng"
speaking("Redo")
endselect
EndSwitch
endIf
endfunc