# This dockerfile utilizes components licensed by their respective owners/authors.
# Prior to utilizing this file or resulting images please review the respective licenses at: http://www.apache.org/licenses/, https://secure.php.net/license/

FROM mcr.microsoft.com/windows/servercore:ltsc2022

LABEL Description="Apache-PHP" Vendor1="Apache Software Foundation" Version1="2.4.38" Vendor2="The PHP Group" Version2="5.6.40"

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'

COPY apache.zip /

RUN	powershell -Command \
    Expand-Archive -Path c:\apache.zip -DestinationPath c:\ ; \
    Remove-Item c:\Apache24\conf\httpd.conf -Force ; \
	Remove-Item c:\apache.zip -Force

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Method Get -Uri https://aka.ms/vs/16/release/VC_redist.x64.exe -OutFile c:\vcredist_x86.exe ; \
   	start-Process c:\vcredist_x86.exe -ArgumentList '/quiet' -Wait ; \
   	Remove-Item c:\vcredist_x86.exe -Force

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Method Get -Uri https://windows.php.net/downloads/releases/archives/php-7.1.33-Win32-VC14-x64.zip -OutFile c:\php.zip ; \
	Expand-Archive -Path c:\php.zip -DestinationPath c:\php ; \
	Remove-Item c:\php.zip -Force

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Method Get -Uri https://packages.blackfire.io/binaries/blackfire/2.5.0/blackfire-windows_amd64.zip -OutFile c:\blackfire.zip ; \
	Expand-Archive -Path c:\blackfire.zip -DestinationPath c:\blackfire ; \
	Remove-Item c:\blackfire.zip -Force
COPY httpd.conf c:/Apache24/conf/

RUN setx path ";C:\php"

# Install Composer
RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Invoke-WebRequest 'https://getcomposer.org/installer' -OutFile 'composer-setup.php'; \
    php .\composer-setup.php; \
    DIR;

WORKDIR /Apache24/bin
COPY php_memcache.dll c:/php/ext
COPY php_blackfire.dll c:/php/ext
COPY php_xdebug.dll c:/php/ext
RUN setx path "%path%;C:\blackfire"
RUN blackfire agent:config --server-id=c0b4b4c5-1602-4fad-b126-816eaa8394d9 --server-token=6b62bed9febfd5e2a57014cfbf11c656cba3ac2579c0e2ae11249c8815b5e259
RUN sc.exe create Blackfire binpath="C:\Blackfire\blackfire.exe agent:start" start=auto depend=Tcpip/Dnscache
RUN echo 172.20.0.110 doajs.local.com >> "C:\Windows\System32\drivers\etc\hosts"
COPY php.ini c:/php

CMD ["c:\\Apache24\\bin\\httpd.exe", "-w"]
