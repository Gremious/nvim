local opt = vim.opt
local g = vim.g

g.rainbow_active = 1
opt.termguicolors = true -- 24-bit colors

---@diagnostic disable: unused-local,unused-function
local function material()
	g.material_theme_style = "ocean"
	g.material_terminal_italics = true
	vim.cmd("colorscheme material")
end

---@diagnostic disable: unused-local,unused-function
local function catppuccin()
	-- g.catppuccin_flavour  = "latte"
	-- g.catppuccin_flavour  = "frappe"
	-- g.catppuccin_flavour  = "mocha"
	g.catppuccin_flavour  = "mocha"
	vim.cmd('colorscheme catppuccin')
end

---@diagnostic disable: unused-local,unused-function
local function sonokai()
	-- g.sonokai_style = "default"
	-- g.sonokai_style = "atlantis"
	-- g.sonokai_style = 'andromeda'
	-- g.sonokai_style = "shusia"
	g.sonokai_style = "maia"
	-- g.sonokai_style = "espresso"
	-- g.sonokai_better_performance = 1
	vim.cmd("colorscheme sonokai")
end

---@diagnostic disable: unused-local,unused-function
local function miramare()
	g.miramare_enable_italic = false
	g.miramare_disable_italic_comment = true
	vim.cmd("colorscheme miramare")
end

-- material()

--  Update  hl group:  may not work here, try in the end of an init.lua
-- local current_def = vim.api.nvim_get_hl(0, { name = "Comment" })
-- local new_def = vim.tbl_extend('force', current_def, { nocombine = true , cterm = { nocombine = true }})
-- vim.api.nvim_set_hl(0, "Comment", new_def)

-- vim.cmd('colorscheme oh-lucy-evening')
-- vim.cmd("colorscheme oh-lucy")
-- vim.cmd("colorscheme tokyodark")
-- vim.cmd[[colorscheme minimal-base16]]
-- vim.cmd("colorscheme minimal")
-- colorscheme wal -- doesn"t seem to work with neovide very sad :c

-- Moose's config
-- vim.cmd([[
-- set background=dark
-- colorscheme base16-eighties
--
-- highlight Search guibg=#3f3f3f guifg=#ffcc66
-- highlight IndentBlanklineIndent1 guibg=#2d2d2d gui=nocombine
-- highlight IndentBlanklineIndent2 guibg=#343434 gui=nocombine
-- highlight IndentBlankLineContextStart guibg=#343434
-- hi SpellCap gui=none guifg=none guibg=#2f4f2f
-- hi SpellBad gui=bold guifg=none guibg=#4f2f2f
--
-- hi link @storageclass.lifetime Special
-- hi @field guifg=#f2777a " base16 08
-- hi Identifier guifg=#d3d0c8 guibg=NONE ctermbg=NONE " base16 05
-- hi @namespace guifg=#a09f93 " base16 04
-- hi link @variable.builtin Constant
--
-- hi link @lsp.type.namespace @namespace
-- hi link @lsp.type.struct TypeDef
-- hi link @lsp.type.enum TypeDef
-- hi link @lsp.type.interface TypeDef
-- hi link @lsp.type.property @field
-- hi link @lsp.typemod.variable.static Constant
--
-- ]])
