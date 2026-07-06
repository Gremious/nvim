-- To customize the syntax highlighting of a capture, simply define or link a highlight group of the same name:
-- -- Highlight the @foo.bar capture group with the "Identifier" highlight group
-- vim.api.nvim_set_hl(0, "@foo.bar", { link = "Identifier" })
return {
	{
	-- You must install tree-sitter-cli on your actual OS
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	branch = 'main',
	build = ':TSUpdate',
	config = function ()
		require("nvim-treesitter").setup({
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"mermaid",
				"latex",

				"rust",
				"toml",
				"ron",

				"css",
				"html",
				"javascript",

				"json",
				"json5",
				"yaml",
				"xml",

				"bash",
		})
	end
  },
  --   -- treesitter debug
  --   "nvim-treesitter/playground",
}
