#!/bin/sh

cd ~/dotfiles
git submodule update --init --recursive
git clone https://github.com/gmarik/vundle vim/bundle/vundle
