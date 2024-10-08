#!/bin/bash

LOG_FILE=".RemoveSnap.log"

logout(){
    echo -e "\033[32m[卸载snap]: $1\033[0m" | tee -a $LOG_FILE
}

logerr(){
    echo -e "\033[31m[卸载snap]: $1\033[0m" | tee -a $LOG_FILE
}

rm -f $LOG_FILE

# 获取当前安装的所有snap包的列表
hasSnap=$(command -v snap)
if [ -z "$hasSnap" ]; then
    logout "没有安装snap程序，退出。"
    exit 0
fi

snap_list=$(snap list | awk '{if(NR>1) print $1}')
while [ ! -z "$snap_list" ]; do
    # 检查是否有正在进行的snap操作
  while snap changes | grep -q "Doing"; do
    logout "等待正在进行的snap操作完成..."
    sleep 5
  done
  # 遍历snap_list，卸载每个包
  for snap in $snap_list; do
      logout "正在卸载$snap..."
      sudo snap remove --purge "$snap"

      if [ $? -ne 0 ]; then
          logerr "卸载$snap失败。"
      fi
  done
  snap_list=$(snap list | awk '{if(NR>1) print $1}')
done

logout "所有snap程序已卸载完成。"

# 卸载snapd服务
logout "正在卸载snapd服务..."
sudo apt remove --autoremove snapd -y

# 清理所有相关目录
logout "正在清理所有snap相关目录..."

set -x
sudo rm -rf ~/snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
sudo rm -rf /var/cache/snapd
sudo rm -rf /usr/lib/snapd
set +x

logout "snap及其所有组件已完全卸载。"

# 禁用snapd源
logout "正在禁用snapd源..."
sudo tee /etc/apt/preferences.d/no-snap.pref <<EOF
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF

if [ $? -eq 0 ]; then
    logout "禁用snapd源成功。"
else
    logerr "禁用snapd源失败。"
fi

# 更新apt源
logout "更新APT源..."
sudo apt-get update

if [ $? -eq 0 ]; then
    logout "更新APT源成功"
else
    logerr "更新APT源失败"
fi

# 安装gnome-software
sudo apt install gnome-software -y

if [ $? -eq 0 ]; then
    logout "安装gnome-software成功"
else
    logerr "安装gnome-software失败"
fi

# 重启gnome-software
logout "重启gnome-software..."
killall gnome-software
gnome-software

if [ $? -eq 0 ]; then
    logout "重启gnome-software成功"
else
    logerr "重启gnome-software失败"
fi

logout "snap已完全卸载，gnome-software已重启。"