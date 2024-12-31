sudo apt install zsh
chsh -s $(which zsh)
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# 拷贝主题
cp config/haoomz.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/haoomz.zsh-theme

# 修改主题
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="haoomz"/' ~/.zshrc

# 自动补全插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# 语法校验插件
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 添加插件
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

