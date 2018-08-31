set nocompatible
filetype off

if empty(glob("~/.vim/bundle/Vundle.vim"))
    silent execute '!git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
endif

function! _is_on_heavy_mode()
    return !empty(glob("~/.vim/HEAVY"))
endfunction

if !empty(glob("~/.vim/bundle/Vundle.vim"))
    " first time open up the vi, remember to use PluginInstall to init plugins"
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    Plugin 'bling/vim-bufferline'
    Plugin 'derekwyatt/vim-scala'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'haya14busa/incsearch.vim'
    Plugin 'haya14busa/incsearch-fuzzy.vim'
    Plugin 'haya14busa/incsearch-easymotion.vim'
    Plugin 'henrik/vim-indexed-search'
    Plugin 'jeetsukumaran/vim-buffersaurus'
    Plugin 'kelwin/vim-smali'
    Plugin 'mhinz/vim-signify'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'octol/vim-cpp-enhanced-highlight'
    Plugin 'Raimondi/delimitMate'
    Plugin 'terryma/vim-expand-region'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'vim-scripts/JSON.vim'
    Plugin 'tpope/vim-surround'
    Plugin 'vim-ruby/vim-ruby'

    " here i use the file existence to switch on-and-off some plugins
    if _is_on_heavy_mode()
        Plugin 'majutsushi/tagbar'
        Plugin 'ozelentok/denite-gtags'
        Plugin 'Shougo/denite.nvim'
        Plugin 'Valloric/YouCompleteMe'
        Plugin 'vim-scripts/YankRing.vim'
    endif

    call vundle#end()

    " bling/vim-airline
    " let g:airline_theme = 'badwolf'

    " easymotion
    map <Leader><Leader>c <Plug>(easymotion-lineanywhere)
    " Bonus fuzzy-search with EasyMotion
    function! s:config_easyfuzzymotion(...) abort
        return extend(copy({
                    \   'converters': [incsearch#config#fuzzyword#converter()],
                    \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
                    \   'keymap': {"\<CR>": '<Over>(easymotion)'},
                    \   'is_expr': 0,
                    \   'is_stay': 1
                    \ }), get(a:, 1, {}))
    endfunction

    noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

    " incsearch
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
    let g:incsearch#auto_nohlsearch = 1
    map n  <Plug>(incsearch-nohl-n)
    map N  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
    map g* <Plug>(incsearch-nohl-g*)
    map g# <Plug>(incsearch-nohl-g#)
    " incsearch-fuzzy
    map f/ <Plug>(incsearch-fuzzy-/)
    map f? <Plug>(incsearch-fuzzy-?)
    map fg/ <Plug>(incsearch-fuzzy-stay)

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

    " denite
    map <Leader>B :Denite buffer<CR>
    map <Leader>D :DeniteCursorWord -buffer-name=gtags_def gtags_def<CR>
    map <Leader>R :DeniteCursorWord -buffer-name=gtags_ref gtags_ref<CR>
endif

filetype plugin indent on

" extra configuration
for f in split(glob("$MY_DOTFILES/vim/*.vim"), '\n')
    exe 'source' f
endfor
