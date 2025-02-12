" ==========================================
" TIP: Useful keywords to search:
" - [[
" - #Vim
" - #Neovim
" - #IdeaVim
" ==========================================

syntax enable
filetype on

" [[ Indentation ]]
set breakindent

" [[ History ]]
set history=10000

" [[ Editor Display ]]
set number
set relativenumber
set cursorline
set nowrap
set scrolloff=10
set sidescrolloff=10

" [[ Search Configuration ]]
set hlsearch
set incsearch
set ignorecase
set smartcase

" [[ Miscellaneous ]]
set whichwrap+=<,>,[,]

if has('ide') " #IdeaVim
  set notimeout
else " #Vim & #Neovim
  " [[ General Settings ]]
  set timeout timeoutlen=300
  set autoread
  set encoding=utf-8
  set conceallevel=2
  set ttimeoutlen=0
  set updatetime=1000

  " [[ Indentation ]]
  set expandtab
  set smartindent
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2

  " [[ User Interface ]]
  set pumheight=10
  set noshowmatch
  set ruler
  set mouse=a

  " [[ Split Configuration ]]
  set splitright
  set splitbelow

  " [[ Backup / Undo ]]
  set nobackup
  set nowritebackup
  if has('nvim')
    set undofile
  else
    if !isdirectory($HOME."/.vim")
        call mkdir($HOME."/.vim", "", 0770)
    endif
    if !isdirectory($HOME."/.vim/undo")
        call mkdir($HOME."/.vim/undo", "", 0700)
    endif
    set undodir=~/.vim/undo
    set undofile
  endif

  " [[ Editor Display ]]
  set numberwidth=4
  if has('nvim')
    set signcolumn=yes
  else
    set signcolumn=no
  endif

  " [[ Miscellaneous ]]
  set shortmess+=c
  set laststatus=3
  set termguicolors
  set formatoptions-=cro

  " [[ Turn on fileencoding if modifiable ]]
  autocmd BufRead,BufNewFile * if &modifiable | set fileencoding=utf-8 | endif

  " [[ Force netrw list style in #Vim ]]
  if !has('nvim')
    let g:netrw_liststyle=1
  endif

  " [[ Use 'catppuccin_mocha' color scheme #Vim ]]
  if !has('nvim')
    if !has('gui_running')
      colorscheme catppuccin_mocha
    endif
  endif
endif

