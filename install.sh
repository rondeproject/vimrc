#!/bin/bash

# .vimディレクトリがない場合はエラー
if [ ! -d $HOME/.vim ]; then
	echo "not found .vim"
	echo "git clone http://github.com/rondeproject/vimrc.git $HOME/.vim"
	exit
fi

# NeoBundleのインストール
if [ ! -d $HOME/.vim/bundle/neobundle.vim ]; then
	mkdir -p $HOME/.vim/bundle
	git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
fi

# .vimrcをリンク
if [ -f $HOME/.vim/.vimrc ]; then
	ln -s $HOME/.vim/.vimrc $HOME/.vimrc
fi
