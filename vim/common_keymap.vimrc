" ===================
" == Common Keymap ==
" ===================

" Remap space as leader key
noremap <silent> <Space> <Nop>
let mapleader=" "
let maplocalleader=" "

" Window navigation
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Buffer navigation
nnoremap <silent> [] :<C-u>bnext<CR>
nnoremap <silent> ][ :<C-u>bprevious<CR>

" Jumping is too hard
noremap <silent> <S-h> ^
noremap <silent> <S-l> g_

" <Esc> is too far
inoremap <silent> jk <Esc>

" Stay in indent mode
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" Split windows
nnoremap <silent> <C-\> :<C-u>vsplit<CR>
nnoremap <silent> <C-_> :<C-u>split<CR>

" Copy & paste
vmap <silent> gy "+y
map <silent> gp "+p

" Do not replace register while pasting
vnoremap <silent> p P

" Do not jump back while yanking
vnoremap <silent> y ygv<Esc>

" Move highlighted text up/down
vnoremap <silent> J :m '>+1<CR>gv==kgvo<esc>=kgvo
vnoremap <silent> K :m '<-2<CR>gv==jgvo<esc>=jgvo

" Select all
nnoremap <C-a> ggVG

