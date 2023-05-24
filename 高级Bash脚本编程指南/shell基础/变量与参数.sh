# 摘自 /etc/rc.d/rc.local
R=$(cat /proc/version)
arch=$(uname -m)
echo "$R $arch"
