return {
	{
		-- undo tree
		-- need to run:
		-- python -m pip install --user --upgrade pynvim
		"sjl/gundo.vim",
		config = function()
		-- GUNDO breaks without python3
		if vim.fn.has("python3") then
			vim.g.gundo_prefer_python3 = 1
			end
			end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
				require("flash").jump({
					search = { forward = true, wrap = false, multi_window = true },
				})
				end,
				desc = "Flash forwards only.",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
				require("flash").jump({
					search = { forward = false, wrap = false, multi_window = true },
				})
				end,
				desc = "Flash backwards only",
			},
			{ "<leader>r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "<leader>R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
	},
}
