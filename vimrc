call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
Plug 'nsf/gocode', { 'tag': 'go.weekly.2012-03-13', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" vim-go plugin
Plug 'fatih/vim-go'

" Scala plugin
Plug 'derekwyatt/vim-scala'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Configuration for vim-scala
au BufRead,BufNewFile *.sbt set filetype=scala

" CtrlP my love
Plug 'kien/ctrlp.vim'

" Angular
Plug 'leafgarland/typescript-vim'

call plug#end()

" SublimeText ctrl-p shortcut
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" My Awnesome conf !
" Nice colorscheme
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

colorscheme molokai

" I want small tabs
set tabstop=2
set softtabstop=2
set expandtab

" I want line number
set number

" I want :GoDef on gv and :GoInstall on gi
map gv :<C-U>call go#def#JumpMode("vsplit")<CR>
map gi :<C-U>call go#cmd#Install(!g:go_jump_to_error)<CR>

:" Map Ctrl-A -> Start of line, Ctrl-E -> End of line
:inoremap <C-a> <Home>
:inoremap <C-e> <End>
