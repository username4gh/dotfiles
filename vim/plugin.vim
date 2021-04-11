function! _is_on_heavy_mode()
    return !empty(glob("~/.vim/HEAVY"))
endfunction

let g:vim_denite_codesearch=expand("$MY_DOTFILES").'/vim/vim-denite-codesearch'

call plug#begin(g:plug_dir)

Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-bufferline'
Plug 'brtastic/vim-jsonviewer'
Plug 'dart-lang/dart-vim-plugin'
Plug 'derekwyatt/vim-scala'
Plug 'easymotion/vim-easymotion'
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
Plug 'udalov/kotlin-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/JSON.vim'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'

" here i use the file existence to switch on-and-off some plugins
if _is_on_heavy_mode()
    Plug 'majutsushi/tagbar'
    Plug 'natebosch/vim-lsc'
    Plug 'natebosch/vim-lsc-dart'
    Plug 'hrsh7th/deoplete-vim-lsc'
    if has('nvim')
        Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/denite.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug g:vim_denite_codesearch
endif

call plug#end()

" save my eyes
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" bling/vim-airline
let g:airline_theme = 'badwolf'

" easymotion
map <Leader><Leader>c <Plug>(easymotion-lineanywhere)

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

if _is_on_heavy_mode()
    " tagbar
    let g:tagbar_sort = 0
    let g:tagbar_compact = 1
    nnoremap <F10> :TagbarToggle<CR>

    " denite
    if executable('rg')
        " Ripgrep command on grep source
        call denite#custom#var('grep', 'command', ['rg'])
        call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
        call denite#custom#var('grep', 'recursive_opts', [])
        call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
        call denite#custom#var('grep', 'separator', ['--'])
        call denite#custom#var('grep', 'final_opts', [])
    endif

    " Define alias
    call denite#custom#alias('source', 'file/rec/git', 'file/rec')
    call denite#custom#var('file/rec/git', 'command',
                \ ['git', 'ls-files', '-co', '--exclude-standard'])

    call denite#custom#alias('source', 'file/rec/py', 'file/rec')
    call denite#custom#var('file/rec/py', 'command',['scantree.py'])

    " Change default prompt
    call denite#custom#option('default', 'prompt', '>')

    " highlight
    call denite#custom#option('_', 'highlight_mode_insert', 'CursorLine')
    call denite#custom#option('_', 'highlight_matched_range', 'None')
    call denite#custom#option('_', 'highlight_matched_char', 'None')
    " denite key mapping
    map <Leader>B :Denite buffer -no-empty<CR>
    map <Leader>fs :Denite cached_file_search -no-empty<CR>
    map <Leader>cs :Denite cached_code_search -no-empty<CR>
    map <Leader>fg :Denite file/rec/git -no-empty<CR>
    map <Leader>fp :Denite file/rec/py -no-empty<CR>
    map <Leader>gp :Denite grep -no-empty<CR>

    " Define mappings
    autocmd FileType denite call s:denite_my_settings()
    function! s:denite_my_settings() abort
        nnoremap <silent><buffer><expr> <CR>
                    \ denite#do_map('do_action')
        nnoremap <silent><buffer><expr> d
                    \ denite#do_map('do_action', 'delete')
        nnoremap <silent><buffer><expr> p
                    \ denite#do_map('do_action', 'preview')
        nnoremap <silent><buffer><expr> q
                    \ denite#do_map('quit')
        nnoremap <silent><buffer><expr> i
                    \ denite#do_map('open_filter_buffer')
        nnoremap <silent><buffer><expr> <Space>
                    \ denite#do_map('toggle_select').'j'
    endfunction

    autocmd FileType denite-filter call s:denite_filter_my_settings()
    function! s:denite_filter_my_settings() abort
        imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
    endfunction
    let g:lsc_auto_map = v:true
endif


