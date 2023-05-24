#!/bin/bash
#特殊字符
#逗号运算符。逗号运算符将一系列的算术表达式串联在一起。算术表达式依次被执行，但只返回最后一个表达式的值。
let "t2 = ((a = 9, 15 / 3))"
# a被赋值为9，t2被赋值为15 / 3
echo "a=$a t2=$t2"
# a=9 t2=5

# 逗号运算符也可以连接字符串
for file in /{,usr/}bin/*sh
#             ^    在 /bin 与 /usr/bin 目录中
#+                 找到所有的以"sh"结尾的可执行文件
do
        if [ -x "$file" ]
        then
          echo $file
        fi
done

# /bin/zsh
# /usr/bin/bash
# /bin/bash

# 冒号
: ${username=`whoami`}
# ${username=`whoami`}   如果没有:就会报错
#                        除非 "username" 是系统命令或内建命令

# : ${1?"Usage: $0 ARGUMENT"}     # 摘自样例脚本 "usage-message.sh"

echo "如果HOSTNAME USER MAIL 其中一个变量没有设置值将会报错"
HOSTNAME="MY_COMPUTER"
USER="USER"
MAIL="111@foxmail.com"
: ${HOSTNAME?} ${USER?} ${MAIL?}
#  如果其中一个或多个必要的环境变量没有被设置
#  将会打印错误

echo "与>>重定向操作符结合，将不会清空任何已存在的文件（: >> target_file）。如果文件不存在，将创建这个文件。"
: >> tmpfile.txt

# ? 问号
var1=100
(( var0 = var1<98?9:21 ))
echo "var0=$var0 var1=$var1"
#不要加空格，紧挨着写

#等价于
# if [ "$var1" -lt 98 ]
# then
#   var0=9
# else
#   var0=21
# fi

# () 括号 命令组
# 通过括号执行一系列命令会产生一个子shell（subshell）。 括号中的变量，
# 即在子shell中的变量，在脚本的其他部分是不可见的。
# 父进程脚本不能访问子进程（子shell）所创建的变量。
a=123
( a=321; )

echo "a = $a"   # a = 123
# 在括号中的 "a" 就像个局部变量。

# {}花括号 扩展结构
echo \"{These,words,are,quoted}\"   # " 将作为单词的前缀和后缀
# "These" "words" "are" "quoted"

# cat {file1,file2,file3} > tmp.txt
# 将 file1, file2 与 file3 拼接在一起后写入 tmp.txt 中。

# cp file22.{txt,backup}
# 将 "file22.txt" 拷贝为 "file22.backup"

# {}也可以用于文本占位符
# 文本占位符。在 xargs -i 后作为输出的占位符使用。
ls . | xargs -i -t cp ./{} $1
#            ^^         ^^
# 摘自 "ex42.sh" (copydir.sh)
