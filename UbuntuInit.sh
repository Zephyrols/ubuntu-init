#!/bin/bash

# 获取脚本自身所在的文件夹
SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

echo "脚本所在的文件夹是: $SCRIPT_DIR"

bash ./ConfigSourelist.sh
bash ./RemoveSnap.sh
bash ./InstallAnaconda.sh

cp $SCRIPT_DIR/.vimrc $HOME/.vimrc