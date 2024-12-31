#!/bin/bash

# 获取脚本自身所在的文件夹
SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

echo "脚本所在的文件夹是: $SCRIPT_DIR"

# 添加选项用 1 2 3 4 选择配置项，直到选择0 退出 h或help 显示帮助信息

help='
选择配置项:
1. 配置APT源
2. 移除Snap
3. 安装Anaconda
4. 安装并配置zsh
5. 安装并配置vim
a. 全部配置
h. 显示帮助信息
0. 退出
'


pushd $SCRIPT_DIR
echo $help
while true; do
    read -p "请输入选项: " choice
    case $choice in
        1)
            bash ./ConfigSourelist.sh
            echo "APT源配置完成"
            ;;
        2)
            bash ./RemoveSnap.sh
            echo "Snap已移除"
            ;;
        3)
            bash ./InstallAnaconda.sh
            echo "Anaconda已安装"
            ;;
        4)
            bash ./ConfigZsh.sh
            echo "zsh已安装并配置完成"
            ;;
        5)
            bash ./ConfigVim.sh
            echo "vim已安装并配置完成"
            ;;
        a|all)
            bash ./ConfigSourelist.sh
            bash ./RemoveSnap.sh
            bash ./InstallAnaconda.sh
            bash ./ConfigZsh.sh
            bash ./ConfigVim.sh
            echo "全部配置完成"
            ;;
        h|help)
            echo $help
            ;;
        0)
            echo "退出"
            break
            ;;
        *)
            echo "无效的选择"
            ;;
    esac
done
popd