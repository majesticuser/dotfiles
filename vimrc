set nocompatible " be iMproved

filetype off " required for vundle

" ------- "
" plugins "
" ------- "

" vundle setup
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Howto for profiling slow plugins
" http://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" Helpers
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'skwp/greplace.vim'
Plugin 'tpope/vim-commentary'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'benmills/vimux'
"Plugin 'vim-scripts/taglist.vim'
"Plugin 'henrik/vim-yaml-flattener'

" Editing plugins
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
"Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'jwhitley/vim-matchit'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'Townk/vim-autoclose'

" Color/theme plugins
Plugin 'vim-scripts/Lucius'
Plugin 'tomasr/molokai'
Plugin 'chriskempson/vim-tomorrow-theme'

" Syntax/language/framework plugins
Plugin 'tpope/vim-rails'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-endwise'
Plugin 'janko-m/vim-test'
Plugin 'vim-scripts/Markdown'
Plugin 'scrooloose/syntastic'
Plugin 'ap/vim-css-color'

" All of your Plugins must be added before the following line
call vundle#end()            
filetype plugin indent on    " required for vundle

" ---------------- "
" general settings "
" ---------------- "

set title " Set the terminal's title
set encoding=utf-8
syntax on

" A more german keyboard friendly mapleader
let mapleader = ","

" swap files will be saved in the following directory
:set dir=~/tmp

au BufRead,BufNewFile *.thor set filetype=ruby

" This is a hack for disabling the highlighting of matching parentheses that
" is also fundamental for speed improvements in Terminal Vim as the paren
" matching function is mapped to the CursorMoved au-Command by default.
let g:loaded_matchparen = 1

" ----------- "
" colorscheme "
" ----------- "

let g:lucius_style = "light"
let g:solarized_termcolors=256
let g:solarized_visibility = "low"

colorscheme lucius
"LuciusLightHighContrast
"LuciusBlack
"LuciusDark
"LuciusDarkHighContrast

"colorscheme Tomorrow-Night
"colorscheme Tomorrow-Night-Eighties

" colorscheme molokai
" let g:rehash256 = 1
" let g:molokai_original = 1

" ---------- "
" appearance "
" ---------- "

set number " Show line numbers
set ruler " Show cursor position
" Show visual marker for preferred line length
" @see http://stackoverflow.com/a/3765575
" set colorcolumn=80

" Highlight current line/cursor line in current window
set cursorline
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

" Standsout (s) and bolds (b) the showmode Message (M)
set highlight=Msb

set scrolloff=3 " Show 3 lines of context around the cursor.

" ------- "
" editing "
" ------- "

" Load the matchit plugin. (needed for 'nelstrom/vim-textobj-rubyblock' Plugin)
runtime macros/matchit.vim

set autoindent
set tabstop=2 " Global tab width.
set shiftwidth=2 " And again, related.
set expandtab " Use spaces instead of tabs

" --------- "
" clipboard "
" --------- "

" Uses the system clipboard as the default register
set clipboard=unnamed

" --------- "
" behaviour "
" --------- "

set wildmenu " Enhanced command line completion.
set visualbell " No beeping.

set showcmd " Display incomplete commands.
set showmode " Display the mode you're in.
set backspace=indent,eol,start " Intuitive backspacing.

set hidden " Handle multiple buffers better.

" ------ "
" search "
" ------ "

set hlsearch " Highlight matches.
set incsearch " Highlight matches as you type.

" Shortcuts for next and previous Quickfind results
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" http://vim.wikia.com/wiki/Search_for_visually_selected_text
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Clear the search highlighting when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" -------- "
" greplace "
" -------- "

set grepprg=ack
let g:grep_cmd_opts = '--noheading'

" -------- "
" nerdtree "
" -------- "

map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFind<CR>

" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" ---------- "
" easymotion "
" ---------- "

let g:EasyMotion_leader_key = 'ö'

" same color as search highlight color
hi EasyMotionTarget ctermbg=214 ctermfg=238
hi EasyMotionTarget2First ctermbg=214 ctermfg=238
hi EasyMotionTarget2Second ctermbg=214 ctermfg=238

" ----- "
" ctrlp "
" ----- "

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.rsync_cache$\|node_modules$\|public/javascripts/compiled$\|target$',
  \ 'file': '\.exe$\|\.so$\|\.dll|\.class$',
  \ 'link': '',
  \ }

let g:ctrlp_match_window = 'bottom,order:btt,min:0,max:15,results:15'

map <C-b> :CtrlPBuffer<CR>

" ---------------- "
" multiple cursors "
" ---------------- "

" let g:multi_cursor_use_default_mapping=0
" let g:multi_cursor_next_key='<C-m>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'
" let g:multi_cursor_start_key='<C-m>'

" -------- "
" vim-test "
" -------- "

" basic | vimux
let test#strategy = "vimux"

let test#ruby#rspec#executable = 'bundle exec rspec'

let test#javascript#jasmine#executable = 'npm test'
let test#javascript#jasmine#file_pattern = '.*Spec\.coffee$'

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" ----- "
" vimux "
" ----- "

" let g:VimuxOrientation = "h"
" let g:VimuxHeight = "50"
let g:VimuxOrientation = "v"
let g:VimuxHeight = "40"
map <leader>vl :VimuxRunLastCommand<cr>
map <leader>vi :VimuxInspectRunner<cr>
map <leader>vq :VimuxCloseRunner<cr>
map <leader>vp :VimuxPromptCommand<cr>

" ----------- "
" align table "
" ----------- "

" Helper for aligning table-like array as I use in Sequel-based tests.
function! AlignTable()
  '<,'>Tabularize /,
  '<,'>Tabularize /[
  '<,'>Tabularize /]
endfunction

vnoremap <leader>a :call AlignTable()<cr>
nnoremap <leader>A Vi(k:call AlignTable()<cr>

" ----------------- "
" convert ruby hash "
" ----------------- "

" Naive implementation of a Ruby Hash conversion to the new Hash Syntax.
function! ConvertRubyHash()
  '<,'>s/:\(.*\) => /\1: /g
endfunction
vnoremap <leader>c :call ConvertRubyHash()<cr>
