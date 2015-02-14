#!/bin/bash

readonly VIM_DIR=$HOME/.vim
readonly VIM_FILE=$HOME/.vimrc

# .vimディレクトリがない場合はエラー
if [ ! -d $VIM_DIR ]; then
	echo "not found $VIM_DIR"
	echo "git clone http://github.com/rondeproject/vimrc.git $VIM_DIR"
	exit
fi

# .vimrcをリンク
if [ -f $VIM_DIR/.vimrc -a ! -f $VIM_FILE ]; then
	ln -s $VIM_DIR/.vimrc $VIM_FILE
fi

# 日本語helpのインストール
mkdir -p $VIM_DIR/temp
pushd $VIM_DIR/temp
wget https://github.com/vim-jp/vimdoc-ja/archive/master.zip
unzip master.zip
cp -a vimdoc-ja-master/doc $VIM_DIR
cp -a vimdoc-ja-master/syntax $VIM_DIR
popd > /dev/null
rm -rf $VIM_DIR/temp

