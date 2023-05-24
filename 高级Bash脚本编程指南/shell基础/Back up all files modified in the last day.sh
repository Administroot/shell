#!/bin/bash

#  将当前目录下24小时之内修改过的所有文件备份成一个
#  "tarball" (经 tar 打包`与 gzip 压缩) 文件

BACKUPFILE=backup-$(date +%m-%d-%Y)
#                 在备份文件中嵌入时间
#                 感谢 Joshua Tschida 提供的建议

archive=${1:-$BACKUPFILE}
#  如果没有在命令行中特别制定备份格式，
#  那么将会默认设置为 "backup-MM-DD-YYYY.tar.gz"。

tar cvf - `find . -mtime -1 -type f -print` > $archive.tar
gzip $archive.tar
echo "Directory $PWD backed up in archive file \"$archive.tar.gz\"."

#  Stephane Chazeles 指出如果目录中有非常多的文件，
#  或文件名中包含空白符时，上面的代码会运行失败。

# 他建议使用以下的任意一种方法：
# -------------------------------------------------------------------
#   find . -mtime -1 -type f -print0 | xargs -0 tar rvf "$archive.tar"
#   使用了 GNU 版本的 "find" 命令。


#   find . -mtime -1 -type f -exec tar rvf "$archive.tar" '{}' \;
#   兼容其他的 UNIX 发行版，但是速度会比较慢
# -------------------------------------------------------------------


exit 0 
