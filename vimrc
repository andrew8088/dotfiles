set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim " required for Vundle
call vundle#begin() " required for Vundle
Plugin 'VundleVim/Vundle.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jgdavey/tslime.vim'
"Plugin 'kien/ctrlp.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Bundle 'mtscout6/vim-cjsx'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'

call vundle#end()         " required for Vundle
filetype plugin indent on " required for Vundle

set t_Co=256
syntax on
let base16colorspace=256  " Access colors present in 256 colorspace
"colorscheme base16-chalk  "Set through .zshrc 

set noerrorbells
set novisualbell
set t_vb=

let g:ctrlp_custom_ignore = 'node_modules\|\.DS_Store\|\.git'
let g:ctrlp_prompt_mappings = {
            \'AcceptSelection("e")': ['<C-e>'],
            \'AcceptSelection("t")': ['<Cr>'],
            \}

" moving around, searching, and patterns ----------------------------------
set incsearch
set showmatch
set smartcase
set ignorecase
set gdefault
" displaying text
set number
set linebreak
set nowrap
" syntax, highlighting, spelling
set hlsearch
set background=light
set colorcolumn=80

set mouse=a

" tabs and indenting ------------------------------------------------------
set autoindent
set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType mail setlocal fo+=aw
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.txt set filetype=markdown

set shiftround
" folding -----------------------------------------------------------------
set foldmethod=marker
set foldmarker={{{,}}}

" spliting ----------------------------------------------------------------
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

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

" project navigation  -----------------------------------------------------
nnoremap <C-p> :Files<cr>

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

highlight ExtraWhitespace ctermbg=18 guibg=#282a2e
match ExtraWhitespace /\s\+$/

"let g:syntastic_javascript_checkers = ['jscs']
