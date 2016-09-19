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
            silent !cd $PWD/.git && cscope -bkq -i './cscope.files' && cd ..
            silent !ctags -R --links=no --tag-relative=yes --exclude=.svn --exclude=.git -f './.git/tags'
            :redraw!
            break
        endif
        silent cd ..
    endwhile
    silent exe 'cd ' . s:CURDIR
endf

function CSLoad()
    " add the database pointed to by environment variable
    silent exe 'cs add ' $NDK_INCLUDE_CSCOPE_DB
    silent exe 'set tags+=' . $NDK_INCLUDE_CTAGS_DB

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
        silent cd ..
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
        silent cd ..
    endwhile
    silent exe 'cd ' . s:CURDIR
endf

" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    "set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0


    " show msg when any other cscope db added
    set cscopeverbose

    if has('quickfix')
        set cscopequickfix=s-,c-,d-,i-,t-,e-
    endif

    nmap <Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <Leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <Leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    " Reload cscope DB or create new one
    :command -nargs=0 CSBuild :call CSBuild()
    :command -nargs=0 CSLoad :call CSLoad()
    :command -nargs=0 CSDelete :call CSDelete()

    " Define the set of Cscope commands
    command! -nargs=* Cscope call s:RunCscope(<f-args>)

    nmap <C-\>s :Cscope s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :Cscope g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>d :Cscope d <C-R>=expand("<cword>")<CR> <C-R>=expand("%")<CR><CR>
    nmap <C-\>c :Cscope c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :Cscope t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :Cscope e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :Cscope f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :Cscope i ^<C-R>=expand("<cfile>")<CR>$<CR>
endif


" https://github.com/vim-scripts/cscope-quickfix
if !exists("Cscope_OpenQuickfixWindow")
    let Cscope_OpenQuickfixWindow = 1
endif

if !exists("Cscope_JumpError")
    let Cscope_JumpError = 1
endif

if !exists("Cscope_Keymap")
    let Cscope_Keymap = 1
endif

if !exists("Cscope_PopupMenu")
    let Cscope_PopupMenu = 0
endif

if !exists("Cscope_ToolMenu")
    let Cscope_ToolMenu = 1
endif

" RunCscope()
" Run the cscope command using the supplied option and pattern
function! s:RunCscope(...)
    if !exists("a:1") || !exists("a:2")
        echohl WarningMsg | echohl None
        return
    endif
    let cscope_opt = a:1
    let pattern = a:2
    let openwin = g:Cscope_OpenQuickfixWindow
    let jumperr = g:Cscope_JumpError
    if cscope_opt == '0' || cscope_opt == 's'
        let cmd = "cs find s " . pattern
    elseif cscope_opt == '1' || cscope_opt == 'g'
        let cmd = "cs find g " . pattern
    elseif cscope_opt == '2' || cscope_opt == 'd'
        let cmd = "cs find d " . pattern
    elseif cscope_opt == '3' || cscope_opt == 'c'
        let cmd = "cs find c " . pattern
    elseif cscope_opt == '4' || cscope_opt == 't'
        let cmd = "cs find t " . pattern
    elseif cscope_opt == '6' || cscope_opt == 'e'
        let cmd = "cs find e " . pattern
    elseif cscope_opt == '7' || cscope_opt == 'f'
        let cmd = "cs find f " . pattern
        let openwin = 0
        let jumperr = 1
    elseif cscope_opt == '8' || cscope_opt == 'i'
        let cmd = "cs find i " . pattern
    else
        echohl WarningMsg | echohl None
        return
    endif
    if exists("a:3")
        let cmd = cmd . " " . a:3
    endif

    let temp_reg = @""
    redir @"
    silent execute cmd
    redir END
    let cmd_output = copy(@")
    let @" = temp_reg

    if cmd_output == ""
        echohl WarningMsg | 
                    \ echomsg "Error: Pattern " . pattern . " not found" | 
                    \ echohl None
        return
    endif

    let tmpfile = tempname()
    let curfile = expand("%")

    if &modified && (!&autowrite || curfile == "")
        let jumperr = 0
    endif

    exe "redir! > " . tmpfile
    if curfile != ""
        silent echon curfile . " dummy " . line(".") . " " . getline(".") . "\n"
        silent let ccn = 2
    else
        silent let ccn = 1
    endif
    silent echon cmd_output
    redir END

    let old_efm = &efm
    set efm=%f\ %*[^\ ]\ %l\ %m

    exe "silent! cfile " . tmpfile
    let &efm = old_efm

    " Open the cscope output window
    if openwin == 1
        botright copen
    endif

    " Jump to the first error
    if jumperr == 1
        exe "cc " . ccn
    endif

    call delete(tmpfile)
endfunction


" Filter the quickfix list
function! FilterQFList(type, action, pattern)
    " get current quickfix list
    let s:curList = getqflist()
    let s:newList = []
    for item in s:curList
        if a:type == 0     " filter on file names
            let s:cmpPat = bufname(item.bufnr)
        elseif a:type == 1 " filter by line content
            let s:cmpPat = item.text . item.pattern
        endif
        if item.valid
            if a:action < 0
                " Keep only nonmatching lines
                if s:cmpPat !~ a:pattern
                    let s:newList += [item]
                endif
            else
                " Keep only matching lines
                if s:cmpPat =~ a:pattern
                    let s:newList += [item]
                endif
            endif
        endif
    endfor
    call setqflist(s:newList)
endfunction

nnoremap <Leader>fs :call FilterQFList(0, -1, inputdialog('Remove file names matching:', ''))<CR>
nnoremap <Leader>of :call FilterQFList(0, 1, inputdialog('Keep only file names matching:', ''))<CR>
nnoremap <Leader>as :call FilterQFList(1, -1, inputdialog('Remove all lines matching:', ''))<CR>
nnoremap <Leader>os :call FilterQFList(1, 1, inputdialog('Keep only lines matching:', ''))<CR>