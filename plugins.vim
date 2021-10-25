call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'

" IDE
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mattn/emmet-vim'
Plug 'sbdchd/neoformat'
Plug 'pangloss/vim-javascript'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'honza/vim-snippets'
Plug 'junegunn/goyo.vim' " good looking
Plug 'itspriddle/vim-shellcheck' " spellcheck
Plug 'xolox/vim-misc' " for switch
Plug 'xolox/vim-colorscheme-switcher' " switch colorscheme
Plug 'chrisbra/csv.vim' " csv viewer
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP
Plug 'Yggdroot/indentLine' " indent lines

"UML
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'

call plug#end()

execute pathogen#infect()
