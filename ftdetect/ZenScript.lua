vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = "*.zs",
  callback = function()
    vim.bo.filetype = 'ZenScript'
  end
})
