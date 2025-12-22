-- To customize the syntax highlighting of a capture, simply define or link a highlight group of the same name:
-- -- Highlight the @foo.bar capture group with the "Identifier" highlight group
-- vim.api.nvim_set_hl(0, "@foo.bar", { link = "Identifier" })
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
  },
--   -- treesitter debug
--   "nvim-treesitter/playground",
  {
    "nushell/tree-sitter-nu",
    build = ":TSUpdate nu",
  },
}
