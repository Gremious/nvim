local fn = vim.fn

-- Consider:
-- https://github.com/eugen0329/vim-esearch

-- Nerd Commenter
vim.g.NERDCreateDefaultMappings = true
vim.g.NERDSpaceDelims = true
vim.g.NERDCommentEmptyLines = true
vim.g.NERDTrimTrailingWhitespace = true
vim.g.NERDDefaultAlign = "left"

vim.g.sqlite_clib_path = vim.env.CONFIG .. "\\sqlite3\\sqlite3.dll"
-- Rooter will change to file location for non-project files
vim.g.rooter_change_directory_for_non_project_files = "current"

-- GUNDO breaks without python3
if vim.fn.has("python3") then
	vim.g.gundo_prefer_python3 = 1
end

-- require("fidget").setup()
require("marks").setup()
require("hop").setup()
require("focus").setup()
require("scope").setup()
require("illuminate").configure()
require("retrail").setup()
require("easy-action").setup()
require("treesj").setup({
	use_default_keymaps = false,
	check_syntax_error = false,
	max_join_length = 160,
})

-- TODO: Remove diagnostics from lsp-status cause lualine already shows them.
require('lualine').setup({
	extensions = { "nvim-tree", "fugitive" },
      sections = {
        lualine_x = {
			function() return require('lsp-status').status() end,
			'encoding', 'fileformat', 'filetype',
		},
	}
})

-- local autosession = require("auto-session")
-- autosession.setup({
--     log_level = "error",
--     auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
-- })
--
-- require('session-lens').setup({})

require("projections").setup({
	workspaces = {
		"C:/Users/Gremious/Projects/Programming/Gremy/dev",
		"C:/Users/Gremious/Projects/dev",
	},
	sessions_directory = "C:\\Users\\Gremious\\ProjectionsSesssions"
})

-- local wilder = require("wilder")
-- wilder.setup({ modes = { ":", "/", "?" } })
-- wilder.set_option(
--     "renderer",
--     wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
--         highlighter = wilder.basic_highlighter(),
--         highlights = {
--             border = "Normal",
--             -- The color of the search match
--             accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
--         },
--         left = { " ", wilder.popupmenu_devicons() },
--         right = { " ", wilder.popupmenu_scrollbar() },
--         border = "rounded",
--         -- min_height = 8,
--         max_height = 8,
--     }))
-- )

require("nvim-treesitter.configs").setup({
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
})

require("nvim-tree").setup({
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = false,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.WARN,
			max = vim.diagnostic.severity.ERROR,
		},
	},
})

require("todo-comments").setup({
	keywords = {
		TODO = { icon = " ", color = "warning" },
	},
})

require("indent_blankline").setup({
	use_treesitter = true,
	show_current_context = true,
})

require("bufferline").setup({
	options = {
		buffer_close_icon = "",
		close_icon = "",
		modified_icon = "✏",

		-- separator_style = "slant",
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = true,
		diagnostics_indicator = function(_count, _level, diagnostics_dict, _context)
			local s = " "
			for e, n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e == "warning" and " " or "")
				s = s .. n .. sym
			end
			return s
		end,
		-- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
		-- enforce_regular_tabs = false | true,
		-- always_show_bufferline = true,
	},
})

-- Cycle
vim.g.cycle_no_mappings = true
vim.g.cycle_phased_search = true
vim.fn["cycle#add_groups"]({
	{ "true", "false" },
	{ "yes", "no" },
	{ "on", "o)ff" },
	{ "+", "-" },
	{ ">", "<" },
	{ '"', "'" },
	{ "==", "!=" },
	-- { "0", "1" },
	{ "and", "or" },
	{ "in", "out" },
	{ "up", "down" },
	{ "left", "right" },
	{ "min", "max" },
	{ "get", "set" },
	{ "add", "remove" },
	{ "to", "from" },
	{ "read", "write" },
	{ "only", "except" },
	{ "without", "with" },
	{ "exclude", "include" },
	{ "asc", "desc" },
	{ { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }, "hard_case" },
})

local telescope = require("telescope")
telescope.setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = { height = 0.95 },
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
			},
		},
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
		}
	}
})
telescope.load_extension("fzf")
telescope.load_extension("projections")
-- require("telescope").load_extension("session-lens")

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
