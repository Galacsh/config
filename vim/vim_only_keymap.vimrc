" ===================== "
" == Vim only Keymap == "
" ===================== "

" [Explorer]
nnoremap <silent> <Leader>e <cmd>Explore<CR>

" [Marks]
nnoremap <silent> <Leader>1 `1
nnoremap <silent> <Leader>2 `2
nnoremap <silent> <Leader>3 `3
nnoremap <silent> <Leader>4 `4
nnoremap <silent> <Leader>5 `5
nnoremap <silent> <Leader>6 `6
nnoremap <silent> <Leader>7 `7
nnoremap <silent> <Leader>8 `8
nnoremap <silent> <Leader>9 `9

" Remove all marks
nnoremap <silent> m0 :delmarks 0-9a-zA-Z<CR>
nnoremap <silent> <Leader>0 :marks 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ<CR>

