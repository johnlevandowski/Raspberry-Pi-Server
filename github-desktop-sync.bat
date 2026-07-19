@ECHO OFF

REM Using Github Desktop on samba share is very slow

robocopy . "C:\Users\john\Documents\github\Raspberry-Pi-Server" /s /njh /njs

TIMEOUT 10
