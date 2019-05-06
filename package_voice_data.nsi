; install_voice_data.nsi
!include WinMessages.nsh

!include "FileFunc.nsh"
!insertmacro GetTime


; The name of the installer
Name "VoiceDATAInstaller"

; The file to write
OutFile "voice_data_installer.exe"

; The default installation directory
InstallDir "C:\voice_data\public\voice_data\"



;--------------------------------
; Pages
; ---------------Our custom page ---------------------------
;Page custom ShowCustom LeaveCustom ": Testing InstallOptions"

;Function ShowCustom

  ; Initialise the dialog but don't show it yet
 ; InstallOptions::initDialog /NOUNLOAD "$PLUGINSDIR\test.ini"
  ; In this mode InstallOptions returns the window handle so we can use it
 ; Pop $0
  ; Now show the dialog and wait for it to finish
;  InstallOptions::show
  ; Finally fetch the InstallOptions status value (we don't care what it is though)
;  Pop $0

;FunctionEnd


;-------------------------------------------------------------

;--------------------------------------------------------------

; The stuff to install
Section "Install Files"

  SectionIn RO

  ; Clear errors variable
  ClearErrors
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put files there
   File /r ".\public\voice_data\*"	;voice files

  
   
  ; Check for errors
  IfErrors 0 Next0
    MessageBox MB_OK|MB_RIGHT "Error in copying files(1)"
    Goto ErrorWay 

  ; no Eroors so far
  Next0:
    
     MessageBox MB_OK|MB_RIGHT "Install File is ready"
       
         
  ; Skip NoError message if there was an error
  ErrorWay:

; end the section
SectionEnd 






; eof
