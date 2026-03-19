" Note: I don't remember if there's a good reason I'm using init.vim instead
" of init.lua. It might have been for VS compatability since I don't think it
" plays well with nvim. But then, I didn't even start using VS. I just swapped
" to Rider. So if I don't find a good reason my 4/26 or whenever, swap back to
" init.lua. -2/23/26

call plug#begin('~/.vim/plugged')   " or any folder you like
" ... your other plugins here ...
Plug 'nyoom-engineering/oxocarbon.nvim'
call plug#end()




" Increment and decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Ctrl + Backspace → delete previous word
inoremap <C-BS> <C-w>
cnoremap <C-BS> <C-w>

" Ctrl + Delete → delete next word
inoremap <C-Del> <C-o>dw

" Line numbers
set number
set relativenumber

" Persistent undo
set undofile

" Indent visually selected lines and keep selection
vnoremap > >gv
vnoremap < <gv

" System clipboard integration (use + register on Linux/X11, * on some systems)
set clipboard=unnamedplus

" Keep cursor centered on half-page jumps
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Search options
set ignorecase
set smartcase

" Lines to keep visible above/below cursor
set scrolloff=18
