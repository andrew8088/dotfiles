set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim " required for Vundle
call vundle#begin() " required for Vundle
Plugin 'VundleVim/Vundle.vim'
Plugin 'chriskempson/base16-vim'

call vundle#end()         " required for Vundle
filetype plugin indent on " required for Vundle

set t_Co=256
syntax on
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-tomorrow

set noerrorbells 
set novisualbell
set t_vb=

" moving around, searching, and patterns ----------------------------------
set incsearch
set showmatch
set smartcase
set ignorecase
set gdefault 
" displaying text
set number
set linebreak
" syntax, highlighting, spelling
set hlsearch
set background=dark

" tabs and indenting ------------------------------------------------------
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set shiftround
" folding -----------------------------------------------------------------
set foldmethod=marker
set foldmarker={{{,}}}

" gui setings -------------------------------------------------------------
if has("gui")
	set guioptions-=T                             "hide toolbar in mvim
	set guioptions-=r
	set guioptions-=L
	set guifont=hack:h20
endif

let mapleader=','
nnoremap \ ,
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>

" abbreviations -----------------------------------------------------------
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Q! q!
cnoreabbrev Tabe tabe
cnoreabbrev wrap set wrap
cnoreabbrev nowrap set nowrap

set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE
