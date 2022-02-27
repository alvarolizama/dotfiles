"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('data') . '/plugged')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""" Themes
Plug 'dracula/vim'

"""" Files Navigation
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'

"""" Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"""" Terminal
Plug 'voldikss/vim-floaterm'

"""" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

"""" Status & tab line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"""" Code Plugins
Plug 'Raimondi/delimitMate'
Plug 'docunext/closetag.vim'
Plug 'mhinz/vim-mix-format'

"""" Git
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'cohama/agit.vim'

"""" Eye candy
Plug 'glepnir/dashboard-nvim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'ap/vim-css-color'
Plug 'RRethy/vim-illuminate'


"""" Other plugins
Plug 'duggiefresh/vim-easydir'


call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
scriptencoding utf-8
set encoding=utf-8

filetype on
filetype plugin on
filetype plugin indent on

" Idention
set smarttab
set expandtab
set autoindent
set smartindent
set tabstop=2
set showtabline=1
set shiftwidth=2

" Search
set hlsearch
set showmatch
set incsearch
set ignorecase

" User interface
set ruler
set number
set wildmenu
set novisualbell
set mouse=a
set cmdheight=1
set linespace=0
set laststatus=2

" Folding
set nofoldenable
set foldlevel=2
set foldnestmax=10
set foldmethod=indent

" Miscellaneous
set hidden
set confirm
set noshowcmd
set modifiable
set nobackup
set nowritebackup
set noswapfile
set backspace=2
set clipboard=unnamed
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*deps/*,*_build/*,*node_modules/*

" Performance
set ttyfast
set lazyredraw
set regexpengine=1
set synmaxcol=256


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme and Colors Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let python_highlight_all = 1

syntax on
set background=dark
hi Comment cterm=italic
colorscheme dracula


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Common VIM Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_localrmdir="rm -rf"
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 1
let g:netrw_banner = 0
let mapleader = "\\"
let g:loaded_matchparen=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Common Key Maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Space> i

map <Leader>gg <Esc>ggvG=<CR>
map <Leader>\ <Esc>:Files<CR>
map <Leader>] <Esc>:Explore<CR>
map <Leader>[ <Esc>:Buffers<CR>
map <Leader>; <Esc>:Ag<CR>
map <Leader>' <Esc>:GFiles?<CR>
map <Leader>. <Esc>:BLines<CR>
map <Leader>/ <Esc>:Lines<CR>
map <Leader>= <Esc>:Commits<CR>
map <Leader>- <Esc>:BCommits<CR>

inoremap jj <esc>
inoremap jk <esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Common Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.html set filetype=html.htmldjango
au BufRead,BufNewFile *.py set filetype=python.django
"au BufWritePost *.exs,*.ex silent :!mix format %
au FileType python set shiftwidth=4 tabstop=4 softtabstop=4 colorcolumn=80 completeopt-=preview
au FileType elixir set colorcolumn=80
au BufWritePre * :%s/\s\+$//e
au VimEnter * RainbowParenthesesToggleAll


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dashboard Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:dashboard_default_executive ='fzf'
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Floaterm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:floaterm_keymap_new    = '<leader>tc'
let g:floaterm_keymap_prev   = '<leader>tp'
let g:floaterm_keymap_next   = '<leader>tn'
let g:floaterm_keymap_toggle = '<leader>tt'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airlines Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RBPT Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mix Formater Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mix_format_on_save = 1
let g:mix_format_silent_errors = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_preview_window = 'right:60%'
