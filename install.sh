#!/bin/bash

readonly VIM_DIR=$HOME/.vim
readonly VIM_FILE=$HOME/.vimrc

# .vimディレクトリがない場合はエラー
if [ ! -d $VIM_DIR -a ! -d $VIM_DIR/.git ]; then
	echo "not found $VIM_DIR"
	echo "git clone http://github.com/rondeproject/vimrc.git $VIM_DIR"
	exit
fi

# .vimrcをリンク
if [ -f $VIM_DIR/.vimrc -a ! -f $VIM_FILE ]; then
	ln -s $VIM_DIR/.vimrc $VIM_FILE
fi

# git 設定
git config --local user.name Ronde
git config --local user.email none


