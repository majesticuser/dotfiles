set nocompatible " be iMproved

" ----------- "
" Vim Plugins "
" ----------- "

" vundle setup
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Syntax/language/framework plugins
Bundle 'tpope/vim-rails'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-endwise'
Bundle 'thoughtbot/vim-rspec'

" Helpers
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
"Bundle 'vim-scripts/taglist.vim'

" Editing plugins
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-surround'

" Color/theme plugins
Bundle 'vim-scripts/Lucius'

" needed for nelstrom/vim-textobj-rubyblock Bundle
if has("autocmd")
  filetype indent plugin on
endif

" ---------------- "
" General settings "
" ---------------- "

set title " Set the terminal's title
set encoding=utf-8
syntax on

" A more german keyboard friendly mapleader
let mapleader = ","

" ----------- "
" Colorscheme "
" ----------- "

let g:lucius_style = "light"
let g:solarized_termcolors=256
let g:solarized_visibility = "low"

colorscheme lucius

" ---------- "
" Appearance "
" ---------- "

set number " Show line numbers
set ruler " Show cursor position

" Highlight current line/cursor line in current window
set cursorline
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

" ------- "
" Editing "
" ------- "

" Load the matchit plugin. (needed for 'nelstrom/vim-textobj-rubyblock' Bundle)
runtime macros/matchit.vim

set autoindent
set tabstop=2 " Global tab width.
set expandtab " Use spaces instead of tabs

" --------- "
" Behaviour "
" --------- "

set wildmenu " Enhanced command line completion.
set visualbell " No beeping.

" --------- "
"  Mappings "
" --------- "

map <C-n> :NERDTreeToggle<CR>

" Rspec.vim mappings
map <Leader>t :call RunNearestSpec()<CR>
map <Leader>T :call RunCurrentSpecFile()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
