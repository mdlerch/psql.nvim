let SQLcaller = {}

function SQLcaller.on_stdout(job_id, data)
    call append(line('$'), self.get_name().' stdout: '.join(a:data))
endfunction

function SQLcaller.on_stderr(job_id, data)
    call append(line('$'), self.get_name().' stderr: '.join(a:data))
endfunction

function SQLcaller.on_exit(job_id, data)
    call append(line('$'), self.get_name().' exited')
endfunction

function SQLcaller.get_name()
    return 'shell '.self.name
endfunction

function SQLcaller.new(name, ...)
    let instance = extend(copy(g:SQLcaller), {'name': a:name})
    let argv = [g:sql_command]
    if a:0 > 0
        let argv += ['-c', a:1]
    endif
    let instance.id = jobstart(argv, instance)
    return instance
endfunction

" let s1 = SQLcaller.new('job1')
" let s2 = SQLcaller.new('job2', 'for i in {1..10}; do echo hello $i!; sleep 1; done')

function! Sql_launch()
    if exists("g:sql_command")
        new
        let g:sql_term_id = termopen(g:sql_command, {'name': 'sql'})
    else
        echo "g:sql_command not found"
    endif
endfunction

function! Sql_query()
    let call1 = SQLcaller.new('call1', 

endfunction

