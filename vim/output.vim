" http://vim.wikia.com/wiki/Capture_ex_command_output
function! OutputSplitWindow(...)
    " this function output the result of the Ex command into a split scratch buffer
    let cmd = join(a:000, ' ')
    let temp_reg = @"
    redir @"
    silent! execute cmd
    redir END
    let output = copy(@")
    let @" = temp_reg
    if empty(output)
        echoerr "no output"
    else
        new
        setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted
        put! =output
    endif
endfunction

command! -nargs=+ -complete=command Output call OutputSplitWindow(<f-args>)
