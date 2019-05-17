copype amd64 C:\WinPE_amd64

Dism /Mount-Image /ImageFile:"C:\WinPE_amd64\media\sources\boot.wim" /index:1 /MountDir:"C:\WinPE_amd64\mount"

Dism /Unmount-Image /MountDir:"C:\WinPE_amd64\mount" /commit


MakeWinPEMedia /ISO C:\WinPE_amd64 C:\WinPE_amd64\WinPE_amd64.iso


diskpart
create vdisk file="C:\WinPE.vhdx" maximum=1000
attach vdisk
create partition primary
assign letter=V
format fs=ntfs quick
exit

MakeWinPEMedia /UFD C:\WinPE_amd64 F: