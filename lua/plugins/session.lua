local vim_options = vim.opt
vim_options.sessionoptions:append("localoptions") -- Save localoptions to session file
vim_options.sessionoptions:append("winpos") -- Save winpos to session file

return {
	-- TODO: Telescope provides this, maybe use that instead. Perhaps without a preview cause confusing?
	-- though it doesn't seem to sort them the same idk needs testing
	"yegappan/mru",
	{
		"olimorris/persisted.nvim",
		lazy = false,
		config = function()
		require("persisted").setup({
			autosave = true,
			autoload = true,
			allowed_dirs = {
				"/home/gremious/Programming",
				"/home/gremious/dev/",
				"/home/gremious/.config",
				"/home/gremious/.dotfiles",
			},
			-- ignored_dirs = {
			-- "/tmp",
			-- { "/home/gremious", exact = true },
			-- },
		})
		require("telescope").load_extension("persisted")
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
}
