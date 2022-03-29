@ECHO OFF
REM Update BC+FW

REM ***************************** Config *****************************
REM Console IAP version
Set IAP_AP_PATH=Console_IAP_Ver_1.43.1.57
REM BC_FILE_PATH: BC File Path
REM Set BC_FILE_PATH= IAP\BootCodeUpdater.ekt
REM Set BC_FILE_PATH= IAP\IAP\MASTER_BootCodeUpdater.ekt;SLAVE1_BootCodeUpdater.ekt
Set BC_FILE_PATH= ..\IAP\BootCodeUpdater_A741.ekt
REM FW_FILE_PATH: FW File Path
REM Set FW_FILE_PATH= IAP\FW.ekt
REM Set FW_FILE_PATH= IAP\Chimera_OFlim_Sharp_2C93_254B_5705.ekt
Set FW_FILE_PATH= ..\IAP\F7.ekt
Set Update_BC_Time= 6
REM WIN8_BRIDGE: 0:Elan bridge(0xb) \ 1:Win 8 or No Bridge 
Set WIN8_BRIDGE= 1
REM VDD(Only use with Elan Bridge): 0:5.0V \ 1:3.3V(default) \ 2:3.0V \ 3:2.8V \ Other
Set VDD= 1
REM VIO(Only use with Elan Bridge): 0:5.0V \ 1:3.3V(default) \ 2:3.0V \ 3:2.8V \ 4:1.8 \ Other
Set VIO= 1
REM I2C_Addr(Only use with Elan Bridge): 0x0 means set to default value 0x20.
Set I2C_Addr= 0x0
REM INTERFACE: 
REM USB or FastUSB:1 \ I2C or FastI2C:2 \SPI:3~6 \Hid over I2C: 8 \SPI for iTouch: 9
REM 3: SPI SL(TP is MA Hi Rising Edge Out)
REM 4: SPI SL(TP is MA Hi Falling Edge Out)
REM 5: SPI MA(TP is SL Hi Rising Edge Out)
REM 6: SPI MA(TP is SL Hi Falling Edge Out)
Set INTERFACE= 8
REM NEW_IAP: Only used in I2C interface
Set NEW_IAP= 0
REM Master/Slave1/Slave2 Addr=0x20/0x40/0x42, Set 0x0 means not to update.
REM Only need to set MASTER_ADDR: 3900, Hid over I2C, and 3300 Lobyte(BootCodeVer)>=0x8A
REM Set SLAVE1_ADDR=0x40 if solution is 3915M I2C
Set MASTER_ADDR= 0x20
Set SLAVE1_ADDR= 0x0
Set SLAVE2_ADDR= 0x0
REM REK_DELAY_TIME(seconds): 0:No ReK \ >0:ReK after IAP
Set REK_DELAY_TIME= 6
REM STOP_TEST_FAILED_TIMES: Retry times while IAP or ReK failed.
REM It will not create log into NG folder, if retry success.
Set STOP_TEST_FAILED_TIMES= 3
REM WAITING_TIME_FOR_RETRY: Retry delay time (sec).
Set WAITING_TIME_FOR_RETRY= 3
REM REK_TIMEOUT(seconds)
Set REK_TIMEOUT= 10
REM OUT_RETURNCODE: output return code if external program need = 1, else set to 0
Set OUT_RETURNCODE= 0
REM ***************************** Config *****************************
Set PID= 0x0
Set VID= 0x04f3
Set PortNo=""
title Elan IAP tool
IF %WIN8_BRIDGE% EQU 0 Set PARAM_BRIDGE_TYPE="-E"
IF %NEW_IAP% EQU 1 Set PARAM_NEW_IAP="-n"
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set LOOKUP=0123456789ABCDEF
set i=0
set f=0
set s=0
:LOOP
cls
cd %~dp0
echo %~n0
set /a i=%i%+1
REM echo **************************** %i%-th IAP ***************************
REM echo **************************** %i%-th IAP *************************** >> Log\Final_Result.txt
REM echo Start Boot Code update Procedure
REM echo Start Boot Code update Procedure >> Log\Final_Result.txt
REM if "%bit%" EQU "x64" (
REM    AP_x64\IAP.exe -r "%STOP_TEST_FAILED_TIMES%,%WAITING_TIME_FOR_RETRY%"  %PARAM_BRIDGE_TYPE% -d %VDD% -o %VIO% -a %I2C_Addr% -p %PID% -V %VID% -i %INTERFACE% -0 %MASTER_ADDR% -1 %SLAVE1_ADDR% -2 %SLAVE2_ADDR%  -f %BC_FILE_PATH% -c %PARAM_NEW_IAP% -b -P %PortNo%
REM ) else (
REM    AP_x86\IAP.exe -r "%STOP_TEST_FAILED_TIMES%,%WAITING_TIME_FOR_RETRY%"  %PARAM_BRIDGE_TYPE% -d %VDD% -o %VIO% -a %I2C_Addr% -p %PID% -V %VID% -i %INTERFACE% -0 %MASTER_ADDR% -1 %SLAVE1_ADDR% -2 %SLAVE2_ADDR%  -f %BC_FILE_PATH% -c %PARAM_NEW_IAP% -b -P %PortNo%
REM )
REM IF %ERRORLEVEL% EQU 1 GOTO BCDONE
REM IF %ERRORLEVEL% EQU -44 GOTO BC_UPDATE_ALREADY
REM GOTO FAILED

REM :BC_UPDATE_ALREADY
REM echo Boot Code Update Already
REM echo Boot Code Update Already >> AP\Log\Final_Result.txt

REM echo ---
REM echo Start FW update Procedure
REM echo Start FW update Procedure >> AP\Log\Final_Result.txt
REM IF %INTERFACE% EQU 2 GOTO USB
REM if "%bit%" EQU "x64" (
REM AP_x64\IAP.exe -r "%STOP_TEST_FAILED_TIMES%,%WAITING_TIME_FOR_RETRY%"  %PARAM_BRIDGE_TYPE% -d %VDD% -o %VIO% -a %I2C_Addr% -p %PID% -V %VID% -i %INTERFACE% -0 %MASTER_ADDR% -1 %SLAVE1_ADDR% -2 %SLAVE2_ADDR%  -f %FW_FILE_PATH% -c %PARAM_NEW_IAP% -P %PortNo%
REM ) else (
REM AP_x86\IAP.exe -r "%STOP_TEST_FAILED_TIMES%,%WAITING_TIME_FOR_RETRY%"  %PARAM_BRIDGE_TYPE% -d %VDD% -o %VIO% -a %I2C_Addr% -p %PID% -V %VID% -i %INTERFACE% -0 %MASTER_ADDR% -1 %SLAVE1_ADDR% -2 %SLAVE2_ADDR%  -f %FW_FILE_PATH% -c %PARAM_NEW_IAP% -P %PortNo%
REM )
REM GOTO RESULT

REM :BCDONE
REM set /a s=%s%+1
REM echo Download Boot code Success (Success= %s%, Failed= %f%)
REM echo Download Boot code Success (Success= %s%, Failed= %f%) >> Log\Final_Result.txt
REM echo Wait %Update_BC_Time%s for Boot Code Update
REM if "%bit%" EQU "x64" (
REM    AP_x64\IAP.exe -s %Update_BC_Time%
REM ) else (
REM    AP_x86\IAP.exe -s %Update_BC_Time%
REM )
REM GOTO UPDATE_FW

REM :BCFAILED
REM echo Download Boot code Failed (err= %ERRORLEVEL%)
REM echo Download Boot code Failed (err= %ERRORLEVEL%) >> Log\Final_Result.txt
REM GOTO END
:UPDATE_FW
echo ---
echo Start FW update Procedure
echo Start FW update Procedure >> Log\Final_Result.txt
IF %INTERFACE% EQU 2 GOTO USB
if "%bit%" EQU "x64" (
   AP_x64\IAP.exe -r "%STOP_TEST_FAILED_TIMES%,%WAITING_TIME_FOR_RETRY%"  %PARAM_BRIDGE_TYPE% -d %VDD% -o %VIO% -a %I2C_Addr% -p %PID% -V %VID% -i %INTERFACE% -0 %MASTER_ADDR% -1 %SLAVE1_ADDR% -2 %SLAVE2_ADDR%  -f %FW_FILE_PATH% -c %PARAM_NEW_IAP% -P %PortNo%
) else (
  AP_x86\IAP.exe -r "%STOP_TEST_FAILED_TIMES%,%WAITING_TIME_FOR_RETRY%"  %PARAM_BRIDGE_TYPE% -d %VDD% -o %VIO% -a %I2C_Addr% -p %PID% -V %VID% -i %INTERFACE% -0 %MASTER_ADDR% -1 %SLAVE1_ADDR% -2 %SLAVE2_ADDR%  -f %FW_FILE_PATH% -c %PARAM_NEW_IAP% -P %PortNo%
)

GOTO RESULT
:USB
if "%bit%" EQU "x64" (
   AP_x64\IAP.exe -r "%STOP_TEST_FAILED_TIMES%,%WAITING_TIME_FOR_RETRY%"  %PARAM_BRIDGE_TYPE% -d %VDD% -o %VIO% -a %I2C_Addr% -p 0x0b -V %VID% -i %INTERFACE% -0 %MASTER_ADDR% -1 %SLAVE1_ADDR% -2 %SLAVE2_ADDR%  -f %FW_FILE_PATH% -c %PARAM_NEW_IAP% -P %PortNo%
) else (
   AP_x86\IAP.exe -r "%STOP_TEST_FAILED_TIMES%,%WAITING_TIME_FOR_RETRY%"  %PARAM_BRIDGE_TYPE% -d %VDD% -o %VIO% -a %I2C_Addr% -p 0x0b -V %VID% -i %INTERFACE% -0 %MASTER_ADDR% -1 %SLAVE1_ADDR% -2 %SLAVE2_ADDR%  -f %FW_FILE_PATH% -c %PARAM_NEW_IAP% -P %PortNo%
)

:RESULT
IF %ERRORLEVEL% EQU 1 GOTO FWDONE
echo Update FW Failed (err= %ERRORLEVEL%)
echo Update FW Failed (err= %ERRORLEVEL%) >> Log\Final_Result.txt
GOTO FAILED

:FWDONE
set /a s=%s%+1
echo Update FW Success (Success= %s%, Failed= %f%)
echo Update FW Success (Success= %s%, Failed= %f%) >> Log\Final_Result.txt
IF %REK_DELAY_TIME% GTR 0 Goto REK
GOTO END

:FAILED
set /a f=%f%+1
echo FAILED (Success= %s%, Failed= %f%) (err= %ERRORLEVEL%)
echo FAILED (Success= %s%, Failed= %f%) (err= %ERRORLEVEL%) >> AP\Log\Final_Result.txt
REM mkdir Log%f%
REM XCOPY /H /Q /Y Log\*.* Log%f%\*.*
echo %STOP_TEST_FAILED_TIMES%  >> Log\Final_Result.txt
GOTO END

:ReK
echo Delay %REK_DELAY_TIME%s for ReK...
if "%bit%" EQU "x64" (
   AP_x64\IAP.exe -s %REK_DELAY_TIME%
) else (
   AP_x86\IAP.exe -s %REK_DELAY_TIME%
)
echo ********************* Write Flash Key and ReK *********************
echo ********************* Write Flash Key and ReK ********************* >> Log\Final_Result.txt
if "%bit%" EQU "x64" (
   AP_x64\IAP.exe -K -r "%STOP_TEST_FAILED_TIMES%,%WAITING_TIME_FOR_RETRY%" %PARAM_BRIDGE_TYPE% -d %VDD% -o %VIO% -a %I2C_Addr% -p %PID% -V %VID% -i %INTERFACE% -c -P %PortNo%
) else (
   AP_x86\IAP.exe -K -r "%STOP_TEST_FAILED_TIMES%,%WAITING_TIME_FOR_RETRY%" %PARAM_BRIDGE_TYPE% -d %VDD% -o %VIO% -a %I2C_Addr% -p %PID% -V %VID% -i %INTERFACE% -c -P %PortNo%
)
IF %ERRORLEVEL% EQU 1 GOTO REK_DONE

:REK_FAILED
echo FAILED (err= %ERRORLEVEL%)
echo FAILED (err= %ERRORLEVEL%) >> Log\Final_Result.txt
GOTO END

:REK_DONE
echo SUCCESS
echo SUCCESS >> Log\Final_Result.txt
GOTO END

:RETURN_CODE
EXIT /B %ERRORLEVEL%
:DEC2HEX
set R=
set A=%1
:DEC2HEX_loop
set /a B=%A% %% 16 & set /a A=%A% / 16
set R=!LOOKUP:~%B%, 1!!%R%
if %A% GTR 0 goto DEC2HEX_loop
set %2=%R%
exit /b

:END
if not %errorlevel% equ 1 (
color c0
echo.
echo.
echo         ffffffff    ;ff:    ffffffff  ff       .ffffffff iffffff:              
echo         fftttttt    ffff    tttffttt  ff       .fttttttt ifttttff.             
echo         ff         tffffl      ff     ff       .f;       if     ff             
echo         ff         ff  ff      ff     ff       .f;       if     ff             
echo         ff        iff  ff;     ff     ff       .f;       if     ff             
echo         fffffff   ff    ff     ff     ff       .ffffff   if     ff             
echo         ff        ffffffff     ff     ff       .f;       if     ff             
echo         ff        ffffffff     ff     ff       .f;       if     ff             
echo         ff        ff    ff     ff     ff       .f;       if    :ff             
echo         ff        ff    ff  ffffffff  ffffffff .ffffffff ifffffff              
echo         ff        ff    ff  ffffffff  ffffffff .ffffffff iffffff        
echo. 
)
IF %OUT_RETURNCODE% EQU 1 GOTO RETURN_CODE
:END2


