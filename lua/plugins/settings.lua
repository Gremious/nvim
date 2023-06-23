local fn = vim.fn

--[[
   [ Consider:
   [ https://github.com/eugen0329/vim-esearch
-- ]]

require("mason").setup()
-- require("fidget").setup()
require("marks").setup()
--require("hop").setup()
require("focus").setup()

require("illuminate").configure()
require("retrail").setup()
require("easy-action").setup()

-- Nerd Commenter
vim.g.NERDCreateDefaultMappings = true
vim.g.NERDSpaceDelims = true
vim.g.NERDCommentEmptyLines = true
vim.g.NERDTrimTrailingWhitespace = true
vim.g.NERDDefaultAlign = "left"

-- Rooter will change to file location for non-project files
-- vim.g.rooter_change_directory_for_non_project_files = "current"

-- GUNDO breaks without python3
if vim.fn.has("python3") then
	vim.g.gundo_prefer_python3 = 1
end

require("treesj").setup({
	use_default_keymaps = false,
	check_syntax_error = false,
	max_join_length = 160,
})

-- require("projections").setup({
--     workspaces = {
--         "~/Projects/Programming/gremy/dev",
--         "~/Projects/dev",
--     },
-- })

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	view = {
		width = 40,
		adaptive_size = true,
	},
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

	-- Update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file.
	update_focused_file = {
		enable = true,
		update_root = true
	},
	-- Prefer startup root directory when updating root directory of the tree.
	prefer_startup_root = true,
	-- Changes the tree root directory on `DirChanged` and refreshes the tree.
	sync_root_with_cwd = false,
	-- Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
	respect_buf_cwd = true,
})

-- TODO: Remove diagnostics from lsp-status cause lualine already shows them.
require("lualine").setup({
	extensions = { "nvim-tree", "fugitive" },
	sections = {
		lualine_x = {
			function()
				return require("lsp-status").status()
			end,
			"encoding",
			"fileformat",
			"filetype",
		},
	},
})

-- require("projections").setup({
--     workspaces = {
--         "~/Projects/Programming/gremy/dev",
--         "~/Projects/dev",
--     },
-- })

require("nvim-treesitter.configs").setup({
	ensure_installed = { "rust", "markdown", "lua", "vimdoc" },
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

require("todo-comments").setup({
	keywords = {
		TODO = { icon = " ", color = "warning" },
	},
})

require("indent_blankline").setup({
	use_treesitter = true,
	show_current_context = true,
})

-- Cycle
vim.g.cycle_no_mappings = true
vim.g.cycle_phased_search = true
vim.fn["cycle#add_groups"]({
	{ "true", "false" },
	{ "yes", "no" },
	{ "on", "off" },
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
	{ ":)", ":(" },
	{ "c:", ":c" },
	{ "fn", "pub fn", "pub(super) fn", "pub(crate) fn", "async fn", "pub async fn", "pub(crate) async fn" },
	{ "let", "let mut" },
	{ { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }, "hard_case" },
})


-- Lags to hell in big files cause of the search.
-- Maybe only load in small files?
--
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
