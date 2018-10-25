
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'mhartington/oceanic-next' " oceanic color scheme
Plug 'vim-airline/vim-airline'
Plug 'wellle/targets.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --racer-completer' }
Plug 'Raimondi/delimitMate'
Plug 'junegunn/fzf', { 'dir': '~/.build/fzf', 'do': './install --all' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tpope/vim-commentary'
Plug 'rhysd/vim-clang-format'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround' " add and modify surrounding characters
Plug 'tpope/vim-abolish' " converting snake_case, CamelCase etc
Plug 'tpope/vim-repeat' " integrate repeating plugin commands
Plug 'mhinz/vim-grepper'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rust-lang/rust.vim'
Plug 'w0rp/ale'
call plug#end()

let mapleader = ","

set clipboard=unnamedplus

let g:python_host_prog='/usr/bin/python' " setting manually speeds up startup time
let g:ycm_show_diagnostics_ui = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

let g:ale_c_parse_compile_commands = 1
let g:ale_c_build_dir_names = ['build', 'build_debug']
let g:ale_cpp_clangtidy_checks = ['cppcoreguidelines*', 'bugprone*', 'modernize*', 'performance*']
let g:ale_cpp_cppcheck_options = '--enable=style --suppress=passedByValue'
let g:ale_linters = {
      \ 'cpp': ['cppcheck', 'clangtidy', 'clangcheck']
      \}

" set file locations
set directory=~/.config/nvim/swapfiles//
set undodir=~/.config/nvim/undofiles/
set undofile

if (has("termguicolors"))
  set termguicolors
endif

syntax enable
" appearance options
colorscheme OceanicNext
let g:airline_theme='oceanicnext'
set guifont=Fira\ Code\ Light:h11
" set macligatures
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
nnoremap <c-p> :FZF<cr>

inoremap ii <Esc>

set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let g:ycm_confirm_extra_conf = 0
let g:ycm_enable_diagnostic_hightlighting = 0
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_open_loclist_on_ycm_diags = 1

" YCM and Ultisnips compatibility
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


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

nmap <leader>1 1gt<cr>
nmap <leader>2 2gt<cr> 
nmap <leader>3 3gt<cr>
nmap <leader>4 4gt<cr>
nmap <leader>5 5gt<cr>
nmap <leader>6 6gt<cr>
nmap <leader>7 7gt<cr>
nmap <leader>8 8gt<cr>
nmap <leader>9 9gt<cr>

autocmd BufWritePre * call ReplaceCopyrightYear()

" YouCompleteMe settings
nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>

let g:clang_format#detect_style_file = 1
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>af :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>af :ClangFormat<CR>
autocmd FileType rust nnoremap <buffer><Leader>af :<C-u>RustFormat<CR>
autocmd FileType rust vnoremap <buffer><Leader>af :RustFormat<CR>

" Treat sconscript files as python
autocmd BufReadPre SCons* set filetype=python
autocmd BufNewFile SCons* set filetype=python

" Treat VS project files as xml
autocmd BufReadPre *.vcxproj set filetype=xml
autocmd BufReadPre *.vcxproj.filters set filetype=xml

