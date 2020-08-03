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
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('dbeniamine/todo.txt-vim')
call minpac#add('voldikss/vim-floaterm')

filetype plugin indent on

set t_Co=256
syntax on
let base16colorspace=256
colorscheme base16-eighties

set noerrorbells
set novisualbell
set t_vb=

" Enable the list of buffers
"let g:airline#extensions#tabline#enabled = 1

" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline_theme='bubblegum'

" moving around, searching, and patterns ----------------------------------
set incsearch
set showmatch
set smartcase
set ignorecase
set gdefault
set inccommand=nosplit
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

"autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
"autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript
autocmd FileType mail setlocal fo+=aw
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.txt set filetype=markdown

set shiftround
" folding -----------------------------------------------------------------
set foldmethod=manual
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
let maplocalleader="\\"
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
"nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <C-l> :bnext<CR>
" Move to the previous buffer
nmap <C-h> :bprevious<CR>

"nnoremap gt :bnext<CR>
"nnoremap gT :bprevious<CR>


" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" abbreviations -----------------------------------------------------------
nnoremap ; :
vnoremap ; :
inoremap ;; <esc>
inoremap jj <esc>


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

let g:yats_host_keyword = 1

" coc config, mostly copied from https://github.com/neoclide/coc.nvim
let g:coc_global_extensions = [
\ 'coc-snippets',
\ 'coc-pairs',
\ 'coc-tsserver',
\ 'coc-json'
\ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

command! -nargs=0 Prettier :CocCommand prettier.formatFile

nmap <leader>qf  <Plug>(coc-fix-current)

augroup javascript_folding
    au!
    au FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

augroup todo_txt
    au!
    au filetype todo setlocal omnifunc=todo#Complete
augroup END

command! -nargs=? Fold :call     CocAction('fold', <f-args>)

hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
