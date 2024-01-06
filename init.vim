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

" remap exiting from terminal with Esc
noremap <Esc> <C-\><C-n>

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

" What do I want ?
" - Colorscheme matching tmux, etc: nightfox with duskfox variation.
" - Modern icons: vim-devicons and nvim-web-devicons
" - LSP, DAP, linters and formatters for each language I use: mason
" - Git integration: gitsigns, fugitive
" - Status bar: feline
" - Latex integration: vimtex
" - File navitagion: Telescope
"
" any language specific plugin should go in favor of mason

call plug#begin("~/.vim/plugged")
 " Theme
 Plug 'EdenEast/nightfox.nvim'
 " Icons
 Plug 'kyazdani42/nvim-web-devicons'
 Plug 'ryanoasis/vim-devicons'
 " Mason
 Plug 'williamboman/mason.nvim'
 " Git
 Plug 'tpope/vim-fugitive'
 Plug 'lewis6991/gitsigns.nvim'
 " Status bar
 Plug 'feline-nvim/feline.nvim'
 " vimtex plugin for latex
 Plug 'lervag/vimtex'
 " Telescope
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" Nightfox colorschemes
colorscheme duskfox

" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
inoremap <C-a> <Home>
inoremap <C-e> <End>

" Spelling
autocmd FileType markdown setlocal spell
autocmd FileType latex setlocal spell
set spelllang=en_gb,fr
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_view_general_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

lua << END
-- Start git setup in status bbar
require('gitsigns').setup()
-- Start status bar
require('feline').setup({
    preset = 'noicon'
})
require('mason').setup()
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
END
