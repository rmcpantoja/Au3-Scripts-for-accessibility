#include "include\ecilib.au3"
#include "include\menu_eloq.au3"
#include "include\menu_nvda.au3"
#include "include\Progress.au3"
#include "include\reader.au3"
#include "include\Say_UDF.au3"
if not fileExists ("config") then
DirCreate("Config")
EndIf
checkselector()
func checkselector()
global $Lang = iniRead ("config\config.st", "General settings", "language", "")
select
case $lang ="es"
main()
case $lang ="eng"
main()
Case Else
selector()
endselect
endfunc
func sistemlang()
Switch StringRight(@OSLang, 2)
Case "09"
Return "English"
IniWrite("config\config.st", "General settings", "WindowsLanguage","English")
Case "0a"
IniWrite("config\config.st", "General settings", "WindowsLanguage","Spanish")
Return "Spanish"
Case Else
IniWrite("config\config.st", "General settings", "WindowsLanguage","unknown")
Return "unknown"
EndSwitch
endfunc
sistemlang()
;This is the function off language selector menu, the first alternative using the main menu speech. Esta es la función de menú de selección de idioma, la primera alternativa que utiliza el menú principal de voz.
Func Selector()
local $widthCell,$msg,$iOldOpt
$langGUI= GUICreate("Language selector")
$widthCell=70
$iOldOpt=Opt("GUICoordMode",$iOldOpt)
GUICtrlCreateLabel("Select language ere:",-1,0)
GUISetBkColor(0x00E0FFFF)
GUISetState(@SW_SHOW)
$configureaccs = iniRead ("config\config.st", "accessibility", "Enable enanced accessibility", "")
$windowslanguage= @OSLang
;Spanish languages: Idiomas en español:
select
case $windowslanguage = "0c0a" or $windowslanguage = "040a" or $windowslanguage = "080a" or $windowslanguage = "100a" or $windowslanguage = "140a" or $windowslanguage = "180a" or $windowslanguage = "1c0a" or $windowslanguage = "200a" or $windowslanguage = "240a" or $windowslanguage = "280a" or $windowslanguage = "2c0a" or $windowslanguage = "300a" or $windowslanguage = "340a" or $windowslanguage = "380a" or $windowslanguage = "3c0a" or $windowslanguage = "400a" or $windowslanguage = "440a" or $windowslanguage = "480a" or $windowslanguage = "4c0a" or $windowslanguage = "500a"
$menu=reader_Create_Menu("Por favor, selecciona tu idioma con las flechas arriva y abajo", "Español,Inglés,Salir")
;English languages: Idiomas para inglés:
case $windowslanguage = "0809" or $windowslanguage = "0c09" or $windowslanguage = "1009" or $windowslanguage = "1409" or $windowslanguage = "1809" or $windowslanguage = "1c09" or $windowslanguage = "2009" or $windowslanguage = "2409" or $windowslanguage = "2809" or $windowslanguage = "2c09" or $windowslanguage = "3009" or $windowslanguage = "3409" or $windowslanguage = "0425" or 
$menu=reader_Create_Menu("Please select a language with the up y down arrows", "Spanish,ENglish,Exit")
;end selection off languages. Fin de selección/detección de idiomas.
case else
$menu=reader_Create_Menu("Please select a language with the up y down arrows", "Spanish,ENglish,Exit")
endselect
select
case $menu = 1
IniWrite("config\config.st", "General settings", "language", "es")
global $language="1"
sleep(100)
GUIDelete($langGUI)
Main()
case $menu = 2
IniWrite ("config\config.st", "General settings", "language", "eng")
global $language="2"
sleep(100)
GUIDelete($langGUI)
Main()
case $menu = 3
sleep(100)
exit
EndSelect
EndFunc
func Main()
$gui = guicreate("Hello Tts")
GuiSetState(@SW_SHOW)
select
Case $Lang ="es"
$ttsString = " Pulsa enter para continuar, espacio para repetir la información."
$m0="Prueba 1. Cuadros de diálogo y mensajes."
$m1="Bienvenido, " &@username
$m2="Vamos a demostrar muchas funciones que se puede hacer con TTS, voz o audio, para aplicar a tus audio-Programas o para verificar su comportamiento. La mayor parte de estas librerías están hechas por Mateo Cedillo, proporcionando una experiencia mejor para la accesibilidad en las personas con discapacidad visual. A continuación pulsa entrar para seguir."
$m3="Para comenzar, me llamo mensaje de diálogo en audio. Con la barra espaciadora repites la información del diálogo; con control+c copias el mensaje hablado al portapapeles, y enter para continuar a la siguiente función del script o al siguiente diálogo, (si hay más de uno)."
$m4="Esto puede usarse para simular cuadros de diálogo, mensajes, texto de información para el usuario, etcétera. A continuación. voy a dejarte con otra función. Pulsando enter finalizas esta prueba."
$m5="Prueba 2. Escritura y lectura de texto."
$m6="Soy un cuadro de edición"
$m7="escríbeme algo y pulsa enter para seguir. Shift f2/f3 para desactivar o activar vervalizar las teclas."
$m8="Gracias, " &@username
Case $Lang ="eng"
$m0="Test 1. Dialog boxes and messages."
$m1="Welcome, " &@username
$m2="We are going to demonstrate many functions that can be done with TTS, voice or audio, to apply to your audio-Programs or to verify their behavior. Most of these libraries are made by Mateo Cedillo, providing a better experience for accessibility for the visually impaired. Then press enter to continue. "
$m3="To begin, my name is dialogue message in audio. With the space bar you repeat the information of the dialogue; with control + c you copy the spoken message to the clipboard, and enter to continue to the next function of the script or to the next dialog , (if there is more than one). "
$m4="This can be used to simulate dialog boxes, messages, user information text, etc. I'm going to leave you with another function below. Hitting enter ends this test."
$m5="Test 2. Writing and reading text."
$m6="I am an edit box"
$m7="write me something and hpress enter to continue. Shift f2 / f3 to disable or enable say the keys."
$m8="Thank you, " &@username
EndSelect
speaking($m0)
sleep(1000)
TTsDialog($m1)
TTsDialog($m2)
TTsDialog($m3)
TTsDialog($m4)
speaking($m5)
sleep(1000)
say()
hotkeyset("{enter}", "exitLoop")
while 1
Switch @HotKeyPressed
Case "{up}"
speaking($texto)
Case "{down}"
speaking($texto)
Case "{left}"
speaking($texto)
Case "{right}"
speaking($texto)
Case "{enter}"
ExitLoop
$say= 0
EndSwitch
sleep(30)
wEnd
;msgbox(0, "Terminado", "Terminado")
EndFunc