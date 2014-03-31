@echo off
rem
rem    Compile and link options used for building MEX-files
rem    using the Microsoft® Visual C++ compiler.
rem
rem ********************************************************************
rem General parameters
rem ********************************************************************
rem Set this to the top level of the Visual C++ Compiler installation directory
rem Possibilities include:
rem    C:\Program Files\Microsoft Visual Studio 8\VC
rem    C:\Program Files\Microsoft Visual Studio 9.0\VC
rem    C:\Program Files\Microsoft SDKs\Windows\v6.0\VC
set VCINSTALLDIR=C:\Program Files\Microsoft Visual Studio 8\VC

rem Set this to the top level of the platform SDK installation directory
rem Possibilities include:
rem    C:\Program Files\Microsoft Visual Studio 8\VC\PlatformSDK
rem    C:\Program Files\Microsoft SDKs\Windows\v6.0
rem    C:\Program Files\Microsoft SDKs\Windows\v6.0A
set MSSdk=C:\Program Files\Microsoft Visual Studio 8\VC\PlatformSDK

rem Set this to the directory that contains files including libmex.lib 
rem in the Matlab installation directory.
rem Possibilities include:
rem    %MATLAB%\extern\lib\win32\microsoft\msvc71
rem    %MATLAB%\extern\lib\win32\microsoft\
set LIBLOC=%MATLAB%\extern\lib\win32\microsoft\msvc71

set MATLAB=%MATLAB%
set PATH=%VCINSTALLDIR%\BIN\;%MSSdk%\bin;%VCINSTALLDIR%\include;%MSSdk%\lib;%VCINSTALLDIR%\..\Common7\IDE;%MATLAB_BIN%;%PATH%
set INCLUDE=%VCINSTALLDIR%\INCLUDE;%MSSdk%\INCLUDE;%INCLUDE%
set LIB=%VCINSTALLDIR%\LIB;%MSSdk%\lib;%MATLAB%\extern\lib\win32;%LIB%
set MW_TARGET_ARCH=win32

rem ********************************************************************
rem Compiler parameters
rem ********************************************************************
set COMPILER=cl
set COMPFLAGS=/c /Zp8 /GR /W3 /EHsc- /Zc:wchar_t- /DMATLAB_MEX_FILE /nologo
set OPTIMFLAGS=/MD /O2 /Oy- /DNDEBUG
set DEBUGFLAGS=/MD /Zi /Fd"%OUTDIR%%MEX_NAME%.pdb"
set NAME_OBJECT=/Fo

rem ********************************************************************
rem Linker parameters
rem ********************************************************************
set LINKER=link
set LINKFLAGS=/dll /export:%ENTRYPOINT% /MAP /LIBPATH:"%LIBLOC%" libmx.lib libmex.lib /implib:%LIB_NAME%.x /MACHINE:X86 kernel32.lib 

set LINKOPTIMFLAGS=
set LINKDEBUGFLAGS=/DEBUG /PDB:"%OUTDIR%%MEX_NAME%.pdb"
set LINK_FILE=
set LINK_LIB=
set NAME_OUTPUT=/out:"%OUTDIR%%MEX_NAME%.dll"
set RSP_FILE_INDICATOR=@

rem ********************************************************************
rem Resource compiler parameters
rem ********************************************************************
set RC_COMPILER=rc /fo "%OUTDIR%mexversion.res"
set RC_LINKER=

set POSTLINK_CMDS=del "%OUTDIR%%MEX_NAME%.map"
set POSTLINK_CMDS1=del %LIB_NAME%.x
set POSTLINK_CMDS2=mt -outputresource:"%OUTDIR%%MEX_NAME%.dll";2 -manifest "%OUTDIR%%MEX_NAME%.dll.manifest"
set POSTLINK_CMDS3=del "%OUTDIR%%MEX_NAME%.dll.manifest" 
