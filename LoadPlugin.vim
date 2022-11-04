" Autoinstall vim-plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

" to benchmark vim startup time
" $ nvim --startuptime startup.log -c q
" 2021/08/31: ~240ms
"
" for lua tips: https://github.com/nanotee/nvim-lua-guide
"
" to print lua table object: print(vim.inspect(TABLE))

call plug#begin('~/.vim/bundle')

" Basic Editing {{{1
Plug 'tpope/vim-repeat'

if has('nvim-0.5')
  " after comparision, I am more used to hop.nvim than lightspeed
  Plug 'phaazon/hop.nvim'
else
  Plug 'Lokaltog/vim-easymotion'
  "### EasyMotion {{{2
    let g:EasyMotion_leader_key = ';'
    let g:EasyMotion_smartcase = 1
    let g:EasyMotion_enter_jump_first = 1

    map ss <Plug>(easymotion-s2)
    map s2 <Plug>(easymotion-s2)
    map sn <Plug>(easymotion-sn)

    map ;l <Plug>(easymotion-lineforward)
    map ;h <Plug>(easymotion-linebackward)

    nmap ;l <Plug>(easymotion-overwin-line)

    function! s:incsearch_config_easymotion(...) abort
      return extend(copy({
      \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
      \   'keymap': {"\<CR>": '<Over>(easymotion)'},
      \   'is_expr': 0,
      \   'is_stay': 1
      \ }), get(a:, 1, {}))
    endfunction
    " noremap <silent><expr> /  incsearch#go(<SID>incsearch_config_easymotion())

    " incsearch.vim x fuzzy x vim-easymotion
    function! s:config_easyfuzzymotion(...) abort
      return extend(copy({
      \   'converters': [incsearch#config#fuzzy#converter()],
      \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
      \   'keymap': {"\<CR>": '<Over>(easymotion)'},
      \   'is_expr': 0,
      \   'is_stay': 1
      \ }), get(a:, 1, {}))
    endfunction
    " noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
  "}}}2
endif

" this plugin make vim slow, don't know why
" Plug 'bsl/obviousmode'

Plug 'tpope/vim-surround'
"### vim-surround {{{2
let g:surround_no_insert_mappings = 1
"}}}2

Plug 'bkad/CamelCaseMotion'

" }}}1

" Coding {{{1
Plug 'tpope/vim-commentary'
if has('nvim-0.5')
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
endif

Plug 'vim-scripts/scratch.vim', {'on': 'Scratch'}
"### setting for scratch.vim {{{
:let g:scratchBackupFile = '/tmp/scratch.txt'
"### }}}

Plug 'AndrewRadev/switch.vim'
"###  setting for Switch  {{{2
let g:switch_custom_definitions =
  \ [
  \  ['white', 'black'],
  \  ['add', 'remove'],
  \  ['read', 'write'],
  \  ['hide', 'show'],
  \  ['before', 'after'],
  \  ['up', 'down'],
  \  ['open', 'close'],
  \  ['right', 'left'],
  \  ['long', 'short'],
  \  ['big', 'small'],
  \  ['post', 'get'],
  \   {
  \     '\<[a-z0-9]\+_\k\+\>': {
  \       '_\(.\)': '\U\1'
  \     },
  \     '\<[a-z0-9]\+[A-Z]\k\+\>': {
  \       '\([A-Z]\)': '_\l\1'
  \     },
  \   }
  \  ]
 noremap ,t :Switch<CR>
 vnoremap ,t <ESC>:Switch<CR>
"}}}2

" Plug 'scrooloose/nerdtree'
"
Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}

" DEPRECATED: use tree sitter instead
" Plug 'vim-syntastic/syntastic'
" "### settings for syntastic {{{2
"   let g:syntastic_enable_signs = 1
"   let g:syntastic_auto_loc_list = 0
"   let g:syntastic_mode_map = { 'mode': 'passive',
"                             \ 'active_filetypes': [],
"                             \ 'passive_filetypes': ['python', 'cpp', 'ruby', 'puppet', 'javascript'] }
" "}}}2

" }}}1

" ColorSchemes {{{1
" Plug 'altercation/vim-colors-solarized'
" Plug 'daddye/soda.vim'
" Plug 'mbbill/desertEx'
" Plug 'nanotech/jellybeans.vim'
" Plug 'nice/sweater'
" Plug 'liuchengxu/space-vim-dark'
Plug 'tomasr/molokai'
Plug 'cormacrelf/vim-colors-github'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
" Plug 'sainnhe/vim-color-desert-night'
" Plug 'lifepillar/vim-solarized8'

if has('nvim-0.5')
  " Plug 'marko-cerovac/material.nvim'
  Plug 'bluz71/vim-nightfly-guicolors'
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
endif
" }}}1

" Enhanced Syntax {{{1
" Plug 'neomutt/neomutt.vim'
" au BufNewFile,BufRead *.muttrc,aliases set filetype=neomuttrc

" }}}1

" Advanced Editing {{{1

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'ibhagwan/fzf-lua', {'branch': 'main'}

Plug 'vifm/vifm.vim'

Plug 'mhinz/vim-grepper'

" Plug 'drmingdrmer/xptemplate'
"### xptemplate {{{2
  " load snippets from personal folder
  " set runtimepath+=~/.vim/personal/

  " Prevent supertab from mapping <tab> to anything.
  "let g:SuperTabMappingForward = '<Plug>xpt_void'

  " Tell XPTemplate what to fall back to, if nothing matches.
  " Original SuperTab() yields nothing if g:SuperTabMappingForward was set to
  " something it does not know.
  "let g:xptemplate_fallback = '<C-r>=XPTwrapSuperTab("n")<CR>'

  " fun! XPTwrapSuperTab(command)
  "     let v = SuperTab(a:command)
  "     if v == ''
  "         " Change \<Tab> to whatever you want, when neither XPTemplate or
  "         " supertab needs to do anything.
  "         return "\<Tab>"
  "     else
  "         return v
  "     end
  " endfunction

  ""xpt uses <Tab> as trigger key
  "let g:xptemplate_key = '<Tab>'
  "let g:xptemplate_key = '<c-m>'
  " let g:xptemplate_key = '<c-l>'

  "" trigger snippet with <Tab> no matter popup menu opened or not
  " let g:xptemplate_key = '<Plug>triggerxpt'
  " inoremap <Plug>closePUM <C-v><C-v><BS>
  " imap <TAB> <Plug>closePUM<Plug>triggerxpt

  let g:xptemplate_move_even_with_pum = 0
  let g:xptemplate_always_show_pum = 1

  "xpt trigger snippet only when there are at least one character
  let g:xptemplate_minimal_prefix = 1

  "disable brace complete
  let g:xptemplate_brace_complete = 0

  let g:xptemplate_pum_tab_nav = 1

  let g:xptemplate_goback = '<C-g>'

  let g:xptemplate_strict = 1

  let g:xptemplate_bundle = "cpp_*"

  let g:xptemplate_vars = "$author=Vincent\ Wang&$email=linsong.qizi@gmail.com"

"}}}2

Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'}
"### EasyAlign {{{2
  vnoremap <silent> <Enter> :EasyAlign<cr>
"}}}2

"required by SQLUtility.vim
" Plug 'vim-scripts/Align'

" Plug 'vim-scripts/LargeFile'
Plug 'tpope/vim-abolish', {'on': 'Subvert'}
" Plug 'tpope/vim-dispatch'

" Plug 'vim-scripts/vimwiki'
" "### settings for vimwiki {{{2
"   let g:vimwiki_menu = "Plugin.Vimwiki"
"   let g:vimwiki_list = [{'path': '~/vimwiki', 'path_html': '~/vimwiki_html'},
"        \ {'path': '~/workspace/auction/client/notes/', 'path_html': '~/workspace/auction/client/notes/html'}]
" "}}}2

Plug 'sk1418/Join', {'on': 'Join'}

" Session Management
" Plug 'vim-scripts/sessionman.vim', {'on': ['SessionOpen', 'SessionOpenLast', 'SessionClose', 'SessionSave', 'SessionSaveAs', 'SessionShowLast']}
Plug 'tpope/vim-obsession'

" Plug 'MattesGroeger/vim-bookmarks', {'on': 'BookmarkToggle'}
" Plug 'kana/vim-textobj-user'
Plug 'wellle/targets.vim'

" Plug 'tpope/vim-afterimage'
" Plug 'vim-scripts/Visual-Mark'
" "### visualmark {{{2
"   nnoremap <silent> ,n :call Vm_goto_next_sign()<cr>
"   nnoremap <silent> ,p :call Vm_goto_prev_sign()<cr>
" "}}}2

" Plug 'haya14busa/incsearch.vim'
" Plug 'haya14busa/incsearch-easymotion.vim'
" Plug 'haya14busa/incsearch-fuzzy.vim'

Plug 'vim-scripts/VisIncr'

" Plug 'linsong/hexman.vim'

" Plug 'AndrewRadev/splitjoin.vim'

" Plug 'liuchengxu/vim-which-key', {'on': ['WhichKey', 'WhichKey!']}

" Plug 'voldikss/vim-floaterm'

" Plug 'unblevable/quick-scope'

Plug 'alvan/vim-closetag'

Plug 'kevinhwang91/nvim-bqf'

if has('nvim-0.5')
  " TreeSitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-treesitter/playground'
  Plug 'mfussenegger/nvim-ts-hint-textobject'
  Plug 'windwp/nvim-ts-autotag'

  " Language Server
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
	Plug 'ojroques/nvim-lspfuzzy'

	Plug 'folke/lsp-colors.nvim'
  Plug 'onsails/lspkind-nvim'

  Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'

  " provide auto popup function signature help, feature ported from
  " completion.nvim, a good companion for nvim-cmp
  " NOTE: if enable completion.nvim, should disable this plugin
  Plug 'ray-x/lsp_signature.nvim'

  Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'rafamadriz/friendly-snippets'

	" Plug 'windwp/nvim-autopairs'

  " not sure if this plugin will make neovim slow, if yes, disable it
  Plug 'lukas-reineke/indent-blankline.nvim'

  " Lightweight alternative to context.vim implemented with nvim-treesitter
  " doesn't work very well
  " Plug 'romgrk/nvim-treesitter-context'

  Plug 'folke/trouble.nvim'

  " Plug 'Pocco81/TrueZen.nvim'
  Plug 'folke/zen-mode.nvim'

  " Plug 'stevearc/dressing.nvim'
  Plug 'rcarriga/nvim-notify'

  " Plug 'ThePrimeagen/refactoring.nvim'
  
else
  " Use release branch
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

Plug 'tommcdo/vim-exchange'

"}}}1

" Utils {{{1
Plug 'kana/vim-fakeclip'
" Plug 'vim-scripts/a.vim'

Plug 'derekwyatt/vim-fswitch'
"### settings for FSwitch {{{2
  map ;aa :FSHere<CR>
  map ;as :FSSplitRight<CR>
  map ;av :FSSplitBelow<CR>
"### }}}2

Plug 'vim-scripts/localvimrc'
"### localvimrc {{{2
  let g:localvimrc_persistent = 1
  let g:localvimrc_whitelist = '' . $HOME . '/workspace/.*'
  let g:localvimrc_sandbox = 0
"}}}2

Plug 'epeli/slimux', {'on': 'SlimuxShellRun'} " related to tmux

" Plug 'mhinz/vim-startify', {'on': 'Startify'}
Plug 'mhinz/vim-startify'

" Plug 'rizzatti/funcoo.vim' " for Dash
" Plug 'rizzatti/dash.vim'
" "### Dash {{{2
"   let g:dash_map = {
"    \ 'cpp' : 'qt'
"    \ }
"   " :nmap <silent> ,k <Plug>DashSearch
" "}}}2

"Plug 'vim-scripts/rainbow_csv.vim', {
"  \ 'on': 'RainbowDelim',
"  \ 'for': ['csv', 'tsv']}
""### rainbow {{{2
"  let g:rainbow_active = 0
"  map ;r :silent! RainbowToggle <CR>
"  "map ;r :silent! RainbowParenthesesToggle <CR>
  
"}}}2

Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'dhruvasagar/vim-table-mode', {
  \ 'on': ['TableModeEnable', 'TableModeToggle', 'Tableize']
  \}

" Plug 'vim-scripts/renamer.vim', {'on': 'Renamer'}
" Plug 'vim-scripts/vimGTD', {'for': 'gtd'}

Plug 'skwp/greplace.vim', {'on': 'Gsearch'}
" Plug 'brooth/far.vim'

Plug 'vim-scripts/ViewOutput', {'on': 'VO'}
" Plug 't9md/vim-choosewin'
"### choosewin {{{2
  nmap <c-w>- <Plug>(choosewin)
  let g:choosewin_overlay_enable = 1
"}}}2

" ScreenShot.vim enables you make screenshot of your VIM session as HTML code.
" Plug 'vim-scripts/ScreenShot', {'on': ['ScreenShot', 'Text2Html', 'Diff2Html']}
"### ScreenShot {{{2
  let g:ScreenShot = {'Credits': 0}
"}}}2

" Plug 'mbbill/VimExplorer', {'on': 'VE'}
" "### setting for vimExplorer.vim {{{2
"  let g:VEConf_showHiddenFiles = 0 " don't show dot files by default
"  let g:VEConf_usingGnome = 1 "use Gnome desktop system. TODO: add support for Mac OSX

 " override some file mode hot keys
 "let g:VEConf_fileHotkey = {}
 " switch itemClicked and openPreview hotkeys
 "let g:VEConf_fileHotkey.itemClicked = 'u'
 "let g:VEConf_fileHotkey.openPreview = '<cr>'
"}}}2

" Plug 'vim-scripts/Mark--Karkat'
" "### settings for mark.vim {{{2
"   let g:mwHistAdd = "/@"
"   let g:mwAutoLoadMarks = 0
"   let g:mwAutoSaveMarks = 0
"   nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
"   nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
"
"   "highlight def MarkWord7   ctermfg=Cyan      ctermbg=Black  guifg=#8CCBEA    guibg=Black
"   "highlight def MarkWord8   ctermfg=Green     ctermbg=Black  guifg=#A4E57E    guibg=Black
"   "highlight def MarkWord9   ctermfg=Yellow    ctermbg=Black  guifg=#FFDB72    guibg=Black
"   "highlight def MarkWord10  ctermfg=Red       ctermbg=Black  guifg=#FF7272    guibg=Black
"   "highlight def MarkWord11  ctermfg=Magenta   ctermbg=Black  guifg=#FFB3FF    guibg=Black
"   "highlight def MarkWord12  ctermfg=Blue      ctermbg=Black  guifg=#9999FF    guibg=Black
"
"   "highlight def MarkWord13  ctermbg=Cyan      ctermfg=White  guibg=#8CCBEA    guifg=White
"   "highlight def MarkWord14  ctermbg=Green     ctermfg=White  guibg=#A4E57E    guifg=White
"   "highlight def MarkWord15  ctermbg=Yellow    ctermfg=White  guibg=#FFDB72    guifg=White
"   "highlight def MarkWord16  ctermbg=Red       ctermfg=White  guibg=#FF7272    guifg=White
"   "highlight def MarkWord17  ctermbg=Magenta   ctermfg=White  guibg=#FFB3FF    guifg=White
"   "highlight def MarkWord18  ctermbg=Blue      ctermfg=White  guibg=#9999FF    guifg=White
"
"   if &t_Co>=256 || has("gui_running")
"     let g:mwDefaultHighlightingPalette = 'extended'
"   endif
" "}}}2

Plug 'vim-airline/vim-airline'

Plug 'vim-utils/vim-man'

" can use vifm + tmux + vimdiff to replace vim-dirdiff plugin
" Plug 'will133/vim-dirdiff', {'on': 'DirDiff'}
"### setting for DirDiff.vim {{{
let g:DirDiffExcludes = "*.pyc,*.pye,.svn,*.svn-base,*.svn-work,*~,*.orig,*.rej,*.swf,.*.swp,.*.swo"
"}}}

Plug 'rickhowe/diffchar.vim'
Plug 'rickhowe/spotdiff.vim'
" Plug 'AndrewRadev/linediff.vim'

" choose one of below three plugins
" Plug 'vim-scripts/ZoomWin', {'on': 'ZoomWin'}
Plug 'szw/vim-maximizer'
"### vim-maximizer {{{2
  nnoremap <silent> <leader>wf :MaximizerToggle<cr>
"}}}2

Plug 'chrisbra/NrrwRgn'
" Plug 'junegunn/goyo.vim'

" Plug 'bps/vim-tshark'

" Plug 'guns/xterm-color-table.vim'

Plug 't9md/vim-quickhl'
"### settings for quickhl {{{
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
"}}}

" to sample and troubleshoot why vim is slow to start
" Plug 'tweekmonster/startuptime.vim'
Plug 'dstein64/vim-startuptime'

if has('nvim')
  Plug 'mhartington/formatter.nvim'

  " Plug 'nvim-lua/plenary.nvim'
  " Plug 'nvim-telescope/telescope.nvim'
  " Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

  " Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-neorg/neorg' 

  Plug 'numToStr/FTerm.nvim'

  "NOTE: tried, not very efficient, better to use curl directly
  " Plug 'NTBBloodbath/rest.nvim'

endif
"}}}1

" Ruby {{{1
Plug 'tpope/vim-endwise', {'for': 'ruby'}
Plug 'tpope/vim-rails', {'for': ['ruby', 'rails']}
Plug 'vim-ruby/vim-ruby', {'for': ['ruby', 'rails']}
Plug 'janx/vim-rubytest', {'for': ['ruby', 'rails']}
Plug 'vim-scripts/ri-browser', {'for': ['ruby', 'rails']}
" }}}1

" Python {{{1
Plug 'vim-scripts/python.vim', {'for': ['python',],}
" Plug 'fs111/pydoc.vim', {'for': ['python',],}
Plug 'vim-scripts/python_match.vim', {'for': ['python',],}
" }}}1

" Web {{{1
Plug 'vim-scripts/vim-coffee-script'
Plug 'gregsexton/MatchTag', {'for': ['xhtml', 'html', 'js', 'css', 'xml', 'php'],}
Plug 'mattn/emmet-vim', {'for': ['xhtml', 'html', 'js', 'css', 'xml', 'php', 'vue'],}

Plug 'sukima/xmledit'
"### xmledit {{{2
  let g:xmledit_enable_html = 1
"}}}2

" Plug 'vim-scripts/jsbeautify', {'for': ['html', 'js', 'css', 'xml'],}
Plug 'tmhedberg/matchit'
" }}}1

" Git {{{1
Plug 'tpope/vim-fugitive'
"### fugitive {{{2
  map ,gb :Gblame<CR>
  map ,gs :Git<CR>
  map ,gd :Gdiff<CR>
  map ,gl :Glog<CR>
  map ,gc :Gcommit<CR>
"}}}2

Plug 'junegunn/gv.vim', {'on': 'GV'}

if has('nvim')
  Plug 'sindrets/diffview.nvim'
endif

" Plug 'airblade/vim-gitgutter'
"}}}1

" C/C++ {{{1
Plug 'derekwyatt/vim-protodef', {'for': ['c', 'cpp', 'h'],}
Plug 'vim-scripts/FSwitch', {'for': ['c', 'cpp', 'h'],}

" Qt
" Plug 'https://bitbucket.org/kh3phr3n/vim-qt-syntax.git', {'for': ['c', 'cpp', 'h'],}
Plug 'vim-scripts/cpp.vim', {'for': ['c', 'cpp', 'h'],}
"" }}}1

" SQL {{{1
Plug 'vim-scripts/SQLUtilities', {'for': 'sql', 'on': 'SQLUFormatter'}
"### setting for SQLUtilities.vim {{{
 let g:sqlutil_keyword_case = '\U'
"}}}

" Plug 'tpope/vim-db'

Plug 'vim-scripts/dbext.vim'

Plug 'tpope/vim-dadbod', {'for': 'sql'}
" Plug 'kristijanhusak/vim-dadbod-ui', {'for': 'sql'}

" SQL Language Server Wrapper
Plug 'nanotee/sqls.nvim'

" }}}1

" iOS {{{1
Plug 'msanders/cocoa.vim', {'for': 'objective-c'}
"Plug 'eraserhd/vim-ios' " crashed vim
" }}}1

" PHP {{{1
" use treesitter folding support instead
" Plug 'rayburgemeestre/phpfolding.vim'
" }}}1

" GoLang {{{1
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" }}}1

" Vue {{{1
Plug 'posva/vim-vue'
" to make vim-vue plugin faster, more details: https://github.com/posva/vim-vue
let g:vue_disable_pre_processors=1

" }}}1

" games {{{1
"NeoBundleLazy 'sokoban.vim'
"NeoBundleLazy 'TeTrIs.vim'
"}}}1

" icons {{{1
" always load devicon as the last one
if has('nvim')
	Plug 'kyazdani42/nvim-web-devicons'
else
	Plug 'ryanoasis/vim-devicons'
endif
"}}}1

call plug#end()

"### CamelCaseMotion {{{1
  call camelcasemotion#CreateMotionMappings(',')
"}}}1

"### coc.vim settings {{{1

"if !has('nvim-0.5')
"  set signcolumn=yes
"
"  " Use tab for trigger completion with characters ahead and navigate.
"  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"  inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
"  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"  function! s:check_back_space() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~# '\s'
"  endfunction
"
"  " Use <c-n> to trigger completion.
"  inoremap <silent><expr> <c-n> coc#refresh()
"
"  " To make <cr> select the first completion item and confirm the completion
"  " and format code when no item has been selected
"  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"  " Use `[g` and `]g` to navigate diagnostics
"  nmap <silent> [g <Plug>(coc-diagnostic-prev)
"  nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"  " Remap keys for gotos
"  nmap <silent> gd <Plug>(coc-definition)
"  nmap <silent> gY <Plug>(coc-type-definition)
"  nmap <silent> gi <Plug>(coc-implementation)
"  nmap <silent> gr <Plug>(coc-references)
"
"  "imap <silent> jj <Plug>(coc-float-hide)
"
"  " Close the preview window when completion is done.
"  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
"
"  " Highlight symbol under cursor on CursorHold
"  autocmd CursorHold * silent call CocActionAsync('highlight')
"
"  " show func signature help
"  " autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
"
"  augroup mygroup
"    autocmd!
"    " Setup formatexpr specified filetype(s).
"    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"    " Update signature help on jump placeholder
"    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"  augroup end
"
"  " Remap for rename current word
"  nmap ;rn <Plug>(coc-rename)
"
"  " Remap for format selected region
"  xmap ;f  <Plug>(coc-format-selected)
"  nmap ;f  <Plug>(coc-format-selected)
"
"  " Remap for do codeAction of current line
"  nmap ;ca  <Plug>(coc-codeaction)
"  " Fix autofix problem of current line
"  nmap ;qf  <Plug>(coc-fix-current)
"
"  " Use `:Format` to format current buffer
"  command! -nargs=0 Format :call CocAction('format')
"
"  " Use `:Fold` to fold current buffer
"  command! -nargs=? Fold :call CocAction('fold', <f-args>)
"
"  " grep word under cursor
"  command! -nargs=+ -complete=custom,s:GrepArgs CocRg exe 'CocList grep '.<q-args>
"
"  function! s:GrepArgs(...)
"    let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
"         \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
"    return join(list, "\n")
"  endfunction
"
"  " Keymapping for grep word under cursor with interactive mode
"  nnoremap <silent> ;cf :exe 'CocList --input='.expand('<cword>').' grep'<CR>
"
"endif

"}}}1

"### vimdevicons settings {{{1
let g:airline_powerline_fonts = 1
let g:webdevicons_enable_startify = 1
"}}}1

"### startify settings {{{1
let g:startify_bookmarks = [
  \ {'c': '~/workspace/cpt/cpt'},
  \ {'w': '~/workspace/cpt/batch_worker'},
  \ {'m': '~/workspace/cpt/ems'},
  \ {'f': '~/workspace/iot/freeboard'},
  \ {'i': '~/.vim'} ]

let g:startify_custom_header_quotes = [
  \ ['“Any fool can write code that a computer can understand. Good programmers write code that humans can understand.”    – Martin Fowler'] ,
  \ ['“Experience is the name everyone gives to their mistakes.”    – Oscar Wilde'],
  \ ['“Knowledge is power.”    – Francis Bacon'],
  \ ['“ Code is like humor. When you have to explain it, it’s bad.”    – Cory House'],
  \ ['“Simplicity is the soul of efficiency.”    – Austin Freeman'],
  \ ['“Before software can be reusable it first has to be usable.”    – Ralph Johnson'],
  \ ['“Make it work, make it right, make it fast.”    – Kent Beck'],
  \ ["“Don't write better error messages, write code that doesn't need them.”    - Jason C. McDonald"],
  \ ["“You're bound to be unhappy if you optimize everything.” — Donald Knuth"],
  \ ["“Don't design with interface, discover them.” — Rob Pike"],
  \ ]
let g:startify_custom_header = 'startify#pad(startify#fortune#quote())'
" let g:startify_custom_header =
"   \ startify#pad(split(system('figlet -w 100 HAPPY HACKING!'), '\n'))

" integrate startify with Obsession 
command! -nargs=? -bar -bang -complete=customlist,startify#session_list SSave
  \ call startify#session_save(<bang>0, <f-args>) |
  \ if !empty(v:this_session) |
  \   execute "Obsession " . v:this_session |
  \ endif

noremap ,s :Startify<CR>
"}}}1

"### gitgutter settings {{{1
set updatetime=300
"}}}1

"### vim-go settings {{{1
" let g:go_fmt_options = {
"  \ 'gofmt': '-s'
"  \ }
  let g:go_auto_sameids = 0
  let g:go_auto_type_info = 0
  let g:go_addtags_transform = 'camelcase'

  " don't break the <C-]> & <C-T> workflow
	let g:go_def_mapping_enabled = 0
"}}}1

"### vifm settings {{{1
" only define one mapping, the shortcuts on how to open the file are defined
" in vifmrc
let g:vifm_exec_args="-c ':only'"
map <leader>vv :Vifm<CR>
" map <leader>vf :Vifm<CR>
" map <leader>vv :VsplitVifm<CR>
" map <leader>vs :SplitVifm<CR>
" map <leader>vd :DiffVifm<CR>
" map <leader>vt :TabVifm<CR>
"}}}1

"### vim-which-key settings {{{1
" nnoremap <silent> <leader> :<c-u>WhichKey '['<CR>
"}}}1

"### vache {{{1
" let g:vache_default_docset_dir = '/Users/vincent/Library/Application Support/Dash/DocSets'
let g:vache_filetype_options = {
  \ 'qt': ['cpp', 'qt']
  \ }
" nmap <silent> ,k yiw:VacheLookup " <CR>
" vmap <silent> ,k y:VacheLookup " <CR>

let g:vache_browser = "Chrome"
"}}}1

"### quick-scope {{{1
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"}}}1

"### Grepper {{{1
  " command! -nargs=* -complete=file GG Grepper -tool git -open -switch -query <args>
  " command! -nargs=* -complete=file Ag Grepper -tool ag -open -switch -query <args>
  command! -nargs=* -complete=file Rg Grepper -noprompt -tool rg -open -switch -query <args>
  " command! -nargs=* -complete=file Pt Grepper -tool pt -open -switch -query <args>

  " nnoremap <leader>g <plug>(GrepperOperator)
  " xnoremap <leader>g <plug>(GrepperOperator)
  nnoremap ,gr :Grepper -tool rg -cword -noprompt<cr>
  vnoremap ,gr  y:Rg "<cr>

  let g:grepper           = {}
  let g:grepper.open      = 1
  let g:grepper.switch    = 1
  let g:grepper.jump      = 1
  let g:grepper.dispatch  = 0
  let g:grepper.tools     = ['rg', 'git', 'ag', 'findstr', 'sift', 'grep']
"}}}1

if has('nvim-0.5')

  " Helper functions
lua <<EOF
  function _G.put(...)
    local objects = {}
    for i = 1, select('#', ...) do
      local v = select(i, ...)
      table.insert(objects, vim.inspect(v))
    end

    print(table.concat(objects, '\n'))
    return ...
  end
EOF

" ### luasnip {{{1
if has('nvim')
lua <<EOF
  local function prequire(...)
  local status, lib = pcall(require, ...)
  if (status) then return lib end
      return nil
  end

  local ls = prequire("luasnip")
  local cmp = prequire("cmp")

	local t = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

	local check_back_space = function()
		local col = vim.fn.col('.') - 1
		if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
			return true
		else
			return false
		end
	end

	_G.tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_next_item()
    -- elseif vim.fn.pumvisible() == 1 then
			-- return t "<C-n>"
		elseif ls and ls.expand_or_jumpable() then
			return t("<Plug>luasnip-expand-or-jump")
		elseif check_back_space() then
			return t "<Tab>"
		else
      cmp.complete() -- nvim-cmp
 	 -- -- completion_smart_tab func will check should insert 'tab' or trigger completion
			-- return t "<Plug>(completion_smart_tab)"
			-- return vim.fn['completion#completion_smart_tab']()
		end
		return ""
	end
	_G.s_tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_prev_item()
    -- elseif vim.fn.pumvisible() == 1 then
			-- return t "<C-p>"
		elseif ls and ls.jumpable(-1) then
			return t("<Plug>luasnip-jump-prev")
		else
			return t "<S-Tab>"
		end
		return ""
	end

  -- use key mapping in above nvim-cmp config
	-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
	-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
	-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
	-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

  local types = require("luasnip.util.types")
  vim.api.nvim_command("hi LuasnipChoiceNodePassive cterm=italic")
  ls.config.setup({
    ext_opts = {
      [types.insertNode] = {
        passive = {
          hl_group = "GruvboxRed"
        }
      },
      [types.choiceNode] = {
        active = {
          virt_text = {{"<- ChoiceNode", "Comment"}}
        }
      },
    },
    ext_base_prio = 200,
    ext_prio_increase = 7,
    delete_check_events = "InsertLeave",
    history = true,
    store_selection_keys = "<Tab>",
  })

  -- show floating window for choices {{{2
  local current_nsid = vim.api.nvim_create_namespace("LuaSnipChoiceListSelections")
  local current_win = nil

  local function window_for_choiceNode(choiceNode)
      local buf = vim.api.nvim_create_buf(false, true)
      local buf_text = {}
      local row_selection = 0
      local row_offset = 0
      local text
      for _, node in ipairs(choiceNode.choices) do
          text = node:get_docstring()
          -- find one that is currently showing
          if node == choiceNode.active_choice then
              -- current line is starter from buffer list which is length usually
              row_selection = #buf_text
              -- finding how many lines total within a choice selection
              row_offset = #text
          end
          vim.list_extend(buf_text, text)
      end

      vim.api.nvim_buf_set_text(buf, 0,0,0,0, buf_text)
      local w, h = vim.lsp.util._make_floating_popup_size(buf_text)

      -- adding highlight so we can see which one is been selected.
      local extmark = vim.api.nvim_buf_set_extmark(buf,current_nsid,row_selection ,0,
          {hl_group = 'incsearch',end_line = row_selection + row_offset})

      -- shows window at a beginning of choiceNode.
      local win = vim.api.nvim_open_win(buf, false, {
          relative = "win", width = w, height = h, bufpos = choiceNode.mark:pos_begin_end(), style = "minimal", border = 'rounded'})

      -- return with 3 main important so we can use them again
      return {win_id = win,extmark = extmark,buf = buf}
  end

  function choice_popup(choiceNode)
    -- build stack for nested choiceNodes.
    if current_win then
      vim.api.nvim_win_close(current_win.win_id, true)
                  vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
    end
          local create_win = window_for_choiceNode(choiceNode)
    current_win = {
      win_id = create_win.win_id,
      prev = current_win,
      node = choiceNode,
                  extmark = create_win.extmark,
                  buf = create_win.buf
    }
  end

  function update_choice_popup(choiceNode)
      vim.api.nvim_win_close(current_win.win_id, true)
      vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
      local create_win = window_for_choiceNode(choiceNode)
      current_win.win_id = create_win.win_id
      current_win.extmark = create_win.extmark
      current_win.buf = create_win.buf
  end

  function choice_popup_close()
    vim.api.nvim_win_close(current_win.win_id, true)
          vim.api.nvim_buf_del_extmark(current_win.buf,current_nsid,current_win.extmark)
          -- now we are checking if we still have previous choice we were in after exit nested choice
    current_win = current_win.prev
    if current_win then
      -- reopen window further down in the stack.
                  local create_win = window_for_choiceNode(current_win.node)
                  current_win.win_id = create_win.win_id
                  current_win.extmark = create_win.extmark
                  current_win.buf = create_win.buf
    end
  end

  vim.cmd([[
  augroup choice_popup
  au!
  au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
  au User LuasnipChoiceNodeLeave lua choice_popup_close()
  au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
  augroup END
  ]])
  -- }}}2
EOF

  imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>' 
  inoremap <silent> <c-g> <cmd>lua require'luasnip'.jump(-1)<Cr>

  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(1)<Cr>
  snoremap <silent> <c-g> <cmd>lua require('luasnip').jump(-1)<Cr>

  imap <silent><expr> <c-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-l>'
  smap <silent><expr> <c-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-l>'

  vnoremap <c-o>  "ec<C-\><C-O>:lua require('luasnip.extras.otf').on_the_fly()<cr>
  inoremap <c-o>  <C-\><C-O>:lua require('luasnip.extras.otf').on_the_fly("e")<cr>

  " load my personal snippets
  luafile ~/.vim/luasnippets.lua

endif
" }}}1

" ### nvim-cmp {{{1
lua <<EOF

	local t = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

	local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  local cmp = require'cmp'
  cmp.setup {
    sources = cmp.config.sources({
			{ name = 'nvim_lsp', keyword_length = 3 },
			{ name = 'luasnip', keyword_length = 3, option = { use_show_condition = true } },
    }, {
			{ name = 'buffer', keyword_length = 5},
    }),
    completion = {
      completeopt = 'menu,menuone,noselect',
      autocomplete = false,
    },
		snippet = {
			expand = function(args)
        require'luasnip'.lsp_expand(args.body)
      end
		},
		mapping = cmp.mapping.preset.insert({
			["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
			end, { "i", "s" }),
			['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<C-n>'] = cmp.mapping(function(fallback)
        if cmp.visible() then 
          cmp.select_next_item()
        else
          fallback()
        end
      end, { "i", "s"}),
      ['<C-p>'] = cmp.mapping(function(fallback)
        if cmp.visible() then 
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s"}),
			['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
		}),
		formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        -- vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
        vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)

        -- set a name for each source
        -- vim_item.menu = ({
        -- 	buffer = "[Buffer]",
        -- 	nvim_lsp = "[LSP]",
        -- 	luasnip = "[LuaSnip]",
        -- 	nvim_lua = "[Lua]",
        -- 	latex_symbols = "[Latex]",
        -- })[entry.source.name]
        vim_item.menu = ({
          luasnip = "",
          nvim_lsp = "ﲳ",
          buffer = "﬘",
          treesitter = "",
          nvim_lua = "",
          path = "ﱮ",
          spell = "暈",
        })[entry.source.name] 
        return vim_item
      end,
		},
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
		enabled = function()
      -- disable completion in comments
      local context = require 'cmp.config.context'
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
        return not context.in_treesitter_capture("comment") 
          and not context.in_syntax_group("Comment")
      end
    end,
  }

  cmp.setup.filetype({ 'markdown', 'txt', 'json', 'yaml' }, {
    sources = {
      { name = 'path' },
      { name = 'buffer' },
    }
  })

  local cmdline_mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
      end
    end, { "c" }),
  }
  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(cmdline_mapping),
    sources = cmp.config.sources({
      { name = 'cmdline' },
      { name = 'path' },
    })
  })

EOF
" }}}1

" ### TreeSitter {{{1
lua <<EOF

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

-- These two are optional and provide syntax highlighting
-- for Neorg tables and the @document.meta tag
parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main"
    },
}
parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main"
    },
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      -- ["foo.bar"] = "Identifier",
    },
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      scope_incremental = "grc",
      node_incremental = "grn",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
  context_commentstring = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["am"] = "@function.outer",
        ["im"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ao"] = "@parameter.outer",
				["io"] = "@parameter.inner",

        -- following config section will cause errors, refs: https://githubhot.com/repo/nvim-treesitter/nvim-treesitter-textobjects/issues/171
        -- Or you can define your own textobjects like this
        -- ["iF"] = {
        --   python = "(function_definition) @function",
        --   cpp = "(function_definition) @function",
        --   c = "(function_definition) @function",
        --   java = "(method_declaration) @function",
        -- },
      },
    },
		swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
		move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]k"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]K"] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[k"] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[K"] = "@class.outer",
      },
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
  autotag = {
    enable = true,
  },
}

-- function _G.toggle_fold() 
--   if vim.o.foldmethod == "expr" then
--     vim.o.foldmethod = "manual"
--   else
--     vim.o.foldmethod = "expr"
--     vim.o.foldexpr = vim.fn['nvim_treesitter#foldexpr']()
--   end
-- end
-- 
-- vim.api.nvim_set_keymap('n', ';z', 'v:lua.toggle_fold()', {expr = true, noremap = true})

 require("tsht").config.hint_keys = { "h", "j", "k", "l", "g", "h", "f", "d", "s", "a", "n", "v" }
EOF

" Tree-sitter based folding.
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" TSHT (Treesitter Hint Textobject)
omap     <silent> ;t :<C-U>lua require('tsht').nodes()<CR>
vnoremap <silent> ;t :lua require('tsht').nodes()<CR>

" }}}1

" ### Language Server  {{{1
lua <<EOF

-- Mappings.
local opts = { noremap=true, silent=true }
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

  vim.keymap.set('n', 'gi', vim.lsp.buf.incoming_calls, bufopts)
  vim.keymap.set('n', 'go', vim.lsp.buf.outgoing_calls, bufopts)

  vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gY', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)

  -- press same shortcut again will focus the floating window
  vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)

  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
  vim.keymap.set('n', '<space>ds', vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set('n', '<space>ws', vim.lsp.buf.workspace_symbol, bufopts)

  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function() 
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  -- -- enable function signature popup
  require "lsp_signature".on_attach({
    bind = true,
    hi_parameter = "IncSearch",
    hint_enable = true,
    hint_prefix = "🐼 ",
    -- handler_opts = {
    --   border = "single",
    -- },
    -- prevent float window overlapped
    -- floating_window_above_cur_line = false,
    -- toggle signature key
    toggle_key = "<c-]>",
  }, bufnr)

end

-- set up nvim-cmp integration
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {"gopls", "phpactor", "vuels", "sqls", "sumneko_lua", "clangd"}
})

require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler 
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      }
    }
    require("lspconfig")[server_name].setup(opts)
  end,

  -- (optional) Customize the options passed to the server
  -- if server_name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end,

  -- sqls config
  ["sqls"] = function()
    local opts = {
      capabilities = capabilities,
      single_file_support = true,
      -- picker = "fzf",
    }
		opts.on_attach = function(client, buf) 
			client.server_capabilities.execute_command = true
			client.commands = require('sqls').commands -- Neovim 0.6+ only
      require('sqls').on_attach(client, buf)

			on_attach(client, buf)	
		end

		opts.settings = {
      sqls = {
        connections = {
          {
            driver = "sqlite3",
            dataSourceName = "file:/Users/vincent/workspace/cpt/ems/server/edge.db",
          },
          {
            driver = "sqlite3",
            dataSourceName = "file:/Users/vincent/workspace/cpt/ems/server/shadow.db",
          },
          {
            driver = "sqlite3",
            dataSourceName = "file:/Users/vincent/workspace/cpt/ems/server/history.db",
          },
        }
      }
    }
  
    require("lspconfig")['sqls'].setup(opts)
    -- print(vim.inspect(opts))
	end,
})

EOF

" }}}1

" ### lspfuzzy {{{1
lua <<EOF
	require('lspfuzzy').setup {
		methods = 'all',         -- either 'all' or a list of LSP methods (see below)
		jump_one = true,         -- jump immediately if there is only one location
		fzf_preview = {          -- arguments to the FZF '--preview-window' option
			'right:+{2}-/2,nohidden'          -- preview on the right and centered on entry
		},
		fzf_action = {           -- FZF actions
			['ctrl-t'] = 'tabedit',  -- go to location in a new tab
			['ctrl-v'] = 'vsplit',   -- go to location in a vertical split
			['ctrl-x'] = 'split',    -- go to location in a horizontal split
		},
		fzf_modifier = ':~:.',   -- format FZF entries, see |filename-modifiers|
		fzf_trim = true,         -- trim FZF entries
	}
EOF
"}}}1

" ### lspkind-nvim {{{1
lua <<EOF
  require('lspkind').init({
    mode = true,
    symbol_map = {
      Text = "",
      Method = "",
      Function = "",
      Constructor = "",
      Field = "ﰠ",
      Variable = "",
      Class = "ﴯ",
      Interface = "",
      Module = "",
      Property = "ﰠ",
      Unit = "塞",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "פּ",
      Event = "",
      Operator = "",
      TypeParameter = ""
    }
  })
EOF
" }}}1

" ### lsp-colors {{{1
lua require("lsp-colors").setup({})
" }}}1

" ### completion.nvim {{{1
" augroup completion
" 	autocmd!
"   " can assign different completion settings based on file type
" 	autocmd BufEnter * lua require'completion'.on_attach()
" 	autocmd FileType cpp let g:completion_trigger_character = ['.', '::']
" 	autocmd FileType sql let g:completion_trigger_character = ['.', '"', '`', '[']
" augroup END

" " Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert

" " Avoid showing message extra message when using completion
" set shortmess+=c

" let g:completion_enable_auto_popup = 0
" let g:completion_enable_auto_signature = 1
" let g:completion_enable_auto_hover = 1
" let g:completion_timer_cycle = 100

" let g:completion_matching_smart_case = 1
" let g:completion_trigger_keyword_length = 3 " default = 1

" let g:completion_matching_strategy_list = ['exact', 'substring']

" let g:completion_chain_complete_list = {
" 	    \ 'lua': {
" 	    \    'string': [
" 	    \        {'mode': '<c-p>'},
" 	    \        {'mode': '<c-n>'}],
" 	    \    'default': [
" 	    \       {'complete_items': ['lsp']},
" 	    \       {'mode': '<c-p>'},
" 	    \       {'mode': '<c-n>'}],
" 	    \  },
" 			\ 'sql' : [
" 			\    {'complete_items': ['vim-dadbod-completion']},
" 			\  ],
" 	    \ 'default' : {
" 	    \   'comment': [],
" 			\   'string': [
" 			\       {'complete_items': ['path'], 'triggered_only': ['/']},
" 	    \       {'mode': '<c-p>'},
" 	    \       {'mode': '<c-n>'},
" 			\   ],
" 	    \   'default': [
" 	    \       {'complete_items': ['lsp']},
" 	    \       {'complete_items': ['buffers']},
" 			\       {'complete_items': ['path'], 'triggered_only': ['/']},
" 	    \       {'mode': '<c-p>'},
" 	    \       {'mode': '<c-n>'}]
" 	    \   }
" 	    \}

" " Use <Tab> and <S-Tab> to navigate through popup menu
" " inoremap <tab> <Plug>(completion_smart_tab)
" " inoremap <s-tab> <Plug>(completion_smart_s_tab)

" " use the enter key mapping defined in autopair config section
" " let g:completion_confirm_key = ""
" " imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
" "                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"

" }}}1

" ### nvim-autopairs {{{1
lua <<EOF
	-- require('nvim-autopairs').setup({
	-- 	disable_filetype = { "TelescopePrompt" , "vim" },
	-- })

  -- for nvim-cmp {{{2
	-- you need setup cmp first put this after cmp.setup()
	-- require("nvim-autopairs.completion.cmp").setup({
	-- 	map_cr = true, --  map <CR> on insert mode
	-- 	map_complete = true, -- it will auto insert `(` after select function or method item
	-- 	auto_select = true -- automatically select the first item
	-- })
  -- }}}2

  -- for completion.nvim {{{2
	-- local remap = vim.api.nvim_set_keymap
	-- local npairs = require('nvim-autopairs')

	-- -- skip it, if you use another global object
	-- _G.MUtils= {}

	-- vim.g.completion_confirm_key = ""

	-- MUtils.completion_confirm=function()
	-- 	if vim.fn.pumvisible() ~= 0  then
	-- 		if vim.fn.complete_info()["selected"] ~= -1 then
	-- 			require'completion'.confirmCompletion()
	-- 			return npairs.esc("<c-y>")
	-- 		else
	-- 			vim.api.nvim_select_popupmenu_item(0 , false , false ,{})
	-- 			require'completion'.confirmCompletion()
	-- 			return npairs.esc("<c-n><c-y>")
	-- 		end
	-- 	else
	-- 		return npairs.autopairs_cr()
	-- 	end
	-- end
	-- remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})
	-- }}}2

EOF
" }}}1

" ### hop.nvim {{{1
lua <<EOF

  require'hop'.setup()

  local opts = { noremap=true, silent=true }
  vim.api.nvim_set_keymap("n", ";w", "<cmd>HopWordAC<cr>", opts)
  vim.api.nvim_set_keymap("n", ";b", "<cmd>HopWordBC<cr>", opts)
  vim.api.nvim_set_keymap("n", ";j", "<cmd>HopLineStartAC<cr>", opts)
  vim.api.nvim_set_keymap("n", ";k", "<cmd>HopLineStartBC<cr>", opts)

  vim.api.nvim_set_keymap("v", ";w", "<cmd>HopWordAC<cr>", opts)
  vim.api.nvim_set_keymap("v", ";b", "<cmd>HopWordBC<cr>", opts)
  vim.api.nvim_set_keymap("v", ";j", "<cmd>HopLineStartAC<cr>", opts)
  vim.api.nvim_set_keymap("v", ";k", "<cmd>HopLineStartBC<cr>", opts)

EOF
  map s1 :HopChar1<cr>
  map s2 :HopChar2<cr>
" }}}1

"### indent-blankline {{{1
lua <<EOF

	require("indent_blankline").setup {
			-- char = "|",
			buftype_exclude = {"terminal"},
      filetype_exclude = {"startify"},
	}

EOF
" }}}1

" "### dial.vim {{{1
" nmap <C-a> <Plug>(dial-increment)
" nmap <C-x> <Plug>(dial-decrement)
" vmap <C-a> <Plug>(dial-increment)
" vmap <C-x> <Plug>(dial-decrement)
" vmap g<C-a> <Plug>(dial-increment-additional)
" vmap g<C-x> <Plug>(dial-decrement-additional)
" "}}}1

" ### formatter.nvim {{{1
lua <<EOF

webprettier = function()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0),
            "--single-quote"},
    stdin = true
  }
end

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = { webprettier },
    vue = { webprettier },
    html = { webprettier },
    typescript = { webprettier },
    css = { webprettier },
    scss = { webprettier },
    json = { webprettier },
    yaml = { webprettier },
    rust = {
      -- Rustfmt
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout"},
          stdin = true
        }
      end
    },
    lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
    },
    cpp = {
        -- clang-format
       function()
          return {
            exe = "clang-format",
            args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
            stdin = true,
            cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
          }
        end
    },
    -- prettier has a php plugin(https://github.com/prettier/plugin-php), but phpcbf seems better
		php = {
			function()
				return {
					exe = "phpcbf",
					args = { '--standard=PSR12', bufname },
					stdin = false,
					ignore_exitcode = true,
				}
			end
		},
    sql = {
      function() 
        return {
          exe = "pg_format",
          args = {'--keyword-case', 2, '--type-case', 2, '--spaces', 2, '--no-extra-line'},
          stdin = true
        }
      end
    }
  }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.vue,*.html,*.ts,*.css,*.scss,*.json,*.yml,*.rs,*.lua FormatWrite
augroup END
]], true)

EOF


noremap <silent> <leader>f :Format<CR>

" }}}1

" ### vgit.nvim {{{1
" lua <<EOF
" require('vgit').setup({
" })
" EOF
"}}}1

" ### nvim-web-devicons {{{1
lua << EOF
require'nvim-web-devicons'.setup {
  default = true;
}
EOF
" }}}1

" ### trouble.nvim {{{1
lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF
" }}}1

" ### telescope.nvim {{{1
" lua << EOF
" 	 require('telescope').setup {
" 	 	extensions = {
" 	 		fzf = {
" 	 			fuzzy = true,                    -- false will only do exact matching
" 	 			override_generic_sorter = true,  -- override the generic sorter
" 	 			override_file_sorter = true,     -- override the file sorter
" 	 			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
" 	 			-- the default case_mode is "smart_case"
" 	 		}
" 	 	} 
" 	 }

" 	 require('telescope').load_extension('fzf')
" EOF
" }}}1

" ### zen mode setup {{{1
lua << EOF
-- require("twilight").setup {
-- }

require("zen-mode").setup {
}
EOF
map ;z :ZenMode<cr>
" }}}1

" ### neorg {{{1
lua << EOF
require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          work = "~/neorg/work",
          personal = "~/neorg/personal",
          gtd = "~/neorg/gtd",
        },
        index = "index.norg",
      }
    },
    ["core.norg.concealer"] = {
      config = { -- Note that this table is optional and doesn't need to be provided
        preset = "diamond"   -- Configuration here
      }
    },
    ["core.gtd.base"] = {
      config = { -- Note that this table is optional and doesn't need to be provided
        workspace = "gtd",
        displayers = {
          projects = {
            show_completed_projects = false,
            show_projects_without_tasks = false
          }  
        }
        -- Configuration here
      }
    },
    ["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
    ["core.keybinds"] = { 
      config = {
        neorg_leader = ";",
        hook = function(keybinds) 
          keybinds.map("norg", "n", "toc", "<cmd>Neorg toc split<cr>")

          -- manoeuvre only can move header, not task
          -- keybinds.remap_event("norg", "n", "K", "core.norg.manoeuvre.item_up")
          -- keybinds.remap_event("norg", "n", "J", "core.norg.manoeuvre.item_down")
        end,
      }
    },
    ["core.norg.qol.toc"] = {},
    -- ["core.export"] = {},
  }
}

EOF
" }}}1

" ### dbext {{{1
  let g:dbext_default_user = 'vincent'
  let g:dbext_default_host = 'localhost'

  let g:dbext_default_use_sep_result_buffer = 1
  let g:dbext_default_always_prompt_for_variables = 1
  "let g:dbext_default_display_cmd_line = 1
  
  let g:dbext_default_profile_edgedb = 'type=SQLITE:dbname=~/workspace/cpt/ems/server/edge.db'
  let g:dbext_default_profile_shadowdb = 'type=SQLITE:dbname=~/workspace/cpt/ems/server/shadow.db'
  let g:dbext_default_profile_historydb = 'type=SQLITE:dbname=~/workspace/cpt/ems/server/history.db'
  
  autocmd FileType sql nnoremap <buffer> <space>; :.,.DBExecRangeSQL<cr>
  autocmd FileType sql vnoremap <buffer> <space>; :DBExecVisualSQL<cr>
  autocmd FileType sql nnoremap <buffer> ;t :DBSelectFromTable<cr>
  autocmd FileType sql vnoremap <buffer> ;t :DBSelectFromTable<cr>
  autocmd FileType sql nnoremap <buffer> ;d :DBDescribeTable<cr>
  autocmd FileType sql vnoremap <buffer> ;d :DBDescribeTable<cr>
" }}}1

" ### vim-notify {{{1

lua <<EOF
  vim.notify = require("notify")
EOF

" }}}1

" ### refactoring {{{1

lua <<EOF
  -- require('refactoring').setup({})
  -- -- prompt for a refactor to apply when the remap is triggered
  -- vim.api.nvim_set_keymap(
  --     "v",
  --     "<leader>rr",
  --     ":lua require('refactoring').select_refactor()<CR>",
  --     { noremap = true, silent = true, expr = false }
  -- )
EOF

" }}}1

" ### diffview {{{1

lua <<EOF
  -- change the diff style, refers to: https://github.com/sindrets/diffview.nvim/issues/35
  local set = vim.opt -- set options
  set.fillchars = set.fillchars + 'diff:╱'

  local actions = require("diffview.actions")
  require("diffview").setup({
    default_args = {    -- Default args prepended to the arg-list for the listed commands
      DiffviewOpen = { "--untracked-files=no" },
      DiffviewFileHistory = {},
    },
  })
EOF

" below 2 commands are not provided by diffview plugin, but shared by its
" author at https://github.com/sindrets/diffview.nvim/issues/39
" Open inline diff for changes in all files in a vertical split
command! DiffInline vsp | exe 'term git diff | delta' | startinsert

" Open inline diff for changes in current file in a vertical split
command! DiffInlineFile vsp | exe 'term git diff -- '
             \ . shellescape(expand("%")) . ' | delta' | startinsert
" }}}1

" ### FTerm {{{1
lua <<EOF

  require("FTerm").setup({
    dimensions = {
      height = 0.9,
      width = 0.9,
    }
  })
  -- vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
  -- vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

  vim.api.nvim_create_user_command('FTermGitDiff', function() 
    require('FTerm').scratch({ cmd = {'git', 'diff'} })
  end, { bang = true })

  vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })

EOF
" }}}1

"### AirLine {{{1
  if has('macunix')
    let g:airline_powerline_fonts = 1
  endif
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#tagbar#enabled = 0
  let g:airline#extensions#hunks#enabled = 0
  let g:airline#extensions#eclim#enabled = 0
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_symbols.linenr = '|'
  let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
"}}}1

"### fzf {{{1
if has('nvim')

lua <<EOF
  local actions = require "fzf-lua.actions"
  require'fzf-lua'.setup {
    keymap = {
      builtin = {
        ["<C-h>"]    = "toggle-help",
        ["<C-s>"]    = "toggle-fullscreen",
        ["?"]        = "toggle-preview",
        ["<C-n>"]    = "preview-page-down",
        ["<C-p>"]    = "preview-page-up",
      },
    },
    actions = {
      files = {
        ["default"]     = actions.file_edit_or_qf,
        ["ctrl-s"]      = actions.file_split,
        ["ctrl-v"]      = actions.file_vsplit,
        ["ctrl-t"]      = actions.file_tabedit,
        ["ctrl-l"]      = actions.file_sel_to_qf,
        -- ["ctrl-l"]      = actions.file_sel_to_ll,
      },
      buffers = {
        ["default"]     = actions.buf_edit,
        ["ctrl-s"]      = actions.buf_split,
        ["ctrl-v"]      = actions.buf_vsplit,
        ["ctrl-t"]      = actions.buf_tabedit,

        ["ctrl-l"]      = actions.file_sel_to_qf,
        -- ["ctrl-l"]      = actions.file_sel_to_ll,
      },
    },
  }
EOF

  noremap <c-p> :lua require('fzf-lua').files()<CR>
  noremap ,ff :lua require('fzf-lua').files()<CR>
  " noremap ,fd :Cd<CR>
  " noremap ,fz :Z<CR>
  noremap ,ft :lua require('fzf-lua').tags()<CR>
  noremap ,fl :lua require('fzf-lua').blines()<CR>
  " noremap ,fr :FZFMru<CR>
  noremap ,fb :lua require('fzf-lua').buffers()<CR>
  noremap ,fh :lua require('fzf-lua').oldfiles()<CR>
  noremap ,fq :lua require('fzf-lua').quickfix()<CR>

  noremap ,fm :lua require('fzf-lua').git_bcommits()<CR>

  nnoremap ,fg :lua require('fzf-lua').grep_cword()<CR>
  vnoremap ,fg :lua require('fzf-lua').grep_visual()<CR>
  nnoremap ,fG :lua require('fzf-lua').live_grep_native()<CR>

  nnoremap <space>gr :lua require('fzf-lua').lsp_references()<CR>
  nnoremap <space>gd :lua require('fzf-lua').lsp_definitions()<CR>
  nnoremap <space>gi :lua require('fzf-lua').lsp_incoming_calls()<CR>

  nnoremap ,fC :lua require('fzf-lua').colorschemes()<CR>
  nnoremap ,fB :lua require('fzf-lua').builtin()<CR>
  nnoremap ,fM :lua require('fzf-lua').marks()<CR>
  nnoremap ,fS :lua require('fzf-lua').spell_suggest()<CR>

  nnoremap ,fr :lua require('fzf-lua').resume()<CR>

else
  "Jump to the existing window if possible
  let g:fzf_buffers_jump = 1

  " Customize fzf colors to match your color scheme
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

	" An action can be a reference to a function that processes selected lines
	function! s:build_quickfix_list(lines)
		call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
		copen
		cc
	endfunction

	let g:fzf_action = {
		\ 'ctrl-q': function('s:build_quickfix_list'),
		\ 'ctrl-t': 'tab split',
		\ 'ctrl-x': 'split',
		\ 'ctrl-v': 'vsplit' }

  " Insert mode completion
  " imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)

  let g:fzf_tags_command = 'ctags -R'

if has('nvim')
  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
	function! FloatingFZF()
		let buf = nvim_create_buf(v:false, v:true)
		call setbufvar(buf, '&signcolumn', 'no')

		let height = &lines - 3
		let width = float2nr(&columns - (&columns * 2 / 10))
		let col = float2nr((&columns - width) / 2)

		let opts = {
					\ 'relative': 'editor',
					\ 'row': 1,
					\ 'col': col,
					\ 'width': width,
					\ 'height': height
					\ }

		call nvim_open_win(buf, v:true, opts)
	endfunction
endif

  " complete input as name in current file in fuzzy way
  " e.g.: gCC => getCurrentComponent
  " inoremap <expr> <c-x><c-k> fzf#complete({
  "      \ 'source': "/usr/bin/grep -o -E '\\w{5,}' " . expand('%:p') . "\| /usr/bin/sort -uf",
  "      \ 'options': '-0 -1 -x',
  "      \ 'left': 35})

  " Replace the default dictionary completion with fzf-based fuzzy completion
  " inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')

  " select file/path from command
  function! s:append_dir_with_fzf(line)
  	call fzf#run(fzf#wrap({
  		\ 'options': ['--prompt', a:line.'> '],
  		\ 'source': 'fd -t d',
  		\ 'sink': {line -> feedkeys("\<esc>:".a:line.line, 'nt')}}))
  	return ''
  endfunction
  cnoremap <expr> <c-x><c-d> <sid>append_dir_with_fzf(getcmdline())

  function! s:get_cmd_args(...) abort
    if a:0 > 0
      return a:1
    else
      return '.'
    endif
  endfunction
  command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
    \ {'source': 'fd -t d '. s:get_cmd_args(<f-args>),
    \  'sink': 'cd'}))

  " Likewise, Files command with preview window
  command! -bang -nargs=? -complete=dir FzfFiles
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('up:50%:hidden', '?'), <bang>0)

  " Augmenting Ag command using fzf#vim#with_preview function
  "   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
  "     * For syntax-highlighting, Ruby and any of the following tools are required:
  "       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
  "       - CodeRay: http://coderay.rubychan.de/
  "       - Rouge: https://github.com/jneen/rouge
  "
  "   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
  "   :Ag! - Start fzf in fullscreen and display the preview window above
  command! -bang -nargs=* FzfAg
    \ call fzf#vim#ag(<q-args>,
    \                 <bang>0 ? fzf#vim#with_preview('up:70%')
    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \                 <bang>0)

  command! -bang -nargs=* FzfRg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:70%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)


  function! Fzf_files_with_dev_icons(command)
    let l:fzf_files_options = '-x -m --preview="bat --color \"always\" --style numbers {2..} | head -'.&lines.'" --preview-window=up:70%:wrap:hidden --bind="?:toggle-preview,ctrl-p:preview-up,ctrl-n:preview-down,ctrl-r:jump-accept,ctrl-d:delete-char/eof" --expect=ctrl-v,ctrl-x,ctrl-t --tiebreak=end,length'
    function! s:edit_devicon_prepended_file(items)
      let items = a:items
      let i = 1
      let ln = len(items)
      while i < ln
        let item = items[i][4:-1]
        let items[i] = item
        let i += 1
      endwhile
      call s:Sink(items)
    endfunction

    echom a:command
    let l:opts = fzf#wrap({})
    let l:opts.source = a:command.' | devicon-lookup'
    let s:Sink = l:opts['sink*']
    let l:opts['sink*'] = function('s:edit_devicon_prepended_file')
    let l:opts.options = l:fzf_files_options
    let l:opts.down = '40%'
    call fzf#run(l:opts)
  endfunction
  nnoremap <c-p> :call Fzf_files_with_dev_icons("fd -d 8 -t f")<CR>
  " nnoremap <c-p> :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND)<CR>

  function! Fzf_git_diff_files_with_dev_icons()
    let l:fzf_files_options = '-x -m --ansi --preview "sh -c \"(git diff --color=always -- {3..} | sed 1,4d; bat --color always --style numbers {3..}) | head -'.&lines.'\"" --preview-window=up:70%:wrap:hidden --bind="?:toggle-preview,ctrl-e:preview-up,ctrl-d:preview-down,ctrl-r:jump-accept" --expect=ctrl-v,ctrl-x,ctrl-t --tiebreak=end,length '

    function! s:edit_devicon_prepended_file_diff(items)
      let items = a:items
      let i = 1
      let ln = len(items)
      let l:first_diff_line_number = 0
      while i < ln
        let l:file_path = items[i][7:-1]
        let items[i] = l:file_path
        let l:first_diff_line_number = system("git diff -U0 ".l:file_path." | rg '^@@.*\+' -o | rg '[0-9]+' -o | head -1")
        let i += 1
      endwhile
      call s:SinkForGitDiff(items)
      execute l:first_diff_line_number
    endfunction

    let opts = fzf#wrap({})
    let opts.source = 'git -c color.status=always status --short --untracked-files=all | devicon-lookup'
    let s:SinkForGitDiff = opts['sink*']
    let opts['sink*'] = function('s:edit_devicon_prepended_file_diff')
    let opts.options = l:fzf_files_options
    let opts.down = '40%'
    call fzf#run(opts)
  endfunction
  nnoremap ,fc :call Fzf_git_diff_files_with_dev_icons()<CR>

  function! FzfSpellSink(word)
    exec 'normal! "_ciw'.a:word
  endfunction

  function! FzfSpell()
    let suggestions = spellsuggest(expand("<cword>"))
    return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 25})
  endfunction
  nnoremap <silent> z= :call FzfSpell()<CR>

  " open dash docset through fzf
  let g:dash_filetype_options = {
      \ 'haskell': [ 'haskell' ],
      \ 'go': [ 'go' ],
      \ 'js': [ 'lodash', 'd3', 'moment', 'javascript' ],
      \ 'r': [ 'r' ],
      \ 'css': [ 'css' ],
      \ 'less': [ 'css', 'less' ],
      \ 'svg': [ 'svg' ],
      \ 'cpp': [ 'cpp', 'qt' ],
      \ 'php': [ 'php' ],
      \ 'javascript': [ 'javascript' ],
      \ }
  function! DashDocFamilies()
    let l:families = ''
    if has_key(g:dash_filetype_options, &ft)
      let l:options = g:dash_filetype_options[&ft]
      if type(l:options) == 3 "options is a list
        let l:families = join(l:options, ',')
      endif
    endif
    return l:families
  endfunction

  let g:dash_chrome_tab_id = ''

  function! s:do_open_docset_by_keyword(word, lucky_mode)
    " GOTCHA: due to mac's privacy restriction, can not run chrome-cli within
    " vimr to open doc URL in chrome. use mosquitto as a workaround:
    " in vimr, publish the url to topic '/chrome-control/url', then in
    " terminal, need to run following command:
    " $ mosquitto_sub -t '/chrome-control/url' | xargs -I{} chrome-cli open "{}"
    let l:is_vimr = has('gui_vimr')
    if l:is_vimr
      let l:cmd = 'mosquitto_pub -t "/chrome-control/url" -m '
    else
      let l:cmd = 'chrome-cli open '
    endif

    let l:families = g:DashDocFamilies()

    " escape special characters
    let l:word = substitute(a:word, '\$', '\\$', '')

    if a:lucky_mode == 1
      let l:cmd = l:cmd . ' "$(fdoc -f ' . l:families . ' -t -m ' . l:word . ')"'
    else
      let l:cmd = l:cmd . ' "$(fdoc -f ' . l:families . ' -t -n ' . l:word . ')"'
    endif
    echom l:cmd

    if l:is_vimr
      let l:foo = system(l:cmd)
    else
      if strlen(g:dash_chrome_tab_id) != 0
        let l:cmd = l:cmd . ' -t ' . g:dash_chrome_tab_id
      endif

      let l:lines = systemlist(l:cmd)
      if len(l:lines) != 0
        let g:dash_chrome_tab_id = substitute(l:lines[0], '^Id: \(\d\+\)$', '\1', '')
      endif
    endif
  endfunction

  function! s:open_docset_by_keyword(word)
    call s:do_open_docset_by_keyword(a:word, 0)
  endfunction

  function! FzfDashOpenByWord(word)
    call s:do_open_docset_by_keyword(a:word, 1)
  endfunction

  function! FzfDash(...)
    let l:families = g:DashDocFamilies()

    let l:fzf_options = ' --prompt="' . l:families . '> " '
    if a:0 == 1
      let l:fzf_options = l:fzf_options . ' --query="' . a:1 . '"'
    endif

    call fzf#run({
        \ 'source': 'fdoc -f ' . l:families,
        \ 'sink': function('s:open_docset_by_keyword'),
        \ 'options': l:fzf_options
        \ })
  endfunction
  command! -nargs=? FzfDash call FzfDash(<f-args>)
  nmap <silent> ,k yiw:FzfDash '" <CR>
  nmap <silent> ,K yiw:silent call FzfDashOpenByWord('"')<CR>
  vmap <silent> ,K y:silent call FzfDashOpenByWord('"')<CR>

	"FZF Buffer Delete
	function! s:list_buffers()
		redir => list
		silent ls
		redir END
		return split(list, "\n")
	endfunction
	function! s:delete_buffers(lines)
		execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
	endfunction
	command! FzfBD call fzf#run(fzf#wrap({
		\ 'source': s:list_buffers(),
		\ 'sink*': { lines -> s:delete_buffers(lines) },
		\ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
	\ }))

  noremap ,ff :FzfFiles<CR>
  noremap ,fd :Cd<CR>
  noremap ,fz :Z<CR>
  noremap ,ft :Tags<CR>
  noremap ,fl :Lines<CR>
  " noremap ,fr :FZFMru<CR>
  noremap ,fb :Buffers<CR>
  noremap ,fh :History<CR>
  noremap ,fm :BCommits<CR>

  nnoremap ,fg yiw:FzfRg "
  vnoremap ,fg  y:FzfRg "<CR>

endif
"}}}1

endif

" vim: ft=vim foldmethod=marker expandtab ts=2 sw=2
