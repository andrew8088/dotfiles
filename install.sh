source ./homebrew-setup.sh

ln -s "$PWD/zshrc" "$HOME/.zshrc"
ln -s "$PWD/vimrc" "$HOME/.vimrc"
ln -s "$PWD/vim" "$HOME/.vim"
ln -s "$PWD/tmux.conf" "$HOME/.tmux.conf"
ln -s "$PWD/teamocil" "$HOME/.teamocil"
ln -s "$PWD/gitignore" "$HOME/.gitignore"

mkdir -p "$home/.config"
ln -s "$PWD/nvim" "$HOME/.config/nvim"

gem install teamocil
