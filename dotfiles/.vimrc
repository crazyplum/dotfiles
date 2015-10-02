set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasr/molokai'

call vundle#end()            " required
filetype plugin indent on    " required

" setting for solarized theme
set nu
syntax enable
colorscheme molokai

" other setting

set cursorline

" size of a hard tabstop
set ts=4

" size of an indent
set sw=4

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4

" make tab insert indents instead of tabs at the beginning of a line
set smarttab

" always uses spaces instead of tab characters
set expandtab





