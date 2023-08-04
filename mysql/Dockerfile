# This dockerfile utilizes components licensed by their respective owners/authors.
# Prior to utilizing this file or resulting images please review the respective licenses at: http://www.mysql.com/about/legal/licensing/oem/

FROM mcr.microsoft.com/windows/servercore:ltsc2022

LABEL Description="MySql" Vendor="Oracle" Version="5.6.29"

COPY mysql.zip c:/

USER ContainerAdministrator

RUN powershell -Command ; \
    $ErrorActionPreference = 'Stop'; \
    Expand-Archive -Path c:\mysql.zip -DestinationPath c:\ ; \
    Remove-Item c:\mysql.zip -Force

RUN setx path ";C:\mysql-5.6.29-winx64\bin"


RUN powershell -Command ; \
    $ErrorActionPreference = 'Stop'; \
    mysqld.exe --install


RUN powershell -Command ; \
    $ErrorActionPreference = 'Stop'; \
    Start-Service mysql ; \
    Stop-Service mysql ; \
    Start-Service mysql

RUN mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Letme1n' WITH GRANT OPTION;"
RUN mysql -u root -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'Letme1n';"
RUN mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'Letme1n' WITH GRANT OPTION;"

CMD [ "ping", "localhost", "-t" ]
