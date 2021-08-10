" Autoinstall vim-plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" }}}

call plug#begin('~/.vim/bundle')

" Basic Editing {{{1
Plug 'tpope/vim-repeat'

if has('nvim-0.5')
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

" Plug 'ervandew/supertab'
"### settings for supertab.vim {{{2
  let g:SuperTabLongestHighlight = 1

  " following setting will set YouCompleteMe as default completion type
  " refer to: http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
  let g:SuperTabDefaultCompletionType = '<c-n>'

  " let g:SuperTabMappingBackward = '<nop>' " disable backward mapping
"}}}2

" this plugin make vim slow, don't know why
" Plug 'bsl/obviousmode'

Plug 'tpope/vim-surround'
Plug 'bkad/CamelCaseMotion'

" }}}1

" Coding {{{1
" Plug 'tomtom/tcomment_vim'
Plug 'Shougo/context_filetype.vim' " help caw.vim to comment based on filetype of context
Plug 'tyru/caw.vim'

" Plug 'Yggdroot/indentLine'
" "### IndentLine {{{2
"   " let g:indentLine_char= '︙'
"   let g:indentLine_color_term = 239
"   let g:indentLine_color_gui = '#A4E57E'
" "}}}2

"Plug 'majutsushi/tagbar'

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
Plug 'junegunn/seoul256.vim'
" Plug 'sainnhe/vim-color-desert-night'
Plug 'lifepillar/vim-solarized8'
" }}}1

" Enhanced Syntax {{{1
Plug 'neomutt/neomutt.vim'
au BufNewFile,BufRead *.muttrc,aliases set filetype=neomuttrc

" }}}1

" Advanced Editing {{{1
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'tweekmonster/fzf-filemru'
" Plug 'pbogut/fzf-mru.vim'
"### fzf {{{2
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

  " Insert mode completion
  " imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)

  
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


  noremap ,ff :FzfFiles<CR>
  noremap ,fd :Cd<CR>
  noremap ,fz :Z<CR>
  noremap ,ft :Tags<CR>
  noremap ,fl :Lines<CR>
  " noremap ,fr :FZFMru<CR>
  noremap ,fb :Buffers<CR>
  noremap ,fh :History<CR>

  nnoremap ,fg yiw:FzfRg "<CR>
  vnoremap ,fg  y:FzfRg "<CR>

"}}}2

Plug 'vifm/vifm.vim'

"Plug 'vim-scripts/AutoComplPop'

Plug 'mhinz/vim-grepper'

Plug 'drmingdrmer/xptemplate'
"### xptemplate {{{2
  " load snippets from personal folder
  set runtimepath+=~/.vim/personal/
  
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
  let g:xptemplate_key = '<c-l>'

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

" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
"### settings for UltiSnips.vim {{{2
  let g:UltiSnipsExpandTrigger="<c-l>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
  let g:UltiSnipsListSnippets="<c-tab>"
  let g:UltiSnipsEnableSnipMate=0

  command! ResetUltiSnip :py UltiSnips_Manager.reset()
"}}}2

"Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'}
"### EasyAlign {{{2
  vnoremap <silent> <Enter> :EasyAlign<cr>
"}}}2

"required by SQLUtility.vim
" Plug 'vim-scripts/Align'

Plug 'vim-scripts/LargeFile'
Plug 'tpope/vim-abolish', {'on': 'Subvert'}
" Plug 'tpope/vim-dispatch'

Plug 'vim-scripts/vimwiki'
"### settings for vimwiki {{{2
  let g:vimwiki_menu = "Plugin.Vimwiki"
  let g:vimwiki_list = [{'path': '~/vimwiki', 'path_html': '~/vimwiki_html'},
        \ {'path': '~/workspace/auction/client/notes/', 'path_html': '~/workspace/auction/client/notes/html'}]
"}}}2

Plug 'sk1418/Join', {'on': 'Join'}
Plug 'vim-scripts/sessionman.vim', {'on': ['SessionOpen', 'SessionOpenLast', 'SessionClose', 'SessionSave', 'SessionSaveAs', 'SessionShowLast']}
" Plug 'MattesGroeger/vim-bookmarks', {'on': 'BookmarkToggle'}
" Plug 'kana/vim-textobj-user'
Plug 'wellle/targets.vim'
" Plug 'lilydjwg/colorizer'
"### Colorize {{{2
  let g:colorizer_startup = 0
"}}}2

" Plug 'tpope/vim-afterimage'
Plug 'vim-scripts/Visual-Mark'
"### visualmark {{{2
  nnoremap <silent> ,n :call Vm_goto_next_sign()<cr>
  nnoremap <silent> ,p :call Vm_goto_prev_sign()<cr>
"}}}2

" Plug 'haya14busa/incsearch.vim'
" Plug 'haya14busa/incsearch-easymotion.vim'
" Plug 'haya14busa/incsearch-fuzzy.vim'

Plug 'vim-scripts/VisIncr'

" Plug 'linsong/hexman.vim'

" Completion setup
if has('nvim')
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'zchee/deoplete-go', { 'do': 'make'}
  " Plug 'Shougo/deoplete-clangx'
  " Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
  " Plug 'linsong/deoplete-mutt-alias'
else
  " Plug 'Shougo/deoplete.nvim'
  " Plug 'roxma/nvim-yarp'
  " Plug 'roxma/vim-hug-neovim-rpc'
endif

" Plug 'AndrewRadev/splitjoin.vim'

" Plug 'liuchengxu/vim-which-key', {'on': ['WhichKey', 'WhichKey!']}

" Plug 'voldikss/vim-floaterm'

" Plug 'unblevable/quick-scope'

Plug 'alvan/vim-closetag'

if has('nvim')
  Plug 'monaqa/dial.nvim'
endif

if has('nvim-0.5')
  "TreeSitter 
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-treesitter/playground'

  " Language Server 
  Plug 'neovim/nvim-lspconfig'
  Plug 'kabouzeid/nvim-lspinstall'
	Plug 'ojroques/nvim-lspfuzzy'

  " Plug 'hrsh7th/nvim-compe'
  Plug 'nvim-lua/completion-nvim'

  " not sure if this plugin will make neovim slow, if yes, disable it
  Plug 'lukas-reineke/indent-blankline.nvim'
   
else 
  " Use release branch
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

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

Plug 'vim-scripts/rainbow_csv.vim', {
  \ 'on': 'RainbowDelim',
  \ 'for': ['csv', 'tsv']}
"### rainbow {{{2
  let g:rainbow_active = 0
  map ;r :silent! RainbowToggle <CR>
  "map ;r :silent! RainbowParenthesesToggle <CR>
"}}}2

Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'dhruvasagar/vim-table-mode', {
  \ 'on': ['TableModeEnable', 'TableModeToggle', 'Tableize']
  \}

Plug 'vim-scripts/renamer.vim', {'on': 'Renamer'}
Plug 'vim-scripts/vimGTD', {'for': 'gtd'}

Plug 'skwp/greplace.vim', {'on': 'Gsearch'}
" Plug 'brooth/far.vim'

Plug 'vim-scripts/ViewOutput', {'on': 'VO'}
" Plug 't9md/vim-choosewin'
"### choosewin {{{2
  nmap <c-w>- <Plug>(choosewin)
  let g:choosewin_overlay_enable = 1
"}}}2

" ScreenShot.vim enables you make screenshot of your VIM session as HTML code. 
Plug 'vim-scripts/ScreenShot', {'on': ['ScreenShot', 'Text2Html', 'Diff2Html']}
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
"### AirLine {{{2
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
"}}}2

Plug 'vim-utils/vim-man'

" can use vifm + tmux + vimdiff to replace vim-dirdiff plugin
Plug 'will133/vim-dirdiff', {'on': 'DirDiff'}
"### setting for DirDiff.vim {{{
let g:DirDiffExcludes = "*.pyc,*.pye,.svn,*.svn-base,*.svn-work,*~,*.orig,*.rej,*.swf,.*.swp,.*.swo"
"}}}

Plug 'rickhowe/diffchar.vim'

" choose one of below three plugins 
" Plug 'vim-scripts/ZoomWin', {'on': 'ZoomWin'}
Plug 'szw/vim-maximizer'
"### vim-maximizer {{{2
  nnoremap <silent> <leader>wf :MaximizerToggle<cr>
"}}}2

Plug 'chrisbra/NrrwRgn'
" Plug 'junegunn/goyo.vim'

" Plug 'bps/vim-tshark'

Plug 'guns/xterm-color-table.vim'

Plug 't9md/vim-quickhl'
"### settings for quickhl {{{
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
"}}}

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
Plug 'mattn/emmet-vim', {'for': ['xhtml', 'html', 'js', 'css', 'xml', 'php'],}

Plug 'sukima/xmledit'
"### xmledit {{{2
  let g:xmledit_enable_html = 1
"}}}2

Plug 'vim-scripts/jsbeautify', {'for': ['html', 'js', 'css', 'xml'],}
Plug 'tmhedberg/matchit'
" }}}1

" Git {{{1
Plug 'tpope/vim-fugitive'
"### fugitive {{{2
  map ,gb :Gblame<CR>
  map ,gs :Gstatus<CR>
  map ,gd :Gdiff<CR>
  map ,gl :Glog<CR>
  map ,gc :Gcommit<CR>
"}}}2

Plug 'gregsexton/gitv', {'on': 'Gitv'}
Plug 'junegunn/gv.vim', {'on': 'GV'}
Plug 'vim-scripts/Gist.vim', {'on': 'Gist'}

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

Plug 'vim-scripts/dbext.vim', {'for': 'sql'}
"### settings for dbext.vim {{{2
  let g:dbext_default_profile_pg_vincent = 'type=PGSQL:user=vincent:dbname=NBET_vincent:host=localhost'
  let g:dbext_default_profile_pg_vincent_testdb = 'type=PGSQL:user=vincent:dbname=TESTDB_vincent:host=localhost'
  let g:dbext_default_profile = 'pg_vincent'
  let g:dbext_default_type = 'PGSQL'
  let g:dbext_default_user = 'vincent'
  let g:dbext_default_host = 'localhost'

  let g:dbext_default_use_sep_result_buffer = 1
  let g:dbext_default_always_prompt_for_variables = 1
  "let g:dbext_default_display_cmd_line = 1
"}}}2

" }}}1

" iOS {{{1
Plug 'msanders/cocoa.vim', {'for': 'objective-c'}
"Plug 'eraserhd/vim-ios' " crashed vim
" }}}1

" PHP {{{1
Plug 'rayburgemeestre/phpfolding.vim'
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
Plug 'ryanoasis/vim-devicons'
"}}}1

call plug#end()

"### CamelCaseMotion {{{1
  call camelcasemotion#CreateMotionMappings(',')
"}}}1

"### deoplete settings {{{1
" if has('nvim')
"   let g:deoplete#enable_at_startup = 1
"   call deoplete#custom#option({
"  \ 'auto_complete_delay': 200,
"  \ 'smart_case': v:true,
"  \ })
"   " deoplete-go settings 
"   let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
"   let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
"   call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])
" endif
" }}}1

"### coc.vim settings {{{1

if !has('nvim-0.5')
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
       \ pumvisible() ? "\<C-n>" :
       \ <SID>check_back_space() ? "\<TAB>" :
       \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-n> to trigger completion.
  inoremap <silent><expr> <c-n> coc#refresh()

  " To make <cr> select the first completion item and confirm the completion
  " and format code when no item has been selected
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gY <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  "imap <silent> jj <Plug>(coc-float-hide)

  " Close the preview window when completion is done.
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " show func signature help 
  " autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for rename current word
  nmap ;rn <Plug>(coc-rename)

  " Remap for format selected region
  xmap ;f  <Plug>(coc-format-selected)
  nmap ;f  <Plug>(coc-format-selected)

  " Remap for do codeAction of current line
  nmap ;ca  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap ;qf  <Plug>(coc-fix-current)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call CocAction('fold', <f-args>)

  " grep word under cursor
  command! -nargs=+ -complete=custom,s:GrepArgs CocRg exe 'CocList grep '.<q-args>

  function! s:GrepArgs(...)
    let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
         \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
    return join(list, "\n")
  endfunction

  " Keymapping for grep word under cursor with interactive mode
  nnoremap <silent> ;cf :exe 'CocList --input='.expand('<cword>').' grep'<CR>

endif

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
  \ {'s': '~/workspace/cpt/sedona'},
  \ {'v': '~/.vim'} ]
let g:startify_custom_header = [
  \ '',
  \ '   Happy Vimming! ']
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
  let g:go_info_mode = 'guru'
  let g:go_addtags_transform = 'camelcase'
  " don't break the <C-]> & <C-T> workflow
	let g:go_def_mapping_enabled = 0
"}}}1

"### vifm settings {{{1
" only define one mapping, the shortcuts on how to open the file are defined
" in vifmrc
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
" ### TreeSitter {{{1
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      -- ["foo.bar"] = "Identifier",
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
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

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
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
        ["]c"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[C"] = "@class.outer",
      },
    },
  },
}
EOF

" Tree-sitter based folding.
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" }}}1

" ### Language Server  {{{1
lua <<EOF

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  buf_set_keymap('n', 'go', '<Cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)

  buf_set_keymap('n', '<c-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gY', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<space>.', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>k', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<space>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

end

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    require'lspconfig'[server].setup{
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- require'lspconfig'.gopls.setup{
--     cmd = {"gopls", "serve"},
--     settings = {
--       gopls = {
--         analyses = {
--           unusedparams = true,
--         },
--         staticcheck = true,
--       },
--     },
--   }

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

" ### nvim-compe {{{1
lua <<EOF
-- 
-- vim.o.completeopt = "menuone,noselect"
-- 
-- require'compe'.setup {
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 2;
--   preselect = 'always';
--   throttle_time = 80;
--   source_timeout = 200;
--   resolve_timeout = 800;
--   incomplete_delay = 400;
--   max_abbr_width = 100;
--   max_kind_width = 100;
--   max_menu_width = 100;
--   documentation = {
--     border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
--     winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
--     max_width = 120,
--     min_width = 60,
--     max_height = math.floor(vim.o.lines * 0.3),
--     min_height = 1,
--   };
-- 
--   source = {
--     path = true;
--     buffer = true;
--     calc = false;
--     nvim_lsp = true;
--     nvim_lua = false;
--     vsnip = false;
--     ultisnips = false;
--     luasnip = false;
--   };
-- }
-- 
-- local t = function(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
-- 
-- local check_back_space = function()
--     local col = vim.fn.col('.') - 1
--     return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
-- end
-- 
-- -- Use (s-)tab to:
-- --- move to prev/next item in completion menuone
-- --- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-n>"
--   elseif vim.fn['vsnip#available'](1) == 1 then
--     return t "<Plug>(vsnip-expand-or-jump)"
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--     return vim.fn['compe#complete']()
--   end
-- end
-- _G.s_tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-p>"
--   elseif vim.fn['vsnip#jumpable'](-1) == 1 then
--     return t "<Plug>(vsnip-jump-prev)"
--   else
--     -- If <S-Tab> is not working in your terminal, change it to <C-h>
--     return t "<S-Tab>"
--   end
-- end
-- 
-- local opts = {expr = true, silent = true}
-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", opts)
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", opts)
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", opts)
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", opts)

EOF
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-b>     compe#scroll({ 'delta': -4 })
" inoremap <silent><expr> <CR>      compe#confirm('<CR>')
 
" }}}1

" completion.nvim {{{1
autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_enable_auto_popup = 1

imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"

let g:completion_matching_smart_case = 1
let g:completion_trigger_keyword_length = 3 " default = 1

let g:completion_matching_strategy_list = ['exact', 'substring'] 

let g:completion_chain_complete_list = {
	    \ 'lua': {
	    \    'string': [
	    \        {'mode': '<c-p>'},
	    \        {'mode': '<c-n>'}],
	    \    'default': [
	    \       {'complete_items': ['lsp', 'snippet']},
	    \       {'mode': '<c-p>'},
	    \       {'mode': '<c-n>'}],
	    \  },
	    \ 'default' : {
	    \   'comment': [],
	    \   'default': [
	    \       {'complete_items': ['lsp', 'snippet']},
	    \       {'mode': '<c-p>'},
	    \       {'mode': '<c-n>'}]
	    \   }
	    \}

" }}}1

" vsnip {{{1
" " Expand
" imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" " Expand or jump
" imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
"}}}1

" hop {{{1
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

"### dial.vim {{{1
nmap <C-a> <Plug>(dial-increment)
nmap <C-x> <Plug>(dial-decrement)
vmap <C-a> <Plug>(dial-increment)
vmap <C-x> <Plug>(dial-decrement)
vmap g<C-a> <Plug>(dial-increment-additional)
vmap g<C-x> <Plug>(dial-decrement-additional)
"}}}1

endif

" vim: ft=vim foldmethod=marker expandtab ts=2 sw=2

