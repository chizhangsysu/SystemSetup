" Author: Chi Zhang (chizhang.sysu@gmail.com)

" Start vim-plug.
call plug#begin('~/.vim/plugged')
Plug 'haya14busa/incsearch.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/a.vim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'vim-scripts/AutoComplPop'
Plug 'altercation/vim-colors-solarized'
Plug 'hushicai/tagbar-javascript.vim'
Plug 'junegunn/vim-easy-align'
call plug#end()

" First thing.
set nocompatible

" Leader key.
let mapleader = ","

" Theme.
colorscheme molokai

" Font.
set guifont=Consolas\ 12

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on.
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin on

" Show line number.
set number

" Use 4-space tab.
set tabstop=4

" Shift by 4-space when using << or >>.
set shiftwidth=4

" Automatically replace tab by spaces.
set expandtab

" Always show status bar.
set laststatus=2

" No wrapping.
set nowrap

" Show vim commands being typed in normal mode.
set showcmd

" Hightlight search matches.
set hlsearch

" Highlight partially matched results on-the-fly.
set incsearch

" Fix misleading matching bracket highlighting
highlight MatchParen cterm=bold ctermbg=none ctermfg=magenta
highlight MatchParen gui=bold guibg=black guifg=magenta

" Change hightlight color in search results.
" http://unix.stackexchange.com/questions/78063/how-to-change-search-result-highlight-in-vi
highlight Search    guifg=White
highlight Search    guibg=Red
highlight IncSearch guifg=Black
highlight IncSearch guibg=Yellow

highlight Search    ctermfg=White
highlight Search    ctermbg=Red
highlight IncSearch ctermfg=Black
highlight IncSearch ctermbg=Yellow

" Show EVERY matched occurences on-the-fly during searching.
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Select all.
noremap <C-a> <Esc>ggVG

" Block selection.
nnoremap <C-b> <C-v>

" Copying to system clipboard.
vnoremap <C-c> "+y

" Pasting from system clipboard.
nnoremap <C-v> "+p
vnoremap <C-v> "+p
inoremap <C-v> <esc>"+p

" Buffer navigation.
noremap <C-S-tab> :bprev<cr>
noremap <C-tab>   :bnext<cr>
noremap <A-j>     :bprev<cr>
noremap <A-k>     :bnext<cr>

" Close the current buffer without changing window layout.
" https://superuser.com/questions/289285/how-to-close-buffer-without-closing-the-window
noremap <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>

" Navigate between panes by ctrl + h,j,k,l.
nnoremap <C-j>	<C-w>j
nnoremap <C-k>	<C-w>k
nnoremap <C-h>	<C-w>h
nnoremap <C-l>	<C-w>l

" Remove the pipe character '|' between pane boarders.
set fillchars+=vert:\ 

" HJKL motions.
noremap H ^
noremap L $
noremap J <Nop>
noremap K <Nop>
noremap J <C-d>
noremap K <C-u>

" Moves between soft lines instead of physical lines in wrap mode.
noremap  k gk
noremap  j gj
noremap  0 g0
noremap  $ g$
noremap  ^ g^

" Ctrl+Backspace to delete previous word in insert mode.
inoremap <C-BS> <C-W>

" Ctrl+L to go to the end of current line in insert mode.
inoremap <C-l> <C-o>$

" Join lines.
noremap <leader>J J

" Number increment and decrement.
nnoremap <A-i> <C-a>
nnoremap <A-d> <C-x>

" Edit and source .vimrc by ,ev and ,sv.
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :w<CR>:source $MYVIMRC<CR>

" Quit and write file by ,q and ,w.
nnoremap <Leader>q  :q<CR>
nnoremap <Leader>w  :w<CR>

" Toggle comments.
nnoremap <Leader>c  :Commentary<CR>
vnoremap <Leader>c  :Commentary<CR>

" Navigate between header and source.
nnoremap <Leader>a :A<CR>

" F5 to execute python
nnoremap <silent> <F5> :!clear;python %<CR>

" print(var) -> print('var', var)
nnoremap <Leader>e yi(i'<Esc>pa',<Space><Esc>

" var -> LOG(INFO) << "var: " << var;
nnoremap <Leader>l ciWLOG(INFO) << "<Esc>pa: " << <Esc>pa;<Esc>

" Airline.
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#wordcount#enable=0
let g:airline_theme='wombat'
let g:airline#extensions#default#layout=[
	\ [ 'a', 'b', 'c' ],
	\ [ 'y', 'z' ]
	\ ]

" Config lightline.
if !has('gui_running')
	set t_Co=256
endif

" ctrlp.
set wildignore+=*.o
let g:ctrlp_show_hidden = 1

" Markdown preview.
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_github=1

" Toggle Nerdtree.
noremap <C-n> :NERDTreeToggle<CR>

" Toggle Tagbar.
noremap <C-t> :TagbarToggle<CR>

" Align GitHub-flavored Markdown tables.
vnoremap <Leader>p :EasyAlign*<Bar><Enter>

" Set autoindent and autowrap with textwidth=72 for markdown files.
augroup auFileTypes
  autocmd!
  autocmd FileType markdown setlocal textwidth=72
  autocmd FileType markdown setlocal autoindent
augroup end

