
 if [[ "$OSTYPE" == "linux-gnu"* ]]; then
     source ./install-deps-linux.sh
 elif [[ "$OSTYPE" == "darwin"* ]]; then
     source ./install-deps-macos.sh
 fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0

. $HOME/.asdf/asdf.sh

asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs $(asdf list nodejs | tail -1 | sed 's/^ *//g')

npm install -g git-branch-utils
