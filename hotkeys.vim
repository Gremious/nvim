nnoremap <SPACE> <Nop>
let mapleader=" "
" You can always call :Telescope keymap to see all keymaps 

" Ctrl+S to save
noremap  <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

noremap <Leader>u :GundoToggle<CR>

" show white space
noremap <Leader>w :set list!<CR>

" == spellcheck-mode ==
nnoremap <silent> <Leader>ss :set spell!<cr>
"toggle suggestions
nnoremap <silent> <Leader>s z=
nnoremap <silent> <Leader><C-s> z=
nnoremap <silent> <Leader>sl ]s
nnoremap <silent> <Leader>sh [s
nnoremap <silent> <Leader>sL ]S
nnoremap <silent> <Leader>sH [S
nnoremap <silent> <Leader>sa zg
" ==/ spellcheck mode /==

" Clear search highlighting
noremap <silent> <Esc><Esc> :noh<CR>

" insert mode undo
inoremap <C-z> <C-o>u
" insert mode redo
inoremap <C-r> <C-o><C-r>

nnoremap <Leader>f :Rg<Cr>
nnoremap <Leader>F :Files<Cr>

nnoremap <left> :BufferPrevious<cr>
nnoremap <right> :BufferNext<cr>
nnoremap <C-Left> :BufferMovePrevious<cr>
nnoremap <C-Right> :BufferMoveNext<cr>
nnoremap <leader>b :BufferPick<cr>
nnoremap <leader>p :BufferPin<cr>
" nnoremap <c-W> :BufferDelete<cr>
" nnoremap <C-s> :BufferCloseAllButPinned<cr>

nnoremap <leader>t :NvimTreeToggle<cr>

" Move line up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
