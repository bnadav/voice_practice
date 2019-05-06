REM "Start server"
cd "c:\voice_data"
start "server" /B "server.bat"
echo "wait for 15 seconds"
ping 1.1.1.1 -n 1 -w 15000 > nul

echo "finished wait"

REM "start secure browser"
cd "C:\Nite\VoiceBrowser\installation"
start "title" /WAIT "C:\Nite\VoiceBrowser\installation\Release\VoiceBrowser.exe" 
REM "Shutdown server"
taskkill /f /im ruby.exe

