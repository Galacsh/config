" ==========================================
" TIP: Useful keywords to search:
" - [[
" - #Vim
" - #Neovim
" - #IdeaVim
" ==========================================

" [[ Remap space as leader key ]]
noremap <silent> <Space> <Nop>
let mapleader=" "
let maplocalleader=" "

" [[ Window navigation ]]
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" [[ Buffer navigation ]]
nnoremap <silent> ) :<C-u>bnext<CR>
nnoremap <silent> ( :<C-u>bprevious<CR>

" [[ Jumping is too hard ]]
noremap <silent> <S-h> ^
noremap <silent> <S-l> g_

" [[ <Esc> is too far ]]
inoremap <silent> jk <Esc>

" [[ Stay in indent mode ]]
vnoremap <silent> <lt> <lt>gv
vnoremap <silent> > >gv

" [[ Split windows vertically ]]
nnoremap <silent> <C-\> :<C-u>vsplit<CR>

" [[ Split windows horizontally ]]
if has('ide') " Ideavim
  nnoremap <silent> <C--> :<C-u>split<CR>
else " #Vim or #Neovim
  nnoremap <silent>  :<C-u>split<CR>
endif

" [[ Copy & paste ]]
vmap <silent> gy "+y
map <silent> gp "+p

" [[ Do not replace register while pasting ]]
vnoremap <silent> p P

" [[ Do not jump back while yanking ]]
vnoremap <silent> y ygv<Esc>

" [[ Move highlighted text up/down ]]
vnoremap <silent> J :m '>+1<CR>gv==kgvo<esc>=kgvo
vnoremap <silent> K :m '<-2<CR>gv==jgvo<esc>=jgvo

" [[ Select all ]]
nnoremap <C-a> ggVG

" [[ Explorer ]]
if has('ide')
  noremap <Leader>e :NERDTreeFind<CR>
elseif !has('nvim')
  nnoremap <silent> <Leader>e <cmd>Explore<CR>
endif

" [[ Marks ]]
if !has('nvim') " #Vim & #IdeaVim
  nnoremap <silent> m0 :delmarks 0-9a-zA-Z<CR>
  nnoremap <silent> <Leader>0 :marks 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>
endif

if has('ide') " #IdeaVim only
  nmap m1 <Action>(ToggleBookmark1)
  nmap m2 <Action>(ToggleBookmark2)
  nmap m3 <Action>(ToggleBookmark3)
  nmap m4 <Action>(ToggleBookmark4)
  nmap m5 <Action>(ToggleBookmark5)
  nmap m6 <Action>(ToggleBookmark6)
  nmap m7 <Action>(ToggleBookmark7)
  nmap m8 <Action>(ToggleBookmark8)
  nmap m9 <Action>(ToggleBookmark9)
  nmap <Leader>1 <Action>(GotoBookmark1)
  nmap <Leader>2 <Action>(GotoBookmark2)
  nmap <Leader>3 <Action>(GotoBookmark3)
  nmap <Leader>4 <Action>(GotoBookmark4)
  nmap <Leader>5 <Action>(GotoBookmark5)
  nmap <Leader>6 <Action>(GotoBookmark6)
  nmap <Leader>7 <Action>(GotoBookmark7)
  nmap <Leader>8 <Action>(GotoBookmark8)
  nmap <Leader>9 <Action>(GotoBookmark9)
elseif !has('nvim') " #Vim only
  nnoremap <silent> <Leader>1 `1
  nnoremap <silent> <Leader>2 `2
  nnoremap <silent> <Leader>3 `3
  nnoremap <silent> <Leader>4 `4
  nnoremap <silent> <Leader>5 `5
  nnoremap <silent> <Leader>6 `6
  nnoremap <silent> <Leader>7 `7
  nnoremap <silent> <Leader>8 `8
  nnoremap <silent> <Leader>9 `9
endif

" [[ Closing is too hard ]]
if has('ide') " #IdeaVim only
  map <Leader>q <Action>(CloseContent)
  map <Leader><S-q> <Action>(CloseAllEditors)
  map <Leader>w <Action>(HideAllWindows)
else " #Vim & #Neovim
  noremap <silent> <Leader>q :<C-u>update<Bar>quit<CR>
  noremap <silent> <Leader><S-q> :<C-u>wall<Bar>qall<CR>
endif

" [[ Searching text ]]
if has('ide') " #IdeaVim only
  map n <Action>(FindNext)
  map N <Action>(FindPrevious)
  map / <Action>(Find)
  map % <Action>(Replace)
else " #Vim & #Neovim
  function! GetVisualSelection()
    " Save the current unnamed register content
    let temp_variable = @"
    " Yank the current(last) visual selection
    normal gvy
    " Set the search pattern to the visual selection, escaping necessary characters
    let @/=substitute(escape(@", "\/.*$^~[]"), "\n", "\\n", "g")
    " Restore the unnamed register content
    let @" = temp_variable
  endfunction

  vnoremap / :<C-u>call GetVisualSelection()<Bar>:set hlsearch<CR>
  vnoremap g/ :<C-u>call GetVisualSelection()<Bar>:set hlsearch<CR>:%s//
  nnoremap <silent> <Esc> :<C-u>nohlsearch<CR>
endif

" [[ Terminal ]]
" ====================================================
" NOTE: For #IdeaVim - use 'Option(Alt) + F12' (default)
" ====================================================
if !has('ide') " #Vim & #Neovim 
  " Determine the command to open a terminal based on the editor
  let s:open_terminal_cmd = has('nvim') ? 
    \ 'botright 15 split +terminal | startinsert!' : 
    \ 'botright terminal ++rows=15' 

  " Function to toggle terminal
  let s:term_buf_nr = -1
  function! ToggleTerminal() abort
    " Get terminal buffer number and window number
    let terminal_info = gettabvar(tabpagenr(), 'term', {'bufnr': -1, 'winnr': -1})

    if terminal_info.bufnr == -1 || !bufexists(terminal_info.bufnr)
      " If the terminal buffer does not exist, open a new terminal
      execute s:open_terminal_cmd
      call settabvar(tabpagenr(), 'term', {'bufnr': bufnr('%'), 'winnr': winnr()})
    else
      " If the terminal buffer exists, check if it is visible in the current tab
      let win_id = bufwinnr(terminal_info.bufnr)
      if win_id == -1
        " If the terminal buffer is not visible, open it in a new split
        execute 'botright 15 split +b' . terminal_info.bufnr . ' | startinsert!'
      else
        " If the terminal buffer is visible, hide the terminal window
        execute win_id . 'hide'
      endif
    endif
  endfunction

  " Toggle terminal
  if has('nvim')
    " Alt + F12 == <F60> in #Neovim
    nnoremap <silent> <F60> <Cmd>call ToggleTerminal()<CR>
    tnoremap <silent> <F60> <Cmd>call ToggleTerminal()<CR>
  else
    " Alt + F12 == [24;3~ in #Vim
    nnoremap <silent> [24;3~ <Cmd>call ToggleTerminal()<CR>
    tnoremap <silent> [24;3~ <Cmd>call ToggleTerminal()<CR>
  endif

  " Change mode
  tnoremap <silent> <C-v> <C-\><C-n>
endif

