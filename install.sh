#!/bin/sh
git clone git@github.com:nekoya/dotfiles_compact ~/dotfiles
SELF_DIR=~/dotfiles

set_symlink() {
if [ ! -e ~/$1 ]; then
    echo "set symlink: $1"
    ln -s ${SELF_DIR}/$1 ~
fi
}

copy() {
if [ ! -e ~/$1 ]; then
    echo "copy: $1"
    cp -a ${SELF_DIR}/$1 ~
fi
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
mkdir ~/bin
install -m 0755 /usr/share/doc/git/contrib/diff-highlight/diff-highlight ~/bin/
set_symlink .gitconfig

# ssh
copy .ssh

# tmux
set_symlink .tmux.conf
