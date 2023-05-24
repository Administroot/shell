#!/bin/bash
# Lee bigelow <ligelowbee@yahoo.com> 编写。
# ABS Guide 经许可可以使用。

#  该脚本用来发现输出损坏的链接。输出的结果是被引用的，
#+ 所以可以直接导到 xargs 中进行处理 ：）
#  例如：sh broken-link.sh /somedir /someotherdir|xargs rm
#
#  更加优雅的方式：
#
#  find "somedir" -type 1 -print0|\
#  xargs -r0 file|\
#  grep "broken symbolic"|
#  sed -e 's/^\|: *broken symbolic.*$/"/g'
#
#  但是这种方法不是纯 Bash 写法。
#  警告：小心 /proc 文件下的文件和任意循环链接！
############################################

#  如果不给脚本传任何参数，那么 directories-to-search 设置为当前目录
#+ 否则设置为传进的参数
#####################

[ $# -eq 0 ] && directory=$(pwd) || directory=$@

#  函数 linkchk 是用来检测传入的文件夹中是否包含损坏的链接文件，
#+ 并引用输出他们。
#  如果文件夹中包含子文件夹，那么将子文件夹继续传给 linkchk 函数进行检测。
#################

linkchk() {
	for element in $1/*; do
		[ -h "$element" -a ! -e "$element" ] && echo \"$element\"
		# 判断当前元素是否为符号链接且指向的文件不存在，如果是则输出该元素
		[ -d "$element" ] && linkchk $element
		# 判断当前元素是否为目录，如果是则递归调用 linkchk 函数
		# -h 用来检测是否是链接，-d 用来检测是否是文件夹。
		# -a 检测文件是否存在 ; -e 同理。已被弃用
	done
}

#  检测传递给 linkchk() 函数的参数是否是一个存在的文件夹，
#+ 如果不是则报错。
################
# echo $direcotrys
for dir in $directory; do
	echo "dir=$dir"
	if [ -d $dir ]; then
		linkchk $dir
	else
		echo "$dir is not a directory"
		echo "Usage $0 dir1 dir2 ..."
	fi
done

exit $?
