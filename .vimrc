set nocompatible
filetype off
syntax off

if empty(glob("~/.vim/autoload/plug.vim"))
    silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

let g:plug_dir='~/.vim/plugged'

filetype plugin indent on
syntax on

" extra configuration
for f in split(glob("$MY_DOTFILES/vim/*.vim"), '\n')
    exe 'source' f
endfor
