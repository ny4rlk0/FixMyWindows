TITLE Fix My Windows 4.05.2022 04:48
cls
@echo off
echo This will not work if you did not removed virus and thing that autostarts it!
echo This computer needs to be connected to internet in order this program to repair the Windows!
echo It will download required files from Microsoft's server!
echo It will restart the computer after finished!
echo It may look stuck but its not. It just takes long time to reinstall some of the Windows Components.
echo Ny4rlk0 https://github.com/ny4rlk0/FixMyWindows
echo "                                                       "
if _%1_==_payload_  goto :payload

:getadmin
    echo %~nx0: Asking for Admin permission from main frame. ~ny4rlk0
    set vbs=%temp%\getadmin.vbs
    echo Set UAC = CreateObject^("Shell.Application"^)                >> "%vbs%"
    echo UAC.ShellExecute "%~s0", "payload %~sdp0 %*", "", "runas", 1 >> "%vbs%"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
goto :eof

:payload

::Kodu buraya yaz::

echo "Bypass Powershell Restrictions"
powershell "Set-ExecutionPolicy Unrestricted"

echo "Dump Hosts File to txt File"
copy "%SystemRoot%\System32\drivers\etc\hosts" "%HOMEDRIVE%\users\%username%\Desktop\HostDump.txt"

echo "Dump Running Proccess to txt File"
powershell "gwmi win32_process | select Caption,Path | Format-List *" > "%HOMEDRIVE%\users\%username%\Desktop\ProccessDump.txt"

echo "Dump DNS Cache to txt File"
ipconfig /displaydns >> %HOMEDRIVE%\users\%username%\Desktop\DNSDump.txt

echo "Dump Connected Machines to txt File"
powershell "netstat -n -b -q | Format-List *" > "%HOMEDRIVE%\users\%username%\Desktop\ConnectionDump1.txt"
powershell "netstat -f -b -q | Format-List *" > "%HOMEDRIVE%\users\%username%\Desktop\ConnectionDump2.txt"

echo "Rewrite the Hosts File for Security"
(echo Cleared for security ny4rlk0. && echo https://github.com/ny4rlk0/Windows-Cache-Cleaner/blob/main/PartlyRestoreHijackedSystem.bat) > "%SystemRoot%\System32\drivers\etc\hosts"

echo "Enable Firewall"
netsh firewall set opmode mode=ENABLE
netsh advfirewall set allprofiles state on

echo "Reset Firewall to Default Values"
netsh firewall reset
netsh advfirewall reset

echo "Reset Windows Store"
wsreset

echo "Flush DNS Cache"
ipconfig /flushdns

echo "Reset Enforced Group Policy Rules to Default"
RD /S /Q "%WinDir%\System32\GroupPolicy"
RD /S /Q "%WinDir%\System32\GroupPolicyUsers"
gpupdate /force

echo "Reset Important Services to Default"
sc config "SysMain" start=auto
timeout 2
sc config "UsoSvc" start=auto
timeout 2
sc config "wuauserv" start=auto
timeout 2
sc config "WaasMedicSvc" start=auto
timeout 2
sc config "mpssvc" start=auto
timeout 2
sc config "SecurityHealthService" start=auto
timeout 2
sc config "DoSvc" start=auto
timeout 2
sc config "SgrmBroker" start=auto
timeout 2
sc config "uhssvc" start=auto
timeout 2
sc config "InstallService" start=auto
timeout 2
sc config "WinDefend" start=auto
timeout 2
sc config "WdNisSvc" start=auto
timeout 2
sc config "WlanSvc" start=auto
timeout 2
sc config "wscsvc" start=auto
timeout 2
sc config "Audiosrv" start=auto
timeout 2
sc config "AudioEndpointBuilder" start=auto
timeout 2
netsh interface tcp set global autotuninglevel=highlyrestricted
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v "AssumeUDPEncapsulationContextOnSendRule" REG_DWORD /d 2 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\WaasMedicSvc" /v Start /f /t REG_DWORD /d 2
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v Start /f /t REG_DWORD /d 2
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /f /t REG_DWORD /d 2
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware" /v Start /f /t REG_DWORD /d 0
sc start "UsoSvc"
timeout 2
sc start "wuauserv"
timeout 2
sc start "WaasMedicSvc"
timeout 2
sc start "SysMain"
timeout 2
sc start "mpssvc"
timeout 2
sc start "DoSvc"
timeout 2
sc start "SgrmBroker"
timeout 2
sc start "uhssvc"
timeout 2
sc start "InstallService"
timeout 2
sc start "WinDefend"
timeout 2
sc start "WdNisSvc"
timeout 2
sc start "WdNisSvc"
timeout 2
sc start "wscsvc"
timeout 2
sc start "Audiosrv"
timeout 2
sc start "AudioEndpointBuilder"
timeout 2

echo "Search For System Problems"
sfc /scannow

echo "Download Working Versions of Broken and Infected Files from MicroSoft"
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /RestoreHealth

echo "Reinstall all Windows Apps"
powershell "Get-AppXPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register """$($_.InstallLocation)\AppXManifest.xml"""}"

echo "RESET DEFENDER SETTINGS"
powershell 'Set-MpPreference -DisableRealtimeMonitoring $false'
powershell 'Set-MpPreference -DisableIOAVProtection $false'
powershell "$pathExclusions = Get-MpPreference | select ExclusionPath; foreach ($exclusion in $pathExclusions) {if ($exclusion.ExclusionPath -ne $null) {Remove-MpPreference -ExclusionPath $exclusion.ExclusionPath}}"
powershell "$extensionExclusion = Get-MpPreference | select ExclusionExtension; foreach ($exclusion in $extensionExclusion) {if ($exclusion.ExclusionExtension -ne $null) {Remove-MpPreference -ExclusionExtension $exclusion.ExclusionExtension}}"
powershell "$processExclusions = Get-MpPreference | select ExclusionProcess; foreach ($exclusion in $processExclusions) {if ($exclusion.ExclusionProcess -ne $null) {Remove-MpPreference -ExclusionProcess $exclusion.ExclusionProcess}}"
powershell 'Set-MpPreference -ScanScheduleTime "02:00:00"'
powershell 'Set-MpPreference -ScanScheduleQuickScanTime "02:00:00"'
powershell 'Set-MpPreference -DisableCatchupFullScan $false'
powershell 'Set-MpPreference -DisableCatchupQuickScan $false'
powershell 'Set-MpPreference -DisableArchiveScanning $false'
powershell 'Set-MpPreference -DisableRemovableDriveScanning $false'
powershell 'Set-MpPreference -DisableScanningNetworkFiles $false'
powershell 'Set-MpPreference -SignatureUpdateInterval 6'
powershell 'Set-MpPreference -SignatureUpdateCatchupInterval 1'
powershell 'Set-MpPreference -SignatureDisableUpdateOnStartupWithoutEngine $false'
powershell 'Set-MpPreference -SignatureFallbackOrder "MicrosoftUpdateServer|MMPC"'
powershell 'Set-MpPreference -QuarantinePurgeItemsAfterDelay 90'

echo "Reset Theme"
start /b "ThemeReset" "%HOMEDRIVE%\Windows\Resources\Themes\aero.theme"

echo "Reapply Powershell Restrictions"
powershell 'Set-ExecutionPolicy restricted'

echo "Scan The Computer"
echo "Updating the Windows Defender..."
powershell "Update-MpSignature"
echo "Initiating a scan of everything that connected to this computer."
echo "If you gonna plug somedrive or USB Stick you got 2 min before it starts for scan. So do it now!"
echo "Sleeping for 120 seconds..."
powershell "Start-Sleep -Seconds 120"
echo "Initiating a Full Systemwide scan of everything that connected to this computer."
powershell "Start-MpScan -ScanType FullScan"
echo "Scan Finished. Now Rebooting..."

echo "Restart the Computer"
shutdown -r -t 10

::Kodu buraya yaz::
