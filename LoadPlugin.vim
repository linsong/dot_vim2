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

Plug 'justinmk/vim-sneak'

Plug 'ervandew/supertab'
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

" ISSUE: can only highlight word within one buffer
" Plug 'lfv89/vim-interestingwords'

" }}}1

" Coding {{{1
" Plug 'tomtom/tcomment_vim'
Plug 'Shougo/context_filetype.vim' " help caw.vim to comment based on filetype of context
Plug 'tyru/caw.vim'

Plug 'Yggdroot/indentLine'
"### IndentLine {{{2
  " let g:indentLine_char= '︙'
  let g:indentLine_color_term = 239
  let g:indentLine_color_gui = '#A4E57E'
"}}}2

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

" Plug 'Valloric/YouCompleteMe'
"### YouCompleteMe {{{2
  " let g:ycm_confirm_extra_conf = 0
  " let g:ycm_key_list_select_completion = ['<c-n>', '<Down>', 'C-j']
  " let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>', 'C-k']
  " let g:ycm_min_num_of_chars_for_completion = 3
"}}}2

Plug 'scrooloose/nerdtree'
Plug 'thinca/vim-quickrun', {'on': 'QuickRun'}

Plug 'vim-syntastic/syntastic' 
"### settings for syntastic {{{2
  let g:syntastic_enable_signs = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_mode_map = { 'mode': 'passive',
                             \ 'active_filetypes': [],
                             \ 'passive_filetypes': ['python', 'cpp', 'ruby', 'puppet'] }
"}}}2

"Plug 'w0rp/ale'
" settings for ale {{{2
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0
" }}}2


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
" }}}1

" Advanced Editing {{{1
" Plug 'kien/ctrlp.vim'
"### ctrlp {{{2
" let g:ctrlp_map = '<c-p>'
" noremap ,fb :CtrlPBuffer<CR>
" noremap ,fm :CtrlPMRU<CR>
" noremap ,ft :CtrlPBufTag<CR>
" noremap ,fg :CtrlPBufTagAll<CR>
" noremap ,fl :CtrlPLine<CR>
" noremap ,fr :CtrlPBookmarkDir<CR>
" noremap ,fe :CtrlPBookmarkDirAdd<CR>

" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 0
" let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

" " after change custom_ignore or user_command, need to clear ctrlp's cache 
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.cache$\|build$\|\.moc$\|\.obj$',
"   \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$\|\.swp$\|\.swc$\|\.swf$\|\.swo$\|tags$\|\.DS_Store$\|\.log$\|\.png$\|\.jpg$\|\.bmp$\|\.o$\|\.obj$\|moc_.*$\|\.plist$',
"   \ }
" let g:ctrlp_user_command = {
"   \ 'types': {
"     \ 1: ['.git/', 'cd %s && git ls-files'],
"     \ 2: ['.hg/', 'hg --cwd %s locate -I .'],
"     \ },
"   \ 'fallback': 'cd %s && ag --nocolor --nogroup -l'
"   \ }

" " will ignore entries in .agignore file
" " GOTCHA: list files with ag will ignore newly created empty files
" " let g:ctrlp_user_command = 'cd %s && ag --nocolor --nogroup -l'
" let g:ctrlp_user_command = 'cd %s && /usr/local/bin/myfindfile'
"
" let g:ctrlp_extensions = ['buffertag', 'dir', 'bookmarkdir'] " ['dir', 'tag', 'rtscript', 'changes']
" let g:ctrlp_prompt_mappings = { 'PrtCurLeft()': ['<left>', '<c-^>'], 'PrtBS()': ['<bs>', '<c-]>', '<c-h>'] }

" " PyMatcher for CtrlP, PyMatcher can improve CtrlP's performance a lot
" if !has('python')
"     echo 'In order to use pymatcher plugin, you need +python compiled vim'
" else
"     let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
" endif

" " Set delay to prevent extra search
" let g:ctrlp_lazy_update = 150
"
" " Do not clear filenames cache, to improve CtrlP startup
" " You can manualy clear it by <F5>
" let g:ctrlp_clear_cache_on_exit = 0
"
" let g:ctrlp_max_files = 3000 

" " If ag is available use it as filename list generator instead of 'find'
" if executable("ag")
"   set grepprg=ag\ --nogroup\ --nocolor
"   "let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
" endif
" " end of PyMatcher

"}}}2

" Plug 'FelikZ/ctrlp-py-matcher'
" Plug 'tacahiroy/ctrlp-funky'

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

  " complete input as name in current file in fuzzy way
  " e.g.: gCC => getCurrentComponent
  inoremap <expr> <c-x><c-k> fzf#complete({
        \ 'source': "/usr/bin/grep -o -E '\\w{5,}' " . expand('%:p') . "\| /usr/bin/sort -uf",
        \ 'options': '-0 -1 -x',
        \ 'left': 35})

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
  command! -bang -nargs=? -complete=dir Files
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
  command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>,
    \                 <bang>0 ? fzf#vim#with_preview('up:60%')
    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \                 <bang>0)

  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)


  function! Fzf_files_with_dev_icons(command)
    let l:fzf_files_options = '-x -m --preview="bat --color \"always\" --style numbers {2..} | head -'.&lines.'" --preview-window=wrap:hidden --bind="?:toggle-preview,ctrl-e:preview-up,ctrl-d:preview-down,ctrl-r:jump-accept" --expect=ctrl-v,ctrl-x --tiebreak=end,length'
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
  nnoremap <c-p> :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND)<CR>

  function! Fzf_git_diff_files_with_dev_icons()
    let l:fzf_files_options = '-x -m --ansi --preview "sh -c \"(git diff --color=always -- {3..} | sed 1,4d; bat --color always --style numbers {3..}) | head -'.&lines.'\"" --preview-window=wrap:hidden --bind="?:toggle-preview,ctrl-e:preview-up,ctrl-d:preview-down,ctrl-r:jump-accept" --expect=ctrl-v,ctrl-x --tiebreak=end,length '

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

  noremap ,ff :Files<CR>
  noremap ,fd :Cd<CR>
  noremap ,fz :Z<CR>
  noremap ,ft :Tags<CR>
  noremap ,fl :Lines<CR>
  " noremap ,fr :FZFMru<CR>
  noremap ,fb :Buffers<CR>
  noremap ,fh :History<CR>

  nnoremap ,fg yiw:Rg "<CR>
  vnoremap ,fg  y:Rg "<CR>

"}}}2

"Plug 'vim-scripts/AutoComplPop'

Plug 'rking/ag.vim', {'on': 'Ag'}
"### settings for ag.vim {{{2
"disabled, use Grepper plugin instead 
"let g:ag_prg="ag --nocolor --nogroup --column --smart-case "
"let g:ag_mapping_message=0
"map ,gr yiw:Ag "<CR>
"vmap ,gr y:Ag "<CR>
"}}}2

Plug 'mhinz/vim-grepper'
"### Grepper {{{2
  " command! -nargs=* -complete=file GG Grepper -tool git -open -switch -query <args>
  " command! -nargs=* -complete=file Ag Grepper -tool ag -open -switch -query <args>
  command! -nargs=* -complete=file Rg Grepper -tool rg -open -switch -query <args>
  " command! -nargs=* -complete=file Pt Grepper -tool pt -open -switch -query <args>

  " nnoremap <leader>g <plug>(GrepperOperator)
  " xnoremap <leader>g <plug>(GrepperOperator)
  nnoremap ,gr :Grepper -tool rg -cword -noprompt<cr>
  vnoremap ,gr  y:Rg "<CR>

  let g:grepper           = {}
  let g:grepper.open      = 1
  let g:grepper.switch    = 1
  let g:grepper.jump      = 1
  let g:grepper.dispatch  = 0
  let g:grepper.tools     = ['rg', 'git', 'ag', 'findstr', 'sift', 'grep']
"}}}2

Plug 'drmingdrmer/xptemplate'
"### xptemplate {{{2
  " Prevent supertab from mapping <tab> to anything.
  "let g:SuperTabMappingForward = '<Plug>xpt_void'

  " Tell XPTemplate what to fall back to, if nothing matches.
  " Original SuperTab() yields nothing if g:SuperTabMappingForward was set to
  " something it does not know.
  "let g:xptemplate_fallback = '<C-r>=XPTwrapSuperTab("n")<CR>'

  fun! XPTwrapSuperTab(command)
      let v = SuperTab(a:command)
      if v == ''
          " Change \<Tab> to whatever you want, when neither XPTemplate or
          " supertab needs to do anything.
          return "\<Tab>"
      else
          return v
      end
  endfunction 

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

  set runtimepath+=~/.vim/personal/
"}}}2

"Plug 'SirVer/ultisnips'
"### settings for UltiSnips.vim {{{2
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  " let g:UltiSnipsListSnippets="<c-l>"
  let g:UltiSnipsEnableSnipMate=0

  command! ResetUltiSnip :py UltiSnips_Manager.reset()
"}}}2

"Plug 'honza/vim-snippets'
Plug 'junegunn/vim-easy-align', {'on': 'EasyAlign'}
"### EasyAlign {{{2
  vnoremap <silent> <Enter> :EasyAlign<cr>
"}}}2

Plug 'vim-scripts/LargeFile'
Plug 'tpope/vim-abolish', {'on': 'Subvert'}
Plug 'tpope/vim-dispatch'

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

" Plug 'terryma/vim-expand-region'
" Plug 'terryma/vim-multiple-cursors'

" Plug 'haya14busa/incsearch.vim'
" Plug 'haya14busa/incsearch-easymotion.vim'
" Plug 'haya14busa/incsearch-fuzzy.vim'

Plug 'vim-scripts/VisIncr'

" Plug 'linsong/hexman.vim'
" Plug 'vim-scripts/DrawIt'

" Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'Shougo/deoplete-clangx'
  Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
else
  " Plug 'Shougo/deoplete.nvim'
  " Plug 'roxma/nvim-yarp'
  " Plug 'roxma/vim-hug-neovim-rpc'
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

Plug 'rizzatti/funcoo.vim' " for Dash
Plug 'rizzatti/dash.vim'
"### Dash {{{2
  let g:dash_map = {
    \ 'cpp' : 'qt'
    \ }
  :nmap <silent> ,k <Plug>DashSearch
"}}}2

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

Plug 'vim-scripts/Mark--Karkat'
"### settings for mark.vim {{{2
  let g:mwHistAdd = "/@"
  let g:mwAutoLoadMarks = 0
  let g:mwAutoSaveMarks = 0
  nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
  nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev

  "highlight def MarkWord7   ctermfg=Cyan      ctermbg=Black  guifg=#8CCBEA    guibg=Black
  "highlight def MarkWord8   ctermfg=Green     ctermbg=Black  guifg=#A4E57E    guibg=Black
  "highlight def MarkWord9   ctermfg=Yellow    ctermbg=Black  guifg=#FFDB72    guibg=Black
  "highlight def MarkWord10  ctermfg=Red       ctermbg=Black  guifg=#FF7272    guibg=Black
  "highlight def MarkWord11  ctermfg=Magenta   ctermbg=Black  guifg=#FFB3FF    guibg=Black
  "highlight def MarkWord12  ctermfg=Blue      ctermbg=Black  guifg=#9999FF    guibg=Black

  "highlight def MarkWord13  ctermbg=Cyan      ctermfg=White  guibg=#8CCBEA    guifg=White
  "highlight def MarkWord14  ctermbg=Green     ctermfg=White  guibg=#A4E57E    guifg=White
  "highlight def MarkWord15  ctermbg=Yellow    ctermfg=White  guibg=#FFDB72    guifg=White
  "highlight def MarkWord16  ctermbg=Red       ctermfg=White  guibg=#FF7272    guifg=White
  "highlight def MarkWord17  ctermbg=Magenta   ctermfg=White  guibg=#FFB3FF    guifg=White
  "highlight def MarkWord18  ctermbg=Blue      ctermfg=White  guibg=#9999FF    guifg=White

  if &t_Co>=256 || has("gui_running")
    let g:mwDefaultHighlightingPalette = 'extended'
  endif
"}}}2

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
Plug 'junegunn/goyo.vim'

Plug 'bps/vim-tshark'
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
Plug 'fs111/pydoc.vim', {'for': ['python',],}
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
Plug 'airblade/vim-gitgutter'
"}}}1

" C/C++ {{{1
Plug 'derekwyatt/vim-protodef', {'for': ['c', 'cpp', 'h'],}
Plug 'vim-scripts/FSwitch', {'for': ['c', 'cpp', 'h'],}

" Qt
" Plug 'https://bitbucket.org/kh3phr3n/vim-qt-syntax.git', {'for': ['c', 'cpp', 'h'],}
Plug 'vim-scripts/cpp.vim', {'for': ['c', 'cpp', 'h'],}
"" }}}1

" SQL {{{1
Plug 'vim-scripts/SQLUtilities', {'for': 'sql'}
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
" }}}1

" games {{{1
"NeoBundleLazy 'sokoban.vim' 
"NeoBundleLazy 'TeTrIs.vim'
"}}}1

" always load devicon as the last one  {{{1
Plug 'ryanoasis/vim-devicons'
"}}}1

call plug#end()

"### CamelCaseMotion {{{1
  call camelcasemotion#CreateMotionMappings(',')
"}}}1

"### LSP support {{{1

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ }

"nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" }}}1

"### deoplete settings {{{1
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  call deoplete#custom#option({
  \ 'auto_complete_delay': 200,
  \ 'smart_case': v:true,
  \ })
  " deoplete-go settings 
  let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
  let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
endif
" }}}1

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
  \ {'v': '~/.vim'} ]
let g:startify_custom_header = [
  \ '',
  \ '   Happy Vimming! ']
noremap ,s :Startify<CR>
"}}}1

"### gitgutter settings {{{1
set updatetime=150
"}}}1

"### vim-go settings {{{1
" let g:go_fmt_options = {
"  \ 'gofmt': '-s'
"  \ }
  let g:go_auto_sameids = 1
  let g:go_addtags_transform = 'camelcase'
"}}}1

" vim: ft=vim foldmethod=marker expandtab ts=2 sw=2

