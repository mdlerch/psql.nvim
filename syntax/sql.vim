" Vim syntax file
" Language:     mysql
" Maintainer:   Kenneth J. Pronovici <pronovic@ieee.org>
" Last Change:  $LastChangedDate: 2010-04-22 09:48:02 -0500 (Thu, 22 Apr 2010) $
" Filenames:    *.mysql
" URL:          ftp://cedar-solutions.com/software/mysql.vim
" Note:         The definitions below are taken from the mysql user manual as of April 2002, for version 3.23

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Always ignore case
syn case ignore

" General keywords which don't fall into other categories
syn keyword mysqlKeyword         action add after aggregate all alter as asc auto_increment avg avg_row_length
syn keyword mysqlKeyword         both by
syn keyword mysqlKeyword         cascade change character check checksum column columns comment constraint create cross
syn keyword mysqlKeyword         current_date current_time current_timestamp
syn keyword mysqlKeyword         data database databases day day_hour day_minute day_second
syn keyword mysqlKeyword         default delayed delay_key_write delete desc describe distinct distinctrow drop
syn keyword mysqlKeyword         enclosed escape escaped explain
syn keyword mysqlKeyword         fields file first flush for foreign from full function
syn keyword mysqlKeyword         global grant grants group
syn keyword mysqlKeyword         having heap high_priority hosts hour hour_minute hour_second
syn keyword mysqlKeyword         identified ignore index infile inner insert insert_id into isam
syn keyword mysqlKeyword         join
syn keyword mysqlKeyword         key keys kill last_insert_id leading left limit lines load local lock logs long 
syn keyword mysqlKeyword         low_priority
syn keyword mysqlKeyword         match max_rows middleint min_rows minute minute_second modify month myisam
syn keyword mysqlKeyword         natural no
syn keyword mysqlKeyword         on optimize option optionally order outer outfile
syn keyword mysqlKeyword         pack_keys partial password primary privileges procedure process processlist
syn keyword mysqlKeyword         read references reload rename replace restrict returns revoke right row rows
syn keyword mysqlKeyword         second select show shutdown soname sql_big_result sql_big_selects sql_big_tables sql_log_off
syn keyword mysqlKeyword         sql_log_update sql_low_priority_updates sql_select_limit sql_small_result sql_warnings starting
syn keyword mysqlKeyword         status straight_join string
syn keyword mysqlKeyword         table tables temporary terminated to trailing type
syn keyword mysqlKeyword         unique unlock unsigned update usage use using
syn keyword mysqlKeyword         values varbinary variables varying
syn keyword mysqlKeyword         where with write
syn keyword mysqlKeyword         year_month
syn keyword mysqlKeyword         zerofill

" Special values
syn keyword mysqlSpecial         false null true

" Strings (single- and double-quote)
syn region mysqlString           start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region mysqlString           start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers and hexidecimal values
syn match mysqlNumber            "-\=\<[0-9]*\>"
syn match mysqlNumber            "-\=\<[0-9]*\.[0-9]*\>"
syn match mysqlNumber            "-\=\<[0-9][0-9]*e[+-]\=[0-9]*\>"
syn match mysqlNumber            "-\=\<[0-9]*\.[0-9]*e[+-]\=[0-9]*\>"
syn match mysqlNumber            "\<0x[abcdefABCDEF0-9]*\>"

" User variables
syn match mysqlVariable          "@\a*[A-Za-z0-9]*\([._]*[A-Za-z0-9]\)*"

" Comments (c-style, mysql-style and modified sql-style)
syn region mysqlComment          start="/\*"  end="\*/"
syn match mysqlComment           "#.*"
syn match mysqlComment           "--\_s.*"
syn sync ccomment mysqlComment

" Column types
"
" This gets a bit ugly.  There are two different problems we have to
" deal with.
"
" The first problem is that some keywords like 'float' can be used
" both with and without specifiers, i.e. 'float', 'float(1)' and
" 'float(@var)' are all valid.  We have to account for this and we
" also have to make sure that garbage like floatn or float_(1) is not
" highlighted.
"
" The second problem is that some of these keywords are included in
" function names.  For instance, year() is part of the name of the
" dayofyear() function, and the dec keyword (no parenthesis) is part of
" the name of the decode() function. 

syn keyword mysqlType            tinyint smallint mediumint int integer bigint 
syn keyword mysqlType            date datetime time bit bool 
syn keyword mysqlType            tinytext mediumtext longtext text
syn keyword mysqlType            tinyblob mediumblob longblob blob
syn region mysqlType             start="float\W" end="."me=s-1 
syn region mysqlType             start="float$" end="."me=s-1 
syn region mysqlType             start="float(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="double\W" end="."me=s-1
syn region mysqlType             start="double$" end="."me=s-1
syn region mysqlType             start="double(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="double precision\W" end="."me=s-1
syn region mysqlType             start="double precision$" end="."me=s-1
syn region mysqlType             start="double precision(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="real\W" end="."me=s-1
syn region mysqlType             start="real$" end="."me=s-1
syn region mysqlType             start="real(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="numeric(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="dec\W" end="."me=s-1
syn region mysqlType             start="dec$" end="."me=s-1
syn region mysqlType             start="dec(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="decimal\W" end="."me=s-1
syn region mysqlType             start="decimal$" end="."me=s-1
syn region mysqlType             start="decimal(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="\Wtimestamp\W" end="."me=s-1
syn region mysqlType             start="\Wtimestamp$" end="."me=s-1
syn region mysqlType             start="\Wtimestamp(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="^timestamp\W" end="."me=s-1
syn region mysqlType             start="^timestamp$" end="."me=s-1
syn region mysqlType             start="^timestamp(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="\Wyear(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="^year(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="char(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="varchar(" end=")" contains=mysqlNumber,mysqlVariable
syn region mysqlType             start="enum(" end=")" contains=mysqlString,mysqlVariable
syn region mysqlType             start="\Wset(" end=")" contains=mysqlString,mysqlVariable
syn region mysqlType             start="^set(" end=")" contains=mysqlString,mysqlVariable

" Logical, string and  numeric operators
syn keyword mysqlOperator        between not and or is in like regexp rlike binary exists
syn region mysqlOperator         start="isnull(" end=")" contains=ALL
syn region mysqlOperator         start="coalesce(" end=")" contains=ALL
syn region mysqlOperator         start="interval(" end=")" contains=ALL

" Control flow functions
syn keyword mysqlFlow            case when then else end
syn region mysqlFlow             start="ifnull("   end=")"  contains=ALL
syn region mysqlFlow             start="nullif("   end=")"  contains=ALL
syn region mysqlFlow             start="if("       end=")"  contains=ALL

" General Functions
"
" I'm leery of just defining keywords for functions, since according to the MySQL manual:
"
"     Function names do not clash with table or column names. For example, ABS is a 
"     valid column name. The only restriction is that for a function call, no spaces 
"     are allowed between the function name and the `(' that follows it. 
"
" This means that if I want to highlight function names properly, I have to use a 
" region to define them, not just a keyword.  This will probably cause the syntax file 
" to load more slowly, but at least it will be 'correct'.

syn match mysqlFunction "abs"
syn match mysqlFunction "acos"
syn match mysqlFunction "adddate"
syn match mysqlFunction "ascii"
syn match mysqlFunction "asin"
syn match mysqlFunction "atan"
syn match mysqlFunction "atan2"
syn match mysqlFunction "benchmark"
syn match mysqlFunction "bin"
syn match mysqlFunction "bit_and"
syn match mysqlFunction "bit_count"
syn match mysqlFunction "bit_or"
syn match mysqlFunction "ceiling"
syn match mysqlFunction "character_length"
syn match mysqlFunction "char_length"
syn match mysqlFunction "concat"
syn match mysqlFunction "concat_ws"
syn match mysqlFunction "connection_id"
syn match mysqlFunction "conv"
syn match mysqlFunction "cos"
syn match mysqlFunction "cot"
syn match mysqlFunction "count"
syn match mysqlFunction "curdate"
syn match mysqlFunction "curtime"
syn match mysqlFunction "date_add"
syn match mysqlFunction "date_format"
syn match mysqlFunction "date_sub"
syn match mysqlFunction "dayname"
syn match mysqlFunction "dayofmonth"
syn match mysqlFunction "dayofweek"
syn match mysqlFunction "dayofyear"
syn match mysqlFunction "decode"
syn match mysqlFunction "degrees"
syn match mysqlFunction "elt"
syn match mysqlFunction "encode"
syn match mysqlFunction "encrypt"
syn match mysqlFunction "exp"
syn match mysqlFunction "export_set"
syn match mysqlFunction "extract"
syn match mysqlFunction "field"
syn match mysqlFunction "find_in_set"
syn match mysqlFunction "floor"
syn match mysqlFunction "format"
syn match mysqlFunction "from_days"
syn match mysqlFunction "from_unixtime"
syn match mysqlFunction "get_lock"
syn match mysqlFunction "greatest"
syn match mysqlFunction "group_unique_users"
syn match mysqlFunction "hex"
syn match mysqlFunction "inet_aton"
syn match mysqlFunction "inet_ntoa"
syn match mysqlFunction "instr"
syn match mysqlFunction "lcase"
syn match mysqlFunction "least"
syn match mysqlFunction "length"
syn match mysqlFunction "load_file"
syn match mysqlFunction "locate"
syn match mysqlFunction "log"
syn match mysqlFunction "log10"
syn match mysqlFunction "lower"
syn match mysqlFunction "lpad"
syn match mysqlFunction "ltrim"
syn match mysqlFunction "make_set"
syn match mysqlFunction "master_pos_wait"
syn match mysqlFunction "max"
syn match mysqlFunction "md5"
syn match mysqlFunction "mid"
syn match mysqlFunction "min"
syn match mysqlFunction "mod"
syn match mysqlFunction "monthname"
syn match mysqlFunction "now"
syn match mysqlFunction "oct"
syn match mysqlFunction "octet_length"
syn match mysqlFunction "ord"
syn match mysqlFunction "period_add"
syn match mysqlFunction "period_diff"
syn match mysqlFunction "pi"
syn match mysqlFunction "position"
syn match mysqlFunction "pow"
syn match mysqlFunction "power"
syn match mysqlFunction "quarter"
syn match mysqlFunction "radians"
syn match mysqlFunction "rand"
syn match mysqlFunction "release_lock"
syn match mysqlFunction "repeat"
syn match mysqlFunction "reverse"
syn match mysqlFunction "round"
syn match mysqlFunction "rpad"
syn match mysqlFunction "rtrim"
syn match mysqlFunction "sec_to_time"
syn match mysqlFunction "session_user"
syn match mysqlFunction "sign"
syn match mysqlFunction "sin"
syn match mysqlFunction "soundex"
syn match mysqlFunction "space"
syn match mysqlFunction "sqrt"
syn match mysqlFunction "std"
syn match mysqlFunction "stddev"
syn match mysqlFunction "strcmp"
syn match mysqlFunction "subdate"
syn match mysqlFunction "substring"
syn match mysqlFunction "substring_index"
syn match mysqlFunction "subtime"
syn match mysqlFunction "sum"
syn match mysqlFunction "sysdate"
syn match mysqlFunction "system_user"
syn match mysqlFunction "tan"
syn match mysqlFunction "time_format"
syn match mysqlFunction "time_to_sec"
syn match mysqlFunction "to_days"
syn match mysqlFunction "trim"
syn match mysqlFunction "ucase"
syn match mysqlFunction "unique_users"
syn match mysqlFunction "unix_timestamp"
syn match mysqlFunction "upper"
syn match mysqlFunction "user"
syn match mysqlFunction "version"
syn match mysqlFunction "week"
syn match mysqlFunction "weekday"
syn match mysqlFunction "yearweek"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_mysql_syn_inits")
  if version < 508
    let did_mysql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink mysqlKeyword            Statement
  HiLink mysqlSpecial            Special
  HiLink mysqlString             String
  HiLink mysqlNumber             Number
  HiLink mysqlVariable           Identifier
  HiLink mysqlComment            Comment
  HiLink mysqlType               Type
  HiLink mysqlOperator           Statement
  HiLink mysqlFlow               Statement
  HiLink mysqlFunction           Function

  delcommand HiLink
endif

let b:current_syntax = "mysql"

