@echo off
cls
GOTO MAINMENU
:MAINMENU
cls
echo ==============================================================================
echo                               Solution Type
echo ==============================================================================
echo.
echo                  1 - Desktop
echo.
echo                  2 - Web
echo.
echo                  3 - Web (Core)
echo.
echo                  4 - Asp.Net (Core)
echo.
echo                  5 - Install Templates
echo.
ECHO =============================================================================
ECHO                            Press 'Q' to Quit
ECHO =============================================================================
echo.
choice /c 1234q /n /m "Choose a menu option, or Q to quit: "
SET TYPE=%ERRORLEVEL%
IF %TYPE%==1 SET SLN=reposln
IF %TYPE%==2 SET SLN=websln
IF %TYPE%==3 SET SLN=webslncore
IF %TYPE%==4 SET SLN=aspnetcore
IF %TYPE%==5 GOTO :TEMPLATES
IF %TYPE%==6 GOTO :QUIT
cls
echo ==============================================================================
echo                               New Solution
echo ==============================================================================
echo.
echo                  1 - GitHub
echo.
echo                  2 - Sandbox
echo.
echo                  3 - Visual Studio
echo.
echo                  4 - Sql
echo.
echo                  5 - Google
echo.
echo                  6 - Tfs
echo.
echo                  7 - Nuget
echo.
echo                  8 - Clean
echo.
ECHO =============================================================================
ECHO                            Press 'Q' to Quit
ECHO =============================================================================
echo.
choice /c 123456789q /n /m "Choose a menu option, or Q to quit: "
SET MENU_CHOICE=%ERRORLEVEL%
IF %MENU_CHOICE%==1 GOTO :GITHUB
IF %MENU_CHOICE%==2 GOTO :SANDBOX
IF %MENU_CHOICE%==3 GOTO :VS
IF %MENU_CHOICE%==4 GOTO :SQL
IF %MENU_CHOICE%==5 GOTO :GOOGLE
IF %MENU_CHOICE%==6 GOTO :TFS
IF %MENU_CHOICE%==7 GOTO :NUGET
IF %MENU_CHOICE%==8 GOTO :CLEAN
IF %MENU_CHOICE%==9 GOTO :QUIT

:SOLUTION
set /P NAME=Enter Solution Name: 
dotnet new %SLN% -n "%NAME%" -o "%TARGET_DIR%\%NAME%" --force
"%TARGET_DIR%\%NAME%\src\%NAME%.sln"
GOTO QUIT

:TEMPLATES
set TARGET_DIR=dotnet\templates\RepositorySolution
dotnet new -i "%TARGET_DIR%"
set TARGET_DIR=dotnet\templates\WebSolution
dotnet new -i "%TARGET_DIR%"
set TARGET_DIR=dotnet\templates\WebSolutionCore
dotnet new -i "%TARGET_DIR%"
set TARGET_DIR=dotnet\templates\AspNetCore
dotnet new -i "%TARGET_DIR%"
GOTO MAINMENU

:SQL
set TARGET_DIR=sql
GOTO SOLUTION
GOTO QUIT

:GITHUB
set TARGET_DIR=github
GOTO SOLUTION
GOTO QUIT

:SANDBOX
set TARGET_DIR=sandbox
GOTO SOLUTION
GOTO QUIT

:VS
set TARGET_DIR=..\vs
GOTO SOLUTION
GOTO QUIT

:TFS
set TARGET_DIR=tfs
GOTO SOLUTION
GOTO QUIT

:GOOGLE
set TARGET_DIR=google
GOTO SOLUTION
GOTO QUIT

:NUGET
set TARGET_DIR=nuget
GOTO SOLUTION
GOTO QUIT





:CLEAN
ECHO WARNING: Removing '.localhistory' directories
for /f "tokens=*" %%i IN ('dir /s /b /ad .localhistory') DO (
rmdir /q /s "%%i"
)
ECHO WARNING: Removing '.vs' directories
for /f "tokens=*" %%j IN ('dir /s /b /ad .vs') DO (
rmdir /q /s "%%j"
)
ECHO WARNING: Removing 'bin' directories
for /f "tokens=*" %%k IN ('dir /s /b /ad bin') DO (
rmdir /q /s "%%k"
)
ECHO WARNING: Removing 'binaries' directories
for /f "tokens=*" %%l IN ('dir /s /b /ad binaries') DO (
rmdir /q /s "%%l"
)
GOTO MAINMENU

:QUIT
exit /b


