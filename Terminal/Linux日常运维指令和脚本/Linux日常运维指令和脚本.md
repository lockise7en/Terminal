# Linux日常运维指令和脚本
------
### case 1：shell终端for循环
```bash
usage:
    for i in {1..10};do step1; step 2; step 3; done
sample:
    for i in ./*; do echo $i; echo `basename $i`; done
```    

### case 2：crontab任务计划
```
usage:
    -l：查看计划清单
    -e：编辑计划清单
    -d：删除计划清单
example:
    * 1/* * * * cp file1 file2
```

### case 3：shell字符截断
```
usage:
    -#：顺序截断第一个
    -##：顺序截断最长的一个
    -%：逆序截断第一个
    -%%：逆序截断最长的一个
example:
    dir = /home/xx/zsrc/libtiff/tools/.libs
    echo ${dir##*/} 获取文件路径，等同于dirname $dir
    echo ${dir%/*}  获取文件名，等同于basename $dir
```

### case 4：递归打印子目录下的所有文件名
```
function readdir(){
    for file in `ls $1`
    do
        if [ -d $1"/"$file ];then
            readdir $1"/"$file    
        else
            echo $1"/"$file
        fi
        done
}
readdir .
```
### case 5：ubuntu 添加仓库和秘钥
```bash
usage:
    1.apt-key adv --server xx.net --recv-keys yy
    2.echo "deb http://llvm.org/apt/jessie/ llvm-toolchain-jessie-3.8 main" > /etc/apt/sources.list.d/llvm.list
```    

### case 6：shell 重定向
```bash
usage:
    1.文件重定向：
    commnad > stdout.log ; 标准输出重定向
    command 2> err.log ; 标准错误重定向
    command &> all.log ; 输出和错误都重定向
    2.文件描述符重定向: 
    command >all.log 2>&1 ; 标准输出重定向到all.log，然后标准错误重定向到标准输出，等于输出和错误都重定向到all.log，常用 command > /dev/null 2>&1屏蔽信息。
    3.管道
    管道是其前者的输出作为后者的输入，只有当后者会阻塞在等候输入的情况下有效，检测方法是直接后者的命令看是否阻塞？
    echo “hello” | cat  有效，因为cat是输入阻塞型
    echo “hello” | ls   无效，因为ls不是输入阻塞型
```   
