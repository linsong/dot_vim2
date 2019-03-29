XPTemplate priority=personal

let s:f = g:XPTfuncs()

" use snippet 'varConst' to generate contant variables
" use snippet 'varFormat' to generate formatting variables
" use snippet 'varSpaces' to generate spacing variables

XPTinclude
    \ _common/common

XPT wtitle " email title
the progress of this iteration (`startOfWeekDate()^ ~ `endOfWeekDate()^)`cursor^

XPT wc " weekly work content
Hi Lim,

  The progress of this iteration: 
    `cursor^

Cheers,
Vincent


