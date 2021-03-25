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
Plug 'justinmk/vim-sneak'
Plug 'vim-scripts/visualrepeat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'zackhsi/fzf-tags'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-peekaboo'
Plug 'mbbill/undotree'
"Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-conflicted'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'ntpeters/vim-better-whitespace'
Plug 'brooth/far.vim'
Plug 'dhruvasagar/vim-zoom'

call plug#end()


""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""
" Case sensitive matching for searching tag file. Much quicker!
set tagcase=match

" specify version control systems for signify
let g:signify_vcs_list = [ 'git', 'tfs' ]

" airline customization
let g:airline_theme='powerlineish'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 0
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
let g:gutentags_ctags_exclude = [
      \ 'build',
      \ 'ChibiOS_18.2.x',
      \ 'ChibiOS_20.x.x',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'cache',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" better_whitespace options
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitelines_at_eof=1
let g:strip_whitespace_confirm=0

" split equalization upon window resize
autocmd VimResized * wincmd =

" Fzf :Buffers - jump to existing window if open
" let g:fzf_buffers_jump=1

""""""""""""""""""""""""""""""
" Key Mappings
""""""""""""""""""""""""""""""

" set leader key
" let mapleader = ","

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
nnoremap <Leader>t :TagbarOpen fj<Return>:<Backspace>

" Fuzzy searching shortcuts (FZF)
nnoremap <Leader>f :Files<CR>
" Wait for path from user
nnoremap <Leader>F :Files<Space>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>w :Windows<CR>
nnoremap <Leader>T :Tags<CR>
nnoremap <Leader>/ :BLines<CR>
" Word under cursor
nnoremap <Leader>s :Ag <c-r><c-w><CR>
nmap <C-]> <Plug>(fzf_tags)
" Search helpgrep
nnoremap <Leader>h :Helptags<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Set plus register as clipboard, to share with GUI and host
set clipboard=unnamedplus

" vim-sneak, one character mappings
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


""""""""""""""""""""""""""""""
" Display
""""""""""""""""""""""""""""""

" show tabline only if 2 or more tabs exist
set showtabline=1

" don't show mode when using airline
"set noshowmode

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
set synmaxcol=300

" Colortheme options
set termguicolors
set background=dark
colorscheme solarized8
"let g:solarized_contrast="high"
"colorscheme solarized

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

" vim-sneak label mode
let g:sneak#label = 1

" Set cursor in different modes
if &term =~ "xterm"
    " use blinking block cursor in insert and replace mode
    let &t_SI = "\e[1 q"
    let &t_SR = "\e[1 q"
    " use solid block cursor otherwise
    let &t_EI = "\e[2 q"
    " set the cursor to solid block when starting Vim, could have been set
    " differently in the terminal previously
    silent !echo -en "\e[2 q"
endif

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
