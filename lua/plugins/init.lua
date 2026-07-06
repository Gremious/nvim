return {
	-- !! Important
	"michaelb/do-nothing.vim",
	-- lib other plugins use
	"nvim-lua/plenary.nvim",
	-- Auto disables treesitter and various other things on huge files
	'pteroctopus/faster.nvim',
	-- remaps . in a way that plugins can tap into it
	"tpope/vim-repeat",
	-- git
	"tpope/vim-fugitive",
	 -- git in gutter
	"airblade/vim-gitgutter",
	"nvim-tree/nvim-web-devicons",
	-- Dones't support neovide yet but works in kitty/wezterm
	{
		"3rd/image.nvim",
		build = false,
		opts = {
			processor = "magick_cli",
		}
	},
}
