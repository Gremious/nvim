-- Consider:
-- https://github.com/eugen0329/vim-esearch

-- Theme
require("catppuccin").setup()

require("marks").setup()
require("hop").setup()
require("focus").setup()
require("scope").setup()
require "nvim-tree".setup {
  diagnostics = {
	enable = true,
	show_on_dirs = true,
	show_on_open_dirs = false,
	debounce_delay = 50,
	severity = {
	  min = vim.diagnostic.severity.WARN,
	  max = vim.diagnostic.severity.ERROR
	},
  },
}
require("todo-comments").setup({
	keywords = {
		TODO = { icon = " ", color = "warning" }
	}
})
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "rust", "markdown", "lua", "help" },
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

-- Cycle
vim.g.cycle_no_mappings = true
vim.g.cycle_phased_search = true

-- call cycle#add_groups([
-- 	\    [['true', 'false']],
-- 	\    [['yes', 'no']],
-- 	\    [['on', 'off']],
-- 	\    [['+', '-']],
-- 	\    [['>', '<']],
-- 	\    [['"', "'"]],
-- 	\    [['==', '!=']],
-- 	\    [['0', '1']],
-- 	\    [['and', 'or']],
-- 	\    [["in", "out"]],
-- 	\    [["up", "down"]],
-- 	\    [["left", "right"]],
-- 	\    [["min", "max"]],
-- 	\    [["get", "set"]],
-- 	\    [["add", "remove"]],
-- 	\    [["to", "from"]],
-- 	\    [["read", "write"]],
-- 	\    [["only", "except"]],
-- 	\    [['without', 'with']],
-- 	\    [["exclude", "include"]],
-- 	\    [["asc", "desc"]],
-- 	\    [['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday',
-- 	\      'Friday', 'Saturday'], 'hard_case', {'name': 'Days'}],
-- 	\ ])

-- Airline
vim.g.airline_enabled = true
-- vim.g.airline#extensions#tabline#enabled = true
-- vim.g.airline_theme = "material" 
-- vim.g.airline_theme = "embark" -- catppuccin doesn't have one, embark is close
-- vim.g.airline_theme = "miramare" 

-- let g:airline#extensions#tabline#formatter = 'unique_tail'
vim.g.airline_powerline_fonts = true
-- let g:airline#extensions#branch#enabled = 1
-- if !exists('g:airline_symbols')
-- let g:airline_symbols = {}
-- endif

-- Nerd Commenter
vim.g.NERDCreateDefaultMappings = true
vim.g.NERDSpaceDelims = true
vim.g.NERDCommentEmptyLines = true
vim.g.NERDTrimTrailingWhitespace = true

-- Rooter will change to file location for non-project files
vim.g.rooter_change_directory_for_non_project_files  = "current"

--illumante
-- augroup illuminate_augroup
--     autocmd!
--     autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
-- augroup END
-- let g:Illuminate_delay = 3

-- GUNDO
if vim.fn.has("python3") then
	vim.g.gundo_prefer_python3 = 1
end

-- FZF
-- let g:fzf_action = {
--   \ 'ctrl-t': 'tab split',
--   \ 'ctrl-x': 'split',
--   \ 'ctrl-v': 'vsplit',
--   \ 'ctrl-o': ':r !echo'}

-- to ignore file names:
-- fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%'), <bang>0)

-- let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
-- let g:fzf_preview_window = ['down:60%'] 
-- command! -bang -nargs=* Rg
--   \ call fzf#vim#grep(
--   \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>),
--   \   1,
--   \   fzf#vim#with_preview(),
--   \   <bang>0
--   \ )

-- Show currently hovered texts' highlight group for colorscheme fixups
-- map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
-- \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
-- \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

