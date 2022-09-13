"  Description: My own functions and commands for daily use
"  				hope this will let my(perhaps yours) Vimming life easier :)
"  	Maintainer: Linsong Wang (linsong dot qizi at gmail dot com)
"  Last Change: Sun Aug 21 15:26:04     2005
"      Version: 1.0
"      History:
"      		    1.0) add a command MyWrap
"        Usage:
"               read the documents around the commands/functions
" avoid reload script {{{1
if exists("loaded_myplugin")
	finish
endif

let loaded_myplugin = 1

" MyCount(initial,delta) {{{1
" MyCount function to get a number sequence,this is very useful when we want
" to substitute a number sequence to lines, for example:
"     :let i=0 | %s/^hello.*$/\=submatch(0).MyCount("i",10)
" the above command will append 10,20,30,40 ... to all lines that start with
" "hello".
" Note: another method(maybe more flexible) to do it is:
"  g// s/^\([^ ]\+\)\s\(.*\)$/\="File" . i . "=" . submatch(1) . "^M" . "Title" . i . "=" . submatch(2) . "^M" . "Length" . i . "=-1"/ | let i +=1
"  the command after "g//" will be executed for every line
"
" the second argument is the delta value
function! MyCount(initial,...)
	if a:0 > 0
		let delta = a:1
	else
		let delta = 1
	endif
	let g:{a:initial} = g:{a:initial} + delta
	return g:{a:initial}
endfunction

"Toggle Transparency {{{1
function! ToggleTransparency()
    let new_val = 100 - str2nr(&transparency)
    exec "set transparency=" . new_val
endfunction
"}}}1

"display git branch info is possible {{{1
function! StatusInfo()
  if exists('*fugitive#statusline')
    return fugitive#statusline()
  else
    return ''
  endif
endfunction
"}}}1

" vim:ft=vim foldmethod=marker ts=4 sw=4 expandtab
