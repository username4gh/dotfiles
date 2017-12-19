set nocompatible
filetype off

if empty(glob("~/.vim/bundle/Vundle.vim"))
    silent execute '!git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
endif

if !empty(glob("~/.vim/bundle/Vundle.vim"))
    " first time open up the vi, remember to use PluginInstall to init plugins"
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    Plugin 'easymotion/vim-easymotion'
    Plugin 'henrik/vim-indexed-search'
    Plugin 'hewes/unite-gtags'
    Plugin 'kelwin/vim-smali'
    Plugin 'majutsushi/tagbar'
    Plugin 'mhinz/vim-signify'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'octol/vim-cpp-enhanced-highlight'
    Plugin 'Raimondi/delimitMate'
    Plugin 'Shougo/unite.vim'
    Plugin 'Shougo/vimproc.vim'
    Plugin 'swaroopch/vim-markdown-preview'
    Plugin 'terryma/vim-expand-region'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'vim-scripts/JSON.vim'
    Plugin 'tpope/vim-surround'
    Plugin 'vim-ruby/vim-ruby'
    Plugin 'vim-scripts/vim-unite-cscope'
    Plugin 'vim-scripts/YankRing.vim'

    " here i use the file existence to switch on-and-off some plugins
    if !empty(glob("~/.vim/HEAVY"))
        Plugin 'bling/vim-bufferline'
        Plugin 'derekwyatt/vim-scala'
        Plugin 'tomasr/molokai'
        Plugin 'Valloric/YouCompleteMe'
        Plugin 'vim-airline/vim-airline'
        Plugin 'vim-airline/vim-airline-themes'
    endif

    call vundle#end()

    " colorscheme
    if !empty(glob("~/.vim/bundle/molokai/colors/molokai.vim"))
        colorscheme molokai
    endif

    " bling/vim-airline
    let g:airline_theme = 'badwolf'

    map <Leader><Leader>c <Plug>(easymotion-lineanywhere)

    " tagbar
    nnoremap <F10> :TagbarToggle<CR>

    " terryma/vim-multiple-cursors
    let g:multi_cursor_use_default_mapping=0
    " Default mapping
    let g:multi_cursor_prev_key='<C-h>'
    let g:multi_cursor_next_key='<C-j>'
    let g:multi_cursor_skip_key='<C-k>'
    let g:multi_cursor_quit_key='<Esc>'

    " https://github.com/terryma/vim-expand-region
    map K <Plug>(expand_region_expand)
    map J <Plug>(expand_region_shrink)

    " unite-cscope
    map <Leader>a :Unite cscope/assignments_to_symbol<CR>
    map <Leader>c :Unite cscope/functions_calling<CR>
    map <Leader>d :Unite cscope/functions_called_by<CR>
    map <Leader>e :Unite cscope/egrep_pattern<CR>
    map <Leader>f :Unite cscope/find_file<CR>
    map <Leader>g :Unite cscope/global_definition<CR>
    map <Leader>i :Unite cscope/including_this_file<CR>
    map <Leader>s :Unite cscope/find_this_symbol<CR>
    map <Leader>t :Unite cscope/text_string<CR>

    " unite-gtags
    map <Leader>D :Unite gtags/def<CR>
    map <Leader>R :Unite gtags/ref<CR>
    map <Leader>G :Unite gtags/grep<CR>
    map <Leader>q <Plug>(unite_exit)<CR>
    map <Leader>Q <Plug>(unite_all_exit)<CR>
endif

filetype plugin indent on

" basic editor-stuff
so ~/.dotfiles/vim/base.vim
so ~/.dotfiles/vim/clipboard.vim
so ~/.dotfiles/vim/output.vim
so ~/.dotfiles/vim/search.vim
so ~/.dotfiles/vim/whitespace.vim
