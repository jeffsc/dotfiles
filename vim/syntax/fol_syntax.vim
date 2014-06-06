" Vim syntax file
" Language:	FOL Log Plugin
" Maintainer:	Krishna Maheshwari (krishna@amazon.com)
" Last Change:	2003 Dec 12

" Only do this when not done yet for this buffer
"if version < 600
"  syntax clear
"elseif exists("b:current_syntax")
"  finish
"endif

syntax clear
syntax case match

syntax keyword fol_log_Debug DEBUG contained
syntax keyword fol_log_Info INFO contained
syntax keyword fol_log_Verbose VERBOSE contained
syntax keyword fol_log_Error ERROR contained
syntax keyword fol_log_Warning WARNING contained
syntax keyword fol_log_Fatal FATAL contained
syntax keyword fol_log_Forced FORCED contained

"syntax match fol_log_date /^\a\{3} \a\{3} \d\{2} \d\{2}:\d\{2}:\d\{2} \d\{4} \u\{3} / contained
"syntax match fol_log_service /^\a\{3} \a\{3} \d\{2} \d\{2}:\d\{2}:\d\{2} \d\{4} \u\{3} [^ ]\+ / contains=fol_log_date
"syntax match   fol_log_logging_service /\([^ ]\+\) \([^ ]\+\) \([^ ]\+\) \([^ ]\+\) \([^ ]\+\) \([^ ]\+\) \([^ ]\+\) /

syntax match eq                              /=/ contained
syntax match at                              /@/ contained
syntax match dash                            /-/ contained
syntax match number                          /\d\+/ contained
syntax match date                            /\d\d\d\d-\d\d-\d\d/ contained
syntax match time                            /\d\d:\d\d:\d\d.\d\+Z/ contained
syntax match dateAndtime                     /\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d\.\d\+Z/ contains=date,time contained
syntax match dateAndtime2                    /\w\w\w \w\w\w \d\d \d\d:\d\d:\d\d \d\d\d\d GMT/ contained
syntax match appname                         /[A-Za-z-]\+/ contained
syntax match pidAndhost                      /\d\+\-\d\+@[a-z-.0-9]\+/ contains=at contained
syntax match unquoted_string                 /[^"]\+/ contained
syntax match quoted_string                   /"[^"]\+"/ contains=unquoted_string contained
syntax match orderId                         /\d\d\d-\d\d\d\d\d\d\d-\d\d\d\d\d\d\d/ contained
syntax match orderString                     /objectId="\d\d\d-\d\d\d\d\d\d\d-\d\d\d\d\d\d\d"/ contains=eq,orderId contained
"syntax keyword success                       SUCCESS contained
"syntax match conditionValue                  /conditionValue="[A-Z]\+"/ contains=success contained

syntax match fol_log_pubsub_realm            /\*realm\*="[^"]\+"/   contains=quoted_string,eq contained
syntax match fol_log_pubsub_host             /\*host\*="[^"]\+"/    contains=quoted_string,eq contained
syntax match fol_log_pubsub_appname          /\*appname\*="[^"]\+"/ contains=quoted_string,eq contained
syntax match fol_log_pubsub_user             /\*user\*="[^"]\+"/    contains=quoted_string,eq contained
syntax match fol_log_pubsub_pid              /\*pid\*=\d\+/         contains=eq,number contained
syntax match fol_log_pubsub_timestamp        /\*timestamp\*=\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d\.\d\+Z/ contains=eq,dateAndtime contained

syntax keyword fol_log_pubsub_publish          publish contained
syntax match   fol_log_pubsub_publish_paren    /publish([^)]\+)/ contains=fol_log_pubsub_publish contained
syntax keyword fol_log_pubsub_reply            reply contained
syntax match   fol_log_pubsub_reply_paren      /reply([^)]\+)/ contains=fol_log_pubsub_reply contained
syntax match   fol_log_pubsub_subject          /[_A-Za-z.\-0-9]\+/ contains=fol_log_pubsub_reply_paren contained
syntax match   fol_log_pubsub_subject_delim    /reply([^)]\+):* [_A-Za-z.\-]\+/ contains=fol_log_pubsub_reply_paren,fol_log_pubsub_subject contained
syntax match   fol_log_subject_sent            /FLRVEventLoop: publish([^)]\+): reply([^)]\+) .*$/ contains=fol_log_pubsub_reply_paren_host,fol_log_pubsub_publish_paren,fol_log_pubsub_reply_paren,fol_log_pubsub_subject_delim,orderString,conditionValue,backtrace contained
syntax keyword fol_log_pubsub_received         received contained
syntax match   fol_log_pubsub_receive_paren    /received ([^)]\+)/ contains=fol_log_pubsub_received contained
syntax match   fol_log_subject_recv            /FLRVEventLoop: onMsg() received ([^)]\+).*$/ contains=fol_log_pubsub_reply_paren_host,fol_log_pubsub_receive_paren,fol_log_pubsub_reply_paren,fol_log_pubsub_subject_delim,orderString,conditionValue contained
syntax match   backtrace                       / backtrace {[^}]\+}/ contained
syntax match   restofstring                    /(null)(): .*$/ contains=fol_log_subject_recv,fol_log_subject_sent,fol_log_Debug,fol_log_Info,fol_log_Verbose,fol_log_Error,fol_log_Warning,fol_log_Fatal,fol_log_Forced,backtrace contained
syntax match   fol_line                         /^\w\+ \w\+ [0-9: ]\+ GMT [a-zA-Z-]\+ \d\+-\d\+@.*$/ contains=fol_log_subject_recv,fol_log_subject_sent,dateAndtime2,appname,pidAndhost,fol_log_Debug,fol_log_Info,fol_log_Verbose,fol_log_Error,fol_log_Warning,fol_log_Fatal,fol_log_Forced,backtrace,restofstring

"syntax match fol_log_pubsub_publish_paren_nohi    /publish([^)]\+): / contained "transparent
"syntax match fol_log_pubsub_heartbeat_name /publish([^)]\+): [^( ].*heartbeat\.[a-zA-Z0-9.]*/ contains=fol_log_pubsub_publish_paren_nohi contained
"syntax match fol_log_pubsub_heartbeat /^.*$/ contains=fol_log_pubsub_heartbeat_name
"syntax match fol_log_pubsub_heartbeat /FLRVEventLoop: publish([^)]\+): [^( ].*heartbeat\.\S*: .*$/ contains=fol_log_pubsub_heartbeat_name

"syntax match   fol_log_logged_msg_junk /([^:]\+): \S\+ / contained
"syntax match   fol_log_logged_msg      /([^:]\+): \S\+ [^\(publish\)].*$/ contains=fol_log_subject_sent

"highlight link fol_log_subject_recv Todo
"highlight app_pid term=standout ctermfg=11 ctermbg=8 guifg=Cyan guibg=DarkGrey
"highlight link fol_log_realm Todo
"highlight link fol_log_logging_service Todo
"highlight link fol_log_subject_sent Todo
"highlight link fol_log_subject_recv Todo


highlight fol_log_Forced term=standout ctermfg=11 ctermbg=8 guifg=#33EE66
highlight fol_log_Verbose term=standout ctermfg=11 ctermbg=8 guifg=#66FF66
highlight fol_log_Debug term=bold ctermfg=9 ctermbg=3 guifg=#669933
highlight fol_log_Info term=reverse cterm=reverse gui=bold
highlight fol_log_Warning term=bold ctermbg=1 guifg=LightBlue
highlight fol_log_Error term=reverse ctermfg=0 ctermbg=14 guifg=Black guibg=Yellow
highlight fol_log_Fatal term=reverse,bold,underline cterm=bold,underline gui=bold,underline ctermfg=15 ctermbg=12 guifg=White guibg=Red

"highlight fol_log_logged_msg term=underline ctermfg=13 guifg=#ffa0a0
"highlight fol_log_service term=bold ctermfg=11 guifg=#80a0ff

highlight fol_log_pubsub_subject term=underline ctermfg=14 guifg=Yellow        
highlight fol_log_pubsub_publish term=underline ctermfg=14 guifg=Yellow
highlight fol_log_pubsub_received term=underline ctermfg=14 guifg=Yellow
"highlight fol_log_subject_sent term=reverse, ctermfg=15 ctermbg=12 guifg=White guibg=Red
"highlight fol_log_pubsub_realm term=underline ctermfg=14 guifg=Yellow
"highlight fol_log_pubsub_host term=underline ctermfg=14 guifg=Yellow
"highlight fol_log_pubsub_appname term=underline ctermfg=14 guifg=Yellow
highlight fol_log_pubsub_reply term=underline ctermfg=14 guifg=Yellow
highlight fol_log_pubsub_user term=underline ctermfg=14 guifg=Yellow
highlight fol_log_pubsub_pid term=underline ctermfg=14 guifg=Yellow
"highlight fol_log_pubsub_timestamp term=underline ctermfg=14 guifg=Yellow
highlight unquoted_string term=underline ctermfg=14 guifg=Magenta
highlight date term=underline ctermfg=14 guifg=Magenta
highlight time term=underline ctermfg=14 guifg=Magenta
"highlight success term=underline ctermfg=14 guifg=Magenta
highlight orderId term=underline ctermfg=14 guifg=Magenta
highlight fol_log_pubsub_reply_paren_host term=underline ctermfg=14 guifg=Cyan
highlight pidAndhost term=underline ctermfg=14 guifg=Cyan
highlight backtrace term=underline ctermfg=13 guifg=#ffa0a0
highlight restofstring term=bold ctermfg=11 guifg=#80a0ff

"highlight error term=reverse, ctermfg=15 ctermbg=12 guifg=White guibg=Red
"highlight fol_log_pubsub_heartbeat_name guifg=Blue
"highlight fol_log_pubsub_heartbeat guifg=Black
"syntax match fol_log_pubsub_heartbeat_name /[^( ].*heartbeat\.\S*:/ contained
"syntax match fol_log_pubsub_heartbeat /FLRVEventLoop: publish([^)]\+): [^( ].*heartbeat\.\S*: .*$/ contains=fol_log_pubsub_heartbeat_name

let b:current_syntax = "fol"
