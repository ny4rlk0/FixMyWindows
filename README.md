# Fix My Windows
<br> Just copy paste this to Command Line:
<br>curl -o repairmywindows.bat https://raw.githubusercontent.com/ny4rlk0/FixMyWindows/main/repairmywindows.bat && start /b repairmywindows.bat


Python based tool to fix common issues or virus releated issues on Windows. 
<br>It will download and run the latest patch from this repo.
<br>(So it's <b>requires internet connection to download broken files from MS</b>.)
<br>Best to scan your computer with some solid antivirus delete the virus then run this tool.
<br>This tool relies heavily on Windows Defenders detection capabilities.
<br>(To scan and delete the virus.)
<br>First it will dump to infection logs to desktop, after it will reset the most of the Windows Services Apps Settings to default. 
<br>(Including Group Policy, Firewall, Services, Defender, Windows Store etc.)
<br>Then will try to use Windows built in commands to initiate self repair.
<br>Finally it will scan everything that connected to this computer. (It should scan network drives too. I'm not so sure tho.)
<br>It will not delete your personal files!
<br>You can either use batch file or exe.
<br>(Batch file does not detected as virus so if you have any doubt just use that or copy of it's contents.)
<br>Because of pyinstaller, Windows Defender Detects as virus. Well i dont have much choice. I dont have any way to sign with key. 
<br>(Or more like money in this case. Yes it costs 400$ a year to get a sign. Thx MS.)
<br>.EXE file will always download latest batch file from this github repo.
 * Screen Shots:
<p align="center">
    <img src="1.jpg">
    <img src="2.jpg">
