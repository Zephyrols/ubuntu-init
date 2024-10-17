#!/bin/bash

LOG_FILE=".ConfigSourcelist.log"

logout(){
    echo -e "\033[32m[source.list配置]: $1\033[0m" | tee -a $LOG_FILE
}

logerr(){
    echo -e "\033[31m[source.list配置]: $1\033[0m" | tee -a $LOG_FILE
}

rm -f $LOG_FILE 

# 获取Ubuntu版本代号
source /etc/os-release

# 步骤1: 备份当前的sources.list
logout "备份当前的APT源 /etc/apt/sources.list -> /etc/apt/sources.list.bak"
if [ -f /etc/apt/sources.list.bak ]; then
    logout "/etc/apt/sources.list.bak 已存在"
else
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
fi

# 步骤2: 配置清华源
logout "正在配置清华大学的APT源..."
sudo sed -i "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list
sudo sed -i "s/cn.mirrors.tuna/mirrors.tuna/g" /etc/apt/sources.list

# 步骤3: 更新apt源
logout "更新APT源... "
sudo apt-get update
EXIT_STATUS=$?

# 步骤4: 检查配置是否成功
if [ $EXIT_STATUS -ne 0 ]; then
    logerr "配置失败: 更新APT源失败"
    cat .tmp
    exit 1
else
    logout "更新APT源成功"
    logout "配置成功"
    rm .tmp
fi