#!/bin/sh
git clone https://github.com/nekoya/dotfiles_compact.git ~/dotfiles
SELF_DIR=~/dotfiles

copy() {
echo "copy: $1"
cp -a ${SELF_DIR}/$1 ~
}

make_dir() {
if [ ! -d ~/$1 ]; then
    echo "mkdir: $1"
    mkdir $1
fi
}

# zsh
copy .zshrc

# vim
copy .vimrc
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
~/.vim/bundle/neobundle.vim/bin/neoinstall

# git
make_dir ~/bin
install -m 0755 /usr/share/doc/git/contrib/diff-highlight/diff-highlight ~/bin/
copy .gitconfig

# ssh
install -d -m 0755 ~/.ssh
echo "StrictHostKeyChecking no\n" > ~/.ssh/config
chmod 600 ~/.ssh/config

# tmux
copy .tmux.conf
