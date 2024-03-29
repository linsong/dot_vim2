" Linsong's vimrc comes from official vimrc example
" vim: foldmethod=marker expandtab ts=2 sw=2
"
" Maintainer:   Linsong  linsong dot qizi at gmail dot com
" Last change:  Fri Dec  9 17:58:24 CST 2005
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"         for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"       for OpenVMS:  sys$login:.vimrc

"## General Setting {{{1
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin indent on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=300      " keep 300 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching

set wildmenu
set mouse-=a " enable mouse
set ignorecase " set search ignorecase

" when If both ignorecase and smartcase are set, Vim will ignore the case
" of the search only if the search pattern is all in lower-case. But if
" there are any upper-case characters in the search pattern, Vim will
" assume you really want to do a case-sensitive search and will do
" its matching accordingly
set smartcase

set sessionoptions+=unix,slash

" set tabstop value and shift width
set ts=2
set sw=2
set expandtab
set smarttab

"setting about indent
" autoindent is not very convenient especially when editing mail text,
" use filetype indent script instead
set noautoindent

" It seems smartindent make things bad instead of smart:
"  > You're probably setting 'smartindent' in your .vimrc.  'smartindent'
"  > is worse than cindent for C/C++/Java, and much worse than filetype
"  > indent scripts for other languages; I'd definitely recommend against
"  > using it.
set nosmartindent

" always want at least two lines of context visible around the cursor at
" all times
" the drawback is: H/L will not arrive the real top/bottom of the buffer
"set scrolloff=2

"setting about old window resizing behavior when open a new window
set winfixheight
" not let all windows keep the same height/width
set noequalalways

:set path+=./**,../,../*,../..,../../*,$HOME/.vim/*

:set hidden

"set statusline=%<%f\ [%{&ff}]%{StatusInfo()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" setting for completion
if v:version >= 700
    :set completeopt=longest,menuone
endif

" search all the include files for a large project is deadly slow
:set complete-=i

:set wildmode=longest,full

" always display the statusline
if has("nvim")
  " :set laststatus=3 " use global status
  :set laststatus=2 " use global status
else
  :set laststatus=2
endif

" In shell scripts, there should be no spaces around "=".
" progname=/usr/local/txserver
" to open files in a shell script with gf command:
" TODO: this setting should only work when we are editing a shell
" script, but for now, just leave it here and see how it works
:set isfname -==

" save screen estate as much as possible
:set numberwidth=1

:set nobackup nowritebackup

" set tags
:set tags+=../tags,../../tags,ftags,../*.tags

:set shortmess+=c

:set number

:let g:mapleader='['
" let g:mapleader = "\<Space>"

if has("gui_macvim")
    :set transparency=5
endif

:set previewheight=25

:set listchars=tab:»-,trail:·,extends:»,precedes:«

:set showmatch "set show matching parenthesis

:set viminfo^=!

:set lazyredraw

:set modelines=5

:set splitbelow
:set splitright

" tips from https://kinbiko.com/vim/my-shiniest-vim-gems/
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

:set showtabline=0

" turn off the quote conceal, that is very annoying
let g:vim_json_syntax_conceal = 0
let g:vim_json_conceal = 0

"## }}}1

"## Encodings {{{1
    "for more details, read help usr_45.txt
    " encodings configure
    :let $LANG="en_US.UTF-8"

    " set the encoding of menu text
    :set langmenu=en_us.utf-8

    " set what is the encoding of inputted text
    if ! has("gui_running")
        :let &termencoding = &encoding
    endif
    :set encoding=utf-8

    :set fileencodings=ucs-bom,utf-8,gb2312,cp936
"## }}}1

"## General Mapping {{{1

    " Use Q for formatting the current paragraph (or selection)
    xmap Q gq
    xmap Q gqap

    " This is an alternative that also works in block mode, but the deleted
    " text is lost and it only works for putting the current register.
    xnoremap p "_d"0p
    xnoremap P "_d"0P

    " when leave insert mode by pressing <ESC>, turn off
    " the input method, but for now it does not work for SCIM :(
    :inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

    " remap builtin shift command
    :xnoremap < <gv
    :xnoremap > >gv

    " general key maps
    "### got following tip from http://www.vim.org/tips/tip.php?tip_id=1
    " Search for selected text in visual mode with */#
    " effect: overrides unnamed register
    " Simplest version: vnoremap * y/<C-R>"<CR>
    " Better one: vnoremap * y/\V<C-R>=escape(@@,"/\\")<CR><CR>
    " This is so far the best, allowing all selected characters and multiline selection:

    " Atom \V sets following pattern to "very nomagic", i.e. only the backslash has special meaning.
    " As a search pattern we insert an expression (= register) that
    " calls the 'escape()' function on the unnamed register content '@@',
    " and escapes the backslash and the character that still has a special
    " meaning in the search command (/|?, respectively).
    " This works well even with <Tab> (no need to change ^I into \t),
    " but not with a linebreak, which must be changed from ^M to \n.
    " This is done with the substitute() function.
    xnoremap * y/\V<C-R>=substitute(escape(@@,"/\\"),"\n","\\\\n","ge")<CR><CR>
    xnoremap # y?\V<C-R>=substitute(escape(@@,"?\\"),"\n","\\\\n","ge")<CR><CR>

    " the following map to make move between windows more easy!
    set winminheight=0
    nmap <C-j> <C-W>j
    nmap <C-k> <C-W>k
    nmap <C-h> <c-w>h
    nmap <C-l> <c-w>l

    " following key maps will make input mode's navigation easier
    " imap <C-j> <down>
    " imap <C-k> <up>
    imap <C-B> <Left>
    imap <C-F> <Right>
    imap <C-D> <Del>
    imap <C-A> <Home>
    imap <C-BS> <C-O>B<C-O>dE
    inoremap <C-E> <C-R>=col('.') == col('$') ? "\<lt>C-E>" : "\<lt>End>"<CR>

    " following key maps will make command mode's navigation easier
    " when input path name, use the '/' to stop a completion
    cnoremap <C-A> <Home>
    cnoremap <C-B> <left>
    cnoremap <C-F> <right>

    " <C-X> as a prefix key under command mode
    " cnoremap <C-X> <Del>

    " key maps will make increase/decrease the width/height of window easier
    nnoremap - <C-W>-
    nnoremap = <C-W>+
    nnoremap _ 5<C-W><
    nnoremap + 5<C-W>>

    nnoremap <silent> ,<space>    :nohlsearch<CR>
    " nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

    " mappings for quickfix mode
    nnoremap <space>n :cnext \| norm zz<CR>
    nnoremap <space>N :cprev \| norm zz<CR>
    nnoremap <C-F4>   :cnfile <CR>
    nnoremap <S-C-F4> :cpfile <CR>

    " MAKE IT EASY TO UPDATE/RELOAD_vimrc
    " I am short of shortcut keys, below key mapping is kind of waste, I
    " recycle them now
    "if has("gui_running")
        ":nmap ,s :source $HOME/.vimrc \| source $HOME/.gvimrc<CR>
    "else
        ":nmap ,s :source $HOME/.vimrc<CR>
    "endif
    ":nmap ,v :e $HOME/.vimrc<CR>

    " :nnoremap <silent> <M->> :if tabpagenr() == tabpagenr("$")\|tabm 0\|else\|exe "tabm ".tabpagenr()\|endif<CR>
    " :nnoremap <silent> <M-<> :if tabpagenr() == 1\|exe "tabm ".tabpagenr("$")\|else\|exe "tabm ".(tabpagenr()-2)\|endif<CR>

    if has("xterm_clipboard")
       nmap <S-Insert> :set paste<CR>"+p:set nopaste<CR>
       imap <S-Insert> <ESC>:set paste<CR>"+p:set nopaste<CR>i
    endif

    nnoremap <leader>t @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

    " nmap <leader>ff :RedoFoldOnRegex<CR>
    " nmap <leader>fu :FoldEndFolding<CR>

    " it can copy texts to last edited place continuously
    function! CopyToLastEditPos()
        let cmd = 'gip'
        if visualmode()==# 'V'
            let cmd = cmd . 'k'
        endif
        let cmd = cmd . '`>'
        :exec 'norm ' . cmd
    endfunction
    :xmap gy y:call CopyToLastEditPos()<CR>
    :nmap gy yy:call CopyToLastEditPos()<CR>

    :nmap <leader>o :only<CR>

    " I want to exchange the meaning of following shortcuts:
    :noremap <C-]> g<C-]>
    :noremap g<C-]> <C-]>

    if has("gui_macvim")
        :map <silent> <D-.> gt
        :map <silent> <D-1> :tabnext 1<CR>
        :map <silent> <D-2> :tabnext 2<CR>
        :map <silent> <D-3> :tabnext 3<CR>
        :map <silent> <D-4> :tabnext 4<CR>
        :map <silent> <D-5> :tabnext 5<CR>
        :map <silent> <D-6> :tabnext 6<CR>
        :map <silent> <D-7> :tabnext 7<CR>
        :map <silent> <D-8> :tabnext 8<CR>
        :map <silent> <D-9> :tabnext 9<CR>
        :map <silent> <D-0> :tabnext 10<CR>
        :nnoremap <silent> <D->> :if tabpagenr() == tabpagenr("$")\|tabm 0\|else\|exe "tabm ".tabpagenr()\|endif<CR>
        :nnoremap <silent> <D-<> :if tabpagenr() == 1\|exe "tabm ".tabpagenr("$")\|else\|exe "tabm ".(tabpagenr()-2)\|endif<CR>
    endif

    :map <silent> ,1 :tabnext 1<CR>
    :map <silent> ,2 :tabnext 2<CR>
    :map <silent> ,3 :tabnext 3<CR>
    :map <silent> ,4 :tabnext 4<CR>
    :map <silent> ,5 :tabnext 5<CR>
    :map <silent> ,6 :tabnext 6<CR>
    :map <silent> ,7 :tabnext 7<CR>
    :map <silent> ,8 :tabnext 8<CR>
    :map <silent> ,9 :tabnext 9<CR>
    :map <silent> ,0 :tabnext 10<CR>

    " tip from http://vim.wikia.com/wiki/Creating_new_text_objects
    :vnoremap af :<C-U>silent! normal! [zV]z<CR>
    :omap af :normal Vaf<CR>

    " http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
    nnoremap <F1> :set invpaste paste?<CR>
    imap <F1> <C-O><F1>
    set pastetoggle=<F1>

    " http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
    map ,cd :cd %:p:h<CR>

    " use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
    " (it will prompt for sudo password when writing)
    cmap w!! %!sudo tee > /dev/null %

    " Center screen on next/previous selection.
    nnoremap n nzz
    nnoremap N Nzz
    " Last and next jump should center too.
    "nnoremap <C-o> <C-o>zz
    "nnoremap <C-i> <C-i>zz

    " use two windows to view a long file
    " from vim tip wiki: http://vim.wikia.com/wiki/View_text_file_in_two_columns
    " <leader>vs is used by VsplitVifm of vifm.vim
    " :noremap <silent> <leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

    " nnoremap <silent> ;;  :silent! %s/\s\+$//g <bar> w<CR>
    nnoremap <silent> ;;  :w<CR>

    nnoremap <silent> <f5> :w <bar> make<CR>
    imap <silent> <f5> <Esc>:w<CR>:make<CR>i

    map <silent> <leader>ss :syntax sync fromstart<CR>

    if has('nvim')
      tnoremap <Esc> <C-\><C-n>
    endif

    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

    " delete chars after cursor
    imap <c-k> <ESC>lDa

"## }}}1

"## Mappings for vim keycodes {{{1
    " mappings for keycodes
    " for more details about keycode mapping, read
    "     http://groups.yahoo.com/group/vim/message/69148
    "     http://groups.yahoo.com/group/vim/message/66451
    "     http://groups.yahoo.com/group/vim/message/66414
    "     http://vim.sourceforge.net/tips/tip.php?tip_id=1272
    "
    set timeout timeoutlen=1000 ttimeoutlen=0
    if !has("gui_running")
      if &term == "win32"
      else
        "following setting does not work after I update my system
        " (from ubuntu 7.04 to 7.10)
        " set <F13>=O5Q
        " set  <F14>=O2Q
        " set  <F15>=[3;2~
        " "set <F16>=
        " set <F17>=n
        " set <F18>=q
        " set <F19>=.
        " set <F20>=,
        " set <F21>=>
        " set <F22>=<
        " set <F23>=[2~;*~
        " set <S-xF4>=O2S

        set <F13>=O1;5Q
        set  <F14>=O1;2Q
        set  <F15>=[3;2~
        set <F17>=n
        set <F18>=q
        set <F19>=.
        set <F20>=,
        set <F21>=>
        set <F22>=<
        set <F23>=[2~;*~
        set <S-xF4>=O1;2S
        set <F24>=O1;5S
        set <F25>=O1;6S
        set <F26>=OF

        nmap <F13> <C-F2>
        nmap <F14> <S-F2>
        imap <F15> <S-Del> " this map does not work, don't know why
        map <F17> <M-n>
        map <F18> <M-q>
        map <F19> <M-.>
        map <F20> <M-,>
        map <F21> <M->>
        map <F22> <M-<>
        map <F23> <S-Insert>
        map <F24> <C-F4>
        map <F25> <C-S-F4>
        map <F26> <end>
      endif
    endif
    if !has("gui_running") && !has("nvim") && exists("&term")
        :set term=builtin_ansi
    endif

    if has('clipboard')
      :nmap ,cp :let @*=expand('%:p')<CR>
      :nmap ,cpd :let @*=expand('%:p:h')<CR>
      :nmap ,cpf :let @*=expand('%:t')<CR>
    endif

"## }}}1

"## General function defination {{{1
    function! MyFoldText()
        let line = getline(v:foldstart)
        let nnum = nextnonblank(v:foldstart + 1)
        let nextline = getline(nnum)
        if nextline =~ '^\s\+"""$'
            let line = line . getline(nnum + 1)
        elseif nextline =~ '^\s\+"""'
            let line = line . ' ' . matchstr(nextline, '"""\zs.\{-}\ze\("""\)\?$')
        elseif nextline =~ '^\s\+"[^"]\+"$'
            let line = line . ' ' . matchstr(nextline, '"\zs.*\ze"')
        elseif nextline =~ '^\s\+pass\s*$'
            let line = line . ' pass'
        endif
        let size = 1 + v:foldend - v:foldstart
        if size < 10
            let size = " " . size
        endif
        if size < 100
            let size = " " . size
        endif
        if size < 1000
            let size = " " . size
        endif
        return "[" . size . "] " . line
    endfunction

    " [Modified by me] define indent block text object
    " Changes to allow blank lines in blocks, and double
    " blank lines as block delimiter
    " Press: vai, vii to select outer/inner python blocks by indetation.
    " Press: vii, yii, dii, cii to select/yank/delete/change an indented block.
    onoremap <silent>ai :<C-u>call IndTxtObj(0)<CR>
    onoremap <silent>ii :<C-u>call IndTxtObj(1)<CR>
    vnoremap <silent>ai :<C-u>call IndTxtObj(0)<CR><Esc>gv
    vnoremap <silent>ii :<C-u>call IndTxtObj(1)<CR><Esc>gv

    function! IndTxtObj(inner)
        let curcol = col(".")
        let curline = line(".")
        let lastline = line("$")
        let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
        let i = i < 0 ? 0 : i
        if getline(".") =~ "^\\s*$"
            return
        endif

        let p = line(".") - 1
        let pp = line(".") - 2
        let nextblank = getline(p) =~ "^\\s*$"
        let nextnextblank = getline(pp) =~ "^\\s*$"
        while p > 0 && !(nextblank && nextnextblank) && ( nextblank || indent(p) >= i )
            -
            let p = line(".") - 1
            let pp = line(".") - 2
            let nextblank = getline(p) =~ "^\\s*$"
            let nextnextblank = getline(pp) =~ "^\\s*$"
        endwhile
        if (!a:inner)
            -
        endif

        normal! 0V
        call cursor(curline, curcol)

        let p = line(".") + 1
        let pp = line(".") + 2
        let nextblank = getline(p) =~ "^\\s*$"
        let nextnextblank = getline(pp) =~ "^\\s*$"
        while p <=lastline && !(nextblank && nextnextblank) && ( nextblank || indent(p) >= i )
            +
            let p = line(".") + 1
            let pp = line(".") + 2
            let nextblank = getline(p) =~ "^\\s*$"
            let nextnextblank = getline(pp) =~ "^\\s*$"
        endwhile
        if (!a:inner)
            +
        endif

        normal! $
    endfunction

    onoremap <silent>aI :<C-u>call IndTxtObj2(0)<CR>
    onoremap <silent>iI :<C-u>call IndTxtObj2(1)<CR>
    vnoremap <silent>aI :<C-u>call IndTxtObj2(0)<CR><Esc>gv
    vnoremap <silent>iI :<C-u>call IndTxtObj2(1)<CR><Esc>gv
    function! IndTxtObj2(inner)
        let curcol = col(".")
        let curline = line(".")
        let lastline = line("$")
        let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
        let i = i < 0 ? 0 : i
        if getline(".") =~ "^\\s*$"
            return
        endif

        let p = line(".") - 1
        let nextblank = getline(p) =~ "^\\s*$"
        while p > 0 && ( nextblank || indent(p) >= i )
            -
            let p = line(".") - 1
            let nextblank = getline(p) =~ "^\\s*$"
        endwhile
        if (!a:inner)
            -
        endif

        normal! 0V
        call cursor(curline, curcol)

        let p = line(".") + 1
        let nextblank = getline(p) =~ "^\\s*$"
        while p <=lastline && ( nextblank || indent(p) >= i )
            +
            let p = line(".") + 1
            let nextblank = getline(p) =~ "^\\s*$"
        endwhile
        if (!a:inner)
            +
        endif

        normal! $
    endfunction

    "convert TOhtml's result into a table, that can be pasted into web forum
    function! MyToHtml(line1, line2)
      " make sure to generate in the correct format
      let old_css = 1
      if exists('g:html_use_css')
        let old_css = g:html_use_css
      endif
      let g:html_use_css = 0

      " generate and delete unneeded lines
      exec a:line1.','.a:line2.'TOhtml'
      %g/<body/normal k$dgg

      " convert body to a table
      %s/<body\s*\(bgcolor="[^"]*"\)\s*text=\("[^"]*"\)\s*[^>]*>/<table \1 cellPadding=0><tr><td><font color=\2>/
      %s#</body>\(.\|\n\)*</html>#\='</font></td></tr></table>'#i

      " restore old setting
      let g:html_use_css = old_css
    endfunction
    command! -range=% MyToHtml :call MyToHtml(<line1>,<line2>)
    " }}}2

    " http://vim.wikia.com/wiki/Quickly_switch_between_pager-like_and_editor-like_scroll {{{2
    function! LessMode()
        if g:lessmode == 0
            let g:lessmode = 1
            let onoff = 'on'
            " Scroll half a page down
            noremap <script> d <C-D>
            " Scroll one line down
            noremap <script> j <C-E>
            " Scroll half a page up
            noremap <script> u <C-U>
            " Scroll one line up
            noremap <script> k <C-Y>
        else
            let g:lessmode = 0
            let onoff = 'off'
            unmap d
            unmap j
            unmap u
            unmap k
        endif
        echohl Label | echo "Less mode" onoff | echohl None
    endfunction
    let g:lessmode = 0
    nnoremap <F6> :call LessMode()<CR>
    inoremap <F6> <Esc>:call LessMode()<CR>
    " }}}2
"}}}1

"## Platform dependent Setting {{{1
    if has('win32')  " windows specific setting{{{2
        set runtimepath=~/.vim,$VIMRUNTIME

        "setting about word complete
        :set complete+=k$VIM/vimfiles/dictionary/*

        " run any program and open any files in windows just like the exporler
        :nmap <LEADER>go :silent !c:/WINDOWS/COMMAND/start <cWORD><CR>
        :vmap <LEADER>go y:silent !c:/WINDOWS/COMMAND/start <C-R>"<CR>

        " let vim to use ctags to generate tags file"
        let Tlist_Ctags_Cmd = 'C:\unzipped\ctags\ctags552\ctags.exe'

        " grep use the UnixUtils that port to Win32 by GNU,this can be imply by set
        " path environment,so the following is useless
        "
        "    if (expand('$VIM/vimtools') != '')
        "       let Grep_Path = expand('$VIM/vimtools/grep')
        "       " Location of the fgrep utility
        "       let Fgrep_Path = expand('$VIM/vimtools/fgrep')
        "       " Location of the egrep utility
        "       let Egrep_Path = expand('$VIM/vimtools/egrep')
        "       " Location of the agrep utility
        "       let Agrep_Path = expand('$VIM/vimtools/agrep')
        "       " Location of the find utility
        "       let Grep_Find_Path = expand('$VIM/vimtools/find')
        "       " Location of the xargs utility
        "       let Grep_Xargs_Path = expand('$VIM/vimtools/xargs')
        "   endif

        " settings for pydoc.vim to find pydoc command in windows
         let g:pydoc_cmd = 'C:\Python24\Lib\pydoc.pyc'"

        "the following option will always yank to * register
        "this is very helpful under Windows
        :set clipboard=unamed

        " windows setting end }}}2
    elseif has('macunix') "macosx specific settings {{{2
      if !has('gui_vimr')
        "set guifont=Monaco:h13
        " set guifont=Source\ Code\ Pro:h18
        " set guifont=Anonymous\ Pro:h18
        " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h18
        set guifont=DejaVu\ Sans\ Mono\ Nerd\ Font:h18
        let Grep_Xargs_Options = '-0'
      endif
        " macosx specific settings end}}}2
    else  " linux like platform specific setting {{{2
        " put some untested or untrusted plugin into .vim-experiment folder,
        " don't mess up .vim
        "set runtimepath+=~/.vim-experiment
        "setting about word complete
        :set complete+=U,k/usr/dict/*,k$VIM/vimfiles/dictionary/*
        ":set complete+=k/usr/dict/*,k$VIM/vimfiles/dictionary/*

        " set grep program
        ":set grepprg=grep\ -n
        :set grepprg=/opt/local/bin/grep\ -n


        " extends manpageview to support reading pydoc in vim
        " manpageview is very extensible especially for man like
        " doc utilities(perldoc, pydoc etc)
        let g:manpageview_pgm_py = "/opt/local/bin/pydoc"

    " linux setting end
    endif "}}}2

    "### console mode setting {{{2
    "TODO: need to set wildmode, for more details, :help 'wildmode'
    " use menu in console mode
    if !has("gui_running")
      "### color scheme settings {{{3
      " to enable 256 colors, you need to put following lines into .vimrc.local file
      :set t_Co=256 " enable 256 colors refs: http://vim.wikia.com/wiki/256_colors_in_vim
      """ NOTE: to make 256 colors work in GNU screen, screen need to be
      """       configured with ./configure --enable-colors256

      " xterm16 color scheme setting
      let xterm16_brightness = 'default'     " Change if needed
      let xterm16_colormap = 'allblue'       " Change if needed
      "### }}}3

      :source $VIMRUNTIME/menu.vim
      :set cpo-=<
      :set wcm=<C-Z>
      :map <M-e> :emenu <C-Z>

      " don't clear vim text in terminal when exit
      :set t_ti= t_te=
    endif
    "### }}}2
"## }}}1

"## Autocmds {{{1
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " for details about how to define a augroup, :help augroup

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78
        autocmd FileType svnlog :call FoldOnRegex('^r\d\{1,\}\>', -1)

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

        " turn off the bell and visual flash
        autocmd VimEnter * set vb t_vb=

        " display the status line in different ways based on the current
        " editing mode
        if version >= 700
           au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
           au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
        endif

        autocmd filetype crontab setlocal nobackup nowritebackup

    augroup END

    " settings related to specified file type. but checkings for file type
    " should be put into ~/.vim/ftdetect/mine.vim
    augroup ft_augroup
        au!
        :au BufRead /etc/network/interfaces :set syntax=interfaces

        " remove trailing whitespace automatically
        :au BufWritePre *.py :%s/\s\+$//e

        " autocmd for read MS Word document
        " Vim Tip 790 - view word documents in Vim (good for diff'ing)
        :autocmd BufReadPre *.doc set ro
        :autocmd BufReadPre *.doc set hlsearch
        :autocmd BufReadPost *.doc %!antiword "%"

        " read pdf in vim
        if has('unix')
            :au BufReadPre *.pdf set ro
            :au BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - | fmt -csw78
        elseif has('win32')
            "use pdftotext that comes cygwin
        endif

        ":autocmd User Rails             colorschem vividchalk
        :autocmd User Rails.controller* set ft=railscontroller.ruby
        :autocmd User Rails.model.arb*  set ft=railsmodel.ruby
        :autocmd User Rails.test*       set ft=railstest.ruby
        :autocmd User Rails.migration*  set ft=railsmigration.ruby
        :autocmd User Rails.view.erb*   set ft=railsview.eruby
        :autocmd User Rails             let g:Grep_Skip_Dirs = join(['log', 'vender', 'index', 'tmp', 'wireframes', 'graphs', 'documents', 'pdf_forms', 'performance'] + Grep_Skip_Dirs_List, ' ')

        autocmd FileType html setlocal ts=2
        autocmd FileType html setlocal sw=2
    augroup END

    "comment it out because it cause too many git diffs
    "" remove trailing whitespace and file end new lines during save
    " augroup TrimTrailingWhiteSpace
    "     au!
    "     au BufWritePre * %s/\s\+$//e
    "     au BufWritePre * %s/\n\+\%$//e
    " augroup END
    "}}}4
    
    if exists("##TermOpen") 
      autocmd TermOpen * setlocal nonumber norelativenumber
    endif

    " syntax omnicomplete {{{2
    if has("autocmd") && exists("+omnifunc")
      augroup omniFunc_augroup
        autocmd Filetype *
                \   if &omnifunc == "" |
                \       setlocal omnifunc=syntaxcomplete#Complete |
                \   endif
      augroup END
    endif
    "}}}2
    
endif " has("autocmd")
"## }}}1

"## Abbreviations {{{1

    "normal abbreviations
    abbr teh the
    abbr widht width
    abbr rigth right

"## }}}1

"## Commands & Functions {{{1

    "### String Object defination {{{2
        " customized string object from http://vim.sourceforge.net/tips/tip.php?tip_id=901
        " with this, we can use commands: da", yi' etc
        function! StringObject(delim,mode)
            if a:mode == 'i'
                let c = 'normal T' . a:delim . 'vt' . a:delim
            elseif a:mode == 'a'
                let c = 'normal F' . a:delim . 'vf' . a:delim
            endif
            execute c
        endfunction

        omap a" :call StringObject('"','a')<cr>
        omap i" :call StringObject('"','i')<cr>
        omap a' :call StringObject("'",'a')<cr>
        omap i' :call StringObject("'",'i')<cr>

        vmap a" <esc>:call StringObject('"','a')<cr>
        vmap i" <esc>:call StringObject('"','i')<cr>
        vmap a' <esc>:call StringObject("'",'a')<cr>
        vmap i' <esc>:call StringObject("'",'i')<cr>
    "### }}}2

    "### add a simple patch for manpageview.vim: check using which doc {{{2
    "tools according to current context
    let g:manpageview_winopen="reuse"
    "nmap <silent> <leader>k  :call FTSMan(expand("<cword>")) <CR>
    " nmap <silent> <leader>k  :call FTSMan(expand("<cword>")) <CR>
    " vmap <silent> <leader>k  :call FTSMan('"'.GetVisualSelectionEscaped("").'"') <CR>
    " File Type Sessitive Man function
    function! FTSMan(word)
        let manpagetopic = substitute(a:word,'[,.;]$','','')
        if &ft == 'python'
            exe "Man " . manpagetopic . ".py"
        elseif &ft == 'perl'
            exe "Man " . manpagetopic . ".pl"
        elseif &ft == 'ruby'
            exe "Man " . manpagetopic . ".rb"
        elseif &ft == 'ri'
            exe "Man " . manpagetopic . ".ri"
        else
            exe "Man " . manpagetopic
        endif
    endfunction

    if !exists("g:manpageview_pgm_rb")
      if executable("fri")
        let g:manpageview_pgm_rb     = "fri"
        let g:manpageview_syntax_rb  = "ruby"

        let g:manpageview_pgm_ri     = "fri"
        let g:manpageview_syntax_ri  = "ruby"
      elseif executable("ri")
        let g:manpageview_pgm_rb     = "ri"
        let g:manpageview_syntax_rb  = "ruby"

        let g:manpageview_pgm_ri     = "ri"
        let g:manpageview_syntax_ri  = "ruby"
      else
      endif
    endif

    " }}}2

    " ### define abbreviation only works under command line, a very smart function {{{2
    " this function comes from a comment of tip http://vim.sourceforge.net/tips/tip.php?tip_id=1285
        function! CommandCabbr( abbreviation, expansion )
            execute 'cabbr ' .  a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
        endfunction
        com!  -nargs=+ CommandCabbr call CommandCabbr( <f-args> )
        " Use it itself to define a simpler abbreviation for itself...
        CommandCabbr ccab CommandCabbr
    " }}}2

    "### function that will fold file based on specified regex pattern {{{2
        function! FoldOnRegex(...)
            if a:0 >= 1
                let regex_string = a:1
            endif
            if a:0 == 2
                let force_to_fold = a:2
            endif

            let do_fold = 0
            if a:0 == 2 && force_to_fold == 1
                let do_fold = 1
            elseif exists("b:FoldRegex") == 0
                let do_fold = 1
            endif

            if do_fold == 1
                let b:FoldRegex = regex_string
                if exists(":FoldMatching")!=2
                    :runtime plugin/foldutils.vim
                endif
                exec 'FoldMatching ' . regex_string . ' -1'
            endif
        endfunction
        :command! -nargs=0 RedoFoldOnRegex call FoldOnRegex(b:FoldRegex, 1)

        function! LimitOnRegex(...)
            let regex_string = expand("<cword>")
            let context_line = -1
            if a:0 >= 1
                let regex_string = a:1
            endif
            if a:0 == 2
                let context_line = a:2
            endif
            exec 'FoldMatching ' . regex_string . ' ' . context_line
        endfunction
        :command! -nargs=* LimitOnRegex call LimitOnRegex(<f-args>)
        " the usage of "<C-R>=" is very powerful! :)
        :noremap ,ll :LimitOnRegex <C-R>=expand("<cword>")<CR>
        :vnoremap ,ll :call LimitOnRegex(GetVisualSelectionEscaped("enV"), -1)<CR>
    " }}}2

"## }}}1

    "## Plugin related settings {{{1
  if filereadable(expand('~/.vim/LoadPlugin.vim'))
    source ~/.vim/LoadPlugin.vim
  endif

    "### setting for netrw.vim {{{2
    " set what kind of files we will ignore
    let g:netrw_list_hide='^\..*$,^.*\~$,^.*\.pyc$'
    let g:netrw_liststyle=1 "use tree list style
    "let g:netrw_altv          = 1
    let g:netrw_fastbrowse    = 2
    let g:netrw_keepdir       = 0
    let g:netrw_silent        = 1
    let g:netrw_special_syntax= 1
    let g:netrw_altv          = 1
    let g:netrw_fastbrowse    = 2
    let g:netrw_keepdir       = 0
    let g:netrw_liststyle     = 2
    let g:netrw_retmap        = 0
    let g:netrw_silent        = 1
    let g:netrw_special_syntax= 1
    "### }}}2

    "### setting for NERD_comments.vim {{{2
    "make NERD_comments silent
    let g:NERDMenuMode=0
    :nnoremap <silent> ,ct :call NERDComment('n', 'toggle')<CR>
    :vnoremap <silent> ,ct :call NERDComment('x', 'toggle')<CR>
    :nnoremap <silent> ,cn :call NERDComment('n', 'nested')<CR>
    :vnoremap <silent> ,cn <ESC>:call NERDComment('x', 'nested')<CR>
    :nnoremap <silent> ,cu :call NERDComment('n', 'uncomment')<CR>
    :vnoremap <silent> ,cu <ESC>:call NERDComment('x', 'uncomment')<CR>
    :nnoremap <silent> ,cy <ESC>:call NERDComment('n', 'yank')<CR>
    :vnoremap <silent> ,cy <ESC>:call NERDComment('x', 'yank')<CR>
    "### }}}2

    "### settting for blockdiff.vim {{{2
    vmap ,d1 :call BlockDiff_GetBlock1()<CR>
    vmap ,d2 :call BlockDiff_GetBlock2()<CR>
    "}}}2

"## }}}1

"## Xterm colors defination {{{1
  if !has("gui_running") && $TERM == "xterm"
    hi x016_Grey0                ctermfg=16  guifg=#000000
    hi x017_NavyBlue             ctermfg=17  guifg=#00005f
    hi x018_DarkBlue             ctermfg=18  guifg=#000087
    hi x019_Blue3                ctermfg=19  guifg=#0000af
    hi x020_Blue3                ctermfg=20  guifg=#0000d7
    hi x021_Blue1                ctermfg=21  guifg=#0000ff
    hi x022_DarkGreen            ctermfg=22  guifg=#005f00
    hi x023_DeepSkyBlue4         ctermfg=23  guifg=#005f5f
    hi x024_DeepSkyBlue4         ctermfg=24  guifg=#005f87
    hi x025_DeepSkyBlue4         ctermfg=25  guifg=#005faf
    hi x026_DodgerBlue3          ctermfg=26  guifg=#005fd7
    hi x027_DodgerBlue2          ctermfg=27  guifg=#005fff
    hi x028_Green4               ctermfg=28  guifg=#008700
    hi x029_SpringGreen4         ctermfg=29  guifg=#00875f
    hi x030_Turquoise4           ctermfg=30  guifg=#008787
    hi x031_DeepSkyBlue3         ctermfg=31  guifg=#0087af
    hi x032_DeepSkyBlue3         ctermfg=32  guifg=#0087d7
    hi x033_DodgerBlue1          ctermfg=33  guifg=#0087ff
    hi x034_Green3               ctermfg=34  guifg=#00af00
    hi x035_SpringGreen3         ctermfg=35  guifg=#00af5f
    hi x036_DarkCyan             ctermfg=36  guifg=#00af87
    hi x037_LightSeaGreen        ctermfg=37  guifg=#00afaf
    hi x038_DeepSkyBlue2         ctermfg=38  guifg=#00afd7
    hi x039_DeepSkyBlue1         ctermfg=39  guifg=#00afff
    hi x040_Green3               ctermfg=40  guifg=#00d700
    hi x041_SpringGreen3         ctermfg=41  guifg=#00d75f
    hi x042_SpringGreen2         ctermfg=42  guifg=#00d787
    hi x043_Cyan3                ctermfg=43  guifg=#00d7af
    hi x044_DarkTurquoise        ctermfg=44  guifg=#00d7d7
    hi x045_Turquoise2           ctermfg=45  guifg=#00d7ff
    hi x046_Green1               ctermfg=46  guifg=#00ff00
    hi x047_SpringGreen2         ctermfg=47  guifg=#00ff5f
    hi x048_SpringGreen1         ctermfg=48  guifg=#00ff87
    hi x049_MediumSpringGreen    ctermfg=49  guifg=#00ffaf
    hi x050_Cyan2                ctermfg=50  guifg=#00ffd7
    hi x051_Cyan1                ctermfg=51  guifg=#00ffff
    hi x052_DarkRed              ctermfg=52  guifg=#5f0000
    hi x053_DeepPink4            ctermfg=53  guifg=#5f005f
    hi x054_Purple4              ctermfg=54  guifg=#5f0087
    hi x055_Purple4              ctermfg=55  guifg=#5f00af
    hi x056_Purple3              ctermfg=56  guifg=#5f00d7
    hi x057_BlueViolet           ctermfg=57  guifg=#5f00ff
    hi x058_Orange4              ctermfg=58  guifg=#5f5f00
    hi x059_Grey37               ctermfg=59  guifg=#5f5f5f
    hi x060_MediumPurple4        ctermfg=60  guifg=#5f5f87
    hi x061_SlateBlue3           ctermfg=61  guifg=#5f5faf
    hi x062_SlateBlue3           ctermfg=62  guifg=#5f5fd7
    hi x063_RoyalBlue1           ctermfg=63  guifg=#5f5fff
    hi x064_Chartreuse4          ctermfg=64  guifg=#5f8700
    hi x065_DarkSeaGreen4        ctermfg=65  guifg=#5f875f
    hi x066_PaleTurquoise4       ctermfg=66  guifg=#5f8787
    hi x067_SteelBlue            ctermfg=67  guifg=#5f87af
    hi x068_SteelBlue3           ctermfg=68  guifg=#5f87d7
    hi x069_CornflowerBlue       ctermfg=69  guifg=#5f87ff
    hi x070_Chartreuse3          ctermfg=70  guifg=#5faf00
    hi x071_DarkSeaGreen4        ctermfg=71  guifg=#5faf5f
    hi x072_CadetBlue            ctermfg=72  guifg=#5faf87
    hi x073_CadetBlue            ctermfg=73  guifg=#5fafaf
    hi x074_SkyBlue3             ctermfg=74  guifg=#5fafd7
    hi x075_SteelBlue1           ctermfg=75  guifg=#5fafff
    hi x076_Chartreuse3          ctermfg=76  guifg=#5fd700
    hi x077_PaleGreen3           ctermfg=77  guifg=#5fd75f
    hi x078_SeaGreen3            ctermfg=78  guifg=#5fd787
    hi x079_Aquamarine3          ctermfg=79  guifg=#5fd7af
    hi x080_MediumTurquoise      ctermfg=80  guifg=#5fd7d7
    hi x081_SteelBlue1           ctermfg=81  guifg=#5fd7ff
    hi x082_Chartreuse2          ctermfg=82  guifg=#5fff00
    hi x083_SeaGreen2            ctermfg=83  guifg=#5fff5f
    hi x084_SeaGreen1            ctermfg=84  guifg=#5fff87
    hi x085_SeaGreen1            ctermfg=85  guifg=#5fffaf
    hi x086_Aquamarine1          ctermfg=86  guifg=#5fffd7
    hi x087_DarkSlateGray2       ctermfg=87  guifg=#5fffff
    hi x088_DarkRed              ctermfg=88  guifg=#870000
    hi x089_DeepPink4            ctermfg=89  guifg=#87005f
    hi x090_DarkMagenta          ctermfg=90  guifg=#870087
    hi x091_DarkMagenta          ctermfg=91  guifg=#8700af
    hi x092_DarkViolet           ctermfg=92  guifg=#8700d7
    hi x093_Purple               ctermfg=93  guifg=#8700ff
    hi x094_Orange4              ctermfg=94  guifg=#875f00
    hi x095_LightPink4           ctermfg=95  guifg=#875f5f
    hi x096_Plum4                ctermfg=96  guifg=#875f87
    hi x097_MediumPurple3        ctermfg=97  guifg=#875faf
    hi x098_MediumPurple3        ctermfg=98  guifg=#875fd7
    hi x099_SlateBlue1           ctermfg=99  guifg=#875fff
    hi x100_Yellow4              ctermfg=100 guifg=#878700
    hi x101_Wheat4               ctermfg=101 guifg=#87875f
    hi x102_Grey53               ctermfg=102 guifg=#878787
    hi x103_LightSlateGrey       ctermfg=103 guifg=#8787af
    hi x104_MediumPurple         ctermfg=104 guifg=#8787d7
    hi x105_LightSlateBlue       ctermfg=105 guifg=#8787ff
    hi x106_Yellow4              ctermfg=106 guifg=#87af00
    hi x107_DarkOliveGreen3      ctermfg=107 guifg=#87af5f
    hi x108_DarkSeaGreen         ctermfg=108 guifg=#87af87
    hi x109_LightSkyBlue3        ctermfg=109 guifg=#87afaf
    hi x110_LightSkyBlue3        ctermfg=110 guifg=#87afd7
    hi x111_SkyBlue2             ctermfg=111 guifg=#87afff
    hi x112_Chartreuse2          ctermfg=112 guifg=#87d700
    hi x113_DarkOliveGreen3      ctermfg=113 guifg=#87d75f
    hi x114_PaleGreen3           ctermfg=114 guifg=#87d787
    hi x115_DarkSeaGreen3        ctermfg=115 guifg=#87d7af
    hi x116_DarkSlateGray3       ctermfg=116 guifg=#87d7d7
    hi x117_SkyBlue1             ctermfg=117 guifg=#87d7ff
    hi x118_Chartreuse1          ctermfg=118 guifg=#87ff00
    hi x119_LightGreen           ctermfg=119 guifg=#87ff5f
    hi x120_LightGreen           ctermfg=120 guifg=#87ff87
    hi x121_PaleGreen1           ctermfg=121 guifg=#87ffaf
    hi x122_Aquamarine1          ctermfg=122 guifg=#87ffd7
    hi x123_DarkSlateGray1       ctermfg=123 guifg=#87ffff
    hi x124_Red3                 ctermfg=124 guifg=#af0000
    hi x125_DeepPink4            ctermfg=125 guifg=#af005f
    hi x126_MediumVioletRed      ctermfg=126 guifg=#af0087
    hi x127_Magenta3             ctermfg=127 guifg=#af00af
    hi x128_DarkViolet           ctermfg=128 guifg=#af00d7
    hi x129_Purple               ctermfg=129 guifg=#af00ff
    hi x130_DarkOrange3          ctermfg=130 guifg=#af5f00
    hi x131_IndianRed            ctermfg=131 guifg=#af5f5f
    hi x132_HotPink3             ctermfg=132 guifg=#af5f87
    hi x133_MediumOrchid3        ctermfg=133 guifg=#af5faf
    hi x134_MediumOrchid         ctermfg=134 guifg=#af5fd7
    hi x135_MediumPurple2        ctermfg=135 guifg=#af5fff
    hi x136_DarkGoldenrod        ctermfg=136 guifg=#af8700
    hi x137_LightSalmon3         ctermfg=137 guifg=#af875f
    hi x138_RosyBrown            ctermfg=138 guifg=#af8787
    hi x139_Grey63               ctermfg=139 guifg=#af87af
    hi x140_MediumPurple2        ctermfg=140 guifg=#af87d7
    hi x141_MediumPurple1        ctermfg=141 guifg=#af87ff
    hi x142_Gold3                ctermfg=142 guifg=#afaf00
    hi x143_DarkKhaki            ctermfg=143 guifg=#afaf5f
    hi x144_NavajoWhite3         ctermfg=144 guifg=#afaf87
    hi x145_Grey69               ctermfg=145 guifg=#afafaf
    hi x146_LightSteelBlue3      ctermfg=146 guifg=#afafd7
    hi x147_LightSteelBlue       ctermfg=147 guifg=#afafff
    hi x148_Yellow3              ctermfg=148 guifg=#afd700
    hi x149_DarkOliveGreen3      ctermfg=149 guifg=#afd75f
    hi x150_DarkSeaGreen3        ctermfg=150 guifg=#afd787
    hi x151_DarkSeaGreen2        ctermfg=151 guifg=#afd7af
    hi x152_LightCyan3           ctermfg=152 guifg=#afd7d7
    hi x153_LightSkyBlue1        ctermfg=153 guifg=#afd7ff
    hi x154_GreenYellow          ctermfg=154 guifg=#afff00
    hi x155_DarkOliveGreen2      ctermfg=155 guifg=#afff5f
    hi x156_PaleGreen1           ctermfg=156 guifg=#afff87
    hi x157_DarkSeaGreen2        ctermfg=157 guifg=#afffaf
    hi x158_DarkSeaGreen1        ctermfg=158 guifg=#afffd7
    hi x159_PaleTurquoise1       ctermfg=159 guifg=#afffff
    hi x160_Red3                 ctermfg=160 guifg=#d70000
    hi x161_DeepPink3            ctermfg=161 guifg=#d7005f
    hi x162_DeepPink3            ctermfg=162 guifg=#d70087
    hi x163_Magenta3             ctermfg=163 guifg=#d700af
    hi x164_Magenta3             ctermfg=164 guifg=#d700d7
    hi x165_Magenta2             ctermfg=165 guifg=#d700ff
    hi x166_DarkOrange3          ctermfg=166 guifg=#d75f00
    hi x167_IndianRed            ctermfg=167 guifg=#d75f5f
    hi x168_HotPink3             ctermfg=168 guifg=#d75f87
    hi x169_HotPink2             ctermfg=169 guifg=#d75faf
    hi x170_Orchid               ctermfg=170 guifg=#d75fd7
    hi x171_MediumOrchid1        ctermfg=171 guifg=#d75fff
    hi x172_Orange3              ctermfg=172 guifg=#d78700
    hi x173_LightSalmon3         ctermfg=173 guifg=#d7875f
    hi x174_LightPink3           ctermfg=174 guifg=#d78787
    hi x175_Pink3                ctermfg=175 guifg=#d787af
    hi x176_Plum3                ctermfg=176 guifg=#d787d7
    hi x177_Violet               ctermfg=177 guifg=#d787ff
    hi x178_Gold3                ctermfg=178 guifg=#d7af00
    hi x179_LightGoldenrod3      ctermfg=179 guifg=#d7af5f
    hi x180_Tan                  ctermfg=180 guifg=#d7af87
    hi x181_MistyRose3           ctermfg=181 guifg=#d7afaf
    hi x182_Thistle3             ctermfg=182 guifg=#d7afd7
    hi x183_Plum2                ctermfg=183 guifg=#d7afff
    hi x184_Yellow3              ctermfg=184 guifg=#d7d700
    hi x185_Khaki3               ctermfg=185 guifg=#d7d75f
    hi x186_LightGoldenrod2      ctermfg=186 guifg=#d7d787
    hi x187_LightYellow3         ctermfg=187 guifg=#d7d7af
    hi x188_Grey84               ctermfg=188 guifg=#d7d7d7
    hi x189_LightSteelBlue1      ctermfg=189 guifg=#d7d7ff
    hi x190_Yellow2              ctermfg=190 guifg=#d7ff00
    hi x191_DarkOliveGreen1      ctermfg=191 guifg=#d7ff5f
    hi x192_DarkOliveGreen1      ctermfg=192 guifg=#d7ff87
    hi x193_DarkSeaGreen1        ctermfg=193 guifg=#d7ffaf
    hi x194_Honeydew2            ctermfg=194 guifg=#d7ffd7
    hi x195_LightCyan1           ctermfg=195 guifg=#d7ffff
    hi x196_Red1                 ctermfg=196 guifg=#ff0000
    hi x197_DeepPink2            ctermfg=197 guifg=#ff005f
    hi x198_DeepPink1            ctermfg=198 guifg=#ff0087
    hi x199_DeepPink1            ctermfg=199 guifg=#ff00af
    hi x200_Magenta2             ctermfg=200 guifg=#ff00d7
    hi x201_Magenta1             ctermfg=201 guifg=#ff00ff
    hi x202_OrangeRed1           ctermfg=202 guifg=#ff5f00
    hi x203_IndianRed1           ctermfg=203 guifg=#ff5f5f
    hi x204_IndianRed1           ctermfg=204 guifg=#ff5f87
    hi x205_HotPink              ctermfg=205 guifg=#ff5faf
    hi x206_HotPink              ctermfg=206 guifg=#ff5fd7
    hi x207_MediumOrchid1        ctermfg=207 guifg=#ff5fff
    hi x208_DarkOrange           ctermfg=208 guifg=#ff8700
    hi x209_Salmon1              ctermfg=209 guifg=#ff875f
    hi x210_LightCoral           ctermfg=210 guifg=#ff8787
    hi x211_PaleVioletRed1       ctermfg=211 guifg=#ff87af
    hi x212_Orchid2              ctermfg=212 guifg=#ff87d7
    hi x213_Orchid1              ctermfg=213 guifg=#ff87ff
    hi x214_Orange1              ctermfg=214 guifg=#ffaf00
    hi x215_SandyBrown           ctermfg=215 guifg=#ffaf5f
    hi x216_LightSalmon1         ctermfg=216 guifg=#ffaf87
    hi x217_LightPink1           ctermfg=217 guifg=#ffafaf
    hi x218_Pink1                ctermfg=218 guifg=#ffafd7
    hi x219_Plum1                ctermfg=219 guifg=#ffafff
    hi x220_Gold1                ctermfg=220 guifg=#ffd700
    hi x221_LightGoldenrod2      ctermfg=221 guifg=#ffd75f
    hi x222_LightGoldenrod2      ctermfg=222 guifg=#ffd787
    hi x223_NavajoWhite1         ctermfg=223 guifg=#ffd7af
    hi x224_MistyRose1           ctermfg=224 guifg=#ffd7d7
    hi x225_Thistle1             ctermfg=225 guifg=#ffd7ff
    hi x226_Yellow1              ctermfg=226 guifg=#ffff00
    hi x227_LightGoldenrod1      ctermfg=227 guifg=#ffff5f
    hi x228_Khaki1               ctermfg=228 guifg=#ffff87
    hi x229_Wheat1               ctermfg=229 guifg=#ffffaf
    hi x230_Cornsilk1            ctermfg=230 guifg=#ffffd7
    hi x231_Grey100              ctermfg=231 guifg=#ffffff
    hi x232_Grey3                ctermfg=232 guifg=#080808
    hi x233_Grey7                ctermfg=233 guifg=#121212
    hi x234_Grey11               ctermfg=234 guifg=#1c1c1c
    hi x235_Grey15               ctermfg=235 guifg=#262626
    hi x236_Grey19               ctermfg=236 guifg=#303030
    hi x237_Grey23               ctermfg=237 guifg=#3a3a3a
    hi x238_Grey27               ctermfg=238 guifg=#444444
    hi x239_Grey30               ctermfg=239 guifg=#4e4e4e
    hi x240_Grey35               ctermfg=240 guifg=#585858
    hi x241_Grey39               ctermfg=241 guifg=#626262
    hi x242_Grey42               ctermfg=242 guifg=#6c6c6c
    hi x243_Grey46               ctermfg=243 guifg=#767676
    hi x244_Grey50               ctermfg=244 guifg=#808080
    hi x245_Grey54               ctermfg=245 guifg=#8a8a8a
    hi x246_Grey58               ctermfg=246 guifg=#949494
    hi x247_Grey62               ctermfg=247 guifg=#9e9e9e
    hi x248_Grey66               ctermfg=248 guifg=#a8a8a8
    hi x249_Grey70               ctermfg=249 guifg=#b2b2b2
    hi x250_Grey74               ctermfg=250 guifg=#bcbcbc
    hi x251_Grey78               ctermfg=251 guifg=#c6c6c6
    hi x252_Grey82               ctermfg=252 guifg=#d0d0d0
    hi x253_Grey85               ctermfg=253 guifg=#dadada
    hi x254_Grey89               ctermfg=254 guifg=#e4e4e4
    hi x255_Grey93               ctermfg=255 guifg=#eeeeee
endif

" set Vim-specific sequences for RGB colors
" GOTCHA: need to disable termguicolors when using some low version of mosh 
" set notermguicolors
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"## }}}1

"## Experiments {{{1
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
"## }}}1

"## Color Scheme {{{1
  " :colorscheme jellybeans

  " :colorscheme molokai
  " let g:rehash256 = 1 "enable 256 color in terminal for molokai

  " italic does not work under tmux, need to figure out how to fix tmux on
  " this
  " let g:gruvbox_italic = 1
  " let g:gruvbox_contrast_dark = 'soft'
  " set background=dark
  " colorscheme gruvbox
  if has('nvim-0.5')
    " color schemes work nicely with diffview.nvim: tokyonight, molokai,
    " github
    colorscheme tokyonight-storm
    " let g:material_style = 'palenight'
    " colorscheme material
    " colorscheme nightfly
  else
    " let g:seoul256_background = 235
    " colorscheme seoul256
    " set background=dark
    " colorscheme solarized8
    " colorscheme desertEx
    " colorscheme synic
    colorscheme github
  endif

  " enhance vimdiff colors
  if &diff
    colorscheme github
  endif
  au FilterWritePre * if &diff | colorscheme github | endif
" }}}1

"## MacVim Related {{{1
if has("gui_macvim")
  set fuoptions=maxvert,maxhorz,background:Normal
  set lines=39 columns=157

  map <D-t> :tabnew<CR>
  map <D-w> :tabclose<CR>
endif
"## }}}1

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif
