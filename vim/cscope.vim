" Helper function to quickly generate cscope.out
function CSBuild()
    let s:CURDIR = getcwd()
    while (getcwd() != '/')
        if isdirectory("./.git")
            " because I want to place the generated cscope.* file under the '.git', so
            " here I need to make sure the /tmp/.cs_db contains the full path of each
            " file
            silent !find $PWD -name '*.aidl' -o -name '*.cc' -o -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.py' > './.git/cscope.files'
            " because cscope cannot accept a specified directory as the output dir, so
            silent !cd $PWD/.git && cscope -bckq -i './cscope.files' && cd ..
            silent !ctags -R --links=no --tag-relative=yes --exclude=.svn --exclude=.git -f './.git/tags'
            :redraw!
            break
        endif
        if isdirectory("..") 
            silent exe 'cd ..'
        else
            silent exe 'cd /'
        endif
    endwhile
    silent exe 'cd ' . s:CURDIR
endf

function CSLoad()
    " add the database pointed to by environment variable
    if filereadable(expand("$NDK_INCLUDE_CSCOPE_DB"))
        silent exe 'cs add ' $NDK_INCLUDE_CSCOPE_DB
        silent exe 'set tags+=' . $NDK_INCLUDE_CTAGS_DB
    endif

    let s:CURDIR = getcwd()
    while (getcwd() != '/')
        "echo 'Try search: '.getcwd()
        if filereadable("./.git/cscope.out")
            let s:CSCOPE_DB = getcwd() . "/.git/cscope.out"
            let s:CTAGS_FILE = getcwd() . "/.git/tags"
            silent exe 'cs add '. s:CSCOPE_DB
            silent exe 'set tags+=' . s:CTAGS_FILE

            :redraw!

            break
        endif
        if isdirectory("..") 
            " for unclear reason, no '..' under the 'workspace' which is the
            " mount point for a sparseimage
            " here we just jump to '/' to avoid stuck in infinite-loop
            silent exe 'cd ..'
        else
            silent exe 'cd /'
        endif
    endwhile

    silent exe 'cd ' . s:CURDIR
endf

function CSDelete()
    let s:CURDIR = getcwd()
    while (getcwd() != '/')
        if isdirectory("./.git")
            silent !rm $PWD/.git/cscope.*
            silent !rm $PWD/.git/tags

            silent exe 'cs reset'
            :redraw!

            break
        endif
        if isdirectory("..") 
            silent exe 'cd ..'
        else
            silent exe 'cd /'
        endif
    endwhile
    silent exe 'cd ' . s:CURDIR
endf

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " show msg when any other cscope db added
    set cscopeverbose

    "nmap <Leader>s :lcs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <Leader>g :lcs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <Leader>c :lcs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <Leader>t :lcs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <Leader>e :lcs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <Leader>f :lcs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <Leader>i :lcs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "nmap <Leader>d :lcs find d <C-R>=expand("<cword>")<CR><CR>

    " Reload cscope DB or create new one
    command! -nargs=0 CSBuild :call CSBuild()
    command! -nargs=0 CSLoad :call CSLoad()
    command! -nargs=0 CSDelete :call CSDelete()
    
    map <F8> :CSLoad<CR>
endif

