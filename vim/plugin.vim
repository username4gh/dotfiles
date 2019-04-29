function! _is_on_heavy_mode()
    return !empty(glob("~/.vim/HEAVY"))
endfunction

let g:vim_denite_codesearch=expand("$MY_DOTFILES").'/vim/vim-denite-codesearch'

function! _is_installed(s)
    if has_key(g:plugs, a:s)
        return isdirectory(g:plugs[a:s].dir)
    else
        return v:false
    endif
endfunction

function! _is_loaded(s)
    if _is_installed(a:s)
        return stridx(&rtp, g:plugs[a:s].dir) >= 0
    else
        return v:false
    endif
endfunction

call plug#begin(g:plug_dir)

Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-bufferline'
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/JSON.vim'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'

" here i use the file existence to switch on-and-off some plugins
if _is_on_heavy_mode()
    Plug 'majutsushi/tagbar'
    if !has('nvim')
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug 'Shougo/denite.nvim'
    Plug g:vim_denite_codesearch
endif

call plug#end()

" save my eyes
if _is_loaded('vim-colors-solarized')
    set background=dark
    let g:solarized_termcolors=256
    colorscheme solarized
endif

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

    if _is_loaded('denite.nvim')
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
        map <Leader>fs :Denite fsearch -no-empty<CR>
        map <Leader>cs :Denite csearch -no-empty<CR>
        map <Leader>fg :Denite file/rec/git -no-empty<CR>
        map <Leader>fp :Denite file/rec/py -no-empty<CR>
        map <Leader>gp :Denite grep  -no-empty<CR>
    endif
endif


