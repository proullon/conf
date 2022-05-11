set encoding=UTF-8          " This is the future...
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
" set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download
" language package)
" " set noswapfile            " disable creating swap file
" " set backupdir=~/.cache/vim " Directory to store backup files.

" My Awnesome conf !
" Nice colorscheme
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1

" enable pasting from clipboard
set mouse=r

" I want small tabs
set tabstop=2
set softtabstop=2
set expandtab

" I want line number
set number

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


call plug#begin("~/.vim/plugged")
 " ????
 Plug 'SirVer/ultisnips'
 Plug 'honza/vim-snippets'
 Plug 'preservim/nerdcommenter'
 Plug 'mhinz/vim-startify'
 " CtrlP my love
 Plug 'ctrlpvim/ctrlp.vim'
 " NERDTree
 Plug 'scrooloose/nerdtree'
 " Theme
 Plug 'EdenEast/nightfox.nvim'
 " Git plugin
 Plug 'tpope/vim-fugitive'
 " Go
 Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
 " Git
 Plug 'lewis6991/gitsigns.nvim'
 " Status bar
 Plug 'feline-nvim/feline.nvim'
 "Plug 'nvim-lualine/lualine.nvim'
 " Icons
 Plug 'kyazdani42/nvim-web-devicons'
 Plug 'ryanoasis/vim-devicons'
call plug#end()

" Nightfox colorschemes
colorscheme duskfox
"colorscheme nightfox
"colorscheme nordfox

" I want :GoDef on gv and :GoInstall on gi
map gv :<C-U>call go#def#JumpMode("vsplit")<CR>
map gi :<C-U>call go#cmd#Install(!g:go_jump_to_error)<CR>

:" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
:inoremap <C-a> <Home>
:inoremap <C-e> <End>

" SublimeText ctrl-p shortcut
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

lua << END
-- Start git setup in status bbar
require('gitsigns').setup()
-- require('feline').setup()
-- Start status bar
require('feline').setup({
    preset = 'noicon'
})
END

