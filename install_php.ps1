Invoke-WebRequest -Method Get -Uri https://windows.php.net/downloads/releases/archives/php-7.1.9-Win32-VC14-x64.zip -OutFile c:\php.zip
Expand-Archive -Path c:\php.zip -DestinationPath c:\php
Remove-Item c:\php.zip -Force
$env:Path += "; c:\php"