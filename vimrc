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
Plug 'lifepillar/vim-solarized8'
Plug 'sainnhe/gruvbox-material'
Plug 'rbong/vim-crystalline'
Plug 'christoomey/vim-conflicted'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'ntpeters/vim-better-whitespace'
Plug 'brooth/far.vim'
Plug 'dhruvasagar/vim-zoom'
Plug 'semanser/vim-outdated-plugins'

call plug#end()


""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""
" Case sensitive matching for searching tag file. Much quicker!
set tagcase=match

" split equalization upon window resize
autocmd VimResized * wincmd =

" open splits to the right and bottom
set splitbelow
set splitright

" Set plus register as clipboard, to share with GUI and host
set clipboard=unnamedplus

""""""""""""""""""""""""""""""
" Key Mappings
""""""""""""""""""""""""""""""

" set leader key, default is \, but set anyways
let mapleader = "\\"

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

" vim-sneak, one character mappings
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T


""""""""""""""""""""""""""""""
" Display
""""""""""""""""""""""""""""""

" get rid of airline delay in switching between normal and insert modes
set ttimeoutlen=50

" 4 lines above/below cursor when scrolling
set scrolloff=4

" show type command in status bar
set showcmd

" show file in titlebar
set title

" always show status line
set laststatus=2

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
" Per recommendation by solarized8 plugin author..
autocmd vimenter * ++nested colorscheme solarized8

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

set hlsearch   " highlight matches
set ignorecase " searches are case insensitive...
set smartcase  " ... unless they contain at least one capital letter

""""""""""""""""""""""""""""""
" Text, tab, indent related
""""""""""""""""""""""""""""""

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
set autoindent
filetype plugin indent on

" wrap lines at 79 chars.
set textwidth=79


""""""""""""""""""""
"" Plugin Related ""
""""""""""""""""""""

" vim-sneak label mode
let g:sneak#label = 1

" specify version control systems for signify
let g:signify_vcs_list = [ 'git', 'tfs' ]

" gutentags don't generate on new, rather generate on missing
let g:gutentags_generate_on_new=0
let g:gutentags_generate_on_missing=1
"let g:gutentags_file_list_command ='ag -l'
"let g:gutentags_trace=1
"let g:gutentags_file_list_command = {
"        \ 'markers': {
"        \ '.git': 'git ls-files',
"        \ },
"        \ }
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

" Fzf :Buffers - jump to existing window if open
" let g:fzf_buffers_jump=1

" FZF BD Command to search buffers for deletion
function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
            \ 'source': s:list_buffers(),
            \ 'sink*': { lines -> s:delete_buffers(lines) },
            \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
            \ }))

command! -nargs=? Apropos call fzf#run(fzf#wrap({
            \ 'source': 'man -k -s 1 '.shellescape(<q-args>).' | cut -d " " -f 1',
            \ 'sink': 'tab Man',
            \ 'options': ['--preview', 'MANPAGER=cat MANWIDTH='.(&columns/2-4).' man {}'
            \ ]}))

" Vim-Crystalline Settings
function! StatusLine(current, width)
    let l:s = ''

    if a:current
        let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
    else
        let l:s .= '%#CrystallineInactive#'
    endif
    let l:s .= ' %f%h%w%m%r '
    if a:current
        let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
    endif

    let l:s .= '%='
    if a:current
        let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
        let l:s .= crystalline#left_mode_sep('')
    endif
    if a:width > 80
        let l:s .= ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
    else
        let l:s .= ' '
    endif

    return l:s
endfunction

function! TabLine()
    let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
    return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'molokai'

set showtabline=2
set guioptions-=e
