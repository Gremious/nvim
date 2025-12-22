local vim_options = vim.opt
local vim_global = vim.g
local vim_api = vim.api

if vim.fn.has("win32") == 1 then
	vim.env.CONFIG = vim.env.LOCALAPPDATA .. "\\nvim"
	-- " Fixes fzf preview
	vim.env.PATH = "C:\\Program Files\\Git\\usr\\bin;" .. vim.env.path

	-- Default to unix, but auto-detect if file is in dos already.
	-- If you don't add "dos" - it will error every time you open vim help
	vim_options.fileformats = "unix,dos"

	-- opt.backupdir = vim.env.CONFIG .. "\\backup"
	vim_options.backupdir = "C:\\Users\\Gremious\\.cache\\nvim\\backup"

	-- font names are weird, you can set guifont=* to list them but only on win/mac
	-- opt.guifont = "JetBrainsMono_Nerd_Font_Mono:h14"
	-- opt.guifont = "Twilio Sans Mono,Segoe_UI_Emoji:h14"
	vim_options.guifont = "FiraCode Nerd Font Mono,Segoe_UI_Emoji:h14"
else
	vim_options.backup = true
	-- The FHS 3 compliant place on linux, explicitly for editors too
	-- https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch05s08.html#varliblteditorgtEditorBackupFilesAn
	-- Might wanna own those dirs or something though.
	vim_options.backupdir = "/var/lib/nvim/backup"
	vim_options.directory = "/var/lib/nvim/swap"
	vim_options.undodir = "/var/lib/nvim/undo"

	vim_options.guifont = "FiraCode Nerd Font Mono,Noto Color Emoji:h14"
	-- opt.guifont = "Adwaita Mono,Noto Color Emoji:h12"
end

if vim_global.neovide then
	require("neovide")
end

vim_global.mapleader = " "

vim_global.rainbow_active = 1
-- Full 24-bit colors
vim_options.termguicolors = true

-- Should be per project
vim_options.expandtab = false
vim_options.tabstop = 4
vim_options.shiftwidth = 4
vim_options.softtabstop = 4

-- if vim.fn.hostname() == "gremy-work-linux" then
-- 	vim_options.shiftwidth= 4
-- 	vim_options.smarttab = true
-- 	vim_options.expandtab = true
-- 	vim_options.tabstop = 8
-- 	vim_options.softtabstop = 0
-- else
-- 	vim_options.expandtab = false
-- 	vim_options.tabstop = 4
-- 	vim_options.shiftwidth = 4
-- 	vim_options.softtabstop = 4
-- end

--characters to use when displaying whitespace
vim_options.listchars = "space:·,tab:>=,trail:·,extends:»,precedes:«,eol:↴"
-- Longer command history
vim_options.history = 1000
-- More undo levels
vim_options.undolevels = 1000
-- Persistent undo between sessions
vim_options.undofile = true
-- Don't redraw in macros
vim_options.lazyredraw = true
-- Don't syntax past 500 char in a single-line (think minified code)
vim_options.synmaxcol = 500
-- Minimum number of lines to keep above and below cursor
vim_options.scrolloff = 15
-- How many ms to wait after typing stops to save file/run plugins updates/etc. Default is 4000.
vim_options.updatetime = 100
-- Show line numbers
vim_options.number = true
-- Line numbers are relative to cursor
vim_options.relativenumber = true
-- highlight current line
vim_options.cursorline = true
-- matching brackets while typing
vim_options.showmatch = true
-- add angle brackets to % matching
vim_options.matchpairs:append({ "<:>" })
-- Wrapped lines will wrap at breaks not mid-word
vim_options.linebreak = true
--new vertical split will be below
vim_options.splitbelow = true
--new horizontal split will be to the right
vim_options.splitright = true
-- diffs are also vertical
vim.opt.diffopt:append({ "vertical" })
--wrap comments, never autowrap long lines
-- see :h fo-table
vim_options.formatoptions = "crqlj"
-- more space for displaying messages
vim_options.cmdheight = 2
-- always show signcolumn (column near number line)
vim_options.signcolumn = "yes"
-- don't auto-highlight last search on new session
vim.cmd("noh")
-- Disable mouse, enabled by default in vim 0.8.
vim_options.mouse = ""
vim_options.clipboard:append({ "unnamed,unnamedplus" })
vim_options.nrformats:remove({ "octal" })
-- Allow left and right arrow to move the cursor left/right to the next line
-- When at the end of a line
vim_options.whichwrap = "<>"
-- only care about case in search if there are upper-case letters, needs ignorecase
vim_options.smartcase = true
-- ^ remove case check in search
vim_options.ignorecase = true
-- Enables project-local configuration. Nvim will execute any .nvim.lua,
-- .nvimrc, or .exrc file found in the current-directory and all parent
-- directories (ordered upwards), if the files are in the trust list.
-- Use :trust to manage trusted files. See also vim.secure.read().
vim_options.exrc = true;

require("plugin_manager")

-- require("config.theme")
-- require("config.functions")
-- require("config.commands")
-- require("config.hotkeys")
-- require("config.autocmd")

require("colorscheme")

vim.cmd [[
	hi link @lsp.type.builtinType.rust Type
	hi link @lsp.type.selfKeyword.rust Constant
	hi link @lsp.type.namespace @namespace
	hi link @lsp.type.macro Macro
	hi link @lsp.type.variable.rust @lsp
	hi link @variable.rust Identifier
	hi link @variable.parameter.rust Identifier
	hi link @lsp.type.parameter.rust @lsp
	hi link @module.rust @lsp
	hi link @variable.member.rust Identifier
]]
