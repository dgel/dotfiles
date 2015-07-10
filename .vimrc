set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
"Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-commentary'

" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
set laststatus=2
set number
syntax enable
set background=dark
colorscheme solarized
let g:airline_theme='kolor'
let mapleader = ","

set modelines=0
set encoding=utf-8
set scrolloff=3
set autoindent
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set backspace=indent,eol,start
set relativenumber
set undofile

nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set formatoptions=qrn1

nnoremap <leader><space> :noh<cr>

" Syntastic settings
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_cpp_checkers = ['cppcheck', 'gcc']
"let g:syntastic_c_checkers = ['cppcheck', 'gcc']

" YouCompleteMe settings
" nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nnoremap <leader>gt :YcmCompleter GetType<CR>
" let g:ycm_confirm_extra_conf = 0
" let g:ycm_enable_diagnostic_hightlighting = 0
" let g:ycm_enable_diagnostic_signs = 1
" let g:ycm_always_populate_location_list = 1
" let g:ycm_open_loclist_on_ycm_diags = 1

set hlsearch
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Treat sconscript files as python
autocmd BufReadPre SCons* set filetype=python
autocmd BufNewFile SCons* set filetype=python

