filetype off
syntax off

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

function _is_on_heavy_mode()
    return !empty(glob("~/.vim/HEAVY"))
endfunction

let g:vim_denite_codesearch=expand("$MY_DOTFILES").'/vim/vim-denite-codesearch'
let g:nvim_plug_dir='~/.local/share/nvim/plugged'

call plug#begin(g:nvim_plug_dir)

Plug 'bling/vim-bufferline'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'lambdalisue/suda.vim'
Plug 'majutsushi/tagbar'
Plug 'ozelentok/denite-gtags'
Plug 'Shougo/denite.nvim'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tomasr/molokai', {'do': ':color molokai'}
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug g:vim_denite_codesearch

call plug#end()

filetype plugin indent on
syntax on

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
map <Leader>B :Denite buffer -highlight-mode-insert=Search<CR>
map <Leader>D :DeniteCursorWord -buffer-name=gtags_def gtags_def -highlight-mode-insert=Search<CR>
map <Leader>R :DeniteCursorWord -buffer-name=gtags_ref gtags_ref -highlight-mode-insert=Search<CR>
map <Leader>fs :Denite fsearch -highlight-mode-insert=Search<CR>
map <Leader>cs :Denite csearch -highlight-mode-insert=Search<CR>
" extra configuration
for f in split(glob("$MY_DOTFILES/vim/*.vim"), '\n')
    exe 'source' f
endfor

:tnoremap <Esc> <C-\><C-n>
