# Dotfiles

## Install

```
git clone <this-repo>
cd <this-repo>
./scripts/bootstrap.sh
```

## Local ZSH Config

If there's customization you want ZSH to load on startup that is specific to 
this machine (stuff you don't want to commit into the repo), create `~/.env.sh`
and put it in there. It will be loaded near the top of `.zshrc`.
