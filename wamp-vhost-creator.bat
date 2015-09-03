@echo off

REM Set your host and httpd-vhosts file path here

set hosts= C:\Windows\System32\Drivers\etc\hosts
set httpdconf=D:\wamp\bin\apache\apache2.4.9\conf\extra\httpd-vhosts.conf

echo *********************************************************************
echo ***                                                               ***
echo ***                 Written by : Milan Maharjan                   ***
echo ***                  mail@milanmaharjan.com.np                    ***
echo ***                        July 3rd, 2015                         ***
echo ***                                                               ***
echo *********************************************************************
echo.
echo.


REM Checking Administrative permission
net session >nul 2>&1
if NOT %errorLevel% == 0 (
    echo Please run this script as an administrator
    pause
    exit
)

GOTO :inputdomain

:inputdomainerror
echo Please input a domain

:inputdomain
set /p domain=Enter the virtual domain: 

if "%domain%" == "" GOTO :inputdomain
GOTO :inputdocroot

:docrooterror
echo "That directory doesn't exist !!"

:inputdocroot
set /p documentroot= Enter the document root ( C:\wamp\www ) : 
IF NOT EXIST %documentroot% GOTO :docrooterror

REM Map domain to localhost in hosts file
echo 127.0.0.1		%domain% >> %hosts%

REM Add virtual host to httpd.conf

(
echo.
echo # %domain% Templates
echo ^<VirtualHost *:80^>
echo 	ServerAdmin admin@localhost.com
echo 	DocumentRoot '%documentroot%'
echo 	ServerName %domain%
echo 	ServerAlias %domain%
echo 	^<Directory '%documentroot%'^>
echo 		AllowOverride All
echo 		Order allow,deny
echo 		Allow from all
echo 	^</Directory^>
echo ^</VirtualHost^>
) >> %httpdconf%

echo "%domain% mapped to %documentroot%"

REM Restart Apache

net stop wampapache64

net start wampapache64

pause
