
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    source ./setup-linux.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
    source ./setup-mac.sh
fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

nvm install latest
nvm use latest

npm install -g git-branch-utils
