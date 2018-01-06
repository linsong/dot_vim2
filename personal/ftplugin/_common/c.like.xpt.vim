" Save this file as ~/.vim/ftplugin/c/hello.xpt.vim(or
" ~/vimfiles/ftplugin/c/hello.xpt.vim).
" Then you can use it in C language file:
"     vim xpt.c
" And type:
"     helloxpt<C-\>
"
XPTemplate priority=personal+

XPT once wrap	" #ifndef .. #define ..
XSET symbol=headerSymbol()
#ifndef `symbol^
#define `symbol^

`cursor^
#endif `$CL^ `symbol^ `$CR^
