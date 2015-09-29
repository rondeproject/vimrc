#!/bin/bash

readonly VIM_DIR=$HOME/.vim

# .vimディレクトリがない場合はエラー
if [ ! -d $VIM_DIR -a ! -d $VIM_DIR/.git ]; then
	echo "not found $VIM_DIR"
	echo "git clone http://github.com/rondeproject/vimrc.git $VIM_DIR"
	exit
fi

# git 設定
pushd $VIM_DIR >/dev/null
git config --local user.name Ronde
git config --local user.email none
popd >/dev/null


