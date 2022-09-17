set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'dense-analysis/ale'
call plug#end()

:imap kj <Esc>
let mapleader=","
let maplocalleader="\\"

set encoding=utf-8
set clipboard=unnamedplus,autoselect
set mouse=a

set nobackup
set nowb
set noswapfile

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic

" folding
set foldmethod=indent
set foldlevel=99
set foldnestmax=5
set foldcolumn=0

" indentations
set expandtab
set smarttab
set shiftwidth=2
set tabstop =2
set softtabstop=2
set autoindent
set fileformat=unix

set hidden " don't close buffer when not displayed
noremap <leader>bd :Bd<CR>

" fzf git files
nmap <C-p> :GitFiles<CR>

" line numbering, relative when focused, absolute otherwise
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" colors
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
syntax on
colorscheme onehalfdark
let g:lightline = { 'colorscheme': 'onehalfdark' }

" nerdtree
let g:NERDTreeMinimalUI=1
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
