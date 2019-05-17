dump -0u -f /dev/sda1 /volume1/sda1.dump
dump -0j -f /root/etc.dump.bz2 /etc


[root@www ~]# restore -t [-f dumpfile] [-h]        <==用来察看 dump 档
[root@www ~]# restore -C [-f dumpfile] [-D 挂载点] <==比较dump与实际文件
[root@www ~]# restore -i [-f dumpfile]             <==进入互动模式
[root@www ~]# restore -r [-f dumpfile]             <==还原整个文件系统

restore -t -f /root/boot.dump 