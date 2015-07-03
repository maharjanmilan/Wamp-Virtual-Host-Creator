# Wamp Virtual Host Creator
Adding many number of virtual hosts is a teadous task to do. This batch script automates the process involved. It prompts 
a user to input virtual domain name and document root, and then adds all the required configuartion itself. 

#How to use it?
Download wamp-vhost-creator.bat and run it as a Administrator. 

If you are running this script for the first time:

1) Open this script in a text editor and make sure that the path to Windows HOST file and Apache httpd-vhosts.conf is 
correct.

2) If your WAMP is a 32 bit version just remove 64 from the lines "net stop wampapache64" and "net start wampapache64"
at the end of the file. 
