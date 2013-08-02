set nocompatible " be iMproved

" needed for nelstrom/vim-textobj-rubyblock Bundle
if has("autocmd")
  filetype indent plugin on
endif

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

" Helpers
Bundle 'scrooloose/nerdtree'

" Editing plugins
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-surround'

" Color/theme plugins
Bundle 'vim-scripts/Lucius'

" ---------------- "
" General settings "
" ---------------- "

set title " Set the terminal's title
set encoding=utf-8
syntax on

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
"  Mappings "
" --------- "

map <C-n> :NERDTreeToggle<CR>
