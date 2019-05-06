; install_voice.nsi

; The name of the installer
Name "VoiceInstaller"

; The file to write
OutFile "Install_voice.exe"

; The default installation directory
InstallDir "c:\voice_data\"

; The text to prompt the user to enter a directory
DirText "This will install voice on your computer. Choose a directory"

; The stuff to install
Section "voice"

; Close window after install completes
SetAutoClose true

; Set output path to the installation directory.
SetOutPath $INSTDIR

; Clear errors variable
ClearErrors

 ; Put file there
;  File "*.bat"
;  File "*.ico"
 ; File "Gemfile"
 ; File "init.rb"			
;  File /r "app\*"		
 ; File /r "config\*"	
 ; File /r "db\*"	
;  File /r "doc\*"	 
;  File /r "public\images\*"
;  File /r "public\javascripts\*"
;  File /r "public\stylesheets\*"
;  File /r "public\*.html"
;  File /r "script\*"	
;  File /r "vendor\*"	

  File /r  *
  

; Copy files from source directory to destination directory
;CopyFiles "$EXEDIR\voice_data\*" $OUTDIR 24000


IfErrors Error1 Next0

Error1:
  MessageBox MB_OK|MB_ICONSTOP "Error in copying files "
  Goto ErrorWay


Next0:
  Delete "$DESKTOP\מבחן השמעה.exe"
  Delete "$DESKTOP\מבחן השמעה.bat"

IfErrors Error2 Next1

Error2:
  MessageBox MB_OK|MB_ICONSTOP "Error in removing files from desktop"
  Goto ErrorWay

Next1:
 ;Create short cut
 CreateShortCut "$DESKTOP\מבחן השמעה.lnk" "$INSTDIR\wait.bat" "" "$INSTDIR\world.ico" 0

IfErrors Error3 Next2

Error3:
  MessageBox MB_OK|MB_ICONSTOP "Error in copying voice_browser to desktop"
  Goto ErrorWay



Next2:
; Final Message: No errors
MessageBox MB_OK "Installed Succesfuly :-)"

; Skip NoError message if there was an error
ErrorWay:

SectionEnd ; end the section

; eof
