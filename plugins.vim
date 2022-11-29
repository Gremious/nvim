call plug#begin(stdpath('data') . '/plugged')
	Plug 'nvim-lua/plenary.nvim' " lib other plugins use

	Plug 'kaicataldo/material.vim', { 'branch': 'main' }
	" Plug 'catppuccin/nvim', {'as': 'catppuccin'}
	" Plug 'chriskempson/base16-vim'
	" Plug 'vim-airline/vim-airline-themes'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'kyazdani42/nvim-tree.lua'

	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax highlighter
	Plug 'nvim-treesitter/playground' " treesitter debug
	Plug 'fladson/vim-kitty', { 'branch': 'main' } " kitty config highlighting
	Plug 'vmchale/dhall-vim'

	Plug 'tpope/vim-obsession' " Per-directory session management (remember layout, etc.)
	" Plug 'luochen1990/rainbow' " Rainbow brackets
	Plug 'p00f/nvim-ts-rainbow' " rainbow parens for treesitter
	Plug 'machakann/vim-highlightedyank' " on yank, highlights yanked text for a second
	
	Plug 'folke/todo-comments.nvim'
	Plug 'tpope/vim-repeat' " remaps . in a way that plugins can tap into it
	Plug 'svermeulen/vim-extended-ft' " f and t searches go through lines, ignore case, can be repeated with ; and ,
	Plug 'vim-airline/vim-airline'
	Plug 'chentoast/marks.nvim' " show marks in sign column

	Plug 'akinsho/bufferline.nvim' " Buffer Tabs
	Plug 'tiagovla/scope.nvim' " Scrope buffers to vim tabs, :bnext and :bprev are workspaces basically
	Plug 'qpkorr/vim-bufkill' " Don't close the whole tab/window on :bd - use :BD instead
	" Plug 'romgrk/barbar.nvim' " Buffer Tabs
	"
	Plug 'scrooloose/nerdcommenter' " Toggle comments
	Plug 'sjl/gundo.vim' " undo tree
	Plug 'yegappan/mru'	" most recently used files so i can undo a close
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'godlygeek/tabular' " Tab/Spaces aligner
	Plug 'ciaranm/detectindent' " adds :DetectIndent, sets shiftwidth, expandtab and tabstop based on existing use
	Plug 'lukas-reineke/indent-blankline.nvim' " Visible indents
	Plug 'tpope/vim-fugitive' " git 
	Plug 'airblade/vim-gitgutter' " git in gutter
	Plug 'airblade/vim-rooter' " changes working dir to project root whenever you open files 
	Plug 'RRethy/vim-illuminate' " Highlight hovered vairables (lsp compatible)
	Plug 'tpope/vim-surround' " suround things with any text
	Plug 'wellle/targets.vim'
	" Plug 'RishabhRD/popfix' " Floating pop-ups library
	" Plug 'RishabhRD/nvim-lsputils' " Floating pop up for lsp stuff
	Plug 'beauwilliams/focus.nvim' " resize splits when focusing them
	Plug 'phaazon/hop.nvim' " EasyMotion but better, jump around places

	" ===== LSP =====
	" https://github.com/sharksforarms/neovim-rust/
	
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'

	" Autocompletion framework
	Plug 'hrsh7th/nvim-cmp'

	" Snippet engine
	" Plug 'hrsh7th/vim-vsnip'
	Plug 'L3MON4D3/LuaSnip'

	" cmp Snippet completion
	" Plug 'hrsh7th/cmp-vsnip'
	Plug 'saadparwaiz1/cmp_luasnip'

	" cmp LSP completion
	Plug 'hrsh7th/cmp-nvim-lsp'

	" cmp Path completion
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-buffer'
	
	" AI-Completion
	Plug 'tzachar/cmp-tabnine', { 'do': 'powershell ./install.ps1' }
	
	" Icons for cmp
	Plug 'onsails/lspkind.nvim' 

	" Adds extra functionality over rust analyzer
	Plug 'simrat39/rust-tools.nvim'

	" Optional
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-lua/lsp-status.nvim'

	" ===== Obsolete =====
	" " pywal theme support (broken in neovide? :c)
	" Plug 'dylanaraps/wal.vim'

	" " Allows for the creations of 'submodes'
	" Plug 'https://github.com/Iron-E/nvim-libmodal'
call plug#end()

" Consider:
" https://github.com/eugen0329/vim-esearch

" lua plugin setups
lua <<EOF
	-- require("catppuccin").setup()
	require'marks'.setup()
	require'nvim-tree'.setup()
	require'hop'.setup()
	require("focus").setup()
	require("scope").setup()
	require("todo-comments").setup({
		keywords = {
			TODO = { icon = " ", color = "warning" }
		}
	})
	require'nvim-treesitter.configs'.setup {
		ensure_installed = { "rust" },
		highlight = {
			enable = true,
		},
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = 4000,
		},
		indent = {             
			enable = false,
		},
	}
	require("indent_blankline").setup {
		use_treesitter = true,
        show_current_context = true,
	}
	require('telescope').setup({
		defaults = {
			layout_strategy = 'vertical',
			layout_config = { height = 0.95 },
		}
	})
    require('bufferline').setup({
        options = {
            buffer_close_icon = '',
            close_icon = '',
            modified_icon = '✏',

			-- separator_style = "slant",
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = true,
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local s = " "
				for e, n in pairs(diagnostics_dict) do
					local sym = e == "error" and " "
						or (e == "warning" and " " or "" )
					s = s .. n .. sym
				end
				return s
			end
            -- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
            -- enforce_regular_tabs = false | true,
            -- always_show_bufferline = true,
        }
    })
--  nvim-lsputils (fly-out pop-ups and stuff)
-- 	vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
-- 	vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
-- 	vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
-- 	vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
-- 	vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
-- 	vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
-- 	vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
-- 	vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
EOF

" Airline
let g:airline_enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_theme = 'material'
" let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
" let g:airline#extensions#branch#enabled = 1
" if !exists('g:airline_symbols')
	" let g:airline_symbols = {}
" endif

" Nerd Commenter
let g:NERDCreateDefaultMappings = 1
let g:NERDSpaceDelims = 1

let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Rooter will change to file location for non-project files
let g:rooter_change_directory_for_non_project_files = 'current'

"illumante
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
augroup END
let g:Illuminate_delay = 3

" GUNDO
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" FZF
let g:fzf_preview_window = ['right:50%'] 
" let g:fzf_preview_window = []

" to ignore file names:
" fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%'), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview(),
  \   <bang>0
  \ )

" RG commant that uses RipGrep to search instead
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Show currently hovered texts' highlight group for colorscheme fixups
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" " Barbar
" let bufferline = get(g:, 'bufferline', {})
" let bufferline.closable = v:false
" " let bufferline.clickable = v:false
" let bufferline.icons = v:true
" let bufferline.animation = v:false
"
" lua <<EOF
	" local nvim_tree_events = require('nvim-tree.events')
	" local bufferline_api = require('bufferline.api')
"
	" local function get_tree_size()
	  " return require'nvim-tree.view'.View.width
	" end
"
	" nvim_tree_events.subscribe('TreeOpen', function()
	  " bufferline_api.set_offset(get_tree_size())
	" end)
"
	" nvim_tree_events.subscribe('Resize', function()
	  " bufferline_api.set_offset(get_tree_size())
	" end)
"
	" nvim_tree_events.subscribe('TreeClose', function()
	  " bufferline_api.set_offset(0)
	" end)
" EOF
