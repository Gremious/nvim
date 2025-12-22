return {
	{
		-- TODO: Remove diagnostics from lsp-status cause lualine already shows them.
		-- go to lsp status and check their config i think they updated
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			extensions = { "nvim-tree", "fugitive", "nvim-dap-ui", "quickfix" },
			sections = {
				lualine_c = {
					{
						'filename',
						path = 1
					}
				},
				lualine_x = {
					function()
					return require('lsp-progress').progress()
					end,
					-- "encoding",
					-- "fileformat",
					"filetype",
				},
			},
		},
	}
}
