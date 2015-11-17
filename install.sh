#!/bin/sh
git clone https://github.com/nekoya/dotfiles_compact.git ~/dotfiles
SELF_DIR=~/dotfiles

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
make_dir ~/bin
install -m 0755 /usr/share/doc/git/contrib/diff-highlight/diff-highlight ~/bin/
copy .gitconfig

# ssh
copy .ssh

# tmux
copy .tmux.conf
