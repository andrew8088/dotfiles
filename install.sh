ln -s "$PWD/zshrc" "$HOME/.zshrc"
ln -s "$PWD/vimrc" "$HOME/.vimrc"
ln -s "$PWD/vim" "$HOME/.vim"
ln -s "$PWD/tmux.conf" "$HOME/.tmux.conf"
ln -s "$PWD/teamocil" "$HOME/.teamocil"
ln -s "$PWD/gitignore" "$HOME/.gitignore"

ln -s "$PWD/zsh/pure/pure.zsh"  /usr/local/share/zsh/site-functions/prompt_pure_setup
ln -s "$PWD/zsh/pure/async.zsh" /usr/local/share/zsh/site-functions/async

gem install teamocil
