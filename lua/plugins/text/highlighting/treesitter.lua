-- To customize the syntax highlighting of a capture, simply define or link a highlight group of the same name:
-- -- Highlight the @foo.bar capture group with the "Identifier" highlight group
-- vim.api.nvim_set_hl(0, "@foo.bar", { link = "Identifier" })
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
	branch = 'master',
    build = ':TSUpdate',
	main = "nvim-treesitter.configs",
	config = function ()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"mermaid",

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
				"nu",
			},
		})
	end
  },
  {
    "nushell/tree-sitter-nu",
    build = ":TSUpdate nu",
  },
  --   -- treesitter debug
  --   "nvim-treesitter/playground",
}
