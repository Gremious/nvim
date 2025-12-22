return {
	{
		"nvim-tree/nvim-tree.lua",
		-- -- nvim-tree recomends explicitly not lazy loading,
		-- -- and lazy.nvim does not call setup automatically when lazy = false
		lazy = false,
		config = function()
		local nvim_tree = require("nvim-tree.api")

		vim.keymap.set("n", "<Leader><tab>", function()
		nvim_tree.tree.toggle({ find_file = true, focus = true, update_root = false })
		end)

		-- TODO Make fn, try find file, if you did - find file toggle. If not - find file toggle but in current dir .
		-- keymap.set(modes.NORMAL, "<leader><tab>", ":NvimTreeFindFileToggle <cr>", { silent = true })
		-- keymap.set(modes.NORMAL, "<leader><tab>", ":NvimTreeFindFileToggle . <cr>", { silent = true })

		require("nvim-tree").setup({
			-- update_focused_file = {
			-- enable = true,
			-- },
			filters = {
				git_ignored = false,
				dotfiles = false,
			},
			actions = {
				-- use_system_clipboard = false,
				open_file = {
					quit_on_open = true,
					window_picker = {
						enable = false,
					},
				},
			},
			view = {
				-- Table means "dynamic"
				width = {},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = false,
				severity = {
					min = vim.diagnostic.severity.WARN,
					max = vim.diagnostic.severity.ERROR,
				},
			},
			-- -- https://github.com/nvim-tree/nvim-tree.lua/issues/2851
			-- -- hijack_unnamed_buffer_when_opening = true,
			renderer = {
				highlight_git = "all",
				-- highlight_modified = "all",
				icons = {
					glyphs = {
						git = {
							unstaged = "📝",
							staged = "✔️",
							unmerged = "",
							renamed = "🔄️",
							untracked = "🆕",
							deleted = "❌",
							ignored = "◌",
						}
					},
				},
			},
		})
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	}
}
