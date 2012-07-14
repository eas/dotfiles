#!/bin/bash
if [ "$0" == "/bin/bash" ]; then
    echo "Run this script, not source it!"
    return
fi

cd "$(dirname "$0")"
git pull
function doIt() {
    rsync --exclude ".git/" --exclude "bootstrap.sh" -av . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt
    fi
fi
unset doIt

echo -e "\n[ -f ~/.bashrc.$(whoami) ] && source ~/.bashrc.$(whoami)" >>~/.bashrc

# Vim config
git clone https://github.com/eas/dotvim.git ~/.vim
cd ~/.vim
git submodule init
git submodule update
echo "runtime vimrc" > ~/.vimrc

# Need to source new bashrc
echo -e "Please type:\nsource ~/.bashrc"
