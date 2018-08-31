filetype off

if empty(glob("~/.vim/bundle/Vundle.vim"))
    silent execute '!git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
endif

function _is_on_heavy_mode()
    return !empty(glob("~/.vim/HEAVY"))
endfunction

let g:vim_extra='file://'.expand("$MY_DOTFILES").'/vim/vim-denite-codesearch'

if !empty(glob("~/.vim/bundle/Vundle.vim"))
    " first time open up the vi, remember to use PluginInstall to init plugins"
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'

    Plugin 'bling/vim-bufferline'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'haya14busa/incsearch.vim'
    Plugin 'haya14busa/incsearch-fuzzy.vim'
    Plugin 'haya14busa/incsearch-easymotion.vim'
    Plugin 'majutsushi/tagbar'
    Plugin 'Shougo/denite.nvim'
    Plugin 'terryma/vim-expand-region'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'tpope/vim-surround'
    Plugin '~/.vim/bundle/vim-denite-codesearch/.git'

    call vundle#end()
endif

filetype plugin indent on

" tagbar
nnoremap <F10> :TagbarToggle<CR>

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
map <Leader>F :Denite file_rec<CR>
map <Leader>fs :Denite fsearch<CR>
map <Leader>cs :Denite csearch<CR>
" extra configuration
for f in split(glob("$MY_DOTFILES/vim/*.vim"), '\n')
    exe 'source' f
endfor

:tnoremap <Esc> <C-\><C-n>
