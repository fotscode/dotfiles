call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'

" IDE
Plug 'easymotion/vim-easymotion' " quick find in file
Plug 'scrooloose/nerdtree' " nerdtree
Plug 'christoomey/vim-tmux-navigator' "idk
Plug 'mattn/emmet-vim' " emmet for html, css
" Plug 'sbdchd/neoformat' " prettier
Plug 'pangloss/vim-javascript'  " syntax highlighting for js
Plug 'yuezk/vim-js'  " syntax highlighting for js
Plug 'maxmellon/vim-jsx-pretty' " syntax highlighting for jsx
Plug 'honza/vim-snippets' " snippets for  vim
Plug 'junegunn/goyo.vim' " good looking
Plug 'itspriddle/vim-shellcheck' " spellcheck
Plug 'xolox/vim-misc' " for switch
Plug 'xolox/vim-colorscheme-switcher' " switch colorscheme
Plug 'chrisbra/csv.vim' " csv viewer
Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP
Plug 'Yggdroot/indentLine' " indent lines
Plug 'kosayoda/nvim-lightbulb' " ligthbulb
Plug 'norcalli/nvim-colorizer.lua' " colors in hex values
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlighting
Plug 'mhinz/vim-startify' " start screen with recent projects
Plug 'vim-airline/vim-airline' " tabs
Plug 'vim-airline/vim-airline-themes' " tabs theme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
"UML
Plug 'aklt/plantuml-syntax' " syntax 
Plug 'weirongxu/plantuml-previewer.vim' " previewer
Plug 'tyru/open-browser.vim'  " open previewer in browser

call plug#end()

"if i need to install by pathogen here it is
execute pathogen#infect()
