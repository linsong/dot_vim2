" This creates a keyword ERROR and puts it in the highlight group called logError
syn keyword logError ERROR
syn keyword logWarn WARN
syn keyword logInfo INFO
syn keyword logDebug DEBUG

" This creates a match on the date and puts in the highlight group called logDate.  The
" nextgroup and skipwhite makes vim look for logTime after the match
syn match logDate /\d\{4}-\d\{2}-\d\{2}/ skipwhite

syn match logTime /\d\{2}:\d\{2}:\d\{2}.\d\{3}/

syn match logErrorText /\(can not\)\|can't\|fail\(ed\|ure\)?\|unexpected/

" Now make them appear:
" Link just links logError to the colouring for error
hi link logError Error
hi link logWarn Function
hi link logInfo Comment
hi link logDebug Identifier

hi link logDate Constant
hi link logTime Constant

hi link logErrorText Identifier

" Def means default colour - colourschemes can override
" hi def logDate guibg=yellow guifg=blue
" hi def logTime guibg=green guifg=white
