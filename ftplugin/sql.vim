let PSQLcaller = {}

" do nothing...
function PSQLcaller.on_stdout(job_id, data)
endfunction

function PSQLcaller.on_stderr(job_id, data)
    call append(line('$'), self.get_name().' stderr: '.join(a:data))
endfunction

" on exit, open job file
function PSQLcaller.on_exit(job_id, data)
    let outfile = "/tmp/" . self.get_name()
    exe "split " . outfile
endfunction

function PSQLcaller.get_name()
    return self.name
endfunction

function PSQLcaller.new(name, ...)
    let instance = extend(copy(g:PSQLcaller), {'name': a:name})
    let outfile = "/tmp/" . a:name
    if exists("g:sql_command")
        if a:0 > 0
            let argv = g:sql_command . a:1
        else
            let argv = g:sql_command . ' -f ' . expand('%') . ' > ' . outfile
        endif
        let instance.id = jobstart(argv, instance)
        return instance
    endif
endfunction

function! PSQLsource()
    let jobname = "psql" . strftime('%s')
    return g:PSQLcaller.new(jobname)
endfunction

function! PSQLsection()
    let jobname = "psql" . strftime('%s')
    let sectionfile = tempname()
    let cmd = "\'<,\'>write " . sectionfile
    exe cmd
    let opts = ' -f ' . sectionfile . ' > /tmp/' . jobname
    return g:PSQLcaller.new(jobname, opts)
endfunction

function! PSQLcolumns(tablename)
    let jobname = "psql" . strftime('%s')
    let opts = ' -c ' . '"\d+ ' . a:tablename . '" > /tmp/' . jobname
    return g:PSQLcaller.new(jobname, opts)
endfunction



