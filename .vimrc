set nocompatible
filetype off

" Cscope
if empty(glob("~/.vim/plugin/cscope_maps.vim"))
    silent execute '!wget -c http://cscope.sourceforge.net/cscope_maps.vim -P ~/.vim/plugin/'
endif

if empty(glob("~/.vim/bundle/Vundle.vim"))
    silent execute '!git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
endif

" first time open up the vi, remember to use PluginInstall to init plugins"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'derekwyatt/vim-scala'
Plugin 'easymotion/vim-easymotion'
Plugin 'henrik/vim-indexed-search'
Plugin 'ktonga/vim-follow-my-lead'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kelwin/vim-smali'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-signify'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomasr/molokai'
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
:nnoremap <Leader>W :w !sudo tee % > /dev/null

:noremap <C-F12> :!ctags -R --c++-kinds=+p --fields=+ias --extra=+q .<CR>

:noremap <C-F11> :cs add $CSCOPE_DB<CR>

" Raimondi/delimitMate
" indent after press enter key"
let delimitMate_expand_cr=1

" scrooloose/nerdtree
let NERDTreeShowHidden=1
let g:nerdtree_tabs_open_on_gui_startup=0
:map <Leader>n <plug>NERDTreeTabsToggle<CR>

" terryma/vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_prev_key='<C-h>'
let g:multi_cursor_next_key='<C-j>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'

" basic editor-stuff
if filereadable(expand("$HOME/repo/my-i3/vim/base.vim"))
    :so $HOME/repo/my-i3/vim/base.vim
endif
