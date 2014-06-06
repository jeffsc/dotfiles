" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 May 28
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

"let $VIMRUNTIME="/usr/local/share/vim/vim63"

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

let vimspell_loaded = 1

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent		" always set autoindenting on
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set backupdir=~/.vim-backup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

set bs=2	" allow backspaciing over everything in insert mode
set sts=4	" tab stop at 4 spaces
set sw=4	" tab indents at 4 spaces
set tabstop=4   " hard tabs are 4 spaces
set expandtab


" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

function InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~'\k'
	return "\<tab>"
    else
	return "\<c-p>"
    endif
endfunction

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  call pathogen#infect()

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  "  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd FileChangedShell *
    \ echoh1 WarningMsg |
    \ echo "File has been changed outside of vim." |
    \ echoh1 None

  autocmd BufNewFile,BufRead *.cc,*.cpp,*.h,*.hh,*.java :FOLD


  autocmd BufRead *.as set filetype=actionscript
  autocmd BufRead *.mxml set filetype=mxml
  autocmd BufRead *.erb set filetype=eruby
  autocmd BufNewFile,BufRead *.cc,*.cpp,*.h,*.hh,*.java set cinoptions+=(0
  autocmd BufRead,BufNewFile *.js set ft=javascript.jquery
  autocmd BufRead,BufNewFile *.sass set filetype=sass
  au BufRead,BufNewFile *.scala set filetype=scala
  au! Syntax scala source ~/.vim/syntax/scala.vim
  au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
  au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

  autocmd FileType c inoremap <tab> <c-r>=InsertTabWrapper()<cr>
  autocmd FileType cpp inoremap <tab> <c-r>=InsertTabWrapper()<cr>
  autocmd FileType java inoremap <tab> <c-r>=InsertTabWrapper()<cr>
  autocmd FileType perl inoremap <tab> <c-r>=InsertTabWrapper()<cr>
  autocmd FileType javascript.jquery inoremap <tab> <c-r>=InsertTabWrapper()<cr>
  autocmd FileType coffee inoremap <tab> <c-r>=InsertTabWrapper()<cr>
  autocmd FileType ruby,eruby inoremap <tab> <c-r>=InsertTabWrapper()<cr>

  autocmd FileType xml set sw=2 sts=2
  autocmd FileType sass set sw=2 sts=2

  "autocmd User Rails set sw=4 sts=4
  autocmd FileType mason set filetype=eruby
  autocmd FileType ruby,eruby,html set sw=2 sts=2

  " Don't screw up folds when inserting text that might affect them, until
  " leaving insert mode. Foldmethod is local to the window. Protect against
  " screwing up folding when switching between windows.
  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
   autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
endif " has("autocmd")

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,sjis,euc-jp

set laststatus=2
set statusline=%f%y%{GetStatusEx()}%m%r%=%l/%L,%c
function! GetStatusEx()
    let str = ' [' . &fileformat
    if has('multi_byte') && &fileencoding != ''
	let str = str . ':' . &fileencoding
    endif
    let str = str . '] '
    return str
endfunction

map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

nmap <silent> <C-N> :silent noh<cr>

"set listchars=tab:ｻｷ,trail:ｷ
"set list

" use for scrolling through error messages from "make"
map <C-down> :cn<CR>
map <C-up> :cp<CR>

"set shellslash
"set nohlsearch
set showmatch
set autoread
let perl_fold=1
set vb t_vb=

let loaded_matchparen=1
set synmaxcol=150

"visible tabs
set list
set listchars=tab:>-,trail:-

colorscheme nightshimmer-mod
set ww=<,>,[,],~,l,h,s,b

"set gfn=Monaco:h12

set wildignore+=.git,vendor/**,*.jpg,*.png,*.gif,Gemfile*,dev-server/**,tmp/**,**/tiny_mce/**,public/packages/**,node_modules/**,lib/**.js,build/**
let g:CommandTMatchWindowReverse=1
map E :CommandT<CR>
map B :CommandTBuffer<CR>

" Remap increment/decrement
:nnoremap <A-a> <C-a>
:nnoremap <A-x> <C-x>
