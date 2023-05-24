#!/bin/bash
# zmore

# 使用筛选器 'more' 查看 gzipped 文件。

E_NOARGS=85
E_NOTFOUND=86
E_NOTGZIP=87

if [ $# -eq 0 ]; then # 作用和 if [ -z "$1" ] 相同。
	# $1 可以为空： zmore "" arg2 arg3
	echo "Usage: $(basename $0) filename" >&2
	# 将错误信息通过标准错误 stderr 进行输出。
	exit $E_NOARGS
	# 脚本的退出状态为 85.
fi

filename=$1

if [ ! -f "$filename" ]; then         # 引用字符串以防字符串中带有空格。
	echo "File $filename not found!" >&2 # 通过标准错误 stderr 进行输出。
	exit $E_NOTFOUND
fi

if [ ${filename##*.} != "gz" ]; then # 在括号内使用变量代换。
	echo "File $1 is not a gzipped file!"
	exit $E_NOTGZIP
fi

zcat $1 | more

# 使用筛选器 'more'
# 也可以用 'less' 替代

exit $? # 脚本的退出状态由管道 pipe 的退出状态决定。
#  实际上 "exit $?" 不一定要写出来，
#+ 因为无论如何脚本都会返回最后执行命令的退出状态。
