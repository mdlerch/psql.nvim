function! Sql_launch()
    if exists("g:sql_command")
        new
        let g:sql_term_id = termopen(g:sql_command, {'name': 'sql'})
    else
        echo "g:sql_command not found"
    endif
endfunction
