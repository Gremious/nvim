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
vnoremap <a-/> <Esc>/\%V

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
nnoremap <leader>tp :BufferPick<cr>
nnoremap <leader>p :BufferPin<cr>
" nnoremap <c-W> :BufferDelete<cr>
nnoremap <leader><c-w> :BufferCloseAllButCurrentOrPinned<cr>

nnoremap <silent> <leader><tab> :NvimTreeFindFileToggle<cr>

nnoremap <leader>gp :GitGutterPreviewHunk<cr>
nnoremap <leader>gu :GitGutterUndoHunk<cr>
nnoremap <leader>g] :GitGutterNextHunk<cr>
nnoremap <leader>g[ :GitGutterPrevHunk<cr>

nnoremap <leader>hh :HopAnywhere<cr>
nnoremap <leader>hw :HopWord<cr>
nnoremap <leader>hW :HopWordAC<cr>
nnoremap <leader>hc :HopChar1<cr>
nnoremap <leader>hC :HopChar1AC<cr>
nnoremap <leader>hl :HopLineStart<cr>
nnoremap <leader>hL :HopLineStartAC<cr>

" Move line up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" F11 to fullscreen
nnoremap <silent> <F11> :let g:neovide_fullscreen = (g:neovide_fullscreen == v:true) ? v:false : v:true<cr>

" Semicolon at EOL
nnoremap <leader>; <C-v>$A;<Esc>

