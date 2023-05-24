#!/bin/bash
var1=20
var2=22
[ "$var1" -ne "$var2" ] && echo "$var1 is not equal to $var2"

home=/home/bozo
[ -d "$home" ] || echo "$home directory does not exist."

# 文件测试操作
# -b 文件是一个块设备
device0="/dev/sda" # /   (根目录)
if [ -b "$device0" ]; then
	echo "$device0 is a block device."
fi
# /dev/sda2 是一个块设备。

# -c 文件是一个字符设备
device1="/dev/ttyS1" # PCMCIA 调制解调卡
if [ -c "$device1" ]; then
	echo "$device1 is a character device."
fi
# /dev/ttyS1 是一个字符设备。

# -p 文件是一个管道设备
function show_input_type() {
	[ -p /dev/fd/0 ] && echo PIPE || echo STDIN
}

show_input_type "Input"        # STDIN
echo "Input" | show_input_type # PIPE

echo "判断字符串非空推荐if [ "\$string1" ]; then"
if [ "$string1" ]; then # 这次只有一个 $string1。
	echo "String \"string1\" is not null."
else
	echo "String \"string1\" is null."
fi # 结果正确。
# 独立的 [ ... ] 测试运算符可以用来检测字符串是否为空。
# 但是最好将字符串进行引用（if [ "$string1" ]）。
#
# Stephane Chazelas 指出：
#    if [ $string1 ]    只有一个参数 "]"
#    if [ "$string1" ]  则有两个参数，空的 "$string1" 和 "]"
echo

# 短路现象
# -n 检查字符串非空
[ 1 -eq 1 ] && [ -n "$(echo true 1>&2)" ] # 真
[ 1 -eq 2 ] && [ -n "$(echo true 1>&2)" ] # 没有输出
# ^^^^^^^ 条件为假。到这里为止，一切都按预期执行。

# 但是
[ 1 -eq 2 -a -n "$(echo true 1>&2)" ] # 真
# ^^^^^^^ 条件为假。但是为什么结果为真？

# 是因为括号内的两个条件子句都执行了么？
[[ 1 -eq 2 && -n "$(echo true 1>&2)" ]] # 没有输出
# 并不是。

#  所以显然 && 和 || 具备“短路”机制，
#+ 例如对于 &&，若第一个表达式为假，则不执行第二个表达式直接返回假，
#+ 而 -a 和 -o 则不是。
