set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source $HOME/.config/vim/plugins.vim
source $HOME/.config/vim/settings.vim
source $HOME/.config/vim/coc.vim
source $HOME/.config/vim/mappings.vim

" colors in hex value setup
lua require'colorizer'.setup() 
