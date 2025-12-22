return {
	-- !! Important
	"michaelb/do-nothing.vim",
	-- lib other plugins use
	"nvim-lua/plenary.nvim",
	-- Auto disables treesitter and various other things on huge files
	'pteroctopus/faster.nvim',
	-- Pretty windows for things that use vim.ui like rust-tools
	-- Immediately nicer for lsp rename
	-- Every plugin that uses vim.ui will basically use
	-- ether pretty windows or telescope automatically
	"stevearc/dressing.nvim",
	"nvim-tree/nvim-web-devicons",
	-- remaps . in a way that plugins can tap into it
	"tpope/vim-repeat",
	-- git
	"tpope/vim-fugitive",
	 -- git in gutter
	"airblade/vim-gitgutter",
	-- most recently used files
}
