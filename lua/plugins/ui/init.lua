local modes = require("consts").modes

return {
	"chentoast/marks.nvim", -- show marks in sign column
	-- minimap right side small thing pop up code preview
	{
		'echasnovski/mini.nvim',
		version = false,
		config = function()
		require('mini.map').setup()
		vim.keymap.set(modes.NORMAL, "<Leader>mm", MiniMap.toggle)
		vim.keymap.set(modes.NORMAL, '<Leader>mt', MiniMap.refresh)
		-- vim.keymap.set('n', '<Leader>mc', MiniMap.close)
		-- vim.keymap.set('n', '<Leader>mf', MiniMap.toggle_focus)
		-- vim.keymap.set('n', '<Leader>mo', MiniMap.open)
		-- vim.keymap.set('n', '<Leader>ms', MiniMap.toggle_side)
		-- vim.keymap.set('n', '<Leader>mt', MiniMap.toggle)
		end
	},
	-- on yank, highlights yanked text for a second
	"machakann/vim-highlightedyank",

	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
		require("hlchunk").setup({
			blank = {
				enable = false,
			}
		})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- Highlight hovered vairables (lsp compatible)
	"RRethy/vim-illuminate",
}
