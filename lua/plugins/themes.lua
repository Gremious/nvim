return {
	-- TODO: would be cool to have live telesacope swithcer, 
	-- but just for these selected themes
	-- and also there's a plugin for per project themes
	"Yazeed1s/minimal.nvim",
	"Yazeed1s/oh-lucy.nvim",
	{ 
		'RRethy/base16-nvim',
		-- config = function()
		--     require('matugen').setup()
		-- end,
	},
	-- Actually funcitonal pywal
	"sonjiku/yawnc.nvim",
	{
		"franbach/miramare",
		config = function()
			vim.g.miramare_enable_italic = false
			vim.g.miramare_disable_italic_comment = true
		end,
	},
	{
		"kaicataldo/material.vim",
		config = function()
			vim.g.material_theme_style = "ocean"
			vim.g.material_terminal_italics = true
		end,
	},
	{
		"sainnhe/sonokai",
		config = function()
			-- vim.g.sonokai_style = "default"
			-- vim.g.sonokai_style = "atlantis"
			-- vim.g.sonokai_style = 'andromeda'
			-- vim.g.sonokai_style = "shusia"
			vim.g.sonokai_style = "maia"
			-- vim.g.sonokai_style = "espresso"
			-- vim.g.sonokai_better_performance = 1
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			-- vim.g.catppuccin_flavour  = "latte"
			-- vim.g.catppuccin_flavour  = "frappe"
			-- vim.g.catppuccin_flavour  = "mocha"
			vim.g.catppuccin_flavour  = "mocha"
		end,
	},
	{ "embark-theme/vim", name = "embark" },
	{ "rose-pine/neovim", name = "rose-pine" },
}
