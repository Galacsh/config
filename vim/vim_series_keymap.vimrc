" ======================= "
" == Vim series Keymap == "
" ======================= "

" [Closing is too hard]
noremap <silent> <leader>qq :<C-u>update<Bar>quit<CR>
noremap <silent> <leader>qa :<C-u>wall<Bar>qall<CR>

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
let s:term_buf_nr = -1
function! s:ToggleTerminal() abort
    if s:term_buf_nr == -1 || !bufexists(s:term_buf_nr)
        execute "botright terminal"
        setlocal nobuflisted
        let s:term_buf_nr = bufnr("%")
    else
        if bufwinnr(s:term_buf_nr) == -1
            execute "botright sbuffer " . s:term_buf_nr
        else
            hide
        endif
    endif
endfunction

nnoremap <silent> <Leader>` :call <SID>ToggleTerminal()<CR>
tnoremap <silent> <Esc><Esc> <C-\><C-n>
