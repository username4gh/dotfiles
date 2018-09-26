set nocompatible
filetype off
syntax off

if empty(glob("~/.vim/autoload/plug.vim"))
    silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

function! _is_on_heavy_mode()
    return !empty(glob("~/.vim/HEAVY"))
endfunction

let g:vim_denite_codesearch=expand("$MY_DOTFILES").'/vim/vim-denite-codesearch'

call plug#begin('~/.vim/plugged')

Plug 'bling/vim-bufferline'
Plug 'derekwyatt/vim-scala'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'henrik/vim-indexed-search'
Plug 'jeetsukumaran/vim-buffersaurus'
Plug 'kelwin/vim-smali'
Plug 'lambdalisue/suda.vim'
Plug 'mhinz/vim-signify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Raimondi/delimitMate'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/JSON.vim'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'

" here i use the file existence to switch on-and-off some plugins
if _is_on_heavy_mode()
    Plug 'majutsushi/tagbar'
    Plug 'ozelentok/denite-gtags'
    Plug 'Shougo/denite.nvim'
    Plug 'Valloric/YouCompleteMe'
    Plug 'vim-scripts/YankRing.vim'
    Plug g:vim_denite_codesearch
    " denite
    map <Leader>B :Denite buffer -highlight-mode-insert=Search<CR>
    map <Leader>D :DeniteCursorWord -buffer-name=gtags_def gtags_def -highlight-mode-insert=Search<CR>
    map <Leader>R :DeniteCursorWord -buffer-name=gtags_ref gtags_ref -highlight-mode-insert=Search<CR>
    map <Leader>fs :Denite fsearch -highlight-mode-insert=Search<CR>
    map <Leader>cs :Denite csearch -highlight-mode-insert=Search<CR>

endif

call plug#end()

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
let g:tagbar_sort = 0
let g:tagbar_compact = 1
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

filetype plugin indent on

syntax on
color molokai

" extra configuration
for f in split(glob("$MY_DOTFILES/vim/*.vim"), '\n')
    exe 'source' f
endfor
