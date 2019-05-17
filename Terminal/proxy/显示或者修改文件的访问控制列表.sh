显示或者修改文件的访问控制列表(ACL)
Cacls d:\ /T /e /c /g fengshun:f
cacls filename [/T] [/M] [/L] [/S[:SDDL]] [/E] [/C] [/G user:perm]
                [/R user [...]] [/P user:perm [...]] [/D user [...]]


filename 显示 ACL。
/T 更改当前目录及其所有子目录中 指定文件的 ACL。
/L 对照目标处理符号链接本身
/M 更改装载到目录的卷的 ACL
/S 显示 DACL 的 SDDL 字符串。
/S:SDDL       使用在 SDDL 字符串中指定的 ACL 替换 ACL。
                  (/E、/G、/R、/P 或 /D 无效)。
/E            编辑 ACL 而不替换。
/C             在出现拒绝访问错误时继续。
/G user:perm   赋予指定用户访问权限。
                  Perm 可以是: R  读取
                              W  写入
                              C  更改(写入)
                              F  完全控制
/R user        撤销指定用户的访问权限(仅在与 /E 一起使用时合法)。
/P user:perm   替换指定用户的访问权限。
                  Perm 可以是: N  无
                              R  读取
                              W  写入
                              C  更改(写入)
                              F  完全控制
/D user        拒绝指定用户的访问。
在命令中可以使用通配符指定多个文件。
也可以在命令中指定多个用户。

缩写:
   CI - 容器继承。
        ACE 会由目录继承。
   OI - 对象继承。
        ACE 会由文件继承。
   IO - 只继承。
        ACE 不适用于当前文件/目录。
   ID - 已继承。
        ACE 从父目录的 ACL 继承。

 

icacls name /save aclfile [/T] [/C] [/L] [/Q]
     将所有匹配名称的 ACL 存储到 aclfile 中以便将来用于 /restore。

icacls directory [/substitute SidOld SidNew [...]] /restore aclfile
                 [/C] [/L] [/Q]
    将存储的 ACL 应用于目录中的文件。

icacls name /setowner user [/T] [/C] [/L] [/Q]
    更改所有匹配名称的所有者。

icacls name /findsid Sid [/T] [/C] [/L] [/Q]
    查找包含显式提及 SID 的 ACL 的所有匹配名称。

icacls name /verify [/T] [/C] [/L] [/Q]
    查找其 ACL 不规范或长度与 ACE 计数不一致的所有文件。

icacls name /reset [/T] [/C] [/L] [/Q]
    为所有匹配文件使用默认继承的 ACL 替换 ACL

icacls name [/grant[:r] Sid:perm[...]]
       [/deny Sid:perm [...]]
       [/remove[:g|:d]] Sid[...]] [/T] [/C] [/L]
       [/setintegritylevel Level:policy[...]]

    /grant[:r] Sid:perm 授予指定的用户访问权限。如果使用 :r，
        这些权限将替换以前授予的所有显式权限。
        如果不使用 :r，这些权限将添加到以前授予的所有显式权限。

    /deny Sid:perm 显式拒绝指定的用户访问权限。
        将为列出的权限添加显式拒绝 ACE，
        并删除所有显式授予的权限中的相同权限。

    /remove[:[g|d]] Sid 删除 ACL 中所有出现的 SID。使用
        :g，将删除授予该 SID 的所有权限。使用
        :d，将删除拒绝该 SID 的所有权限。

    /setintegritylevel [(CI)(OI)] 级别将完整性 ACE 显式添加到所有
        匹配文件。要指定的级别为以下级别之一:
            L[ow]
            M[edium]
            H[igh]
        完整性 ACE 的继承选项可以优先于级别，但只应用于
        目录。

    /inheritance:e|d|r
        e - 启用继承
        d - 禁用继承并复制 ACE
        r - 删除所有继承的 ACE

注意:
    Sid 可以采用数字格式或友好的名称格式。如果给定数字格式，
    那么请在 SID 的开头添加一个 *。

    /T 指示在以该名称指定的目录下的所有匹配文件/目录上
        执行此操作。

    /C 指示此操作将在所有文件错误上继续进行。仍将显示错误消息。

    /L 指示此操作在符号链接本身而不是其目标上执行。

    /Q 指示 icacls 应该禁止显示成功消息。

    icacls 保留 ACE 项的规范顺序:
            显式拒绝
            显式授予
            继承的拒绝
            继承的授予

    perm 是权限掩码，可以两种格式之一指定:
        简单权限序列:
                F - 完全访问权限
                M - 修改权限
                RX - 读取和执行权限
                R - 只读权限
                W - 只写权限
        在括号中以逗号分隔的特定权限列表:
                D - 删除
                RC - 读取控制
                WDAC - 写入 DAC
                WO - 写入所有者
                S - 同步
                AS - 访问系统安全性
                MA - 允许的最大值
                GR - 一般性读取
                GW - 一般性写入
                GE - 一般性执行
                GA - 全为一般性
                RD - 读取数据/列出目录
                WD - 写入数据/添加文件
                AD - 附加数据/添加子目录
                REA - 读取扩展属性
                WEA - 写入扩展属性
                X - 执行/遍历
                DC - 删除子项
                RA - 读取属性
                WA - 写入属性
        继承权限可以优先于每种格式，但只应用于
        目录:
                (OI) - 对象继承
                (CI) - 容器继承
                (IO) - 仅继承
                (NP) - 不传播继承

示例:

        icacls c:\windows\* /save AclFile /T
        - 将 c:\windows 及其子目录下所有文件的
           ACL 保存到 AclFile。

        icacls c:\windows\ /restore AclFile
        - 将还原 c:\windows 及其子目录下存在的 AclFile 内
          所有文件的 ACL

        icacls file /grant Administrator:(D,WDAC)
        - 将授予用户对文件删除和写入 DAC 的管
          理员权限

        icacls file /grant *S-1-1-0:(D,WDAC)
        - 将授予由 sid S-1-1-0 定义的用户对文件删
          除和写入 DAC 的权限

======================================================================


1、强制将当前目录下的所有文件及文件夹、子文件夹下的所有者更改为管理员组(administrators)命令：
takeown /f * /a /r /d y

2、将所有d:\documents目录下的文件、子文件夹的NTFS权限修改为仅管理员组(administrators)完全控制(删除原有所有NTFS权限设置)：
cacls d:\documents\*.* /T /G administrators:F

3、在原有d:\documents目录下的文件、子文件夹的NTFS权限上添加管理员组(administrators)完全控制权限(并不删除原有所有NTFS权限设置)：
cacls d:\documents\*.* /T /E /G administrators:F

4、取消管理员组(administrators)完全控制权限(并不删除原有所有NTFS权限设置)：
cacls \\Server\Documents\%username%\我的文档 /t /e /r "mddq\domain admins"
cacls \\Server\Documents\%username%\桌面 /t /e /r "mddq\domain admins"


--------------------- 
作者：xuhuan_wh 
来源：CSDN 
原文：https://blog.csdn.net/xuhuan_wh/article/details/25647317 
版权声明：本文为博主原创文章，转载请附上博文链接！