@echo off
pushd "%~dp0"
cls
for /f "tokens=*" %%i IN ('"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -property installationPath') DO (
set VSINSTALLPATH=%%i
set TOOLSPATH=%%i\Common7\Tools
set DEVENVDIR=%%i\Common7\IDE\
set DEVCMD=%%i\Common7\Tools\VsDevCmd.bat
)
for /f "tokens=*" %%j IN ('dir src\*.sln /b') DO (
set SOLUTIONFILE=%~dp0src\%%j
)
call "%DEVCMD%"
popd
msbuild "%SOLUTIONFILE%" /t:Restore /m /v:m 
msbuild "%SOLUTIONFILE%" /t:Build /m /v:m 
echo Complete!
pause
exit /b
