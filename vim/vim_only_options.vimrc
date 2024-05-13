" ======================
" == Vim only Options ==
" ======================

let g:netrw_liststyle=1

set signcolumn=no

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme habamax

