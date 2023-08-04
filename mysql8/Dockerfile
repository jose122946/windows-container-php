# Use the official Windows Server Core base image from Microsoft
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set environment variables for MySQL installation
ENV MYSQL_VERSION 8.0.32
ENV MYSQL_INSTALL_DIR "C:\\mysql"

# Download MySQL installer
ADD https://dev.mysql.com/get/Downloads/MySQL-${MYSQL_VERSION}/mysql-${MYSQL_VERSION}-winx64.zip C:\\mysql.zip

RUN powershell -Command \
    	$ErrorActionPreference = 'Stop'; \
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 ; \
    Invoke-WebRequest "https://aka.ms/vs/17/release/vc_redist.x64.exe" -OutFile "vc_redist.x64.exe"; \
    Start-Process -filepath C:\vc_redist.x64.exe -ArgumentList "/install", "/passive", "/norestart" -NoNewWindow -Wait; \
    Remove-Item -Force vc_redist.x64.exe;

# Extract MySQL installer
RUN powershell -Command Expand-Archive -Path C:\\mysql.zip -DestinationPath C:\\ ; \
    Remove-Item -Path C:\\mysql.zip -Force

# Install MySQL
#RUN msiexec.exe /i C:\\mysql\\mysql-${MYSQL_VERSION}-winx64.msi /qn
RUN powershell -Command New-Item -ItemType Directory -Path C:\mysql-8.0.32-winx64\data
# Add MySQL to the system PATH
RUN setx /M PATH "%PATH%;C:\mysql-8.0.32-winx64\bin"
# Expose MySQL port
#EXPOSE 3306
RUN mysqld --install
COPY mysql.txt C:/mysql.txt
RUN mysqld --initialize
# Start MySQL service on container startup
CMD ["mysqld", "--console", "--datadir=C:\\mysql-8.0.32-winx64\\data"]
