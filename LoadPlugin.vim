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
"Plug 'majutsushi/tagbar'
Plug 'vim-scripts/scratch.vim', {'on': 'Scratch'}
Plug 'AndrewRadev/switch.vim'
" Plug 'Valloric/YouCompleteMe'
" Plug 'scrooloose/nerdtree'
Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}
" }}}1

" ColorSchemes {{{1
Plug 'altercation/vim-colors-solarized'
Plug 'daddye/soda.vim'
Plug 'croaky/vim-colors-github'
Plug 'mbbill/desertEx'
Plug 'vim-scripts/synic.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'nice/sweater'
Plug 'tomasr/molokai'
Plug 'liuchengxu/space-vim-dark'
Plug 'endel/vim-github-colorscheme'
" }}}1

" Advanced Editing {{{1
Plug 'kien/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'tacahiroy/ctrlp-funky'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'vim-scripts/AutoComplPop'
Plug 'rking/ag.vim', {'on': 'Ag'}
Plug 'mhinz/vim-grepper'
Plug 'drmingdrmer/xptemplate'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'}
Plug 'vim-scripts/LargeFile'
Plug 'tpope/vim-abolish', {'on': 'Subvert'}
Plug 'tpope/vim-dispatch'
Plug 'vim-scripts/vimwiki'
Plug 'sk1418/Join', {'on': 'Join'}
Plug 'vim-scripts/sessionman.vim', {'on': ['SessionOpen', 'SessionOpenLast', 'SessionClose', 'SessionSave', 'SessionSaveAs', 'SessionShowLast']}
" Plug 'MattesGroeger/vim-bookmarks', {'on': 'BookmarkToggle'}
Plug 'kana/vim-textobj-user'
" Plug 'lilydjwg/colorizer'
" Plug 'tpope/vim-afterimage'
Plug 'vim-scripts/Visual-Mark'
" Plug 'terryma/vim-expand-region'
" Plug 'terryma/vim-multiple-cursors'

" Plug 'haya14busa/incsearch.vim'
" Plug 'haya14busa/incsearch-easymotion.vim'
" Plug 'haya14busa/incsearch-fuzzy.vim'

Plug 'linsong/hexman.vim'
Plug 'vim-scripts/DrawIt'
"}}}1

" Utils {{{1
Plug 'kana/vim-fakeclip'
" Plug 'vim-scripts/a.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'vim-scripts/localvimrc'
Plug 'epeli/slimux', {'on': 'SlimuxShellRun'} " related to tmux 
Plug 'mhinz/vim-startify', {'on': 'Startify'}
Plug 'rizzatti/funcoo.vim' " for Dash
Plug 'rizzatti/dash.vim'

Plug 'vim-scripts/rainbow_csv.vim', {
  \ 'on': 'RainbowDelim',
  \ 'for': ['csv', 'tsv']}

Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'dhruvasagar/vim-table-mode', {
  \ 'on': ['TableModeEnable', 'TableModeToggle', 'Tableize']
  \}

Plug 'vim-scripts/renamer.vim', {'on': 'Renamer'}
Plug 'vim-scripts/vimGTD', {'for': 'gtd'}
Plug 'skwp/greplace.vim', {'on': 'Gsearch'}
Plug 'vim-scripts/ViewOutput', {'on': 'VO'}
" Plug 't9md/vim-choosewin'

" ScreenShot.vim enables you make screenshot of your VIM session as HTML code. 
Plug 'vim-scripts/ScreenShot', {'on': ['ScreenShot', 'Text2Html', 'Diff2Html']}
Plug 'mbbill/VimExplorer', {'on': 'VE'}
Plug 'vim-scripts/Mark--Karkat'
Plug 'vim-airline/vim-airline'

Plug 'vim-utils/vim-man'
Plug 'will133/vim-dirdiff', {'on': 'DirDiff'}
Plug 'rickhowe/diffchar.vim'

" choose one of below three plugins 
" Plug 'szw/vim-maximizer'
" Plug 'vim-scripts/ZoomWin', {'on': 'ZoomWin'}
" Plug 'chrisbra/NrrwRgn'
"}}}1

" Ruby Vundles {{{1
Plug 'tpope/vim-endwise', {'for': 'ruby'}
Plug 'tpope/vim-rails', {'for': ['ruby', 'rails']}
Plug 'vim-ruby/vim-ruby', {'for': ['ruby', 'rails']}
Plug 'janx/vim-rubytest', {'for': ['ruby', 'rails']}
Plug 'vim-scripts/ri-browser', {'for': ['ruby', 'rails']}
" }}}1

" Python Vundles {{{1
Plug 'vim-scripts/python.vim', {'for': ['python',],}
Plug 'fs111/pydoc.vim', {'for': ['python',],}
Plug 'vim-scripts/python_match.vim', {'for': ['python',],}
" }}}1

" Web Vundles {{{1
Plug 'vim-scripts/vim-coffee-script'
Plug 'gregsexton/MatchTag', {'for': ['xhtml', 'html', 'js', 'css', 'xml', 'php'],}
Plug 'mattn/emmet-vim'
Plug 'sukima/xmledit'
Plug 'vim-scripts/jsbeautify', {'for': ['html', 'js', 'css', 'xml'],}
Plug 'tmhedberg/matchit'
" }}}1

" Git Utils {{{1
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', {'on': 'Gitv'}
Plug 'vim-scripts/Gist.vim', {'on': 'Gist'}
"}}}1

"" C/C++ NeoBundles {{{1
Plug 'vim-scripts/OmniCppComplete', {'for': ['c', 'cpp', 'h'],}
Plug 'derekwyatt/vim-protodef', {'for': ['c', 'cpp', 'h'],}
Plug 'vim-scripts/FSwitch', {'for': ['c', 'cpp', 'h'],}

" Qt
" Plug 'https://bitbucket.org/kh3phr3n/vim-qt-syntax.git', {'for': ['c', 'cpp', 'h'],}
Plug 'vim-scripts/cpp.vim', {'for': ['c', 'cpp', 'h'],}
"" }}}1

" SQL Vundles {{{1
Plug 'vim-scripts/SQLUtilities', {'for': 'sql'}
Plug 'vim-scripts/dbext.vim', {'for': 'sql'}
" }}}1

" iOS Vundles {{{1
Plug 'msanders/cocoa.vim', {'for': 'objective-c'}
"Plug 'eraserhd/vim-ios' " crashed vim
" }}}1

" PHP Vundles {{{1
Plug 'rayburgemeestre/phpfolding.vim'
" }}}1

"" games {{{1
"NeoBundleLazy 'sokoban.vim' 
"NeoBundleLazy 'TeTrIs.vim'
""}}}1

" vim: ft=vim

call plug#end()
