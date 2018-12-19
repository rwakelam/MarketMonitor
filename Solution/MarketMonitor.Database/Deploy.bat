@echo off

SET DIR=%~d0%~p0%

SET database.name="MarketMonitor"
SET sql.files.directory="%DIR%.\Scripts"
SET server.database="(local)"
SET version.file=".\MarketMonitor.Database.dll"
SET environment="LOCAL"

cd "%DIR%"
"%DIR%\.\rh.exe" /d=%database.name% /f=%sql.files.directory% /s=%server.database% /vf=%version.file% /vx=%version.xpath% /r=%repository.path% /env=%environment% /simple /t /silent /ra=any

pause