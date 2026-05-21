vim.opt.sessionoptions:append("localoptions") -- Save localoptions to session file
vim.opt.sessionoptions:append("winpos") -- Save winpos to session file

return {
	-- TODO: Telescope provides mru, maybe use that instead. Perhaps without a preview cause confusing?
	-- though it doesn't seem to sort them the same idk needs testing

	-- most recently used files
	"yegappan/mru",
	{
		"windwp/nvim-projectconfig",
		config = function()
			require('nvim-projectconfig').setup({})
		end
	},
}
