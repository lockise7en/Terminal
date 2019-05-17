用法：ls [选项]... [文件]...
List information about the FILEs (the current directory by default).
Sort entries alphabetically if none of -cftuvSUX nor --sort is specified.

必选参数对长短选项同时适用。
  -a, --all			不隐藏任何以. 开始的项目
  -A, --almost-all		列出除. 及.. 以外的任何项目
      --author			与-l 同时使用时列出每个文件的作者
  -b, --escape			以八进制溢出序列表示不可打印的字符
      --block-size=SIZE      scale sizes by SIZE before printing them; e.g.,
                               '--block-size=M' prints sizes in units of
                               1,048,576 bytes; see SIZE format below
  -B, --ignore-backups       do not list implied entries ending with ~
  -c                         with -lt: sort by, and show, ctime (time of last
                               modification of file status information);
                               with -l: show ctime and sort by name;
                               otherwise: sort by ctime, newest first
  -C                         list entries by columns
      --color[=WHEN]         colorize the output; WHEN can be 'always' (default
                               if omitted), 'auto', or 'never'; more info below
  -d, --directory            list directories themselves, not their contents
  -D, --dired                generate output designed for Emacs' dired mode
  -f                         do not sort, enable -aU, disable -ls --color
  -F, --classify             append indicator (one of */=>@|) to entries
      --file-type            likewise, except do not append '*'
      --format=WORD          across -x, commas -m, horizontal -x, long -l,
                               single-column -1, verbose -l, vertical -C
      --full-time            like -l --time-style=full-iso
  -g				类似-l，但不列出所有者
      --group-directories-first
                             group directories before files;
                               can be augmented with a --sort option, but any
                               use of --sort=none (-U) disables grouping
  -G, --no-group             in a long listing, don't print group names
  -h, --human-readable       with -l and/or -s, print human readable sizes
                               (e.g., 1K 234M 2G)
      --si                   likewise, but use powers of 1000 not 1024
  -H, --dereference-command-line
                             follow symbolic links listed on the command line
      --dereference-command-line-symlink-to-dir
                             follow each command line symbolic link
                               that points to a directory
      --hide=PATTERN         do not list implied entries matching shell PATTERN
                               (overridden by -a or -A)
      --indicator-style=WORD  append indicator with style WORD to entry names:
                               none (default), slash (-p),
                               file-type (--file-type), classify (-F)
  -i, --inode                print the index number of each file
  -I, --ignore=PATTERN       do not list implied entries matching shell PATTERN
  -k, --kibibytes            default to 1024-byte blocks for disk usage
  -l				使用较长格式列出信息
  -L, --dereference		当显示符号链接的文件信息时，显示符号链接所指示
				的对象而并非符号链接本身的信息
  -m				所有项目以逗号分隔，并填满整行行宽
  -n, --numeric-uid-gid      like -l, but list numeric user and group IDs
  -N, --literal              print entry names without quoting
  -o                         like -l, but do not list group information
  -p, --indicator-style=slash
                             append / indicator to directories
  -q, --hide-control-chars   print ? instead of nongraphic characters
      --show-control-chars   show nongraphic characters as-is (the default,
                               unless program is 'ls' and output is a terminal)
  -Q, --quote-name           enclose entry names in double quotes
      --quoting-style=WORD   use quoting style WORD for entry names:
                               literal, locale, shell, shell-always,
                               shell-escape, shell-escape-always, c, escape
  -r, --reverse			逆序排列
  -R, --recursive		递归显示子目录
  -s, --size			以块数形式显示每个文件分配的尺寸
  -S                         sort by file size, largest first
      --sort=WORD            sort by WORD instead of name: none (-U), size (-S),
                               time (-t), version (-v), extension (-X)
      --time=WORD            with -l, show time as WORD instead of default
                               modification time: atime or access or use (-u);
                               ctime or status (-c); also use specified time
                               as sort key if --sort=time (newest first)
      --time-style=STYLE     with -l, show times using style STYLE:
                               full-iso, long-iso, iso, locale, or +FORMAT;
                               FORMAT is interpreted like in 'date'; if FORMAT
                               is FORMAT1<newline>FORMAT2, then FORMAT1 applies
                               to non-recent files and FORMAT2 to recent files;
                               if STYLE is prefixed with 'posix-', STYLE
                               takes effect only outside the POSIX locale
  -t                         sort by modification time, newest first
  -T, --tabsize=COLS         assume tab stops at each COLS instead of 8
  -u                         with -lt: sort by, and show, access time;
                               with -l: show access time and sort by name;
                               otherwise: sort by access time, newest first
  -U                         do not sort; list entries in directory order
  -v                         natural sort of (version) numbers within text
  -w, --width=COLS           set output width to COLS.  0 means no limit
  -x                         list entries by lines instead of by columns
  -X                         sort alphabetically by entry extension
  -Z, --context              print any security context of each file
  -1                         list one file per line.  Avoid '\n' with -q or -b
      --append-exe           append .exe if cygwin magic was needed
      --help		显示此帮助信息并退出
      --version		显示版本信息并退出

The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).

使用色彩来区分文件类型的功能已被禁用，默认设置和 --color=never 同时禁用了它。
使用 --color=auto 选项，ls 只在标准输出被连至终端时才生成颜色代码。
LS_COLORS 环境变量可改变此设置，可使用 dircolors 命令来设置。


退出状态：
 0  正常
 1  一般问题 (例如：无法访问子文件夹)
 2  严重问题 (例如：无法使用命令行参数)

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
请向<http://translationproject.org/team/zh_CN.html> 报告ls 的翻译错误
Full documentation at: <http://www.gnu.org/software/coreutils/ls>
or available locally via: info '(coreutils) ls invocation'
功能：ls是英文单词list的简写，其功能为列出目录的内容。这是用户最常用的一个命令之一，因为用户需要不时地查看某个目录的内容。该命令类似于DOS下的dir命令。
语法：ls [选项] [目录或是文件] 
对于每个目录，该命令将列出其中的所有子目录与文件。对于每个文件，ls将输出 其文件名以及所要求的其他信息。默认情况下，输出条目按字母顺序排序。当未给出目录名或是文件名时，就显示当前目录的信息。
参数：
- a 显示指定目录下所有子目录与文件，包括隐藏文件。 
- A 显示指定目录下所有子目录与文件，包括隐藏文件。但不列出“.”和 “..”。
- b 对文件名中的不可显示字符用八进制逃逸字符显示。
- c 按文件的修改时间排序。 
- C 分成多列显示各项。
- d 如果参数是目录，只显示其名称而不显示其下的各文件。往往与l选项一起使 用，以得到目录的详细信息。
- f 不排序。该选项将使lts选项失效，并使aU选项有效。
- F 在目录名后面标记“/”，可执行文件后面标记“*”，符号链接后面标记 “@”，管道（或FIFO）后面标记“|”，socket文件后面标记“=”。 
- i 在输出的第一列显示文件的i节点号。 
- l 以长格式来显示文件的详细信息。这个选项最常用。
每行列出的信息依次是： 文件类型与权限 链接数 文件属主 文件属组 文件大小 建立或最近修改的时间 名字 
对于符号链接文件，显示的文件名之后有“—〉”和引用文件路径名。 
对于设备文件，其“文件大小”字段显示主、次设备号，而不是文件大小。
目录中的总块数显示在长格式列表的开头，其中包含间接块。 
- L 若指定的名称为一个符号链接文件，则显示链接所指向的文件。
- m 输出按字符流格式，文件跨页显示，以逗号分开。 
- n 输出格式与l选项相同，只不过在输出中文件属主和属组是用相应的UID号和 GID号来表示，而不是实际的名称。
- o 与l选项相同，只是不显示拥有者信息。
- p 在目录后面加一个“/”。
- q 将文件名中的不可显示字符用“?”代替。 
- r 按字母逆序或最早优先的顺序显示输出结果。 
- R 递归式地显示指定目录的各个子目录中的文件。 
- s 给出每个目录项所用的块数，包括间接块。 
- t 显示时按修改时间（最近优先）而不是按名字排序。若文件修改时间相同，则 按字典顺序。修改时间取决于是否使用了c或u选顶。缺省的时间标记是最后一次修 改时间。
- u 显示时按文件上次存取的时间（最近优先）而不是按名字排序。即将-t的时间 标记修改为最后一次访问的时间。
- x 按行显示出各排序项的信息。
-----------------------------------------------------------------------------------------------------
用ls - l命令显示的信息中，开头是由10个字符构成的字符串，其中第一个字符表示文件类型，它可以是下述类型之一：
- 普通文件
d 目录 
l 符号链接
b 块设备文件
c 字符设备文件
后面的9个字符表示文件的访问权限，分为3组，每组3位。
第一组表示文件属主的权限，第二组表示同组用户的权限，第三组表示其他用户的权限。每一组的三个字 符分别表示对文件的读、写和执行权限。 
各权限如下所示：
r 读 
w 写 
x 执行。对于目录，表示进入权限。
s 当文件被执行时，把该文件的UID或GID赋予执行进程的UID（用户ID）或GID（组 ID）。
t 设置标志位（留在内存，不被换出）。如果该文件是目录，在该目录中的文件只能被超级用户、目录拥有者或文件属主删除。如果它是可执行文件，在该文件执行后，指向其正文段的指针仍留在内存。这样再次执行它时，系统就能更快地装入该文件。 
- 没有设置权限。
------------------------------------------------------------------------------------------------------ 
例1：列出当前目录的内容。
$ ls 
  ls –F  
  ls  -a
例2：列出某个目录的内容。 
$ ls –F /home/xu Mai1/ 

例3：列出某个目录下所有的文件（包括隐藏文件）。
$ 1s -aF /home/xu

例4：用长格式列出某个目录下所有的文件（包括隐藏文件）。
$ 1s -laF /home/xu

例5：用长格式列出某个目录下所有的文件包括隐藏文件和它们的i节点号。并把文件属主和属组以UID号和GID号的形式显示。
$ 1s -1ainF /home/xu tota1 584 399672 

有三种不同类型的用户可对文件或目录进行访问：文件所有者，同组用户、其他用户。所有者一般是文件的创建者。所有者可以允许同组用户有权访问文件，还可以将文件的访问权限赋予系统中的其他用户。在这种情况下，系统中每一位用户都能访问该用户拥有的文件或目录。
每一文件或目录的访问权限都有三组，每组用三位表示，分别为文件属主的读、写和执行权限；与属主同组的用户的读、写和执行权限；系统中其他用户的读、写和执行权限。当用ls -l命令显示文件或目录的详细信息时，最左边的一列为文件的访问权限。例如：
$ ls -l sobsrc. tgz
-rw-r--r-- 1 root root 483997 Ju1 l5 17:3l sobsrc. tgz
横线代表空许可。r代表只读，w代表写，x代表可执行。注意这里共有10个位置。第一个字符指定了文件类型。在通常意义上，一个目录也是一个文件。如果第一个字符是横线，表示是一个非目录的文件。如果是d，表示是一个目录。
例如：
- 　 rw- 　 r-- 　 r-- 
普通文件 文件主 组用户 其他用户 
是文件sobsrc.tgz 的访问权限，表示sobsrc.tgz是一个普通文件；sobsrc.tgz的属主有读写权限；与sobsrc.tgz属主同组的用户只有读权限；其他用户也只有读权限。
确定了一个文件的访问权限后，用户可以利用Linux系统提供的chmod命令来重新设定不同的访问权限。也可以利用chown命令来更改某个文件或目录的所有者。利用chgrp命令来更改某个文件或目录的用户组。