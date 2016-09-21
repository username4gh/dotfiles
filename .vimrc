set nocompatible
filetype off

if empty(glob("~/.vim/bundle/Vundle.vim"))
    silent execute '!git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
endif

" first time open up the vi, remember to use PluginInstall to init plugins"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'bling/vim-bufferline'
Plugin 'derekwyatt/vim-scala'
Plugin 'easymotion/vim-easymotion'
Plugin 'henrik/vim-indexed-search'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kelwin/vim-smali'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-signify'
Plugin 'myusuf3/numbers.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'swaroopch/vim-markdown-preview'
Plugin 'terryma/vim-expand-region'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/JSON.vim'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/YankRing.vim'

call vundle#end()

filetype plugin indent on

" colorscheme
colorscheme molokai

" bling/vim-airline
let g:airline_theme = 'badwolf'

" default Leader key is \"
nnoremap <Leader>W :w !sudo tee % > /dev/null

" Raimondi/delimitMate
" indent after press enter key"
let delimitMate_expand_cr=1

" scrooloose/nerdtree
let NERDTreeShowHidden=1
let g:nerdtree_tabs_open_on_gui_startup=0
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" terryma/vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_prev_key='<C-h>'
let g:multi_cursor_next_key='<C-j>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'

" basic editor-stuff
if filereadable(expand("$MY_I3/vim/base.vim"))
    so $MY_I3/vim/base.vim
    so $MY_I3/vim/cscope.vim
    so $MY_I3/vim/output.vim
endif

let g:loaded_python_provider = 1
let g:loaded_python3_provider = 1
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
let g:python_host_prog = '/opt/local/bin/python'

" https://github.com/myusuf3/numbers.vim
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" https://github.com/terryma/vim-expand-region
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)

" https://github.com/kien/rainbow_parentheses.vim
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

nnoremap <Leader>T :TagbarToggle
