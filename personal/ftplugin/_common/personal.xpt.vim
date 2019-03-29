" Move me to your own fptlugin/_common and config your personal information.
"
" Here is the place to set personal preferences; "priority=personal" is the
" highest which overrides any other XPTvar setting.
"
" You can also set personal variables with 'g:xptemplate_vars' in your .vimrc.
XPTemplate priority=personal


" XPTvar $author       you have not yet set $author variable
" XPTvar $email        you have not yet set $email variable

" containers
let s:f = g:XPTfuncs()

" ========================= Function and Variables =============================

" added by vincent 2013/10/18 {{{
fun! s:f.capitalize( v )
  return substitute(a:v, '^.', '\u&', '')
endfunction

fun! s:f.camelCase(...)
  let str = a:0 == 0 ? self.V() : a:1
  let r = substitute(substitute(str, "[\/ _]", ' ', 'g'), '\<.', '\u&', 'g')
  return substitute(r, " ", '', 'g')
endfunction

fun! s:f.now()
  return strftime("%Y%m%d_%H%M%S")
endfunction

fun! s:f.startOfWeekDate()
  let startOfWeek = system('date -v-5d "+%Y/%m/%d"')
  return startOfWeek 
endfunction

fun! s:f.endOfWeekDate()
  return strftime("%Y/%m/%d")
endfunction
" added by vincent }}}

XPT now 
`now()^

XPT time
`strftime("%T")^

XPT timestamp 
`strftime("%s")^

