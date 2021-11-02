set relativenumber
set mouse=a
set numberwidth=1
set clipboard+=unnamedplus
syntax enable
syn on
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set laststatus=2
set linebreak
set expandtab
set cul
set shiftwidth=4
set tabstop=4
filetype plugin indent on

"split always in right
set splitbelow splitright

"spanish lang
"set spell
set spelllang=es_es,en_us
set spellfile=~/.vim/dict.utf-8.add
"]s next ortographic error
"[s previous ortographic error
"z= suggestions
"zg add to dictionary

"Disable auto-commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" color bug
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" default colorscheme
colorscheme one
set background=dark



" theme
let g:airline_theme='one'

" nerdtree
let NERDTreeQuitOnOpen=1

" EMMET SHORTCUTS
let g:user_emmet_mode='n'
let g:user_emmet_leader_key=','

" exclude colorschemes
let g:colorscheme_switcher_exclude = ['default', 'test', 'blue', 'darkblue', 'delek', 'desert', 'elflord', 'evening', 'industry', 'koehler', 'morning', 'murphy', 'pablo', 'peachpuff', 'ron', 'shine', 'slate', 'torte', 'zellner']

"indent lines
let g:indentLine_char='|'
let g:indentLine_fileTypeExclude = ["coc-explorer","help","nerdtree"]
let g:indentLine_leadingSpaceEnabled = 1 
let g:indentLine_leadingSpaceChar = '·'

"nvim
if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

" prettie
let g:javascript_plugin_jsdoc = 1
let g:vim_jsx_pretty_colorful_config = 1

" startify header
source $HOME/.config/vim/startify.vim

" airline config
source $HOME/.config/nvim/airline.vim

" fzf config
source $HOME/.config/nvim/fzf.vim

" open non readable files with xdg-open
autocmd BufReadCmd *.pdf,*.png,*.jpg,*.jpeg,*.gif silent !xdg-open % &
autocmd BufEnter *.pdf,*.png,*.jpg,*.jpeg,*.gif bdelete
