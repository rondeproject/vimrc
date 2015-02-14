#!/bin/bash

if [ ! -d $HOME/.vim ]; then
	echo "not found .vim"
	echo "git clone http://github.com/rondeproject/vimrc.git $HOME/.vim"
	exit
fi

# NeoBundle用ディレクトリ作成
mkdir -p ~.vim/bundle

# NeoBundleのインストール
if [ ! -d ~/.vim/bundle/neobundle.vim ]; then
	git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

# .vimrcをリンク
if [ -f $HOME/.vim/.vimrc ]; then
	ln -s $HOME/.vim/.vimrc $HOME/.vimrc
fi
