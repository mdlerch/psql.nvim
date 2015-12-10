if !exists("g:PSQLcalls")
    let g:PSQLcalls = 0
endif

let PSQLcaller = {}

let s:tmpdir = "/tmp/nvimpsql/"

" do nothing...
function PSQLcaller.on_stdout(job_id, data)
endfunction

function PSQLcaller.on_stderr(job_id, data)
    call append(line('$'), self.get_name().' stderr: '.join(a:data))
endfunction

" on exit, open job file
function PSQLcaller.on_exit(job_id, data)
    let g:PSQLcalls = g:PSQLcalls - 1
    if a:data == 0
        let outfile = s:tmpdir . self.get_name()
        exe "bot split " . outfile
        set tw=0
    endif
endfunction

function PSQLcaller.get_name()
    return self.name
endfunction

function PSQLcaller.new(name, ...)
    let g:PSQLcalls = g:PSQLcalls + 1
    let instance = extend(copy(g:PSQLcaller), {'name': a:name})
    let outfile = s:tmpdir . a:name
    if exists("g:sql_command")
        if a:0 > 0
            let argv = g:sql_command . a:1
        else
            if !isdirectory(s:tmpdir)
                exe "call mkdir(\"" . s:tmpdir . "\")"
            endif
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
    let sectionfile = s:tmpdir . jobname . ".sql"
    let cmd = "\'<,\'>write " . sectionfile
    exe cmd
    let opts = ' -f ' . sectionfile . ' > ' . s:tmpdir . jobname
    return g:PSQLcaller.new(jobname, opts)
endfunction

function! PSQLcolumns(tablename)
    let jobname = "psql" . strftime('%s')
    let opts = ' -c ' . '"\d+ ' . a:tablename . '" > ' . s:tmpdir . jobname
    return g:PSQLcaller.new(jobname, opts)
endfunction

nmap ,r :call PSQLsource()<CR>
xmap ,r <ESC>:call PSQLsection()<CR>
nmap ,v :call PSQLcolumns(expand("<cword>"))<CR>


