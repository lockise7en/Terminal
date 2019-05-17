机F8,安全模式菜单.选择Repair your 
computer(修复计算机)，直接按回车。
之后会弹出2个提示框，直接点Next或OK即可。就来到了工具界面：
单击最后一项：Command 
Prompt(命令行工具)，依次输入下面三条命令。每条命令后按回车。


以下3条命令将“用户文件夹”从“C:\Users”设置为“D:\Users”。


robocopy “C:\Users” “D:\Users” /E /COPYALL /XJ /XD 
“C:\Users\Administrator”
参数说明：此命令为Windows的“强健文件拷贝”命令。
/E 
表示拷贝文件时包含子目录（包括空目录）
/COPYALL 表示拷贝所有文件信息
/XJ 表示不包括Junction 
points（默认是包括的）
/XD “C:\Users\Administrator” 
表示不包括指定的目录，此处指定目录为：“C:\Users\Administrator”


rmdir “C:\Users” /S /Q
参数说明：此命令删除指定目录。
/S 删除指定目录及其中的所有文件。用于删除目录树。
/Q 
安静模式。删除时不询问。


mklink /J  “C:\Users\fengshun\AppData\Roaming\Apple Computer\MobileSync\Backup” “F:\Backup”

mklink /J  “C:\Program Files\Git” “C:\Git”
mklink /J  “C:\Program Files (x86)\WinSCP\PuTTY” “C:\Program Files\PuTTY”

参数说明：此命令创建符号连接。
/J 连接类型为目录连接 

执行完成后，单击Restart重启。就OK了。

不知道win 10是否一样呢