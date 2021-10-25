" leader key
let mapleader = " "

" easymotion
nmap <Leader>s <Plug>(easymotion-s2) 
"nerdtree
nmap <Leader>nt :NERDTreeFind<CR>
"goyo
nmap <Leader>go :Goyo<CR><F8><CR>:echon ''<CR>
nmap <Leader>gr :Goyo 300x300<CR>:echon ''<CR>
".csv view
nmap <Leader>csv :CSVTabularize<CR>
"format all
nmap <Leader>fe gg=G<CR> 
"latex compiler
nnoremap <Leader>pdf :!pdflatex %<CR><CR>

tnoremap <Esc> <C-\><C-n>

"latex snippets
nmap <Leader>bf i\textbf{}<Esc>i
nmap <Leader>it i\textit{}<Esc>i
nmap <Leader>tt i\texttt{}<Esc>i
nmap <Leader>sp i\vspace{}<Esc>i

"plantuml compiler
nnoremap <Leader>uml :PlantumlSave %:r.png<CR>:PlantumlOpen<CR>

"firefox exec
nnoremap <Leader>gl :exec '!firefox '.getline('.')<CR><CR>

"clear vim command line
nnoremap <C-l> :echon ''<CR>

" Deactivating arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
