call plug#begin('~/.vim/bundle')

" Basic Editing {{{1
Plug 'tpope/vim-repeat'
Plug 'Lokaltog/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'bsl/obviousmode'
Plug 'tpope/vim-surround'
Plug 'bkad/CamelCaseMotion'
" }}}1

" Coding {{{1
Plug 'tomtom/tcomment_vim'
Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'
Plug 'scratch.vim', {'on': 'Scratch'}
Plug 'AndrewRadev/switch.vim', {'on': 'Switch'}
" }}}1

" ColorSchemes {{{1
Plug 'altercation/vim-colors-solarized'
Plug 'daddye/soda.vim'
Plug 'croaky/vim-colors-github'
Plug 'mbbill/desertEx'
Plug 'vim-scripts/synic.vim'
Plug 'nanotech/jellybeans.vim'
" }}}1

" Advanced Editing {{{1
Plug 'kien/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'tacahiroy/ctrlp-funky'
Plug 'AutoComplPop'
Plug 'rking/ag.vim', {'on': 'Ag'}
Plug 'drmingdrmer/xptemplate'
Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'}
Plug 'LargeFile'
Plug 'tpope/vim-abolish', {'on': 'Subvert'}
Plug 'vim-scripts/vimwiki'
Plug 'chrisbra/NrrwRgn'
Plug 'sk1418/Join', {'on': 'Join'}
Plug 'sessionman.vim', {'on': ['SessionOpen', 'SessionOpenLast', 'SessionClose', 'SessionSave', 'SessionSaveAs', 'SessionShowLast']}
Plug 'MattesGroeger/vim-bookmarks', {'on': 'BookmarkToggle'}
"}}}1

" Utils {{{1
Plug 'kana/vim-fakeclip'
Plug 'a.vim'
Plug 'localvimrc'
Plug 'epeli/slimux', {'on': 'SlimuxShellRun'} " related to tmux 
Plug 'mhinz/vim-startify'
Plug 'rizzatti/funcoo.vim' " for Dash
Plug 'rizzatti/dash.vim', {'on': 'Dash'} " for Dash

Plug 'vim-scripts/rainbow_csv.vim', {
  \ 'on': 'RainbowDelim',
  \ 'for': ['csv', 'tsv']}

Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'dhruvasagar/vim-table-mode', {
  \ 'on': ['TableModeEnable', 'TableModeToggle', 'Tableize']
  \}

Plug 'renamer.vim', {'on': 'Renamer'}
Plug 'vimGTD', {'for': 'gtd'}
Plug 'skwp/greplace.vim', {'on': 'Gsearch'}
Plug 'ViewOutput', {'on': 'VO'}

" ScreenShot.vim enables you make screenshot of your VIM session as HTML code. 
Plug 'ScreenShot', {'on': ['ScreenShot', 'Text2Html', 'Diff2Html']}
Plug 'mbbill/VimExplorer', {'on': 'VE'}
Plug 'vim-scripts/ZoomWin', {'on': 'ZoomWin'}
Plug 'vim-scripts/Mark--Karkat'
Plug 'bling/vim-airline'
"}}}1

" Ruby Vundles {{{1
Plug 'tpope/vim-endwise', {'for': 'ruby'}
Plug 'tpope/vim-rails', {'for': ['ruby', 'rails']}
Plug 'vim-ruby/vim-ruby', {'for': ['ruby', 'rails']}
Plug 'janx/vim-rubytest', {'for': ['ruby', 'rails']}
Plug 'ri-browser', {'for': ['ruby', 'rails']}
" }}}1

" Python Vundles {{{1
Plug 'python.vim', {'for': ['python',],}
Plug 'fs111/pydoc.vim', {'for': ['python',],}
Plug 'python_match.vim', {'for': ['python',],}
" }}}1

" Web Vundles {{{1
Plug 'vim-coffee-script', {'for': ['coffee', 'html', 'js', 'css', 'xml'],}
Plug 'gregsexton/MatchTag', {'for': ['html', 'xml'],}
Plug 'rstacruz/sparkup', {'rtp': 'vim/', 'for': ['html', 'js', 'css', 'xml'],}
Plug 'mattn/emmet-vim', {'for': ['html', 'js', 'css', 'xml'],}
Plug 'sukima/xmledit', {'for': ['html', 'js', 'css', 'xml'],}
Plug 'jsbeautify', {'for': ['html', 'js', 'css', 'xml'],}
" }}}1

" Git Utils {{{1
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', {'on': 'Gitv'}
Plug 'Gist.vim', {'on': 'Gist'}
"}}}1

"" C/C++ NeoBundles {{{1
Plug 'OmniCppComplete', {'for': ['c', 'cpp', 'h'],}
Plug 'derekwyatt/vim-protodef', {'for': ['c', 'cpp', 'h'],}
Plug 'FSwitch', {'for': ['c', 'cpp', 'h'],}

" Qt
Plug 'https://bitbucket.org/kh3phr3n/vim-qt-syntax.git', {'for': ['c', 'cpp', 'h'],}
"" }}}1

" SQL Vundles {{{1
Plug 'SQLUtilities', {'for': 'sql'}
Plug 'dbext.vim', {'for': 'sql'}
" }}}1

" iOS Vundles {{{1
Plug 'msanders/cocoa.vim', {'for': 'objective-c'}
"Plug 'eraserhd/vim-ios' " crashed vim
" }}}1

"" games {{{1
"NeoBundleLazy 'sokoban.vim' 
"NeoBundleLazy 'TeTrIs.vim'
""}}}1

"" disabled {{{1
"Plug 'L9'
"Plug 'FuzzyFinder', {'on': 'FufFileWithCurrentBufferDir'}
"Plug 'grep.vim'
"Plug 'goldfeld/vim-seek'
" NeoBundle 'scrooloose/syntastic.git'
" NeoBundle 'scrooloose/nerdcommenter'
" NeoBundleLazy 'Bexec'
" NeoBundleLazy 'scrooloose/nerdtree'
" NeoBundleLazy 'AndrewRadev/linediff.vim.git'
" NeoBundleLazy 'xuhdev/SingleCompile', {'autoload': {'commands': ['SCCompile', 'SCCompileRun']}}
" NeoBundle 'Valloric/YouCompleteMe', {'augroup': 'youcompletemeStart', 
"  \ 'build': {
"    \ 'mac': './install.sh --clang-completer',
"    \ 'unix': './install.sh --clang-completer',
"    \ 'cygwin': './install.sh --clang-completer',
"    \ },
"  \ }
"NeoBundle 'Align'
" NeoBundle 'tpope/vim-dispatch' " dispatch.vim: asynchronous build and test dispatcher
" NeoBundle 'genutils'
"NeoBundleLazy 'VisIncr'
"NeoBundleLazy 'foldcol.vim'
"NeoBundleLazy 'foldutil.vim'
"NeoBundleLazy 'bufexplorer.zip', {'autoload': {'mappings': '<leader>be'},}
" NeoBundleLazy 'tpope/vim-rsi.git'
" NeoBundleLazy 'terryma/vim-multiple-cursors.git', {'name': 'multiple-cursors'}
" NeoBundleLazy 'tpope/vim-afterimage.git'
"NeoBundle 'Shougo/vimproc', {
"    \ 'build' : {
"      \     'windows' : 'make -f make_mingw32.mak',
"      \     'cygwin' : 'make -f make_cygwin.mak',
"      \     'mac' : 'make -f make_mac.mak',
"      \     'unix' : 'make -f make_unix.mak',
"      \    },
"      \ }
"NeoBundle 'Shougo/unite.vim.git'
"NeoBundle 'Shougo/vimfiler', {'depends' : 'Shougo/unite.vim'}

" NeoBundle 'cecutil' " Some utilities used by several of my scripts (window positioning, mark handling)
" NeoBundle 'tangledhelix/vim-octopress.git'
" NeoBundle 'bling/vim-airline'
"NeoBundleLazy 'kikijump/tslime.vim.git'
"NeoBundle 'tpope/vim-tbone' " tbone.vim: tmux basics
" NeoBundleLazy 'quickrun.vim'
" NeoBundleLazy 'DirDiff.vim'
" NeoBundleLazy 'DirDo.vim'
" Colorscheme display and editor 
"NeoBundleLazy 'HiColors'

"NeoBundleLazy 'TVO--The-Vim-Outliner'

" needed for fetching schemes online. and much more
"NeoBundleLazy 'mattn/webapi-vim' 
"NeoBundleLazy 'Rykka/colorv.vim', {'depends': 'mattn/webapi-vim'}

"NeoBundleLazy 'ppwwyyxx/vim-PinyinSearch', {'name': 'pinyinsearch'}

"NeoBundleLazy 'lpenz/vimcommander', {'autoload': {'mappings': ';vc'}} " Total-commander-like file manager for VIM
"Plug 'toggle_words.vim'

"" }}}1

" vim: ft=vim

call plug#end()
