前言:虽然有winbuilder一类优秀的制作pe的工具,我还是打算写一个从WAIK入手,”手工”制作winpe并加入explorer的教程.此教程很基本,分为两个部分（后加入文件列表部分，共3部分）,前面部分提及winpe及waik的基础知识,以及用waik添加程序包,通过修改win7sp1安装文件中的注册表software配置单元实现explorer的初步加入;后面部分介绍explorer的完善和设置,windows功能的添加,以及对winpe精简和合盘等的一些讨论.我写的这些主要来自于自己做pe的一些积累,waik的帮助文件和winbuilder的脚本,另外一些关键的问题很多是在wuyou,boot-land等论坛得到解决的,pe文件的加入部分也参考了很多他人的pe,还有很多问题都是通过google搜索解决.希望大家在看完本文后也都能做出自己满意的pe.

下面以64位winpe3.1为例,介绍制作带explorer的win7pe的操作过程.最终得到一个功能较为全面的winpe,如我的pe3.1, wingwy-pe3.1-v2.iso

http://www.wingwy.com/archives/2011_02_851.html

注:此文很多是回忆内容,文中难免很多错误,欢迎大家指出并讨论.

1 winpe和WAIK的一些基本知识

1.1 winpe全称Windows Preinstallation Environment,中文就是Windows预安装环境.其他的不用啰嗦,但我觉得有必要先说一下他的版本和名称问题.

winpe 1.x系列对应windows xp和2003,可以叫xpe,需要注意的是Windows XP Embedded也简称xpe,不过在pe领域,xpe应该不具有误导性.相应的,winpe 2.x系列对应windows vista和2008, 也叫vistape.3.x系列是对应windows 7和2008R2,所以有时也叫win7pe.后面的小标号x则是对应各个sp版本,如某个pe是winpe2.2,即表示对应于vista sp2,目前最新的winpe3.1就是对应于win7 sp1.

1.2 WAIK全称Windows Automated Installation Kit,意为自动安装工具包.我们做pe主要用到他的2个工具,imagex和dism. 要制作winpe3.1,目前需同时下载WAIK3.0(KB3AIK_CN.iso 含制作工具,)和3.1的补充包(waik_supplement_zh-cn.iso 含新的wim文件). 注:以后微软可能会把这两个整合到一起.

另外,winpe2.0以后,程序系统和语言包都是分离的,WAIK的语言版本也就不是问题了,各个版本都含有对应的语言包,只需要自己添加就行了. 下面的例子是以中文版为例,其他语言版本也可.

2 准备工作

理想情况下,我建议大家准备好两个waik的iso文件和win7sp1的中文版安装镜像.要中文版win7主要是为了让最后制作出来的带explorer的winpe完全中文化.

如果你没有win7sp1中文版安装iso,只要你的操作系统是win7sp1中文版就可以了(这可以通过安装中文sp1包升级,我下面的例子就是这样的).如果这个条件还是不满足,下载我的pe, wingwy-pe3.1-v2.iso 里面的文件基本上就够了.

其他软件可以主要是ultraliso和Registry Workshop.

3 winpe的基本制作

WAIK其实提供了快速生成简单pe的脚本,不过为了使大家更好的了解pe,我们在这里手动完成.

3.1加载waik_supplement_zh-cn.iso进入amd64文件夹,拷贝boot文件夹bootmgr文件到 D:\TEMP\winpe3.1\org\win7pe (路径随意,以后以这个路径为例).

3.2拷贝amd64文件夹下winpe.wim到D:\TEMP\winpe3.1\org\win7pe\sources 并改名为boot.wim

3.3用ultraiso打开win7安装文件,提取iso引导信息文件备用,比如存为boot.bif.

新建一个启动光盘,引导文件用刚才的boot.bif文件,把D:\TEMP\winpe3.1\org\win7pe\下所有文件加入这个启动光盘,保存称pe.iso.一个基本的winpe就完成了.用虚拟机测试一下吧,启动后就是一个cmd窗口,如下图



这个pe是最基本的,显然不好用,我们需要修改boot.wim文件加入程序包

4 程序包的加入

4.1 加载waik_supplement_zh-cn.iso进入amd64文件夹,拷贝WINPE_FPS到D:\TEMP\winpe3.1\org\win7pe (路径随意,以后以这个路径为例)

4.2 新建文件夹D:\TEMP\winpe3.1\org\mount 在开始菜单上打开Windows AIK中打开”部署工具命令提示”如下



4.3 展开imagex以供修改,运行如下代码:

imagex /apply D:\TEMP\winpe3.1\org\win7pe\sources\boot.wim 1 D:\TEMP\winpe3.1\org\mount

4.4 添加程序包

AIK的说明文件里面有详细介绍,推荐添加以下6个包

WinPE-HTA:HTML 应用程序支持。
WinPE-MDAC:Microsoft(R) 数据访问组件支持。
WinPE-Scripting:Windows 脚本主机 (WSH) 支持。
WinPE-WMI:Windows Management Instrumentation (WMI) 支持。

WinPE-PPPoE:启用以太网上的点对点协议 (PPPoE) 支持。(如ADSL)
WinPE-DOT3SVC:IEEE 802.X 身份验证协议支持。(如WiFi)

命令格式如下:

dism /image:D:\TEMP\winpe3.1\org\mount /Add-Package /PackagePath:”D:\TEMP\winpe3.1\org\WINPE_FPS\winpe-wmi.cab”

添加其他程序包格式一样,只需修改cab文件路径,别忘了各个程序包还有相应的_ZH-CN.CAB包.

注:如果是英文版的WAIK,还需要先添加WINPE-FONTSUPPORT-ZH-CN和LP_ZH-CN包,然后设置:

dism /image:D:\TEMP\winpe3.1\org\mount /set-uilang:zh-cn
dism /image:D:\TEMP\winpe3.1\org\mount /set-syslocale:zh-cn
dism /image:D:\TEMP\winpe3.1\org\mount /set-userlocale:zh-cn
dism /image:D:\TEMP\winpe3.1\org\mount /set-inputlocale:0804:00000804
dism /image:D:\TEMP\winpe3.1\org\mount /set-timezone:”China Standard Time”
dism /image:D:\TEMP\winpe3.1\org\mount /set-SKUIntlDefaults:zh-cn

最后删除英文包:

dism /image:D:\TEMP\winpe3.1\org\mount /Remove-Package /PackageName:Microsoft-Windows-WinPE-LanguagePack-Package~31bf3856ad364e35~amd64~en-US~6.1.7601.17514

5 explorer初步加入winpe

5.1 好了,大家估计都急着让pe运行explorer了.我们把explorer加入到windows目录下,运行

imagex /capture /compress fast /boot D:\TEMP\winpe3.1\org\mount D:\TEMP\winpe3.1\org\win7pe\sources\boot.wim “winpe” “winpe”

重新打包boot.wim,并替换掉pe.iso中的boot.wim,保存后放入vm测试.在启动后还是一个cmd窗口.直接输入explorer.exe,你看到了什么? 系统提示缺少ExplorerFrame.dll.

显然,单独加入explorer.exe是不行的.简单的说windows系统程序的正常运行至少要满足两点,一个是相关的支持文件出现在正确的路径中(如各个dll文件和mui文件等),另外一个就是正确的注册表配置(程序运行的设置和支持文件的路径等).

好,明白了这个,一切就很清晰了,基本的explorer运行并不需要任何第三方程序的加入或是对微软的文件进行任何修改.只要添加了支持explorer运行的文件,配置好了注册表,就可以在winpe中正常运行explorer了.

5.2 其中文件的加入部分我这里不想细讲,因为它既繁琐又简单,意义不大.为什么呢?你运行程序,它提示你少什么文件,你加入就是了.如果你有耐心,可以一个一个加(当然,有时候他并不会提示你缺少某个文件,而explorer还是不能运行).文件的加入相对于注册表的是显而易见的,即使是才接触计算机的网友,只要他会复制和粘贴就没问题.另外,你还可以用鼠标右键看文件说明。

详细的文件列表可以参见 给winpe添加explorer教程(续):文件列表  http://www.wingwy.com/archives/2011_03_868.html

其实pe的制作就是不断地积累,吸收前人的经验,我更喜欢先对比别人的pe,看看别人都加了些什么文件,换一个思路,先添加足够的文件,运行起了explorer后再删除. 因此我建议你直接把我的wingwy-pe3.1-v2.iso中winpe.wim文件展开. 同时展开win7sp1的install.wim文件,依照我我的pe文件列表复制win7的安装文件到你要做的pe目录,D:\TEMP\winpe3.1\org\mount 下.(实现此步有很多办法,比如用xcpoy带/s /h /d /y 参数). 实在不行就直接复制我pe展开的文件,注意不要替换文件.

5.3 好了,该动pe的注册表了,注意D:\TEMP\winpe3.1\org\mount\Windows\System32\config 下的三个文件 software, system 和 default . 用注册表编辑器加载software单元,命名为pe-soft全部导出为soft-init.reg后,卸载pe-soft配置单元.

5.3.1 打开win7sp1的install.wim文件(可以用7-zip,用imagex展开也可),定位到Windows\System32\config下,把software文件加载到注册表,同命名为pe-soft. 一会儿你会遇到权限问题,可先在”权限”-“高级”中替换”所有者”为你当前用户.再在”权限”中添加好权限.

5.3.2 在pe-soft下搜索Interactive User,找到后全部删除.

5.3.3 在pe-soft下搜索D:\ 全部替换为X:\

5.3.4 导入刚才的soft-init.reg替换掉win7安装文件的,卸载pe-soft

5.4 用imagex打包,生成iso后启动vm测试.还是命令提示符窗口,不过你现在运行explorer.exe.看看,熟悉的explorer是不是已经出来.

此文是“给winpe添加explorer教程”http://www.wingwy.com/archives/2011_02_857.html  系列的补充部分。 在前文中我觉得这部分意义不大，所以没有提及文件加入部分。其实winpe的文件部分的加入确实是“既繁琐又简单”。pe的制作就是不断地积累,吸收前人的经验，比如别人的成品pe，以及winbuilder，make_pe3一类的pe制作工具。不过有些网友反映文件不知道怎么办，这里贴一个的文件列表给大家参考（以make_pe3为基础，略有修改）。按照我的教程制作的不需要重复添加某些文件。如果你对某个文件的作用不清楚，可以用鼠标右键看文件说明，或者google。

注：此文件列表主要基于make_pe3，感谢原作者wimb以及原作者感谢之人（主要是JFX，nu825等）。原作者发布地址 http://www.msfn.org/board/topic/143529-make-pe3-program-to-create-portable-windows-7-pe/

1 语言栏支持。如需加入微软拼音用WAIK的帮助脚本即可.

C:\Windows\System32\input.dll
C:\Windows\System32\zh-cn\input.dll.mui
C:\Windows\System32\ctfmon.exe
C:\Windows\System32\zh-cn\ctfmon.exe.mui
C:\Windows\System32\msctf.dll
C:\Windows\System32\zh-cn\msctf.dll.mui
C:\Windows\System32\MsCtfMonitor.dll
C:\Windows\System32\msctfp.dll
C:\Windows\System32\msctfui.dll
C:\Windows\System32\zh-cn\msctfui.dll.mui
C:\Windows\System32\msutb.dll
C:\Windows\System32\zh-cn\msutb.dll.mui
2 主题支持。另需启动相应服务，参见给winpe添加explorer教程(下) http://www.wingwy.com/archives/2011_02_862.html 第6部分。为避免桌面背景重复占用，建议使用system32下的winpe.bmp为背景。


C:\Windows\system32\shsvcs.dll
C:\Windows\system32\themeservice.dll
C:\Windows\system32\themeui.dll
C:\Windows\system32\tstheme.exe
C:\Windows\system32\uxsms.dll
C:\Windows\system32\UXInit.dll
C:\Windows\system32\net.exe
C:\Windows\system32\WindowsCodecs.dll
C:\Windows\system32\WindowsCodecsExt.dll
C:\Windows\system32\UIRibbon.dll
C:\Windows\system32\UIRibbonRes.dll
C:\Windows\System32\zh-cn\shsvcs.dll.mui
C:\Windows\System32\zh-cn\themeservice.dll.mui
C:\windows\system32\zh-cn\themeui.dll.mui
C:\Windows\System32\zh-cn\TSTheme.exe.mui
C:\Windows\System32\zh-cn\UIRibbon.dll.mui
C:\Windows\Resources\Ease of Access Themes\basic.theme
C:\Windows\Resources\Ease of Access Themes\classic.theme
C:\Windows\Resources\Themes\aero.theme
C:\Windows\Resources\Themes\Aero\*

C:\Windows\Media\*.wav
C:\Windows\Media\*.mid
C:\Windows\Media\Desktop.ini
3 视频驱动以及个性化桌面的额外文件

C:\Windows\system32\cdd.dll
C:\Windows\system32\dispci.dll
C:\Windows\system32\dispex.dll
C:\Windows\system32\wdi.dll
C:\Windows\system32\drivers\dxapi.sys
C:\Windows\system32\drivers\dxg.sys
C:\Windows\system32\drivers\dxgkrnl.sys
C:\Windows\system32\drivers\dxgmms1.sys
C:\Windows\system32\zh-cn\dispci.dll.mui
C:\Windows\system32\zh-cn\wdi.dll.mui
C:\Windows\system32\alttab.dll
C:\Windows\system32\cscdll.dll
C:\Windows\system32\cscui.dll
C:\Windows\system32\msfeeds.dll
C:\Windows\system32\mydocs.dll
C:\Windows\system32\photometadatahandler.dll
C:\Windows\system32\provsvc.dll
C:\Windows\system32\searchfolder.dll
C:\Windows\system32\shacct.dll
C:\Windows\system32\shgina.dll
C:\Windows\system32\structuredquery.dll
C:\Windows\system32\themeui.dll
C:\Windows\system32\dwmcore.dll

C:\Windows\system32\zh-cn\alttab.dll.mui
C:\Windows\system32\zh-cn\cscui.dll.mui
C:\Windows\system32\zh-cn\mydocs.dll.mui
C:\Windows\system32\zh-cn\provsvc.dll.mui
C:\Windows\system32\zh-cn\searchfolder.dll.mui
C:\Windows\system32\zh-cn\shacct.dll.mui
C:\Windows\system32\zh-cn\shgina.dll.mui
C:\Windows\system32\zh-cn\themeui.dll.mui
C:\Windows\system32\zh-cn\dwmcore.dll.mui

4 音频驱动

C:\Windows\System32\audiodg.exe
C:\Windows\System32\AudioEng.dll
C:\Windows\System32\AUDIOKSE.dll
C:\Windows\System32\AudioSes.dll
C:\Windows\System32\audiosrv.dll
C:\Windows\System32\batmeter.dll
C:\Windows\System32\dciman32.dll
C:\Windows\System32\ddraw.dll
C:\Windows\System32\ddrawex.dll
C:\Windows\System32\dxtrans.dll
C:\Windows\System32\ksuser.dll
C:\Windows\System32\linkinfo.dll
C:\Windows\System32\mfplat.dll
C:\Windows\System32\mmci.dll
C:\Windows\System32\mmcico.dll
C:\Windows\System32\mmres.dll
C:\Windows\System32\SndVol.exe
C:\Windows\System32\wdmaud.drv
C:\Windows\System32\wsock32.dll
C:\Windows\System32\XInput9_1_0.dll

C:\Windows\System32\imaadp32.acm
C:\Windows\System32\iyuv_32.dll
C:\Windows\System32\l3codeca.acm
C:\Windows\System32\l3codecp.acm
C:\Windows\System32\midimap.dll
C:\Windows\System32\msacm32.drv
C:\Windows\System32\msadp32.acm
C:\Windows\System32\msg711.acm
C:\Windows\System32\msgsm32.acm
C:\Windows\System32\msrle32.dll
C:\Windows\System32\msvidc32.dll
C:\Windows\System32\msyuv.dll
C:\Windows\System32\tsbyuv.dll
C:\Windows\System32\wdmaud.drv

C:\Windows\System32\zh-cn\imaadp32.acm.mui
C:\Windows\System32\zh-cn\iyuv_32.dll.mui
C:\Windows\System32\zh-cn\l3codeca.acm.mui
C:\Windows\System32\zh-cn\midimap.dll.mui
C:\Windows\System32\zh-cn\msacm32.drv.mui
C:\Windows\System32\zh-cn\msadp32.acm.mui
C:\Windows\System32\zh-cn\msg711.acm.mui
C:\Windows\System32\zh-cn\msgsm32.acm.mui
C:\Windows\System32\zh-cn\msrle32.dll.mui
C:\Windows\System32\zh-cn\msvidc32.dll.mui
C:\Windows\System32\zh-cn\wdmaud.drv.mui

C:\Windows\SysWow64\imaadp32.acm
C:\Windows\SysWow64\iyuv_32.dll
C:\Windows\SysWow64\l3codeca.acm
C:\Windows\SysWow64\l3codecp.acm
C:\Windows\SysWow64\midimap.dll
C:\Windows\SysWow64\msacm32.drv
C:\Windows\SysWow64\msadp32.acm
C:\Windows\SysWow64\msg711.acm
C:\Windows\SysWow64\msgsm32.acm
C:\Windows\SysWow64\msrle32.dll
C:\Windows\SysWow64\msvidc32.dll
C:\Windows\SysWow64\msyuv.dll
C:\Windows\SysWow64\tsbyuv.dll
C:\Windows\SysWow64\wdmaud.drv

C:\Windows\SysWow64\zh-cn\imaadp32.acm.mui
C:\Windows\SysWow64\zh-cn\iyuv_32.dll.mui
C:\Windows\SysWow64\zh-cn\l3codeca.acm.mui
C:\Windows\SysWow64\zh-cn\midimap.dll.mui
C:\Windows\SysWow64\zh-cn\msacm32.drv.mui
C:\Windows\SysWow64\zh-cn\msadp32.acm.mui
C:\Windows\SysWow64\zh-cn\msg711.acm.mui
C:\Windows\SysWow64\zh-cn\msgsm32.acm.mui
C:\Windows\SysWow64\zh-cn\msrle32.dll.mui
C:\Windows\SysWow64\zh-cn\msvidc32.dll.mui
C:\Windows\SysWow64\zh-cn\wdmaud.drv.mui

C:\Windows\System32\drivers\dxapi.sys
C:\Windows\System32\drivers\ks.sys

C:\Windows\System32\zh-cn\audiodg.exe.mui
C:\Windows\System32\zh-cn\AudioSes.dll.mui
C:\Windows\System32\zh-cn\AudioSrv.dll.mui
C:\Windows\System32\zh-cn\batmeter.dll.mui
C:\Windows\System32\zh-cn\ddraw.dll.mui
C:\Windows\System32\zh-cn\mfplat.dll.mui
C:\Windows\System32\zh-cn\mmci.dll.mui
C:\Windows\System32\zh-cn\mmres.dll.mui
C:\Windows\System32\zh-cn\sndvol.exe.mui
C:\Windows\System32\zh-cn\SysFxUI.dll.mui
C:\Windows\System32\zh-cn\wdmaud.drv.mui
C:\Windows\System32\zh-cn\wsock32.dll.mui
C:\Windows\System32\zh-cn\XInput9_1_0.dll.mui

C:\Windows\inf\bda.inf
C:\Windows\inf\hdaudio.inf
C:\Windows\inf\hdaudss.inf
C:\Windows\inf\ks.inf
C:\Windows\inf\kscaptur.inf
C:\Windows\inf\ksfilter.inf
C:\Windows\inf\wave.inf
C:\Windows\inf\wdma_usb.inf
C:\Windows\inf\wdmaudio.inf

C:\Windows\SysWow64\audiodg.exe
C:\Windows\SysWow64\AudioEng.dll
C:\Windows\SysWow64\AUDIOKSE.dll
C:\Windows\SysWow64\AudioSes.dll
C:\Windows\SysWow64\audiosrv.dll
C:\Windows\SysWow64\batmeter.dll
C:\Windows\SysWow64\dciman32.dll
C:\Windows\SysWow64\ddraw.dll
C:\Windows\SysWow64\ddrawex.dll
C:\Windows\SysWow64\dxtrans.dll
C:\Windows\SysWow64\ksuser.dll
C:\Windows\SysWow64\linkinfo.dll
C:\Windows\SysWow64\mfplat.dll
C:\Windows\SysWow64\mmci.dll
C:\Windows\SysWow64\mmcico.dll
C:\Windows\SysWow64\mmres.dll
C:\Windows\SysWow64\SndVol.exe
C:\Windows\SysWow64\wdmaud.drv
C:\Windows\SysWow64\wsock32.dll
C:\Windows\SysWow64\XInput9_1_0.dll

C:\Windows\SysWow64\drivers\dxapi.sys
C:\Windows\SysWow64\drivers\ks.sys

C:\Windows\SysWow64\zh-cn\audiodg.exe.mui
C:\Windows\SysWow64\zh-cn\AudioSes.dll.mui
C:\Windows\SysWow64\zh-cn\AudioSrv.dll.mui
C:\Windows\SysWow64\zh-cn\batmeter.dll.mui
C:\Windows\SysWow64\zh-cn\ddraw.dll.mui
C:\Windows\SysWow64\zh-cn\mfplat.dll.mui
C:\Windows\SysWow64\zh-cn\mmci.dll.mui
C:\Windows\SysWow64\zh-cn\mmres.dll.mui
C:\Windows\SysWow64\zh-cn\sndvol.exe.mui
C:\Windows\SysWow64\zh-cn\SysFxUI.dll.mui
C:\Windows\SysWow64\zh-cn\wdmaud.drv.mui
C:\Windows\SysWow64\zh-cn\wsock32.dll.mui
C:\Windows\SysWow64\zh-cn\XInput9_1_0.dll.mui
C:\Windows\System32\DriverStore\FileRepository\bda.inf_amd64_neutral_*
C:\Windows\System32\DriverStore\FileRepository\hdaudio.inf_amd64_neutral_*
C:\Windows\System32\DriverStore\FileRepository\hdaudss.inf_amd64_neutral_*
C:\Windows\System32\DriverStore\FileRepository\ks.inf_amd64_neutral_*
C:\Windows\System32\DriverStore\FileRepository\kscaptur.inf_amd64_neutral_*
C:\Windows\System32\DriverStore\FileRepository\ksfilter.inf_amd64_neutral_*
C:\Windows\System32\DriverStore\FileRepository\wave.inf_amd64_neutral_*
C:\Windows\System32\DriverStore\FileRepository\wdma_usb.inf_amd64_neutral_*
C:\Windows\System32\DriverStore\FileRepository\wdmaudio.inf_amd64_neutral_*
5 64位pe的32位程序支持集wow64
C:\Windows\SysWow64\snmpapi.dll
C:\Windows\SysWow64\msvbvm60.dll
C:\Windows\SysWow64\config\*
C:\Windows\SysWow64\drivers\*
C:\Windows\SysWow64\zh-cn\comctl32.dll.mui
C:\Windows\SysWow64\zh-cn\comdlg32.dll.mui
C:\Windows\SysWow64\zh-cn\mlang.dll.mui
C:\Windows\SysWow64\zh-cn\msimsg.dll.mui
C:\Windows\SysWow64\manifeststore\*.*
C:\Windows\SysWow64\*.nls
C:\Windows\SysWow64\activeds.dll
C:\Windows\SysWow64\actxprxy.dll
C:\Windows\SysWow64\adsldp.dll
C:\Windows\SysWow64\adsldpc.dll
C:\Windows\SysWow64\advapi32.dll
C:\Windows\SysWow64\apphelp.dll
C:\Windows\SysWow64\asycfilt.dll
C:\Windows\SysWow64\atl.dll
C:\Windows\SysWow64\avifil32.dll
C:\Windows\SysWow64\browseui.dll
C:\Windows\SysWow64\cfgmgr32.dll
C:\Windows\SysWow64\clusapi.dll
C:\Windows\SysWow64\comctl32.dll
C:\Windows\SysWow64\comdlg32.dll
C:\Windows\SysWow64\credui.dll
C:\Windows\SysWow64\crtdll.dll
C:\Windows\SysWow64\crypt32.dll
C:\Windows\SysWow64\cscapi.dll
C:\Windows\SysWow64\dbghelp.dll
C:\Windows\SysWow64\dhcpcsvc.dll
C:\Windows\SysWow64\dhcpcsvc6.dll
C:\Windows\SysWow64\dnsapi.dll
C:\Windows\SysWow64\duser.dll
C:\Windows\SysWow64\ehstorshell.dll
C:\Windows\SysWow64\esent.dll
C:\Windows\SysWow64\gdi32.dll
C:\Windows\SysWow64\iertutil.dll
C:\Windows\SysWow64\imagehlp.dll
C:\Windows\SysWow64\imm32.dll
C:\Windows\SysWow64\iphlpapi.dll
C:\Windows\SysWow64\ir41_qc.dll
C:\Windows\SysWow64\kernel32.dll
C:\Windows\SysWow64\lpk.dll
C:\Windows\SysWow64\lz32.dll
C:\Windows\SysWow64\mpr.dll
C:\Windows\SysWow64\mprapi.dll
C:\Windows\SysWow64\msacm32.dll
C:\Windows\SysWow64\msasn1.dll
C:\Windows\SysWow64\mscms.dll
C:\Windows\SysWow64\msctf.dll
C:\Windows\SysWow64\msi.dll
C:\Windows\SysWow64\mfc.dll
C:\Windows\SysWow64\msimg32.dll
C:\Windows\SysWow64\msvcp60.dll
C:\Windows\SysWow64\msvcrt.dll
C:\Windows\SysWow64\msvfw32.dll
C:\Windows\SysWow64\mswsock.dll
C:\Windows\SysWow64\netapi32.dll
C:\Windows\SysWow64\normaliz.dll
C:\Windows\SysWow64\nsi.dll
C:\Windows\SysWow64\ntdll.dll
C:\Windows\SysWow64\ntshrui.dll
C:\Windows\SysWow64\ntvdm64.dll
C:\Windows\SysWow64\odbc32.dll
C:\Windows\SysWow64\odbcint.dll
C:\Windows\SysWow64\ole32.dll
C:\Windows\SysWow64\oleacc.dll
C:\Windows\SysWow64\oleaccrc.dll
C:\Windows\SysWow64\oleaut32.dll
C:\Windows\SysWow64\oledlg.dll
C:\Windows\SysWow64\olepro32.dll
C:\Windows\SysWow64\propsys.dll
C:\Windows\SysWow64\psapi.dll
C:\Windows\SysWow64\reg.exe
C:\Windows\SysWow64\regapi.dll
C:\Windows\SysWow64\regsvr32.exe
C:\Windows\SysWow64\riched20.dll
C:\Windows\SysWow64\riched32.dll
C:\Windows\SysWow64\rpcrt4.dll
C:\Windows\SysWow64\rsaenh.dll
C:\Windows\SysWow64\rtutils.dll
C:\Windows\SysWow64\rundll32.exe
C:\Windows\SysWow64\samlib.dll
C:\Windows\SysWow64\schannel.dll
C:\Windows\SysWow64\secur32.dll
C:\Windows\SysWow64\setupapi.dll
C:\Windows\SysWow64\shell32.dll
C:\Windows\SysWow64\shfolder.dll
C:\Windows\SysWow64\shlwapi.dll
C:\Windows\SysWow64\slc.dll
C:\Windows\SysWow64\stdole2.tlb
C:\Windows\SysWow64\stdole32.tlb
C:\Windows\SysWow64\Storprop.dll
C:\Windows\SysWow64\svchost.exe
C:\Windows\SysWow64\sxs.dll
C:\Windows\SysWow64\sxsstore.dll
C:\Windows\SysWow64\sxstrace.exe
C:\Windows\SysWow64\syssetup.dll
C:\Windows\SysWow64\tzres.dll
C:\Windows\SysWow64\urlmon.dll
C:\Windows\SysWow64\user32.dll
C:\Windows\SysWow64\userenv.dll
C:\Windows\SysWow64\usp10.dll
C:\Windows\SysWow64\uxtheme.dll
C:\Windows\SysWow64\version.dll
C:\Windows\SysWow64\wininet.dll
C:\Windows\SysWow64\winmm.dll
C:\Windows\SysWow64\winnsi.dll
C:\Windows\SysWow64\winspool.drv
C:\Windows\SysWow64\wintrust.dll
C:\Windows\SysWow64\wldap32.dll
C:\Windows\SysWow64\wow32.dll
C:\Windows\SysWow64\ws2help.dll
C:\Windows\SysWow64\ws2_32.dll
C:\Windows\SysWow64\wshtcpip.dll
C:\Windows\SysWow64\wsock32.dll
C:\Windows\SysWow64\xmllite.dll
C:\Windows\SysWow64\AudioSes.dll
C:\Windows\SysWow64\avrt.dll
C:\Windows\SysWow64\clbcatq.dll
C:\Windows\SysWow64\cmd.exe
C:\Windows\SysWow64\credssp.dll
C:\Windows\SysWow64\cryptdll.dll
C:\Windows\SysWow64\dllhost.exe
C:\Windows\SysWow64\dsound.dll
C:\Windows\SysWow64\dwmapi.dll
C:\Windows\SysWow64\FWPUCLNT.DLL
C:\Windows\SysWow64\ksuser.dll
C:\Windows\SysWow64\mlang.dat
C:\Windows\SysWow64\mlang.dll
C:\Windows\SysWow64\MMDevAPI.dll
C:\Windows\SysWow64\msacm32.drv
C:\Windows\SysWow64\msvcrt40.dll
C:\Windows\SysWow64\msvcirt.dll
C:\Windows\SysWow64\msxml3.dll
C:\Windows\SysWow64\ntmarta.dll
C:\Windows\SysWow64\powrprof.dll
C:\Windows\SysWow64\resutils.dll
C:\Windows\SysWow64\wdmaud.drv
C:\Windows\SysWow64\winbrand.dll
C:\Windows\SysWow64\wship6.dll
C:\Windows\SysWow64\ExplorerFrame.dll
C:\Windows\SysWow64\networkexplorer.dll
C:\Windows\SysWow64\shellstyle.dll
C:\Windows\SysWow64\imageres.dll
C:\Windows\SysWow64\api-ms-win*.dll
C:\Windows\SysWow64\cryptbase.dll
C:\Windows\SysWow64\cryptsp.dll
C:\Windows\SysWow64\devobj.dll
C:\Windows\SysWow64\kernelbase.dll
C:\Windows\SysWow64\netutils.dll
C:\Windows\SysWow64\profapi.dll
C:\Windows\SysWow64\samcli.dll
C:\Windows\SysWow64\sechost.dll
C:\Windows\SysWow64\srvcli.dll
C:\Windows\SysWow64\sspicli.dll
C:\Windows\SysWow64\wkscli.dll
C:\Windows\SysWow64\browcli.dll
C:\Windows\SysWow64\dui70.dll
C:\Windows\SysWow64\StructuredQuery.dll
C:\Windows\Winsxs\x86_microsoft.vc80.crt*\*.*
C:\Windows\Winsxs\x86_microsoft.vc90.crt*\*.*
C:\Windows\Winsxs\x86_microsoft.windows.c..-controls.resources*\*.*
C:\Windows\Winsxs\x86_microsoft.windows.common-controls*\*.*
C:\Windows\Winsxs\x86_microsoft.windows.gdiplus*\*.*
C:\Windows\Winsxs\x86_microsoft.windows.i..utomation.proxystub*\*.*
C:\Windows\Winsxs\x86_microsoft.windows.isolationautomation*\*.*
C:\Windows\Winsxs\x86_microsoft-windows-m..tion-isolationlayer*\*.*
C:\Windows\Winsxs\Manifests\x86_microsoft.vc80.crt*.*
C:\Windows\Winsxs\Manifests\x86_microsoft.vc90.crt*.*
C:\Windows\Winsxs\Manifests\x86_microsoft.windows.c..-controls.resources*.*
C:\Windows\Winsxs\Manifests\x86_microsoft.windows.common-controls*.*
C:\Windows\Winsxs\Manifests\x86_microsoft.windows.gdiplus_*.*
C:\Windows\Winsxs\Manifests\x86_microsoft.windows.i..utomation.proxystub*.*
C:\Windows\Winsxs\Manifests\x86_microsoft.windows.isolationautomation*.*
C:\Windows\Winsxs\Manifests\x86_microsoft.windows.systemcompatible*.*
C:\Windows\Winsxs\Manifests\x86_microsoft-windows-m..tion-isolationlayer*.*
C:\Windows\system32\wow64.dll
C:\Windows\system32\wow64cpu.dll
C:\Windows\system32\wow64win.dll

C:\Windows\SysWow64\zh-cn\activeds.dll.mui
C:\Windows\SysWow64\zh-cn\adsldp.dll.mui
C:\Windows\SysWow64\zh-cn\adsldpc.dll.mui
C:\Windows\SysWow64\zh-cn\advapi32.dll.mui
C:\Windows\SysWow64\zh-cn\apphelp.dll.mui
C:\Windows\SysWow64\zh-cn\atl.dll.mui
C:\Windows\SysWow64\zh-cn\avifil32.dll.mui
C:\Windows\SysWow64\zh-cn\clusapi.dll.mui
C:\Windows\SysWow64\zh-cn\comctl32.dll.mui
C:\Windows\SysWow64\zh-cn\comdlg32.dll.mui
C:\Windows\SysWow64\zh-cn\credui.dll.mui
C:\Windows\SysWow64\zh-cn\crypt32.dll.mui
C:\Windows\SysWow64\zh-cn\dhcpcsvc.dll.mui
C:\Windows\SysWow64\zh-cn\dhcpcsvc6.dll.mui
C:\Windows\SysWow64\zh-cn\dnsapi.dll.mui
C:\Windows\SysWow64\zh-cn\duser.dll.mui
C:\Windows\SysWow64\zh-cn\ehstorshell.dll.mui
C:\Windows\SysWow64\zh-cn\esent.dll.mui
C:\Windows\SysWow64\zh-cn\iphlpapi.dll.mui
C:\Windows\SysWow64\zh-cn\kernel32.dll.mui
C:\Windows\SysWow64\zh-cn\mpr.dll.mui
C:\Windows\SysWow64\zh-cn\msacm32.dll.mui
C:\Windows\SysWow64\zh-cn\mscms.dll.mui
C:\Windows\SysWow64\zh-cn\msctf.dll.mui
C:\Windows\SysWow64\zh-cn\msvfw32.dll.mui
C:\Windows\SysWow64\zh-cn\mswsock.dll.mui
C:\Windows\SysWow64\zh-cn\ntdll.dll.mui
C:\Windows\SysWow64\zh-cn\ntshrui.dll.mui
C:\Windows\SysWow64\zh-cn\ntvdm64.dll.mui
C:\Windows\SysWow64\zh-cn\odbcint.dll.mui
C:\Windows\SysWow64\zh-cn\ole32.dll.mui
C:\Windows\SysWow64\zh-cn\oleaccrc.dll.mui
C:\Windows\SysWow64\zh-cn\oledlg.dll.mui
C:\Windows\SysWow64\zh-cn\propsys.dll.mui
C:\Windows\SysWow64\zh-cn\reg.exe.mui
C:\Windows\SysWow64\zh-cn\regsvr32.exe.mui
C:\Windows\SysWow64\zh-cn\rpcrt4.dll.mui
C:\Windows\SysWow64\zh-cn\rundll32.exe.mui
C:\Windows\SysWow64\zh-cn\setupapi.dll.mui
C:\Windows\SysWow64\zh-cn\shell32.dll.mui
C:\Windows\SysWow64\zh-cn\shlwapi.dll.mui
C:\Windows\SysWow64\zh-cn\slc.dll.mui
C:\Windows\SysWow64\zh-cn\srvsvc.dll.mui
C:\Windows\SysWow64\zh-cn\Storprop.dll.mui
C:\Windows\SysWow64\zh-cn\svchost.exe.mui
C:\Windows\SysWow64\zh-cn\sxs.dll.mui
C:\Windows\SysWow64\zh-cn\sxstrace.exe.mui
C:\Windows\SysWow64\zh-cn\tzres.dll.mui
C:\Windows\SysWow64\zh-cn\urlmon.dll.mui
C:\Windows\SysWow64\zh-cn\user32.dll.mui
C:\Windows\SysWow64\zh-cn\userenv.dll.mui
C:\Windows\SysWow64\zh-cn\uxtheme.dll.mui
C:\Windows\SysWow64\zh-cn\wininet.dll.mui
C:\Windows\SysWow64\zh-cn\winmm.dll.mui
C:\Windows\SysWow64\zh-cn\winspool.drv.mui
C:\Windows\SysWow64\zh-cn\wldap32.dll.mui
C:\Windows\SysWow64\zh-cn\ws2_32.dll.mui
C:\Windows\SysWow64\zh-cn\wshtcpip.dll.mui
C:\Windows\SysWow64\zh-cn\wsock32.dll.mui
C:\Windows\SysWow64\zh-cn\AudioSes.dll.mui
C:\Windows\SysWow64\zh-cn\cmd.exe.mui
C:\Windows\SysWow64\zh-cn\dsound.dll.mui
C:\Windows\SysWow64\zh-cn\FWPUCLNT.dll.mui
C:\Windows\SysWow64\zh-cn\mlang.dll.mui
C:\Windows\SysWow64\zh-cn\MMDevAPI.dll.mui
C:\Windows\SysWow64\zh-cn\msacm32.drv.mui
C:\Windows\SysWow64\zh-cn\ntmarta.dll.mui
C:\Windows\SysWow64\zh-cn\powrprof.dll.mui
C:\Windows\SysWow64\zh-cn\wdmaud.drv.mui
C:\Windows\SysWow64\zh-cn\wship6.dll.mui
C:\Windows\SysWow64\zh-cn\ExplorerFrame.dll.mui
C:\Windows\SysWow64\zh-cn\networkexplorer.dll.mui
C:\Windows\SysWow64\zh-cn\shellstyle.dll.mui
C:\Windows\SysWow64\zh-cn\imageres.dll.mui
C:\Windows\SysWow64\zh-cn\kernelbase.dll.mui
C:\Windows\SysWow64\zh-cn\sechost.dll.mui
C:\Windows\SysWow64\zh-cn\dui70.dll.mui

6 windows图片查看器，ie8，附件等。此为64位版本，32位版本可拷贝Program Files(x86)文件夹中相应文件，比如很多人就喜欢32位的ie8

C:\Program Files\Windows Photo Viewer\*
C:\Windows\System32\spool\drivers\color\*.*
C:\Windows\System32\d3d8thk.dll
C:\Windows\System32\icm32.dll
C:\Windows\System32\IconCodecService.dll
C:\Windows\System32\UIRibbon.dll
C:\Windows\System32\UIRibbonRes.dll
C:\Windows\System32\mspaint.exe
C:\Windows\System32\stobject.dll
C:\Windows\System32\zh-cn\icm32.dll.mui
C:\Windows\System32\zh-cn\mspaint.exe.mui
C:\Windows\System32\zh-cn\stobject.dll.mui
C:\Windows\System32\zh-cn\UIRibbon.dll.mui

C:\Program Files\Windows NT\Accessories\wordpad*.*
C:\Program Files\Windows NT\Accessories\zh-cn\wordpad*.*

C:\Program Files\Internet Explorer\IEShims.dll
C:\Program Files\Internet Explorer\ieproxy.dll

C:\Program Files\Internet Explorer\*

C:\Windows\System32\adsldp.dll
C:\Windows\System32\dxtmsft.dll
C:\Windows\System32\mshtml.tlb
C:\Windows\System32\pngfilt.dll

C:\Windows\System32\zh-cn\adsldp.dll.mui

7 Explorer 支持

C:\ProgramData\Microsoft\User Account Pictures\user.bmp
C:\Windows\Winsxs\amd64_microsoft.windows.gdiplus*\*.*
C:\Windows\Winsxs\Manifests\amd64_microsoft.windows.gdiplus_*.*
C:\Windows\AppPatch\sysmain.sdb
C:\Windows\Branding\Basebrd\basebrd.dll
C:\Windows\Branding\Basebrd\zh-cn\basebrd.dll.mui
C:\Windows\Branding\ShellBrd\shellbrd.dll
C:\Windows\explorer.exe
C:\Windows\zh-cn\explorer.exe.mui

C:\Windows\System32\actxprxy.dll
C:\Windows\System32\avrt.dll
C:\Windows\System32\certEnroll.dll
C:\Windows\System32\comctl32.dll
C:\Windows\System32\cscapi.dll
C:\Windows\System32\d3d9.dll
C:\Windows\System32\dhcpcore.dll
C:\Windows\System32\diskcopy.dll
C:\Windows\System32\display.dll
C:\Windows\System32\dmdlgs.dll
C:\Windows\System32\dmdskmgr.dll
C:\Windows\System32\dwmapi.dll
C:\Windows\System32\efsadu.dll
C:\Windows\System32\es.dll
C:\Windows\System32\hal.dll
C:\Windows\System32\hlink.dll
C:\Windows\System32\ie*.*
C:\Windows\System32\ieuinit.inf
C:\Windows\System32\imgutil.dll
C:\Windows\System32\inetcomm.dll
C:\Windows\System32\jscript.dll
C:\Windows\System32\locale.nls
C:\Windows\System32\mmdevapi.dll
C:\Windows\System32\msfeeds.dll
C:\Windows\System32\mshtml.dll
C:\Windows\System32\msi.dll
C:\Windows\System32\msoert2.dll
C:\Windows\System32\msrating.dll
C:\Windows\System32\msxml3.dll
C:\Windows\System32\msxml6.dll
C:\Windows\System32\ndfapi.dll
C:\Windows\System32\net*.dll
C:\Windows\System32\ntdll.dll
C:\Windows\System32\occache.dll
C:\Windows\System32\ole*.dll
C:\Windows\System32\osbaseln.dll
C:\Windows\System32\propsys.dll
C:\Windows\System32\puiapi.dll
C:\Windows\System32\rstrtmgr.dll
C:\Windows\System32\secur32.dll
C:\Windows\System32\setupapi.dll
C:\Windows\System32\shdocvw.dll
C:\Windows\System32\shell32.dll
C:\Windows\System32\shlwapi.dll
C:\Windows\System32\SLC.dll
C:\Windows\System32\SndVolSSO.dll
C:\Windows\System32\tdh.dll
C:\Windows\System32\thumbcache.dll
C:\Windows\System32\urlmon.dll
C:\Windows\System32\user.exe
C:\Windows\System32\uxtheme.dll
C:\Windows\System32\van.dll
C:\Windows\System32\vaultcli.dll
C:\Windows\System32\vbscript.dll
C:\Windows\System32\verclsid.exe
C:\Windows\System32\wevtsvc.dll
C:\Windows\System32\windowscodecs.dll
C:\Windows\System32\WindowsCodecsExt.dll
C:\Windows\System32\wininet.dll
C:\Windows\System32\winnsi.dll
C:\Windows\System32\winrnr.dll

C:\Windows\System32\zh-cn\comctl32.dll.mui
C:\Windows\System32\zh-cn\dhcpcore.dll.mui
C:\Windows\System32\zh-cn\diskcopy.dll.mui
C:\Windows\System32\zh-cn\Display.dll.mui
C:\Windows\System32\zh-cn\dwmapi.dll.mui
C:\Windows\System32\zh-cn\efsadu.dll.mui
C:\Windows\System32\zh-cn\hlink.dll.mui
C:\Windows\System32\zh-cn\ie*.*
C:\Windows\System32\zh-cn\jscript.dll.mui
C:\Windows\System32\zh-cn\MMDevAPI.dll.mui
C:\Windows\System32\zh-cn\mshtml.dll.mui
C:\Windows\System32\zh-cn\msoert2.dll.mui
C:\Windows\System32\zh-cn\msrating.dll.mui
C:\Windows\System32\zh-cn\ndfapi.dll.mui
C:\Windows\System32\zh-cn\net*.dll.mui
C:\Windows\System32\zh-cn\ntdll.dll.mui
C:\Windows\System32\zh-cn\occache.dll.mui
C:\Windows\System32\zh-cn\ole*.dll.mui
C:\Windows\System32\zh-cn\osbaseln.dll.mui
C:\Windows\System32\zh-cn\propsys.dll.mui
C:\Windows\System32\zh-cn\puiapi.dll.mui
C:\Windows\System32\zh-cn\rstrtmgr.dll.mui
C:\Windows\System32\zh-cn\setupapi.dll.mui
C:\Windows\System32\zh-cn\shdocvw.dll.mui
C:\Windows\System32\zh-cn\shell32.dll.mui
C:\Windows\System32\zh-cn\shlwapi.dll.mui
C:\Windows\System32\zh-cn\slc.dll.mui
C:\Windows\System32\zh-cn\sndvolsso.dll.mui
C:\Windows\System32\zh-cn\tdh.dll.mui
C:\Windows\System32\zh-cn\thumbcache.dll.mui
C:\Windows\System32\zh-cn\urlmon.dll.mui
C:\Windows\System32\zh-cn\uxtheme.dll.mui
C:\Windows\System32\zh-cn\van.dll.mui
C:\Windows\System32\zh-cn\vbscript.dll.mui
C:\Windows\System32\zh-cn\wevtsvc.dll.mui
C:\Windows\System32\zh-cn\wininet.dll.mui

C:\Windows\system32\connect.dll
C:\Windows\system32\zh-cn\connect.dll.mui

C:\Windows\system32\mdminst.dll
C:\Windows\system32\modemui.dll
C:\Windows\system32\zh-cn\mdminst.dll.mui
C:\Windows\system32\zh-cn\modemui.dll.mui

C:\Windows\system32\uniplat.dll
C:\Windows\system32\sud.dll
C:\Windows\system32\zh-cn\sud.dll.mui
8 控制面板等，此中文件按自己需求拷贝即可

C:\Windows\System32\*.cpl
C:\Windows\System32\*cpl.dll

C:\Windows\System32\autoplay.dll
C:\Windows\System32\cacls.exe
C:\Windows\System32\calc.exe
C:\Windows\System32\control.exe
C:\Windows\System32\d3d10_1.dll
C:\Windows\System32\d3d10_1core.dll
C:\Windows\System32\dxgi.dll
C:\Windows\System32\ExplorerFrame.dll
C:\Windows\System32\hdwwiz.exe
C:\Windows\System32\lusrmgr.msc
C:\Windows\System32\mscms.dll
C:\Windows\System32\msinfo32.exe
C:\Windows\System32\mstsc.exe
C:\Windows\System32\mstscax.dll
C:\Windows\System32\msvbvm60.dll
C:\Windows\System32\Netplwiz.exe
C:\Windows\System32\nslookup.exe
C:\Windows\System32\odbcad32.exe
C:\Windows\System32\pnp*.dll
C:\Windows\System32\pnp*.exe
C:\Windows\System32\shellstyle.dll
C:\Windows\System32\systeminfo.exe
C:\Windows\System32\SystemPropertiesAdvanced.exe
C:\Windows\System32\SystemPropertiesComputerName.exe
C:\Windows\System32\SystemPropertiesDataExecutionPrevention.exe
C:\Windows\System32\SystemPropertiesHardware.exe
C:\Windows\System32\SystemPropertiesPerformance.exe
C:\Windows\System32\SystemPropertiesProtection.exe
C:\Windows\System32\SystemPropertiesRemote.exe
C:\Windows\System32\wdi.dll
C:\Windows\System32\wer.dll
C:\Windows\System32\wercplsupport.dll
C:\Windows\System32\werdiagcontroller.dll
C:\Windows\System32\WerFault.exe
C:\Windows\System32\WerFaultSecure.exe
C:\Windows\System32\wermgr.exe
C:\Windows\System32\wersvc.dll
C:\Windows\System32\werui.dll

C:\Windows\System32\zh-cn\*.cpl.mui
C:\Windows\System32\zh-cn\*cpl.dll.mui

C:\Windows\System32\zh-cn\autoplay.dll.mui
C:\Windows\System32\zh-cn\cacls.exe.mui
C:\Windows\System32\zh-cn\calc.exe.mui
C:\Windows\System32\zh-cn\explorerframe.dll.mui
C:\Windows\System32\zh-cn\hdwwiz.exe.mui
C:\Windows\System32\zh-cn\lusrmgr.msc
C:\Windows\System32\zh-cn\mscms.dll.mui
C:\Windows\System32\zh-cn\msinfo32.exe.mui
C:\Windows\System32\zh-cn\mstsc.exe.mui
C:\Windows\System32\zh-cn\mstscax.dll.mui
C:\Windows\System32\zh-cn\Netplwiz.exe.mui
C:\Windows\System32\zh-cn\nslookup.exe.mui
C:\Windows\System32\zh-cn\odbcad32.exe.mui
C:\Windows\System32\zh-cn\pnp*.dll.mui
C:\Windows\System32\zh-cn\pnp*.exe.mui
C:\Windows\System32\zh-cn\shellstyle.dll.mui
C:\Windows\System32\zh-cn\systeminfo.exe.mui
C:\Windows\System32\zh-cn\SystemPropertiesAdvanced.exe.mui
C:\Windows\System32\zh-cn\SystemPropertiesComputerName.exe.mui
C:\Windows\System32\zh-cn\SystemPropertiesDataExecutionPrevention.exe.mui
C:\Windows\System32\zh-cn\SystemPropertiesHardware.exe.mui
C:\Windows\System32\zh-cn\SystemPropertiesPerformance.exe.mui
C:\Windows\System32\zh-cn\SystemPropertiesProtection.exe.mui
C:\Windows\System32\zh-cn\SystemPropertiesRemote.exe.mui
C:\Windows\System32\zh-cn\wdi.dll.mui
C:\Windows\System32\zh-cn\wer.dll.mui
C:\Windows\System32\zh-cn\wercplsupport.dll.mui
C:\Windows\System32\zh-cn\WerFault.exe.mui
C:\Windows\System32\zh-cn\WerFaultSecure.exe.mui
C:\Windows\System32\zh-cn\wersvc.dll.mui
C:\Windows\System32\zh-cn\werui.dll.mui
9 WLAN支持与控制台

C:\Windows\inf\ndisuio.inf
C:\Windows\inf\netnwifi.inf
C:\Windows\inf\netserv.inf
C:\Windows\inf\netvwifibus.inf
C:\Windows\inf\netvwifibus.PNF
C:\Windows\inf\netvwififlt.inf
C:\Windows\inf\netvwifimp.inf

C:\Windows\L2Schemas\WLAN_policy_v1.xsd
C:\Windows\L2Schemas\WLAN_profile_v1.xsd
C:\Windows\L2Schemas\WLANAP_profile_v1.xsd
C:\Windows\L2Schemas\WWAN_profile_v1.xsd

C:\Windows\schemas\AvailableNetwork\AvailableNetworkInfo.xsd

C:\Windows\System32\apphelp.dll
C:\Windows\System32\authfwcfg.dll
C:\Windows\System32\AuthFWGP.dll
C:\Windows\System32\browser.dll
C:\Windows\System32\clbcatq.dll
C:\Windows\System32\cfgbkend.dll
C:\Windows\System32\compmgmt.msc
C:\Windows\System32\CompMgmtLauncher.exe
C:\Windows\System32\crtdll.dll
C:\Windows\System32\devmgmt.msc
C:\Windows\System32\devmgr.dll
C:\Windows\System32\diskmgmt.msc
C:\Windows\System32\dmdlgs.dll
C:\Windows\System32\dmdskmgr.dll
C:\Windows\System32\dmdskres.dll
C:\Windows\System32\dmdskres2.dll
C:\Windows\System32\dmintf.dll
C:\Windows\System32\dmocx.dll
C:\Windows\System32\dmutil.dll
C:\Windows\System32\dmvdsitf.dll
C:\Windows\System32\dmview.ocx
C:\Windows\System32\filemgmt.dll
C:\Windows\System32\findstr.exe
C:\Windows\System32\FirewallControlPanel.dll
C:\Windows\System32\fsmgmt.msc
C:\Windows\System32\fsutil.exe
C:\Windows\System32\fwcfg.dll
C:\Windows\System32\hnetcfg.dll
C:\Windows\System32\icacls.exe
C:\Windows\System32\ipsecsnp.dll
C:\Windows\System32\lanman.drv
C:\Windows\System32\mlang.dat
C:\Windows\System32\mlang.dll
C:\Windows\System32\mmc.exe
C:\Windows\System32\mmcbase.dll
C:\Windows\System32\mmcndmgr.dll
C:\Windows\System32\mmcshext.dll
C:\Windows\System32\msacm32.dll
C:\Windows\System32\mycomput.dll
C:\Windows\System32\netman.dll
C:\Windows\System32\netplwiz.dll
C:\Windows\System32\netprof.dll
C:\Windows\System32\netprofm.dll
C:\Windows\System32\oledlg.dll
C:\Windows\System32\sc.exe
C:\Windows\System32\sens.dll
C:\Windows\System32\services.msc
C:\Windows\System32\shfolder.dll
C:\Windows\System32\shrpubw.exe
C:\Windows\System32\srvcli.dll
C:\Windows\System32\srvsvc.dll
C:\Windows\System32\sscore.dll
C:\Windows\System32\WfHC.dll
C:\Windows\System32\wlan*.dll
C:\Windows\System32\wlanapi.dll
C:\Windows\System32\wlanhlp.dll
C:\Windows\System32\wlaninst.dll
C:\Windows\System32\wlanmsm.dll
C:\Windows\System32\wlansec.dll
C:\Windows\System32\wlansvc.dll
C:\Windows\System32\wlanui.dll
C:\Windows\System32\wlgpclnt.dll
C:\Windows\System32\wwan*.dll
C:\Windows\system32\wwanapi.dll
C:\Windows\system32\wwaninst.dll
C:\Windows\system32\wwapi.dll

C:\Windows\System32\drivers\nwifi.sys
C:\Windows\System32\drivers\srv.sys
C:\Windows\System32\drivers\srv2.sys
C:\Windows\System32\drivers\srvnet.sys
C:\Windows\System32\drivers\tcpipreg.sys
C:\Windows\System32\drivers\vwifibus.sys
C:\Windows\System32\drivers\vwififlt.sys
C:\Windows\System32\drivers\vwifimp.sys
C:\Windows\System32\drivers\zh-cn\srv.sys.mui

C:\Windows\System32\zh-cn\apphelp.dll.mui
C:\Windows\System32\zh-cn\browser.dll.mui
C:\Windows\System32\zh-cn\cfgbkend.dll.mui
C:\Windows\System32\zh-cn\compmgmt.msc
C:\Windows\System32\zh-cn\devmgmt.msc
C:\Windows\System32\zh-cn\devmgr.dll.mui
C:\Windows\System32\zh-cn\diskmgmt.msc
C:\Windows\System32\zh-cn\dmdskres.dll.mui
C:\Windows\System32\zh-cn\dmdskres2.dll.mui
C:\Windows\System32\zh-cn\dmocx.dll.mui
C:\Windows\System32\zh-cn\dmutil.dll.mui
C:\Windows\System32\zh-cn\filemgmt.dll.mui
C:\Windows\System32\zh-cn\findstr.exe.mui
C:\Windows\System32\zh-cn\FirewallControlPanel.dll.mui
C:\Windows\System32\zh-cn\fsmgmt.msc
C:\Windows\System32\zh-cn\fsutil.exe.mui
C:\Windows\System32\zh-cn\fwcfg.dll.mui
C:\Windows\System32\zh-cn\hnetcfg.dll.mui
C:\Windows\System32\zh-cn\ICacls.exe.mui
C:\Windows\System32\zh-cn\ipsecsnp.dll.mui
C:\Windows\System32\zh-cn\mlang.dll.mui
C:\Windows\System32\zh-cn\mmc.exe.mui
C:\Windows\System32\zh-cn\mmcbase.dll.mui
C:\Windows\System32\zh-cn\mmcndmgr.dll.mui
C:\Windows\System32\zh-cn\mmcshext.dll.mui
C:\Windows\System32\zh-cn\msacm32.dll.mui
C:\Windows\System32\zh-cn\mycomput.dll.mui
C:\Windows\System32\zh-cn\netman.dll.mui
C:\Windows\System32\zh-cn\netplwiz.dll.mui
C:\Windows\System32\zh-cn\netprof.dll.mui
C:\Windows\System32\zh-cn\netprofm.dll.mui
C:\Windows\System32\zh-cn\oledlg.dll.mui
C:\Windows\System32\zh-cn\sc.exe.mui
C:\Windows\System32\zh-cn\sens.dll.mui
C:\Windows\System32\zh-cn\services.msc
C:\Windows\System32\zh-cn\shrpubw.exe.mui
C:\Windows\System32\zh-cn\srvsvc.dll.mui
C:\Windows\System32\zh-cn\sscore.dll.mui
C:\Windows\System32\zh-cn\WfHC.dll.mui
C:\Windows\System32\zh-cn\wlan*.dll.mui
C:\Windows\System32\zh-cn\wlanapi.dll.mui
C:\Windows\System32\zh-cn\wlansvc.dll.mui
C:\Windows\System32\zh-cn\wlanui.dll.mui
C:\Windows\System32\zh-cn\wlgpclnt.dll.mui
C:\Windows\System32\zh-cn\wwan*.dll.mui
10 一些程序的支持

C:\Windows\SysWOW64\wow32.dll
C:\Windows\System32\ntvdm.exe
C:\Windows\System32\msvfw32.dll
C:\Windows\System32\msvcr71.dll
C:\Windows\System32\avifil32.dll
C:\Windows\System32\zh-cn\msvfw32.dll.mui
C:\Windows\System32\zh-cn\avifil32.dll.mui
11 XPS 查看器（没人加这个吧？）

C:\Windows\System32\DWrite.dll
C:\Windows\System32\XPSSHHDR.dll
C:\Windows\System32\xpssvcs.dll
C:\Windows\System32\xpsrchvw.exe
C:\Windows\System32\xpsfilt.dll
C:\Windows\System32\zh-cn\xpsrchvw.exe.mui
C:\Windows\System32\zh-cn\DWrite.dll.mui
C:\Windows\System32\zh-cn\xpsshhdr.dll.mui
12 网络支持。如果你按照我的文章http://www.wingwy.com/archives/2011_02_857.html加入过WinPE-DOT3SVC和WinPE-PPPoE程序包，这里不需要。

C:\Windows\System32\Dot3cfg.dll
C:\Windows\System32\Dot3api.dll
C:\Windows\System32\Dot3dlg.dll
C:\Windows\System32\dot3gpclnt.dll
C:\Windows\System32\Dot3msm.dll
C:\Windows\System32\Dot3svc.dll
C:\Windows\System32\l2gpstore.dll
C:\Windows\System32\Shwebsvc.dll
C:\Windows\System32\Onex.dll
C:\Windows\System32\Onexui.dll

C:\Windows\System32\zh-cn\Dot3cfg.dll.mui
C:\Windows\System32\zh-cn\Dot3api.dll.mui
C:\Windows\System32\zh-cn\Dot3dlg.dll.mui
C:\Windows\System32\zh-cn\dot3gpclnt.dll.mui
C:\Windows\System32\zh-cn\Dot3msm.dll.mui
C:\Windows\System32\zh-cn\Dot3svc.dll.mui
C:\Windows\System32\zh-cn\shwebsvc.dll.mui
C:\Windows\System32\zh-cn\Onex.dll.mui
C:\Windows\System32\zh-cn\Onexui.dll.mui

C:\Windows\System32\drivers\ndisuio.sys
C:\Windows\System32\drivers\zh-cn\ndisuio.sys.mui
C:\Windows\System32\wbem\l2gpstore.mof
C:\Windows\System32\wbem\zh-cn\l2gpstore.mfl

C:\Windows\L2Schemas\LAN_policy_v1.xsd
C:\Windows\L2Schemas\LAN_profile_v1.xsd
C:\Windows\L2Schemas\OneX_v1.xsd

C:\Windows\PLA\*
C:\Windows\schemas\*
C:\Windows\TAPI\*
C:\Windows\inf\TAPISRV\*

C:\Windows\system32\dialer.exe
C:\Windows\system32\sens.dll
C:\Windows\system32\tapi32.dll
C:\Windows\system32\tapi.dll
C:\Windows\system32\tapilua.dll
C:\Windows\system32\tapiperf.dll
C:\Windows\System32\tapisrv.dll
C:\Windows\System32\tapiui.dll
C:\Windows\system32\telephon.cpl

C:\Windows\system32\zh-cn\dialer.exe.mui
C:\Windows\system32\zh-cn\sens.dll.mui
C:\Windows\system32\zh-cn\tapi32.dll.mui
C:\Windows\System32\zh-cn\tapisrv.dll.mui
C:\Windows\System32\zh-cn\tapiui.dll.mui
C:\Windows\system32\zh-cn\telephon.cpl.mui

C:\Windows\System32\rasdial.exe
C:\Windows\System32\rasgcw.dll
C:\Windows\System32\RASMM.dll
C:\Windows\System32\rasphone.exe
C:\Windows\System32\rasplap.dll

C:\Windows\System32\zh-cn\rasdial.exe.mui
C:\Windows\System32\zh-cn\rasgcw.dll.mui
C:\Windows\System32\zh-cn\rasmm.dll.mui
C:\Windows\System32\zh-cn\rasphone.exe.mui
C:\Windows\System32\zh-cn\rasplap.dll.mui

C:\Windows\system32\ras\*
C:\Windows\System32\SHELL.DLL
C:\Windows\System32\Shsvcs.dll
C:\Windows\System32\zh-cn\shsvcs.dll.mui

13 foobar2000的回放支持

C:\Windows\System32\dsound.dll
C:\Windows\System32\zh-cn\dsound.dll.mui
14 windows自带zip文件支持

C:\Windows\System32\zipfldr.dll
C:\Windows\System32\zh-cn\zipfldr.dll.mui

15 msi安装服务。需按照http://www.wingwy.com/archives/2011_02_862.html 8.2步骤添加服务

C:\Windows\System32\msi.dll
C:\Windows\System32\msiexec.exe
C:\Windows\System32\msihnd.dll
C:\Windows\System32\msimsg.dll
C:\Windows\System32\msisip.dll
C:\Windows\System32\msiltcfg.dll
C:\Windows\System32\wbem\msi.mof
C:\Windows\System32\wbem\msiprov.dll

C:\Windows\System32\zh-cn\msiexec.exe.mui
C:\Windows\System32\zh-cn\msimsg.dll.mui
C:\Windows\System32\wbem\zh-cn\msi.mfl

C:\Windows\SysWOW64\msi.dll
C:\Windows\SysWOW64\msiexec.exe
C:\Windows\SysWOW64\msihnd.dll
C:\Windows\SysWOW64\msimsg.dll
C:\Windows\SysWOW64\msisip.dll
C:\Windows\SysWOW64\msiltcfg.dll
C:\Windows\SysWOW64\msi*.dll

C:\Windows\SysWOW64\zh-cn\msiexec.exe.mui
C:\Windows\SysWOW64\zh-cn\msimsg.dll.mui
C:\Windows\SysWOW64\zh-cn\msi*.dll.mui
C:\Windows\System32\dinput.dll
C:\Windows\System32\dinput8.dll
C:\Windows\System32\zh-cn\dinput.dll.mui
C:\Windows\System32\zh-cn\dinput8.dll.mui
C:\Windows\SysWOW64\dinput.dll
C:\Windows\SysWOW64\dinput8.dll
C:\Windows\SysWOW64\zh-cn\dinput.dll.mui
C:\Windows\SysWOW64\zh-cn\dinput8.dll.mui

C:\Windows\System32\shpafact.dll
C:\Windows\System32\twext.dll
C:\Windows\System32\zh-cn\twext.dll.mui

C:\Windows\System32\mfc40.dll
C:\Windows\System32\zh-cn\MFC40.dll.mui
16 VMWare player支持

C:\Windows\system32\dsound.dll
C:\Windows\system32\glu32.dll
C:\Windows\system32\opengl32.dll
C:\Windows\system32\sqmapi.dll

C:\Windows\Syswow64\cryptui.dll
C:\Windows\Syswow64\devrtl.dll
C:\Windows\Syswow64\loadperf.dll
C:\Windows\Syswow64\msls31.dll
C:\Windows\Syswow64\newdev.dll
C:\Windows\Syswow64\RpcRtRemote.dll
C:\Windows\Syswow64\sfc.dll
C:\Windows\Syswow64\srclient.dll
C:\Windows\Syswow64\webio.dll
C:\Windows\Syswow64\winhttp.dll
C:\Windows\Syswow64\winrnr.dll
C:\Windows\Syswow64\WinSCard.dll

17 连接设置导航
C:\Windows\system32\xwizards.dll
C:\Windows\system32\xwtpw32.dll
C:\Windows\system32\xwreg.dll
C:\Windows\system32\zh-cn\xwizards.dll.mui
C:\Windows\system32\zh-cn\xwreg.dll.mui
C:\Windows\system32\zh-cn\xwtpw32.dll.mui

C:\Windows\system32\crypt32.dll
C:\Windows\system32\fdProxy.dll
C:\Windows\system32\fdWCN.dll
C:\Windows\system32\fundisc.dll
C:\Windows\system32\hgcpl.dll
C:\Windows\System32\msimtf.dll
C:\Windows\system32\netcenter.dll
C:\Windows\system32\networkexplorer.dll
C:\Windows\system32\newdev.dll
C:\Windows\System32\npmproxy.dll
C:\Windows\system32\pnidui.dll
C:\Windows\system32\PortableDeviceApi.dll
C:\Windows\system32\schedsvc.dll
C:\Windows\System32\ssdpapi.dll
C:\Windows\System32\termsrv.dll
C:\Windows\system32\UIAnimation.dll
C:\Windows\system32\WcnApi.dll
C:\Windows\system32\WcnEapPeerProxy.dll
C:\Windows\system32\wcnwiz.dll
C:\Windows\system32\winhttp.dll
C:\Windows\system32\wlandlg.dll
C:\Windows\system32\WlanMM.dll
C:\Windows\system32\wwanmm.dll
C:\Windows\system32\xwtpdui.dll

C:\Windows\system32\zh-cn\crypt32.dll.mui
C:\Windows\system32\zh-cn\FunDisc.dll.mui
C:\Windows\system32\zh-cn\hgcpl.dll.mui
C:\Windows\system32\zh-cn\msimtf.dll.mui
C:\Windows\system32\zh-cn\netcenter.dll.mui
C:\Windows\system32\zh-cn\NetworkExplorer.dll.mui
C:\Windows\system32\zh-cn\newdev.dll.mui
C:\Windows\system32\zh-cn\pnidui.dll.mui
C:\Windows\system32\zh-cn\PortableDeviceApi.dll.mui
C:\Windows\system32\zh-cn\schedsvc.dll.mui
C:\Windows\System32\zh-cn\termsrv.dll.mui
C:\Windows\System32\zh-cn\UIAnimation.dll.mui
C:\Windows\system32\zh-cn\wcnwiz.dll.mui
C:\Windows\system32\zh-cn\winhttp.dll.mui
C:\Windows\system32\zh-cn\wlandlg.dll.mui
C:\Windows\system32\zh-cn\wlanmm.dll.mui
C:\Windows\system32\zh-cn\WWanMM.dll.mui
C:\Windows\system32\zh-cn\xwtpdui.dll.mui

18 wmp和sidebar以及其他的一些文件

C:\Program Files\Windows Media Player\*

C:\Program Files\Windows Sidebar\*

C:\Program Files\Common Files\System\DirectDB.dll
C:\Program Files\Common Files\System\wab32.dll
C:\Program Files\Common Files\System\wab32res.dll
C:\Program Files\Common Files\System\zh-cn\wab32res.dll.mui
C:\Program Files\Windows Portable Devices\sqmapi.dll

C:\Windows\Cursors\aero*

C:\Windows\inf\netbrdgm.inf
C:\Windows\inf\netbrdgs.inf
C:\Windows\inf\netpacer.inf
C:\Windows\inf\netpgm.inf
C:\Windows\inf\netrndis.inf

C:\Windows\System32\ActionCenter.dll
C:\Windows\System32\aelupsvc.dll
C:\Windows\System32\avicap32.dll
C:\Windows\System32\colorcpl.exe
C:\Windows\System32\comsvcs.dll
C:\Windows\System32\connect.dll
C:\Windows\System32\d3d10.dll
C:\Windows\System32\d3d10core.dll
C:\Windows\System32\d3d11.dll
C:\Windows\System32\d3dim700.dll
C:\Windows\System32\devenum.dll
C:\Windows\system32\dtsh.dll
C:\Windows\System32\dxdiag.exe
C:\Windows\System32\dxdiagn.dll
C:\Windows\system32\DXP.dll
C:\Windows\System32\dxtmsft.dll
C:\Windows\System32\dxva2.dll
C:\Windows\system32\EhStorAPI.dll
C:\Windows\system32\EhStorShell.dll
C:\Windows\System32\evr.dll
C:\Windows\system32\fdProxy.dll
C:\Windows\system32\fdWCN.dll
C:\Windows\system32\fundisc.dll
C:\Windows\System32\grpconv.exe
C:\Windows\system32\hgcpl.dll
C:\Windows\System32\iccvid.dll
C:\Windows\System32\imaadp32.acm
C:\Windows\System32\iphlpsvc.dll
C:\Windows\System32\iyuv_32.dll
C:\Windows\System32\ksproxy.ax
C:\Windows\System32\l3codeca.acm
C:\Windows\System32\mdminst.dll
C:\Windows\System32\mf.dll
C:\Windows\System32\mfps.dll
C:\Windows\System32\midimap.dll
C:\Windows\System32\MP3DMOD.DLL
C:\Windows\System32\MP43DECD.DLL
C:\Windows\System32\MP4SDECD.DLL
C:\Windows\System32\Mpeg2Data.ax
C:\Windows\System32\mpg2splt.ax
C:\Windows\System32\MPG4DECD.DLL
C:\Windows\System32\MSAC3ENC.DLL
C:\Windows\System32\msacm32.drv
C:\Windows\System32\msadp32.acm
C:\Windows\System32\mscoree.dll
C:\Windows\System32\msdmo.dll
C:\Windows\System32\msdt.exe
C:\Windows\System32\MSDvbNP.ax
C:\Windows\System32\msfeedsbs.dll
C:\Windows\System32\msg711.acm
C:\Windows\System32\msgsm32.acm
C:\Windows\System32\mshta.exe
C:\Windows\System32\mshtml.tlb
C:\Windows\system32\msieftp.dll
C:\Windows\System32\msimtf.dll
C:\Windows\System32\msmpeg2adec.dll
C:\Windows\System32\MSMPEG2ENC.DLL
C:\Windows\System32\msmpeg2vdec.dll
C:\Windows\System32\MSNP.ax
C:\Windows\System32\msrle32.dll
C:\Windows\System32\msvidc32.dll
C:\Windows\System32\mswmdm.dll
C:\Windows\System32\msyuv.dll
C:\Windows\system32\netcenter.dll
C:\Windows\system32\networkexplorer.dll
C:\Windows\System32\Notepad.exe
C:\Windows\System32\npmproxy.dll
C:\Windows\System32\pngfilt.dll
C:\Windows\System32\pnrpsvc.dll
C:\Windows\system32\PortableDeviceApi.dll
C:\Windows\system32\portabledeviceconnectapi.dll
C:\Windows\system32\prnfldr.dll
C:\Windows\System32\psisrndr.ax
C:\Windows\system32\QAGENT.DLL
C:\Windows\system32\QAGENTRT.DLL
C:\Windows\System32\qasf.dll
C:\Windows\System32\qcap.dll
C:\Windows\System32\qdv.dll
C:\Windows\System32\qdvd.dll
C:\Windows\System32\qedit.dll
C:\Windows\System32\quartz.dll
C:\Windows\System32\sbe.dll
C:\Windows\System32\sberes.dll
C:\Windows\System32\sccls.dll
C:\Windows\system32\schedcli.dll
C:\Windows\system32\schedsvc.dll
C:\Windows\system32\security.dll
C:\Windows\System32\Shsvcs.dll
C:\Windows\System32\spp.dll
C:\Windows\system32\sqmapi.dll
C:\Windows\System32\srclient.dll
C:\Windows\System32\ssdpapi.dll
C:\Windows\System32\sti_ci.dll
C:\Windows\system32\sud.dll
C:\Windows\System32\SyncCenter.dll
C:\Windows\System32\synceng.dll
C:\Windows\System32\Syncreg.dll
C:\Windows\System32\syncui.dll
C:\Windows\System32\themeservice.dll
C:\Windows\System32\tsbyuv.dll
C:\Windows\system32\UIAnimation.dll
C:\Windows\system32\umb.dll
C:\Windows\System32\uniplat.dll
C:\Windows\System32\unregmp2.exe
C:\Windows\system32\upnp.dll
C:\Windows\System32\url.dll
C:\Windows\System32\VBICodec.ax
C:\Windows\System32\vbisurf.ax
C:\Windows\system32\WcnApi.dll
C:\Windows\system32\WcnEapPeerProxy.dll
C:\Windows\system32\wcnwiz.dll
C:\Windows\system32\wiarpc.dll
C:\Windows\system32\wlandlg.dll
C:\Windows\System32\WMADMOD.DLL
C:\Windows\System32\WMADMOE.DLL
C:\Windows\System32\WMASF.DLL
C:\Windows\System32\wmdmps.dll
C:\Windows\System32\wmdrmsdk.dll
C:\Windows\System32\WMNetMgr.dll
C:\Windows\System32\wmp.dll
C:\Windows\System32\wmpeffects.dll
C:\Windows\System32\WMPhoto.dll
C:\Windows\System32\wmploc.DLL
C:\Windows\System32\wmpps.dll
C:\Windows\System32\wmpsrcwp.dll
C:\Windows\System32\WMSPDMOD.DLL
C:\Windows\System32\WMSPDMOE.DLL
C:\Windows\System32\WMVCORE.DLL
C:\Windows\System32\WMVDECOD.DLL
C:\Windows\System32\WMVENCOD.DLL
C:\Windows\System32\WMVSDECD.DLL
C:\Windows\System32\WMVSENCD.DLL
C:\Windows\System32\WMVXENCD.DLL
C:\Windows\System32\wpdbusenum.dll
C:\Windows\system32\wpdshext.dll
C:\Windows\System32\WSTPager.ax
C:\Windows\system32\xwizards.dll
C:\Windows\system32\xwreg.dll
C:\Windows\system32\xwtpdui.dll
C:\Windows\system32\xwtpw32.dll

C:\Windows\System32\zh-cn\ActionCenter.dll.mui
C:\Windows\System32\zh-cn\aelupsvc.dll.mui
C:\Windows\System32\zh-cn\avicap32.dll.mui
C:\Windows\System32\zh-cn\colorcpl.exe.mui
C:\Windows\System32\zh-cn\connect.dll.mui
C:\Windows\system32\zh-cn\crypt32.dll.mui
C:\Windows\System32\zh-cn\devenum.dll.mui
C:\Windows\System32\zh-cn\dxdiag.exe.mui
C:\Windows\System32\zh-cn\dxdiagn.dll.mui
C:\Windows\System32\zh-cn\evr.dll.mui
C:\Windows\System32\zh-cn\grpconv.exe.mui
C:\Windows\system32\zh-cn\hgcpl.dll.mui
C:\Windows\System32\zh-cn\iccvid.dll.mui
C:\Windows\System32\zh-cn\imaadp32.acm.mui
C:\Windows\System32\zh-cn\iphlpsvc.dll.mui
C:\Windows\System32\zh-cn\iyuv_32.dll.mui
C:\Windows\System32\zh-cn\ksproxy.ax.mui
C:\Windows\System32\zh-cn\l3codeca.acm.mui
C:\Windows\System32\zh-cn\mdminst.dll.mui
C:\Windows\System32\zh-cn\mf.dll.mui
C:\Windows\System32\zh-cn\mp4sdecd.dll.mui
C:\Windows\System32\zh-cn\msacm32.drv.mui
C:\Windows\System32\zh-cn\msadp32.acm.mui
C:\Windows\System32\zh-cn\msdt.exe.mui
C:\Windows\System32\zh-cn\msg711.acm.mui
C:\Windows\System32\zh-cn\msgsm32.acm.mui
C:\Windows\System32\zh-cn\mshta.exe.mui
C:\Windows\System32\zh-cn\MSMPEG2ENC.DLL.mui
C:\Windows\System32\zh-cn\msrle32.dll.mui
C:\Windows\System32\zh-cn\msvidc32.dll.mui
C:\Windows\system32\zh-cn\netcenter.dll.mui
C:\Windows\system32\zh-cn\NetworkExplorer.dll.mui
C:\Windows\system32\zh-cn\newdev.dll.mui
C:\Windows\system32\zh-cn\pnidui.dll.mui
C:\Windows\System32\zh-cn\pnrpsvc.dll.mui
C:\Windows\System32\zh-cn\qasf.dll.mui
C:\Windows\System32\zh-cn\qcap.dll.mui
C:\Windows\System32\zh-cn\qdv.dll.mui
C:\Windows\System32\zh-cn\qdvd.dll.mui
C:\Windows\System32\zh-cn\qedit.dll.mui
C:\Windows\System32\zh-cn\quartz.dll.mui
C:\Windows\System32\zh-cn\sberes.dll.mui
C:\Windows\System32\zh-cn\sccls.dll.mui
C:\Windows\system32\zh-cn\schedsvc.dll.mui
C:\Windows\System32\zh-cn\shsvcs.dll.mui
C:\Windows\System32\zh-cn\sti_ci.dll.mui
C:\Windows\system32\zh-cn\sud.dll.mui
C:\Windows\System32\zh-cn\SyncCenter.dll.mui
C:\Windows\System32\zh-cn\syncui.dll.mui
C:\Windows\System32\zh-cn\themeservice.dll.mui
C:\Windows\System32\zh-cn\unregmp2.exe.mui
C:\Windows\system32\zh-cn\wcnwiz.dll.mui
C:\Windows\system32\zh-cn\winhttp.dll.mui
C:\Windows\system32\zh-cn\wlandlg.dll.mui
C:\Windows\system32\zh-cn\wlanmm.dll.mui
C:\Windows\System32\zh-cn\WMPhoto.dll.mui
C:\Windows\System32\zh-cn\wmploc.DLL.mui
C:\Windows\System32\zh-cn\wpdbusenum.dll.mui
C:\Windows\system32\zh-cn\wpdshext.dll.mui
C:\Windows\system32\zh-cn\WWanMM.dll.mui
C:\Windows\system32\zh-cn\xwizards.dll.mui
C:\Windows\system32\zh-cn\xwtpdui.dll.mui
C:\Windows\System32\DeviceCenter.dll
C:\Windows\System32\dwm.exe
C:\Windows\System32\Faultrep.dll
C:\Windows\System32\hcproviders.dll
C:\Windows\System32\webcheck.dll
C:\Windows\System32\wscapi.dll
C:\Windows\System32\wscinterop.dll

C:\Windows\System32\zh-cn\DeviceCenter.dll.mui
C:\Windows\System32\zh-cn\dwm.exe.mui
C:\Windows\System32\zh-cn\Faultrep.dll.mui
C:\Windows\System32\zh-cn\hcproviders.dll.mui

C:\Windows\SysWOW64\notepad.exe
C:\Windows\SysWOW64\shdocvw.dll
C:\Windows\SysWOW64\taskmgr.exe

C:\Windows\SysWOW64\zh-cn\shdocvw.dll.mui
C:\Windows\SysWOW64\zh-cn\taskmgr.exe.mui