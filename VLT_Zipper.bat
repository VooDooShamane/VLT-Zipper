@echo off
setlocal enabledelayedexpansion
set "home=%~dp0"
cd /d "%home%resource"

set "inpname=%~nx1"
set "sfk=bin\sfk.exe"
set "py=bin\python\python.exe"
set mydate=%date:~-10,2%-%date:~-7,2%-%date:~-4%
if "%time:~-11,1%" == " " (
		set mytime=0%time:~1,1%-%time:~-8,2%-%time:~-5,2%
	) else (
		set mytime=%time:~-11,2%-%time:~-8,2%-%time:~-5,2%
		)
	)



@echo "%1">tempdir
REM teste schreibzugriff
if exist tempdir (
		"%sfk%" replace tempdir -binary "/22//" -yes >NUL
		set /p input1= <tempdir
		del tempdir
	) else (
		color 4
		@echo Keine Schreibrechte!
		@echo bitte VLT Zipper als Administrator ausfuehren.
		pause
		exit
		)
	)

REM Cleanup
for %%d in (info.txt params.txt FIRM.bin FIRM.bin.enc) do if exist %%d del %%d






@echo.
@echo  _   ____ ______  ____  _                  
@echo ^| ^| / / //_  __/ /_  / /_/__  ___  ___ ____
@echo ^| ^|/ / /__/ /     / /_/ / _ \/ _ \/ -_\ __/
@echo ^|___/____/_/     /___/_/ .__/ .__/\__/_/   
@echo                       /_/  /_/             
@echo          powered by Python ^& XiaoTea
@echo          created by VooDooShamane
@echo.

for %%d in (bin\python\xiaotea.py bin\python\enc.py bin\python\dec.py) do if not exist %%d (
	@echo.
	@echo XiaoTea Script zum verschluesseln der Firmware nicht gefunden
	@echo bitte xiaotea.py dec.py enc.py downloaden
	@echo.
	@echo https://github.com/BotoX/xiaomi-m365-firmware-patcher/tree/master/xiaotea
	@echo.
	@echo speichern unter:
	@echo resource\bin\python\xiaotea.py
	@echo resource\bin\python\enc.py
	@echo resource\bin\python\dec.py
	pause
	exit
	)

for %%d in (bin\firmwares\DRV236.bin bin\firmwares\DRV304.bin) do if not exist %%d (
	@echo.
	@echo Vanilla Firmwares DRV236 und DRV304 nicht gefunden
	@echo bitte downloaden
	@echo.
	@echo DRV236
	@echo https://files.scooterhacking.org/firmware/pro2/DRV/DRV236.bin
	@echo.
	@echo DRV304
	@echo https://files.scooterhacking.org/firmware/1s/DRV/DRV304.bin
	@echo.
	@echo speichern unter:
	@echo resource\bin\firmwares\DRV236.bin
	@echo resource\bin\firmwares\DRV304.bin
	@echo.
	pause
	exit
	)

if ["%input1%"] == [""] (
	@echo Keine Firmware ausgewaehlt
	@echo Bitte Firmware auf das VLT_Zipper.bat Script ziehen
	pause
	exit
	)

for /f %%i in ("%input1%") do set "inpsz=%%~zi"

:VER
for /f %%h in ('%sfk% hexdump -nofile -pure -offlen 0x00006646 0x00000004 "%input1%"') do set drv236=%%h >NUL
for /f %%h in ('%sfk% hexdump -nofile -pure -offlen 0x000067EA 0x00000004 "%input1%"') do set drv304=%%h >NUL

	if %drv236% EQU 40F23620 (
		set "drv=236"
		@echo dev: pro2;>info.txt
		@echo nam: VLT236;>>info.txt
		@echo - Version: DRV236;>params.txt
		@echo.
		@echo Mi Pro2 Firmware DRV236 erkannt
		if not ["%inpsz%"] == ["28660"] (
		color 4
		@echo.
		@echo Achtung^^! 
		@echo %input1% hat eine andere groesse als erwartet ^^!^^!^^!
		@echo Vanilla sind 28660 Bytes diese hat %inpsz% Bytes
		@echo Trotzdem weiter machen ?
		@echo.
		pause
		)
	) else (
		if %drv304% EQU 4FF44170 (
			set "drv=304"
			@echo dev: 1s;>info.txt
			@echo nam: VLT304;>>info.txt
			@echo - Version: DRV304;>params.txt
			@echo.
			@echo Mi 1s Firmware DRV304 erkannt
			if not ["%inpsz%"] == ["28644"] (
			color 4
			@echo.
			@echo Achtung^^! 
			@echo %input1% hat eine andere groesse als erwartet ^^!^^!^^!
			@echo Vanilla sind 28644 Bytes diese hat %inpsz% Bytes
			@echo Trotzdem weiter machen ?
			@echo.
			pause
			)
		) else (
			@echo.
			@echo "Keine DRV236 oder DRV304 Firmware"
			pause
			exit
		)
	)

@echo enc: B;>>info.txt
@echo typ: DRV;>>info.txt
@echo This file has been generated from VLT_Zipper powered by XiaoTea. Make sure you know what it contains.;>>params.txt
@echo.;>>params.txt
@echo Changes below;>>params.txt
@echo Offset^| Vanilla ^| Mod;>>params.txt
fc /b "%home%resource\bin\firmwares\DRV%drv%.bin" "%input1%" >> params.txt
@echo.
if exist params.txt (
		@echo params.txt mit Mod offsets erfolgreich erstellt
	) else (
		@echo Params.txt konnte nicht erstellt werden.
		@echo bitte VLT Zipper als Administrator ausfuehren
		pause
		exit
		)
	)

:ENC
copy "%input1%" FIRM.bin >NUL
%py% bin\python\enc.py FIRM.bin FIRM.bin.enc
for /f %%i in ("FIRM.bin.enc") do set "oupsz=%%~zi"
@echo.
REM Check File
if not exist FIRM.bin.enc (
		@echo Kritischer Fehler
		@echo Konnte Firmware nicht verschluesseln
		pause
		exit
		)

if %oupsz% GTR 28000 (
		@echo %inpname% erfolgreich mit XiaoTea encrypted
	) else (
		@echo Kritischer Fehler
		@echo Verschluesselte FIRM.bin.enc ist kleiner als 28000 Bytes
		pause
		exit
		)
	)

:MD5
for /f %%m in ('%sfk% md5 FIRM.bin') do @echo md5: %%m;>>info.txt
@echo.
@echo FIRM.bin Md5 erstellt
for /f %%m in ('%sfk% md5 FIRM.bin.enc') do @echo md5e: %%m;>>info.txt
@echo.
@echo FIRM.bin.enc Md5 erstellt
@echo.
@echo info.txt erfolgreich erstellt

:ZIP
%sfk% zip -yes "%home%VLT%drv%_%mydate%_%mytime%.zip" info.txt params.txt FIRM.bin FIRM.bin.enc >NUL
@echo.
@echo %home%VLT%drv%_%mydate%_%mytime%.zip erfolgreich erstellt
for %%d in (info.txt params.txt FIRM.bin FIRM.bin.enc) do del %%d
@echo.
pause