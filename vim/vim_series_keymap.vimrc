" ======================= "
" == Vim series Keymap == "
" ======================= "

" [Closing is too hard]
noremap <silent> <Leader>q :<C-u>update<Bar>quit<CR>
noremap <silent> <Leader><S-q> :<C-u>wall<Bar>qall<CR>

" [Find / Replace]
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

" [Terminal]

" Toggle terminal
let g:term_buf_nr = -1
function! ToggleTerminal() abort
  " Determine the command to open a terminal based on the editor (Vim or Neovim)
  if has('nvim')
    let l:open_terminal = 'botright 15 split +terminal | startinsert!'
  else
    let l:open_terminal = 'botright terminal ++rows=15'
  endif

  " Get terminal buffer number and window number
  let terminal_info = gettabvar(tabpagenr(), 'term', {'bufnr': -1, 'winnr': -1})

  " If the terminal buffer does not exist, open a new terminal
  if terminal_info.bufnr == -1 || !bufexists(terminal_info.bufnr)
    execute l:open_terminal
    call settabvar(tabpagenr(), 'term', {'bufnr': bufnr('%'), 'winnr': winnr()})
  else
    " If the terminal buffer exists, check if it is visible in the current tab
    let win_id = bufwinnr(terminal_info.bufnr)
    if win_id == -1
      " If the terminal buffer is not visible, open it in a new split
      execute 'botright 15 split +b' . terminal_info.bufnr . ' | startinsert!'
    else
      " If the terminal buffer is visible, close the terminal window
      execute win_id . 'hide'
    endif
  endif
endfunction

" Normal mode mappings to toggle the terminal emulator
nnoremap <silent> <C-e> <Cmd>call ToggleTerminal()<CR>
" Terminal mode mapping to close the terminal emulator
tnoremap <silent> <C-e> <Cmd>call ToggleTerminal()<CR>
" Change mode
tnoremap <silent> <C-v> <C-\><C-n>

