set relativenumber
set mouse=a
set numberwidth=1
set clipboard=unnamedplus
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set laststatus=2
set linebreak
set expandtab
filetype plugin indent on

"spanish lang
set spell
set spelllang=es_es,en_us
set spellfile=~/.vim/dict.utf-8.add
"]s next ortographic error
"[s previous ortographic error
"z= suggestions
"zg add to dictionary

"Disable auto-commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"split always in right
set splitbelow splitright

call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'

" IDE
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mattn/emmet-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'sbdchd/neoformat'
Plug 'pangloss/vim-javascript'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'honza/vim-snippets'

call plug#end()

execute pathogen#infect()

set termguicolors

colorscheme one
set background=dark
let g:airline_theme='one'
let NERDTreeQuitOnOpen=1

syn on
set shiftwidth=4
set tabstop=4

let mapleader = " "

nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>nt :NERDTreeFind<CR>

"format all
nmap <Leader>fe gg=G<CR> 

"pascal and latex compiler
nnoremap <Leader>fpc :!fpc %<CR>
nnoremap <Leader>pdf :!pdflatex %<CR><CR>

tnoremap <Esc> <C-\><C-n>

"latex snippets
nmap <Leader>bf i\textbf{}<Esc>i
nmap <Leader>it i\textit{}<Esc>i
nmap <Leader>tt i\texttt{}<Esc>i
nmap <Leader>sp i\vspace{}<Esc>i

" Deactivating arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" EMMET SHORTCUTS
let g:user_emmet_mode='n'
let g:user_emmet_leader_key=','

" tab autocompletion
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-n>"
  endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" indentation colors
let g:indent_guides_enable_on_vim_startup = 1

" prettier 
autocmd BufWritePre *.js Neoformat
let g:javascript_plugin_jsdoc = 1
let g:vim_jsx_pretty_colorful_config = 1
