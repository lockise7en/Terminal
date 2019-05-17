机F8,安全模式菜单.选择Repair your 
computer(修复计算机)，直接按回车。
之后会弹出2个提示框，直接点Next或OK即可。就来到了工具界面：
单击最后一项：Command 
Prompt(命令行工具)，依次输入下面三条命令。每条命令后按回车。
copy c:\notepad.exe C:\Windows\  /A
C:\Windows\system32>copy c:\notepad.exe C:\Windows\system32\ /A
以下3条命令将"用户文件夹"从"C:\Users"设置为"D:\Users"。
robocopy "C:\Windows\SoftwareDistribution\Download"  "D:\Download" /E /COPYALL /XJ /XD 
robocopy "C:\Users\fengshun\AppData\Roaming\Apple Computer" "E:\Users\fengshun\AppData\Apple Computer" /E /COPYALL /XJ /XD 
robocopy "C:\Git" "D:\Git" /E /COPYALL /XJ /XD 
"C:\Users\Administrator"
参数说明：此命令为Windows的"强健文件拷贝"命令。
/E 
表示拷贝文件时包含子目录（包括空目录）
/COPYALL 表示拷贝所有文件信息
/XJ 表示不包括Junction 
points（默认是包括的）
/XD "C:\Users\Administrator" 
表示不包括指定的目录，此处指定目录为："C:\Users\Administrator"

robocopy "C:\Windows\SoftwareDistribution" "C:\Windows\SoftwareDistribution1"  /E /COPYALL /XJ /XD 

rmdir "C:\Users" /S /Q
参数说明：此命令删除指定目录。
/S 删除指定目录及其中的所有文件。用于删除目录树。
/Q 
安静模式。删除时不询问。

#
services.msc
wsreset
mklink /J "C:\Users\fengshun\go" "E:\Users\fengshun\go"
mklink /J "C:\Users\fengshun\Apple\MobileSync\Backup" "e:\Users\fengshun\Documents\Apple\Backup"

mklink /J "E:\i4Tools7" "e:\Users\fengshun\Documents\Apple"
e:\Users\fengshun\Documents\Apple
#
mklink /J "C:\Users\fengshun\Documents" "E:\Users\fengshun\Documents"
#
mklink /J "C:\Users\fengshun\Downloads" "E:\Users\fengshun\Downloads"
#
mklink /J "C:\Users\fengshun\Music" "E:\Users\fengshun\Music"
#
mklink /J "C:\Users\fengshun\Pictures" "E:\Users\fengshun\Pictures"
#
mklink /J "C:\Users\fengshun\Videos" "E:\Users\fengshun\Videos"

mklink /J  "C:\Program Files (x86)\PanDownload\PanData" "C:\Users\fengshun\AppData\Local\PanData"
mklink /J  "C:\Program Files\Git\var\cache\pacman\pkg" "D:\C\Git\repo\git-for-windows\pacman\pkg"

mklink /J  "C:\Users\fengshun\Apple\Backup" "E:\i4Tools7\Backup"
mklink /J  "C:\Users\fengshun\Apple\Backup" "E:\i4Tools7\Backup"
mklink /J "C:\Users\fengshun\Apple\MobileSync\Backup" "E:\i4Tools7\Backup"
mklink /J  "C:\Git"  "C:\Program Files\Git"

mklink /J  "C:\Program Files\Git" "C:\Git"
mklink /J  "c:\Git" "d:\c\Git"
mklink /J  "c:\Go" "d:\c\Go"
mklink /J  "C:\Program Files (x86)\WinSCP\PuTTY" "C:\Program Files\PuTTY"

参数说明：此命令创建符号连接。
/J 连接类型为目录连接 

执行完成后，单击Restart重启。就OK了。

不知道win 10是否一样呢