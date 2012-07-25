function! s:ClickatellDiff(...)

    let l:current_filepath = expand("%:p")

    " If the current branch is QA, set the diff to TRUNK and vice versa
    if l:current_filepath =~ '/qa/'
        let l:branch = '/qa/'
        let l:diff_branch = '/trunk/'
    elseif current_filepath =~ '/trunk/'
        let l:branch = '/trunk/'
        let l:diff_branch = '/qa/'
    else
        echo "ERROR! Current path is somewhat unexpected: " . l:current_filepath
        :return
    endif

    " Oh noes! We have had an argument passed to the function so it looks like
    " we're actually trying to diff against a TAG, so set the diff to the tag
    " number
    if a:0 > 0
        let l:diff_branch = '/tags/' . a:1 . '/'
    endif

    let l:diff_filepath = substitute(current_filepath, l:branch, l:diff_branch, 'g')

    " Deal with any spaces in the path
    let l:diff_filepath = substitute(diff_filepath, ' ', '\\ ', 'g') 

    execute ':rightb diffsplit ' . l:diff_filepath

endfunction

command! -nargs=? ClickatellDiff call s:ClickatellDiff(<f-args>)

nmap <leader>d <Esc>:ClickatellDiff
nmap <leader>o <C-w>l<ESC>:bd!<CR>:diffoff<CR>
