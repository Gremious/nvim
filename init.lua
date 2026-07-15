local vim_global = vim.g
local vim_api = vim.api

if vim.fn.has("win32") == 1 then
	vim.env.CONFIG = vim.env.LOCALAPPDATA .. "\\nvim"
	-- " Fixes fzf preview
	vim.env.PATH = "C:\\Program Files\\Git\\usr\\bin;" .. vim.env.path

	-- Default to unix, but auto-detect if file is in dos already.
	-- If you don't add "dos" - it will error every time you open vim help
	vim.opt.fileformats = "unix,dos"

	-- opt.backupdir = vim.env.CONFIG .. "\\backup"
	vim.opt.backupdir = "C:\\Users\\Gremious\\.cache\\nvim\\backup"

	-- font names are weird, you can set guifont=* to list them but only on win/mac
	-- opt.guifont = "JetBrainsMono_Nerd_Font_Mono:h14"
	-- opt.guifont = "Twilio Sans Mono,Segoe_UI_Emoji:h14"
	vim.opt.guifont = "FiraCode Nerd Font Mono,Segoe_UI_Emoji:h14"
else
	vim.opt.backup = true
	-- The FHS 3 compliant place on linux, explicitly for editors too
	-- https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch05s08.html#varliblteditorgtEditorBackupFilesAn
	-- Might wanna own those dirs or something though.
	vim.opt.backupdir = "/var/lib/nvim/backup"
	vim.opt.directory = "/var/lib/nvim/swap"
	vim.opt.undodir = "/var/lib/nvim/undo"

	vim.opt.guifont = "FiraCode Nerd Font Mono,Noto Color Emoji:h14"
	-- opt.guifont = "Adwaita Mono,Noto Color Emoji:h12"
end

if vim_global.neovide then
	require("neovide")
end

vim_global.mapleader = " "

vim_global.rainbow_active = 1
-- Full 24-bit colors
vim.opt.termguicolors = true

--characters to use when displaying whitespace
vim.opt.listchars = "space:·,tab:>=,trail:·,extends:»,precedes:«,eol:↴"
-- Longer command history
vim.opt.history = 1000
-- More undo levels
vim.opt.undolevels = 1000
-- Persistent undo between sessions
vim.opt.undofile = true
-- Don't redraw in macros
vim.opt.lazyredraw = true
-- Don't syntax past 500 char in a single-line (think minified code)
vim.opt.synmaxcol = 500
-- Minimum number of lines to keep above and below cursor
vim.opt.scrolloff = 15
-- How many ms to wait after typing stops to save file/run plugins updates/etc. Default is 4000.
vim.opt.updatetime = 100
-- Show line numbers
vim.opt.number = true
-- Line numbers are relative to cursor
vim.opt.relativenumber = true
-- highlight current line
vim.opt.cursorline = true
-- matching brackets while typing
vim.opt.showmatch = true
-- add angle brackets to % matching
vim.opt.matchpairs:append({ "<:>" })
-- Wrapped lines will wrap at breaks not mid-word
vim.opt.linebreak = true
--new vertical split will be below
vim.opt.splitbelow = true
--new horizontal split will be to the right
vim.opt.splitright = true
-- diffs are also vertical
vim.opt.diffopt:append({ "vertical" })
--wrap comments, never autowrap long lines
-- see :h fo-table
vim.opt.formatoptions = "crqlj"
-- more space for displaying messages
vim.opt.cmdheight = 2
-- always show signcolumn (column near number line)
vim.opt.signcolumn = "yes"
-- don't auto-highlight last search on new session
vim.cmd("noh")
-- Disable mouse, enabled by default in vim 0.8.
vim.opt.mouse = ""
vim.opt.clipboard:append({ "unnamed,unnamedplus" })
vim.opt.nrformats:remove({ "octal" })
-- Allow left and right arrow to move the cursor left/right to the next line
-- When at the end of a line
vim.opt.whichwrap = "<>"
-- only care about case in search if there are upper-case letters, needs ignorecase
vim.opt.smartcase = true
-- ^ remove case check in search
vim.opt.ignorecase = true
-- Enables project-local configuration. Nvim will execute any .nvim.lua,
-- .nvimrc, or .exrc file found in the current-directory and all parent
-- directories (ordered upwards), if the files are in the trust list.
-- Use :trust to manage trusted files. See also vim.secure.read().
vim.opt.exrc = true;

local at_work = vim.uv.os_gethostname() == "gremy-work-linux";
-- at work they use spaces
vim.opt.expandtab = at_work

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- If your indentation is scuffed consider:
-- 1. vim_global.rust_recommended_style = false (put it in lsp init)
-- 2. after/ftplugin/{set filetype?}.lua
vim.cmd("filetype indent on")
vim.cmd("filetype plugin on")

require("plugin_manager")

require("hotkeys")
require("commands")
require("autocmd")
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

