#!/bin/bash
# 使用 (( )) 进行算术测试
# (( ... )) 结构执行并测试算术表达式。
# 与 [ ... ] 结构的退出状态正好相反。

(( 0 ))
echo "Exit status of \"(( 0 ))\" is $?."         # 1

(( 1 ))
echo "Exit status of \"(( 1 ))\" is $?."         # 0

(( 5 > 4 ))                                      # 真
echo "Exit status of \"(( 5 > 4 ))\" is $?."     # 0

(( 5 > 9 ))                                      # 假
echo "Exit status of \"(( 5 > 9 ))\" is $?."     # 1

(( 5 == 5 ))                                     # 真
echo "Exit status of \"(( 5 == 5 ))\" is $?."    # 0
# (( 5 = 5 )) 会报错。

(( 5 - 5 ))                                      # 0
echo "Exit status of \"(( 5 - 5 ))\" is $?."     # 1

(( 5 / 4 ))                                      # 合法
echo "Exit status of \"(( 5 / 4 ))\" is $?."     # 0 

(( 1 / 2 ))                                      # 结果小于1
echo "Exit status of \"(( 1 / 2 ))\" is $?."     # 舍入至0。
                                                 # 1

(( 1 / 0 )) 2>/dev/null                          # 除0，非法
#           ^^^^^^^^^^^
echo "Exit status of \"(( 1 / 0 ))\" is $?."     # 1

# "2>/dev/null" 的作用是什么？
# 如果将其移除会发生什么？
# 尝试移除这条语句并重新执行脚本。

# ======================================= #

# (( ... )) 在 if-then 中也非常有用

var1=5
var2=4

if (( var1 > var2 ))
then #^      ^      注意不是 $var1 和 $var2，为什么？
  echo "$var1 is greater then $var2"
fi     # 5 大于 4

exit 0
