if has('win32')
	let $CONFIG = $LOCALAPPDATA . '\nvim'
else
	let $CONFIG = '~/.config/nvim'
endif

" rust-analyzer.server.extraEnv
" neovim doesn't have custom client-side code to honor this setting, it doesn't actually work
" https://github.com/neovim/nvim-lspconfig/issues/1735
let $CARGO_TARGET_DIR = "target/rust-analyzer-check"

syntax on
" set autochdir "auto-set current dir so that you can do `:e newfile` to make newfiles in ./ by default
filetype plugin indent on " see help filetype
set fileformats=unix
set encoding=utf-8 "required for powerline symbols
set fileencoding=utf-8
set spelllang=en,cjk
set autoindent noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
" set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab "use tabs instead of spaces

set backupdir=/var/lib/nvim/backup
set directory=/var/lib/nvim/swap
set undodir=/var/lib/nvim/undo
set writebackup
set history=1000 "longer command history
set undolevels=1000 "more undo levels
set undofile " persistent undo between sessions

set termguicolors
set lazyredraw " don't redraw in macros
set synmaxcol=500 " don't syntax past 500 char in a single-line (think minified code)
set ttimeoutlen=50 "small timeout for airline
set scrolloff=15

set number "display line numbers
set relativenumber "line numbers are relative to the current line
set cursorline "highlight current line
set laststatus=2 "always show status
set showmatch "matching brackets while typing
set showcmd "show incomplete commands
set listchars=space:·,tab:>=,trail:·,extends:»,precedes:«,eol:↴ "characters to use for whitespace
" set linebreak " Wrapped lines will wrap at breaks not mid-letter
set nowrap
set wildmenu "autocomplete for commands is visible
set splitbelow "new vertical split will be below
set splitright "new horizontal split will be to the right
set formatoptions=crqlj "wrap comments, never autowrap long lines
set diffopt+=vertical " diffs are vertical
set cmdheight=2 " more space for displaying messages
set signcolumn=yes " always show signcolumn
" set shortmess+=c " on't pass messages to ins-completion-menu
set textwidth=0 wrapmargin=0
noh " don't auto-highlight last search on new session
set noshowmode " We have airline so don't need to see 'VISUAL'

" set mouse=a
" set backspace=indent,eol,start " Backspace anthing in edit mode
set clipboard+=unnamed,unnamedplus "default register is clipboard
set nrformats-=octal " do not inc/dec octal numbers as it can lead to errors
set hidden "allows unsaved buffers
set autoread "auto-refresh changed files
" set incsearch "show what part of searched string matches
set ignorecase "remove case check in search
set smartcase "only care about case in search if there are upper-case letters, needs ignorecase
set whichwrap=<>
set pyx=3 " set python version

" set guifont=JetBrainsMono_Nerd_Font:h12
" set guifont=FiraCode_Nerd_Font_Mono:h12
set guifont=FiraCode_NF:h12
let neovide_remember_window_size = v:true
let g:neovide_refresh_rate=140
let g:rainbow_active = 1

let g:material_theme_style = 'ocean'
let g:material_terminal_italics = 1
colorscheme material
" colorscheme wal " doesn't seem to work with neovide very sad :c

source $CONFIG/plugins.vim
source $CONFIG/lsp.vim
" source $CONFIG/lsp-coc.vim
source $CONFIG/hotkeys.vim
source $CONFIG/autocmd.vim

" Type config -> get config
command Config :e $CONFIG/init.vim
command ConfigHotkeys :e $CONFIG/hotkeys.vim
command ConfigPlugins :e $CONFIG/plugins.vim
command ConfigLsp :e $CONFIG/lsp.vim
command ConfigAutocmd :e $CONFIG/autocmd.vim
command Reload execute ':so $MYVIMRC'
" Copy filepath to clipboard
command Cc     :let @+ = expand("%:p")


