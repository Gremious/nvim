-- Consider:
-- https://github.com/eugen0329/vim-esearch

-- Nerd Commenter
vim.g.NERDCreateDefaultMappings = true
vim.g.NERDSpaceDelims = true
vim.g.NERDCommentEmptyLines = true
vim.g.NERDTrimTrailingWhitespace = true
vim.g.NERDDefaultAlign = "left"

-- Rooter will change to file location for non-project files
vim.g.rooter_change_directory_for_non_project_files = "current"

-- GUNDO breaks without python3
if vim.fn.has("python3") then
	vim.g.gundo_prefer_python3 = 1
end

require('lualine').setup()
require("fidget").setup()
require("marks").setup()
require("hop").setup()
require("focus").setup()
require("scope").setup()
require('illuminate').configure()

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
	{ "0", "1" },
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
			enable_preview = true
		}
	},
	extensions = {
		command_palette = {
			{
				"Config",
				{ "Init", ":Config" },
				{ "Packer", ":ConfigPacker" },
				{ "Plugins", ":ConfigPlugins" },
				{ "Lsp", ":ConfigLsp" },
				{ "Commands", ":ConfigCommands" },
				{ "Hotkeys", ":ConfigHotkeys" },
				{ "ConfigAutocmd", ":ConfigAutocmd" },
			},
			{
				"File",
				{ "entire selection (C-a)", ':call feedkeys("GVgg")' },
				{ "save current file (C-s)", ":w" },
				{ "save all files (C-A-s)", ":wa" },
				{ "quit (C-q)", ":qa" },
				{ "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
				{ "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
				{ "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
				{ "files (C-f)", ":lua require('telescope.builtin').find_files()", 1 },
			},
			{
				"Vim",
				{ "reload vimrc", ":source $MYVIMRC" },
				{ "check health", ":checkhealth" },
				{ "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
				{ "commands", ":lua require('telescope.builtin').commands()" },
				{ "command history", ":lua require('telescope.builtin').command_history()" },
				{ "registers (A-e)", ":lua require('telescope.builtin').registers()" },
				{ "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
				{ "vim options", ":lua require('telescope.builtin').vim_options()" },
				{ "keymaps", ":lua require('telescope.builtin').keymaps()" },
				{ "buffers", ":Telescope buffers" },
				{ "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
				{ "paste mode", ":set paste!" },
				{ "cursor line", ":set cursorline!" },
				{ "cursor column", ":set cursorcolumn!" },
				{ "spell checker", ":set spell!" },
				{ "relative number", ":set relativenumber!" },
				{ "search highlighting (F12)", ":set hlsearch!" },
			},
		},
	},
})

require("telescope").load_extension("command_palette")
telescope.load_extension('fzf')

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
