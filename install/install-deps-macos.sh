# Get an initial package list with 'brew bundle dump' before and save the created Brewfile in '$DOTFILES/install/Brewfile'

#!/bin/sh

echo "Installing brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing packages..."
brew bundle --file $DOTFILES/install/Brewfile
