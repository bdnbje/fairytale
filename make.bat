REM @echo off

REM Usage:
REM "make" for a 64-bit compile
REM "make 32" for a 32-bit compile

REM g++ 32-bit/64-bit commands - change them according to your environment
set GPP32=g++
set GPP64=x86_64-w64-mingw32-g++

set GCC=%GCC64%
set GPP=%GPP64%

:parse
if "%1"=="" goto endparse
if "%1"=="32" (
  set GPP=%GPP32%
)
if "%1"=="appveyor" (
  set GPP=C:\MinGW\bin\g++
  set GPP32=C:\MinGW\bin\g++
)
SHIFT
goto parse
:endparse

echo %GPP%
%GPP% --version

set PARSERSCPP=parsers\ddsparser.cpp parsers\modparser.cpp parsers\textparser.cpp
set TRANSFORMSCPP=transforms\zlibtransform.cpp
set MAINCPP=analyser.cpp block.cpp deduper.cpp filestream.cpp hybridstream.cpp storagemanager.cpp

%GPP% -O2 -std=c++11 -fomit-frame-pointer -s -static -static-libgcc -static-libstdc++ -Wall %TRANSFORMSCPP% %PARSERSCPP% %MAINCPP% -lz fairytale.cpp -ofairytale.exe > test.txt
type test.txt

if not %ERRORLEVEL% == 0 echo ERROR!!!
if %ERRORLEVEL% == 0 echo.
if %ERRORLEVEL% == 0 echo Build successful.

set CPPFILES=
set GPP32=
set GPP64=