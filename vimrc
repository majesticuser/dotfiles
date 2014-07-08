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

" Helpers
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'skwp/greplace.vim'
Bundle 'tpope/vim-commentary'
Bundle 'vim-scripts/Rename2'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'benmills/vimux'
"Bundle 'vim-scripts/taglist.vim'
Bundle 'rizzatti/dash.vim'

" Editing plugins
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-surround'
Bundle 'godlygeek/tabular'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'jwhitley/vim-matchit'

" Color/theme plugins
Bundle 'vim-scripts/Lucius'

" Syntax/language/framework plugins
Bundle 'tpope/vim-rails'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-endwise'
Bundle 'skalnik/vim-vroom'
Bundle 'vim-scripts/Markdown'
Bundle 'scrooloose/syntastic'

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
"LuciusBlack
"LuciusDark
"LuciusDarkHighContrast

" ---------- "
" Appearance "
" ---------- "

set number " Show line numbers
set ruler " Show cursor position

" Highlight current line/cursor line in current window
set cursorline
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

" Standsout (s) and bolds (b) the showmode Message (M)
set highlight=Msb

" ------- "
" Editing "
" ------- "

" Load the matchit plugin. (needed for 'nelstrom/vim-textobj-rubyblock' Bundle)
runtime macros/matchit.vim

set autoindent
set tabstop=2 " Global tab width.
set shiftwidth=2 " And again, related.
set expandtab " Use spaces instead of tabs

" --------- "
" Clipboard "
" --------- "

" Uses the system clipboard as the default register
" set clipboard=unnamed

" --------- "
" Behaviour "
" --------- "

set wildmenu " Enhanced command line completion.
set visualbell " No beeping.

set showcmd " Display incomplete commands.
set showmode " Display the mode you're in.
set backspace=indent,eol,start " Intuitive backspacing.

" ------ "
" Search "
" ------ "

set hlsearch " Highlight matches.
set incsearch " Highlight matches as you type.

" ---------- "
" EasyMotion "
" ---------- "

let g:EasyMotion_leader_key = 'ö'

" ----------- "
"  Functions  "
" ----------- "

" Helper for aligning table-like array as I use in Sequel-based tests.
function! AlignTable()
  '<,'>Tabularize /,
  '<,'>Tabularize /[
  '<,'>Tabularize /]
endfunction

" Clear the search highlighting when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" --------- "
"  Mappings "
" --------- "

map <C-n> :NERDTreeToggle<CR>

:nmap <silent> <leader>d <Plug>DashSearch

" vroom mappings
let g:vroom_map_keys = 0
let g:vroom_write_all = 1
let g:vroom_use_vimux = 1
map <leader>t :VroomRunNearestTest<cr>
map <leader>T :VroomRunTestFile<cr>

" vimux mappings
let g:VimuxOrientation = "h"
let g:VimuxHeight = "50"
map <leader>vl :VimuxRunLastCommand<cr>
map <leader>vi :VimuxInspectRunner<cr>
map <leader>vq :VimuxCloseRunner<cr>
map <leader>vp :VimuxPromptCommand<cr>

vnoremap <leader>a :call AlignTable()<cr>
nnoremap <leader>A Vi(k:call AlignTable()<cr>
