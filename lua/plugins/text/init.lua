return {
	{
		-- Toggle comments
		"scrooloose/nerdcommenter",
		config = function()
		vim.g.NERDDefaultAlign = 'left'
		vim.g.NERDCreateDefaultMappings = true
		vim.g.NERDSpaceDelims = true
		vim.g.NERDTrimTrailingWhitespace = true
		vim.g.NERDCustomDelimiters = {
			ZenScript = {
				left = "//",
			}
		}
		end,
	},
	"godlygeek/tabular", -- Tab/Spaces aligner

	-- 	{
	-- 		-- rainbow brackets
	-- 		"HiPhish/rainbow-delimiters.nvim",
	-- 		dependencies = {
	-- 			"nvim-treesitter/nvim-treesitter",
	-- 			-- For whatever reason, this plugin resets it's hl groups
	-- 			-- on color scheme load
	-- 			-- so we depend on theme here and then can set the hl groups
	-- 			-- (or i guess our theme can depend on this and set them)
	-- 			"kaicataldo/material.vim",
	-- 		},
	-- 		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
	-- 		config = function()
	-- 		-- vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#FF0000", force = true })
	-- 		-- vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#FF0000", force = true })
	-- 		-- vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#FF0000", force = true })
	-- 		-- vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#FF0000", force = true })
	-- 		-- vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#FF0000", force = true })
	-- 		-- vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#FF0000", force = true })
	-- 		-- vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#FF0000", force = true })
	-- 		end,
	-- 	},
	{
		-- Highlights TODO/INFO/etc.
		"folke/todo-comments.nvim",
		opts = {
			keywords = {
				TODO = { icon = " ", color = "warning" },
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		lazy = false,
		config = function()
		require("textcase").setup({
			prefix = "<leader>tc"
		})
		require("telescope").load_extension("textcase")
		end,
		keys = {
			"<leader>tc",
			--Prefix for the default builting keymaps
			{ "<leader>tc.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
		},
	},
	-- surround things with any text
	"tpope/vim-surround",
	-- stuff like `da, (around commas)`, `cin) (next paren)`
	"wellle/targets.vim",
	{
		-- Auto-trim trailing whitespace on :write
		"zakharykaplan/nvim-retrail",
		lazy = false,
		main = "retrail",
	},
}
