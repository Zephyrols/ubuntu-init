# 下载 Anaconda 安装脚本
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O anaconda.sh

# 运行安装脚本
bash anaconda.sh -b -p $HOME/anaconda3
rm anaconda.sh

$HOME/anaconda3/bin/conda init --all