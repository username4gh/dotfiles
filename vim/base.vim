" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Better command-line completion
set wildmenu

" Allow backspace in insert-mode
set backspace=indent,eol,start

" Indention settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 width with this setup
set shiftwidth=4
set softtabstop=4
set expandtab

" Copy indent from last line when starting new line
set autoindent

" At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth
" spaces
set smartindent

" Enable line numbers
" set number

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Set the command window height to 2 lines, to avoid many cases of having to
" press <Enter> to continue
set cmdheight=2

" Reload files changed outside vim
set autoread

" Respect modeline in files
set modeline
set modelines=4

" Enable per-directory .vimrc files and disable unsafe commands in them
set secure

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" Show current mode
set showmode

" Show the (partial) command as it's being typed
set showcmd

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Automatic commands
if has ("autocmd")
    " Enable file type detection
    filetype plugin indent on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setfiletype setlocal filetype=markdown
endif

" Setup Backup Stuff
let backup_dir = '~/.vim/backups/'
let swaps_dir= '~/.vim/swaps'
let undo_dir = '~/.vim/undo'

set backup
" Centralize backups, swapfiles and undo history
silent execute '!mkdir -p ' .backup_dir
set backupdir=~/.vim/backups
silent execute '!mkdir -p ' .swaps_dir
set directory=~/.vim/swaps
silent execute '!mkdir -p ' .undo_dir
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" autopair
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return '\<Right>'
    else
        return a:char
    endif
endfunction

":inoremap ( ()<esc>i
":inoremap ) <c-r>=ClosePair(')')<cr>
":inoremap { {}<esc>i
":inoremap } <c-r>=ClosePair('}')<cr>
":inoremap [ []<esc>i
":inoremap ] <c-r>=ClosePair(']')<cr>
":inoremap " ""<esc>i
":inoremap ' ''<esc>i
":inoremap ` ``<esc>i

" emacs-like-key in insert-mode
:inoremap <C-b> <Left>
:inoremap <C-n> <Down>
:inoremap <C-p> <Up>
:inoremap <C-f> <Right>
:inoremap <C-a> <Home>
:inoremap <C-e> <End>

" http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting
:nnoremap <esc> :noh<return><esc>

" http://vim.wikia.com/wiki/Fix_arrow_keys_that_display_A_B_C_D_on_remote_shell
nnoremap <silent> <ESC>OA <Nop>
nnoremap <silent> <ESC>OB <Nop>
nnoremap <silent> <ESC>OC <Nop>
nnoremap <silent> <ESC>OD <Nop>

" encoding
set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,gbk,cp936,latin-1
set fileformat=unix
set fileformats=unix,dos,mac

" show all the buffers
map <F1> :buffers<CR>

" toggle line number
nnoremap <F2> :set number!<CR>

" buffer navigation
nnoremap <F3> :bp<CR>
nnoremap <F4> :bn<CR>

" repeat last command
nnoremap <F5> :@:<CR>

set pastetoggle=<F6>

" format json
nnoremap <F7> :%!jq '.'<CR>

"nnoremap <F7> :w !sudo tee % > /dev/null
"nnoremap <F8> 20j<CR>
"nnoremap <F9> 20k<CR>

:tnoremap <Esc> <C-\><C-n>