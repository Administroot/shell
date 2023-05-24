#!/bin/bash
#使用双引号可以防止字符串被分割。即使参数中拥有很多空白分隔符，被包在双引号中后依旧是算作单一字符。
List="one two three"

for a in $List     # 空白符将变量分成几个部分。
do
  echo "$a"
done
# one
# two
# three

echo "---"

for a in "$List"   # 在单一变量中保留所有空格。
do #     ^     ^
  echo "$a"
done
# one two three
