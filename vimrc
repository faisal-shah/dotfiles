set nocompatible              " be iMproved, required


""""""""""""""""""""""""""""""
" Vim-plug
""""""""""""""""""""""""""""""

" Download vim-plug if not already installed
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'easymotion/vim-easymotion'
Plug 'machakann/vim-sandwich'
Plug 'vim-scripts/visualrepeat'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-peekaboo'
Plug 'mbbill/undotree'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-conflicted'
" Plug 'drmikehenry/vim-headerguard'
" Plug 'jreybert/vimagit'

call plug#end()


""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""

let g:ackprg = 'ag --nogroup --nocolor --column'

" airline customization
" let g:airline_theme='molokai'
let g:airline_theme='powerlineish'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
"Show tabs if only one is enabled.
let g:airline#extensions#tabline#enabled = 1
"enable/disable displaying open splits per tab (only when tabs are opened). >
let g:airline#extensions#tabline#show_splits = 1
" enable/disable displaying buffers with a single tab
let g:airline#extensions#tabline#show_buffers = 1
" tab number
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
" remove the filetype part
let g:airline_section_x=''
" remove the encoding part
let g:airline_section_y=''
" remove separators for empty sections
let g:airline_skip_empty_sections = 1

" gutentags don't generate on new, rather generate on missing
let g:gutentags_generate_on_new=0
let g:gutentags_generate_on_missing=1

" split equalization upon window resize
autocmd VimResized * wincmd =

" Fzf :Buffers - jump to existing window if open
let g:fzf_buffers_jump=1

""""""""""""""""""""""""""""""
" Key Mappings
""""""""""""""""""""""""""""""

" set leader key
" let mapleader = ","

set whichwrap+=<,>,h,l

" Yank till the end of line
nnoremap Y y$

" Yank line ignoring leading and trailing whitespace
nnoremap <Leader>yy ^yg_

" Indent visual mode, keep highlighted
vmap > >gv
vmap < <gv

" Play back macro in register q
nnoremap Q @q

" Delete till end of row in insert mode
inoremap <C-D> <C-\><C-O>D

" Clear highlight
nnoremap <Leader><Space> :noh<Return>:<Backspace>

" Open Tagbar and jump to it (even if already open). Keep open after making
" selection
" nnoremap <Leader>t :TagbarOpenAutoClose<Return>:<Backspace>
nnoremap <Leader>t :TagbarOpen fj<Return>:<Backspace>

" Fuzzy search open file .. waiting for path argument
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>F :Files<Space>

" Fuzzy search buffers
nnoremap <Leader>b :Buffers<CR>

" Fuzzy search windows
nnoremap <Leader>w :Windows<CR>

" Fuzzy search tags
nnoremap <Leader>T :Tags<CR>

" Fuzzy search in current buffer
nnoremap <Leader>/ :BLines<CR>

" Fuzzy search word under cursor
nnoremap <Leader>s "zyiw:Ag <C-r>z<CR>
"
" Fuzzy search helpgrep
nnoremap <Leader>h :Helptags<CR>

" Easy motion, front or back
nmap <Plug>(easymotion-prefix)f <Plug>(easymotion-s)

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" movement by screen line instead of file line (for text wrap)
nnoremap j gj
nnoremap <down> gj
nnoremap k gk
nnoremap <up> gk

" Move between splits (windows)
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Set plus register as clipboard, to share with GUI and host
set clipboard=unnamedplus


""""""""""""""""""""""""""""""
" Display
""""""""""""""""""""""""""""""

" don't show mode when using airline
set noshowmode

" get rid of airline delay in switching between normal and insert modes
set ttimeoutlen=50

" 4 lines above/below cursor when scrolling
set scrolloff=4

" show type command in status bar
set showcmd

" show file in titlebar
set title

" show matching bracket for 0.2 seconds
set matchtime=2

" don't wrap long lines
set nowrap

" turn line numbers on
set number relativenumber

" hacks to speed things up
set regexpengine=1
set lazyredraw
set ttyfast
set synmaxcol=200

" Colortheme options
set background=dark
set t_Co=256
let g:palenight_terminal_italics=1
let g:solarized_contrast="high"
colorscheme solarized

set mouse=a
" ttymouse=sgr needed, otherwise mouse > column 220 or so doesn't work
set ttymouse=sgr

" highlight matching braces
set showmatch

" Show all changes
set report=0

" Show only pop-up menu for omni completion - preview scratch buffer
set completeopt=menu

" Highlight current line
set cursorline
" hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white

" easymotion highlight colors
hi link EasyMotionTarget Search
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search
hi link EasyMotionShade Comment

""""""""""""""""""""""""""""""
" Searching
""""""""""""""""""""""""""""""

set hlsearch                    " highlight matches
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

""""""""""""""""""""""""""""""
" Text, tab, indent related
""""""""""""""""""""""""""""""

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces

" wrap lines at 79 chars.
set textwidth=79

" open splits to the right and bottom
set splitbelow
set splitright

" strip trailing whitespace upon writing to buffer of specified filetypes.
augroup my_trim_whitespace
  autocmd FileType c,cpp,make,gitconfig,python,vim autocmd BufWritePre <buffer> %s/\s\+$//e
augroup END

