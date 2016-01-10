rem 此文件放在create_project.py 同级目录下。命令窗口运行 create_project.py  可以知道什么创建一个新的工程，此文件需要放在和 create_project.py同一级目录下
@echo off
set /p projectName=projectName:
if "%projectName%" == "" goto inputError1

set /p language=language(cpp,lua,javascript):
if "%language%" == "" goto inputError2

create_project.py -project %projectName% -package com.cocos2d-x.org -language %language%
pause
exit

:inputError1 @echo projectName can not nil
:inputError2 @echo language can not nil,choose lua/cpp/javascript

pause

