set nocompatible
filetype off

packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('chriskempson/base16-vim')
call minpac#add('jgdavey/tslime.vim') "for tmux
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')
call minpac#add('tpope/vim-fugitive')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('janko/vim-test')
call minpac#add('pangloss/vim-javascript')
call minpac#add('tpope/vim-commentary')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('HerringtonDarkholme/yats.vim')

" For Neovim
if has('nvim')
    call minpac#add('mhartington/nvim-typescript', {'do': './install.sh'})
    call minpac#add('Shougo/deoplete.nvim')
    call minpac#add('Shougo/denite.nvim')
endif

filetype plugin indent on

set t_Co=256
syntax on
let base16colorspace=256
colorscheme base16-eighties


set noerrorbells
set novisualbell
set t_vb=

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline_theme='bubblegum'

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
set background=dark
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

" concealing --------------------------------------------------------------
set conceallevel=2

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
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>

" project navigation  -----------------------------------------------------
nnoremap <C-p> :GFiles<cr>

" Buffers -----------------------------------------------------------------
" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <C-l> :bnext<CR>

nnoremap gt :bnext<CR>
nnoremap gT :bprevious<CR>

" Move to the previous buffer
nmap <C-h> :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" abbreviations -----------------------------------------------------------
nnoremap ; :
vnoremap ; :

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

autocmd FileType typescript setlocal completeopt+=preview

let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"


let g:deoplete#enable_at_startup = 1
