source ./homebrew-setup.sh

ln -s "$PWD/zshrc" "$HOME/.zshrc"
ln -s "$PWD/vimrc" "$HOME/.vimrc"
ln -s "$PWD/vim" "$HOME/.vim"
ln -s "$PWD/tmux" "$HOME/.tmux"
ln -s "$PWD/tmux.conf" "$HOME/.tmux.conf"
ln -s "$PWD/teamocil" "$HOME/.teamocil"
ln -s "$PWD/gitignore" "$HOME/.gitignore"
ln -s "$PWD/p10k.sh" "$HOME/.p10k.sh"

mkdir -p "$home/.config"
ln -s "$PWD/config/nvim" "$HOME/.config/nvim"
ln -s "$PWD/config/alacritty" "$HOME/.config/alacritty"

gem install teamocil

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

nvm install latest
nvm use latest

npm install -g git-branch-utils
