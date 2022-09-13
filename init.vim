set runtimepath+=~/.vim,~/.vim/after    
set packpath+=~/.vimformat    
source ~/.vimrc

set ts=2
set sw=2
set expandtab
set smarttab

if has("gui_vimr") " VimR specifi settings
endif

" highlight yanked text for a while
augroup highlight_yank
	autocmd!
	au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

