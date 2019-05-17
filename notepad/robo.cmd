@echo off
mklink /J "C:\Users\fengshun\Desktop" "E:\Users\fengshun\Desktop"
mklink /J "C:\Users\fengshun\Documents" "E:\Users\fengshun\Documents"
mklink /J "C:\Users\fengshun\Downloads" "E:\Users\fengshun\Downloads"
mklink /J "C:\Users\fengshun\Music" "E:\Users\fengshun\Music"
mklink /J "C:\Users\fengshun\Pictures" "E:\Users\fengshun\Pictures"
mklink /J "C:\Users\fengshun\Videos" "E:\Users\fengshun\Videos"
mklink /J  "C:\Users\fengshun\Apple\Backup" "E:\i4Tools7\Backup"
mklink /J  "C:\Program Files\Git" "c:\Git"
mklink /J  "c:\Git" "d:\c\Git"
mklink /J  "c:\Go" "e:\Users\fengshun\AppData\Local"
mklink /J  "C:\Program Files (x86)\WinSCP\PuTTY" "C:\Program Files\PuTTY"
mklink /J  "C:\Program Files\TortoiseGit\bin\puttygen.exe" "C:\Program Files\PuTTY\puttygen.exe"
mklink /J  "C:\Program Files\TortoiseGit\bin\pageant.exe" "C:\Program Files\PuTTY\pageant.exe"
mklink /J  "C:\Program Files\TortoiseGit\bin\pageant\TortoisePlink.exe "C:\Program Files\PuTTY\Plink.exe"
git push --set-upstream ssh://git@192.168.168.2:30001/git/$(git rev-parse --show-toplevel | xargs basename).git $(git rev-parse --abbrev-ref HEAD)
export

mklink /J  "c:\Users\fengshun\AppData\Local\Apple" "e:\Users\fengshun\AppData\Local\Apple"
mklink /J  "c:\Users\fengshun\AppData\Local\Apple Computer" "e:\Users\fengshun\AppData\Local\Apple Computer"
mklink /J  "c:\Users\fengshun\AppData\Local\Apple Inc" "e:\Users\fengshun\AppData\Local\Apple Inc"
mklink /J  "c:\Users\fengshun\AppData\Roaming\Apple Computer" "e:\Users\fengshun\AppData\Roaming\Apple Computer"
mklink /J  "c:\Users\fengshun\AppData\Roaming\Lantern" "e:\Users\fengshun\AppData\Roaming\Lantern"
mklink /J  "c:\Users\fengshun\AppData\Roaming\Notepad++" "e:\Users\fengshun\AppData\Roaming\Notepad++"