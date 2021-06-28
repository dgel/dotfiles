
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'wellle/targets.vim'
Plug 'Raimondi/delimitMate'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-commentary'
Plug 'rhysd/vim-clang-format'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround' " add and modify surrounding characters
Plug 'tpope/vim-abolish' " converting snake_case, CamelCase etc
Plug 'tpope/vim-repeat' " integrate repeating plugin commands
Plug 'mhinz/vim-grepper'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rust-lang/rust.vim'
Plug 'w0rp/ale'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'cloudhead/neovim-fuzzy'
Plug 'lervag/vimtex'
Plug 'mbbill/undotree'
call plug#end()

" exrc allows loading local executing local rc files.
set exrc
" seruce disallows the use of :autocmd, shell and write commands in local
" .vimrc files.
set secure

let mapleader = ","

set clipboard=unnamedplus

let g:python_host_prog='/usr/bin/python' " setting manually speeds up startup time

let g:ale_c_parse_compile_commands = 1
let g:ale_c_build_dir_names = ['build', 'build_debug']
let g:ale_cpp_clangtidy_executable = 'clang-tidy-8'
let g:ale_cpp_clangcheck_executable = 'clang-check-8'
let g:ale_cpp_cppcheck_options = '--enable=style --suppress=passedByValue'
let g:ale_linters = {
      \ 'cpp': ['cppcheck', 'clangtidy'],
      \ 'python': []
      \}
let g:ale_fixers = {
        'cpp': ['clangtidy'],
        'python': []
      }
let g:ale_virtualtext_cursor = 1
nnoremap <leader>? :ALEDetail<cr>

" set file locations
set directory=~/.config/nvim/swapfiles//
set undodir=~/.config/nvim/undofiles/
set undofile

if (has("termguicolors"))
  set termguicolors
endif

syntax enable
" appearance options
color dracula
set guifont=Fira\ Code\ Light:h11
set linespace=1

set laststatus=2 " always display status line

set number " show line numbers
set relativenumber " relative line numbering
set hidden " hide buffers
set scrolloff=5 " always show at least 5 lines around the cursor

set inccommand=split
set incsearch
set hlsearch
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set lazyredraw " redraw only when needed (not while executing macros)

let g:clang_format#command="clang-format-8"

nnoremap <leader>rg :Grepper -tool rg<cr>
nnoremap <c-p> :FuzzyOpen<cr>

inoremap ii <Esc>

set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let g:tex_flavor = 'latex'

function! ReplaceCopyrightYear()
  let curyear = strftime("%Y")
  let oldpos = getcurpos()
  call cursor(1,1)
  
  let yeardashpattern = '\(Copyright \d\{4\} - \)\(\d\{4\}\)\(\(,\)\? \)'
  let yearpattern = '\(Copyright \)\(\d\{4\}\)\(\(,\)\? \)'

  if search(yeardashpattern, '', line(".") + 5)
    if matchlist(getline("."), yeardashpattern)[2] < curyear
      execute ":,5s/" . yeardashpattern . "/\\1" . curyear . "\\3/"
    endif
  elseif search(yearpattern, '', line(".") + 5)
    if matchlist(getline("."), yearpattern)[2] < curyear
     execute ":,5s/" . yearpattern . "/\\1\\2 - " . curyear . "\\3/"
    endif
  endif
  call setpos(".", oldpos)
endfunction

autocmd BufWritePre * call ReplaceCopyrightYear()

" Treat sconscript files as python
autocmd BufReadPre SCons* set filetype=python
autocmd BufNewFile SCons* set filetype=python

" Treat VS project files as xml
autocmd BufReadPre *.vcxproj set filetype=xml
autocmd BufReadPre *.vcxproj.filters set filetype=xml

nnoremap <leader>gd :call CocAction('jumpDefinition')<CR>
nnoremap <leader>gc :call CocAction('jumpDeclaration')<CR>
nnoremap <leader>gi :call CocAction('jumpImplementation')<CR>
nnoremap <leader>gr :call CocAction('jumpReferences')<CR>
nnoremap <leader>gt :call CocAction('jumpTypeDefinition')<CR>
nnoremap <leader>rn :call CocAction('rename')<CR>
nnoremap <leader>af :call CocAction('format')<CR>
vnoremap <leader>af :call CocAction('formatSelected', 'V')<CR>


let g:clang_format#detect_style_file = 1
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>af :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>af :ClangFormat<CR>
autocmd FileType rust nnoremap <buffer><Leader>af :<C-u>RustFmt<CR>
autocmd FileType rust vnoremap <buffer><Leader>af :RustFmt<CR>

