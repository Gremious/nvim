local opt = vim.opt
local g = vim.g

g.rainbow_active = 1
opt.termguicolors = true -- 24-bit colors
-- g.catppuccin_flavour  = "mocha"
-- vim.cmd('colorscheme catppuccin')

g.miramare_enable_italic = false
g.miramare_disable_italic_comment = true
-- vim.cmd("colorscheme miramare")

g.material_theme_style = "ocean"
g.material_terminal_italics = true

-- vim.cmd("colorscheme material")
-- vim.cmd('colorscheme tokyonight-night')
-- vim.cmd('colorscheme oh-lucy-evening')
vim.cmd("colorscheme oh-lucy")
-- vim.cmd[[colorscheme minimal-base16]]
-- vim.cmd("colorscheme minimal")

-- colorscheme wal -- doesn"t seem to work with neovide very sad :c
