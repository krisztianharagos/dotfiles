# scoop install python
# pip3 install pyautogui

# ~/.scr/h.py
import pyautogui as pg
import time
import datetime

print(f' Hello: {datetime.datetime.now().isoformat()} \n')


def writeTime():
    with open("myfile.txt", "a") as f:
        str = f'{datetime.datetime.now().isoformat()} \n'
        f.write(str)


def f():
    x, y = pg.position()
    # pg.moveRel(100, 0, duration=0.25)
    # pg.moveRel(-100, 0, duration=0.25)
    pg.scroll(2)
    pg.scroll(-2)
    writeTime()
    # pg.typewrite([" ", "[left]"])

    # pg.click(807, 979)
    # pg.typewrite("hello")
    # pg.scroll(200)
    # pg.typewrite(["enter"])
    # time.sleep(2)

while(True):
    f()
    time.sleep(30)

# h.ps1
# Start-Process "C:\Users\harakri\scoop\apps\python\3.9.1\python.exe" -ArgumentList "h.py" -WorkingDirectory "$env:userprofile\.scr" -WindowStyle Hidden
 
# # d "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
# # h.cmd
# PowerShell -Command "Set-ExecutionPolicy -Scope CurrentUser Unrestricted" >> "%USERPROFILE%\.scr\h.log" 2>&1
# #PowerShell -ExecutionPolicy Bypass -windowstyle hidden -command "%USERPROFILE%\.scr\h.ps1" >> "%USERPROFILE%\.scr\h.log" 2>&1
# PowerShell "%USERPROFILE%\.scr\h.ps1" >> "%USERPROFILE%\.scr\h.log" 2>&1