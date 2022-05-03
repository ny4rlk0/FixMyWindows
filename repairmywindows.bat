TITLE Fix My Windows 3.05.2022 23:19
cls
@echo off
echo This will not work if you did not removed virus and thing that autostarts it!
echo This computer needs to be connected to internet in order this program to repair the Windows!
echo It will download required files from Microsoft's server!
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

::Bypass Powershell Restrictions
powershell "Set-ExecutionPolicy Unrestricted"

::Dump Hosts File to txt File
copy "%SystemRoot%\System32\drivers\etc\hosts" "%HOMEDRIVE%\users\%username%\Desktop\HostDump.txt"

::Dump Running Proccess to txt File
powershell "gwmi win32_process | select Caption,Path | Format-List *" > "%HOMEDRIVE%\users\%username%\Desktop\ProccessDump.txt"

::Dump DNS Cache to txt File
ipconfig /displaydns >> %HOMEDRIVE%\users\%username%\Desktop\DNSDump.txt

::Dump Connected Machines to txt File
powershell "netstat -n -b -q | Format-List *" > "%HOMEDRIVE%\users\%username%\Desktop\ConnectionDump1.txt"
powershell "netstat -f -b -q | Format-List *" > "%HOMEDRIVE%\users\%username%\Desktop\ConnectionDump2.txt"

::Rewrite the Hosts File for Security
(echo Cleared for security ny4rlk0. && echo https://github.com/ny4rlk0/Windows-Cache-Cleaner/blob/main/PartlyRestoreHijackedSystem.bat) > "%SystemRoot%\System32\drivers\etc\hosts"

::Enable Firewall
netsh firewall set opmode mode=ENABLE
netsh advfirewall set allprofiles state on

::Reset Firewall to Default Values
netsh firewall reset
netsh advfirewall reset

::Reset Windows Store
wsreset

::Flush DNS Cache
ipconfig /flushdns

::Reset Enforced Group Policy Rules to Default
RD /S /Q "%WinDir%\System32\GroupPolicy"
RD /S /Q "%WinDir%\System32\GroupPolicyUsers"
gpupdate /force

::Reset Important Services to Default
sc config "SysMain" start=auto
sc config "UsoSvc" start=auto
sc config "wuauserv" start=auto
sc config "WaasMedicSvc" start=auto
sc config "mpssvc" start=auto
sc config "SecurityHealthService" start=auto
sc config "DoSvc" start=auto
sc config "SgrmBroker" start=auto
sc config "uhssvc" start=auto
sc config "InstallService" start=auto
sc config "WinDefend" start=auto
sc config "WdNisSvc" start=auto
sc config "WlanSvc" start=auto
sc config "wscsvc" start=auto
netsh interface tcp set global autotuninglevel=highlyrestricted
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent" /v "AssumeUDPEncapsulationContextOnSendRule" REG_DWORD /d 2 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\WaasMedicSvc" /v Start /f /t REG_DWORD /d 2
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v Start /f /t REG_DWORD /d 2
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v Start /f /t REG_DWORD /d 2
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware" /v Start /f /t REG_DWORD /d 0
sc start "UsoSvc"
sc start "wuauserv"
sc start "WaasMedicSvc"
sc start "SysMain"
sc start "mpssvc"
sc start "DoSvc"
sc start "SgrmBroker"
sc start "uhssvc"
sc start "InstallService"
sc start "WinDefend"
sc start "WdNisSvc"
sc start "WdNisSvc"
sc start "wscsvc"

::Search For System Problems
sfc /scannow

::Download Working Versions of Broken and Infected Files from MicroSoft
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /RestoreHealth

::Reinstall all Windows Apps
powershell "Get-AppXPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register """$($_.InstallLocation)\AppXManifest.xml"""}"

::RESET DEFENDER SETTINGS
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

::Reset Theme
start /b "ThemeReset" "%HOMEDRIVE%\Windows\Resources\Themes\aero.theme"

::Reapply Powershell Restrictions
powershell 'Set-ExecutionPolicy restricted'

::Scan The Computer
echo "Updating the Windows Defender..."
powershell "Update-MpSignature"
echo "Initiating a scan of everything that connected to this computer."
echo "If you gonna plug somedrive or USB Stick you got 2 min before it starts for scan. So do it now!"
echo "Sleeping for 120 seconds..."
powershell "Start-Sleep -Seconds 120"
echo "Initiating a Full Systemwide scan of everything that connected to this computer."
powershell "Start-MpScan -ScanType FullScan"
echo "Scan Finished. Now Rebooting..."

::Restart the Computer
shutdown -r -t 10

::Kodu buraya yaz::
