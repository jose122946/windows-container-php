FROM mcr.microsoft.com/windows/servercore:ltsc2022

COPY memcached.zip c:/

RUN	powershell -Command \
    Expand-Archive -Path c:\memcached.zip -DestinationPath c:\ ; \
	Remove-Item c:\memcached.zip -Force

CMD ["C:\\memcached.exe", "start"]
