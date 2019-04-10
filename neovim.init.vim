filetype off
syntax off

let g:python3_host_prog = '/usr/local/bin/python3'

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

let g:plug_dir='~/.local/share/nvim/plugged'

filetype plugin indent on
syntax on

" extra configuration
for f in split(glob("$MY_DOTFILES/vim/*.vim"), '\n')
    exe 'source' f
endfor


