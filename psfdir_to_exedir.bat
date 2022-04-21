set bat_dir=%~dp0
@echo off
title PSF Sets to EXEs Converter
color 8b
cd /d %1
md _UPX
for /d %%A in (*) do (
  if "%%A" NEQ "_UPX" md ".\_UPX\%%A"
  cd "%%A"
  if "%%A" NEQ "_UPX" call :do_dir "%%A"
  cd..
)
pause
goto :eof
:do_dir
  title %1 - PSF Sets to EXEs Converter
  if exist *.psflib if not exist *.minipsf ren *.psf *.minipsf
  for %%n in (*.minipsf) do python %bat_dir%\unminipsf.py "%%n"
  for %%p in (*.psf) do %bat_dir%\psf2exe.exe "%%p"
  for %%q in (*.exe) do %bat_dir%\upx.exe --best --force -o"..\_UPX\%~1\%%~nq.exe" "%%q"
goto :eof
