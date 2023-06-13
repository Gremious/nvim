-- You can always call :Telescope keymap to see all keymaps

local g = vim.g
local keymap = vim.keymap

-- vim.g.maplocalleader = " "

-- Navigage by visual line instead of text line
keymap.set({ "n", "v" }, "j", "gj")
keymap.set({ "n", "v" }, "k", "gk")

-- Ctrl+S to save
keymap.set("n", "<C-S>", ":update<CR>", { silent = true })

keymap.set("n", "<Leader>u", ":GundoToggle<CR>")

-- show white space
keymap.set("n", "<Leader>w", ":set list!<CR>")

-- == spellcheck-mode ==
keymap.set("n", "<Leader>ss", ":set spell!<CR>", { silent = true })
--toggle suggestions
keymap.set("n", "<Leader>s", "z=", { silent = true })
keymap.set("n", "<Leader><C-s>", "z=", { silent = true })
keymap.set("n", "<Leader>sl", "]s", { silent = true })
keymap.set("n", "<Leader>sh", "[s", { silent = true })
keymap.set("n", "<Leader>sL", "]S", { silent = true })
keymap.set("n", "<Leader>sH", "[S", { silent = true })
-- Spell-add
keymap.set("n", "<Leader>sa", "zg", { silent = true })
-- ==/ spellcheck mode /==

-- Clear search highlighting
keymap.set("n", "<leader><esc>", ":noh<CR>", { silent = true })

-- insert mode undo
keymap.set("i", "<C-z>", "<C-o>u")
-- insert mode redo
keymap.set("i", "<C-r>", "<C-o><C-r>")

vim.keymap.set("n", "<Leader>rg", function()
	require("telescope.builtin").grep_string()
end)
vim.keymap.set("n", "<Leader>f", function()
	require("telescope.builtin").grep_string({ search = "" })
end)
vim.keymap.set("n", "<Leader>F", function()
	require("telescope.builtin").find_files()
end)

-- BufferLine
-- " These commands will navigate through buffers in order
-- " regardless of which mode you are using  e.g. if you change
-- " the order of buffers :bnext and :bprevious will not respect the custom ordering
keymap.set("n", "<right>", ":BufferLineCycleNext<CR>", { silent = true })
keymap.set("n", "<left>", ":BufferLineCyclePrev<CR>", { silent = true })

-- " These commands will move the current buffer backwards or forwards in the bufferline
keymap.set("n", "<C-Right>", ":BufferLineMoveNext<CR>", { silent = true })
keymap.set("n", "<C-Left>", ":BufferLineMovePrev<CR>", { silent = true })
keymap.set("n", "<A-Right>", ":tabnext<CR>", { silent = true })
keymap.set("n", "<A-Left>", ":tabprev<CR>", { silent = true })
keymap.set("n", "<leader>p", ":BufferLineTogglePin<CR>")
keymap.set("n", "<leader>ht", ":BufferLinePick<CR>")

-- TODO: Make fn, try find file, if you did - find file toggle. If not - find file toggle but in current dir .
keymap.set("n", "<leader><tab>", ":NvimTreeFindFileToggle <cr>", { silent = true })
-- keymap.set("n", "<leader><tab>", ":NvimTreeFindFileToggle . <cr>", { silent = true })

keymap.set("n", "<leader>gh", ":GitGutterPreviewHunk<cr>")
keymap.set("n", "<leader>gu", ":GitGutterUndoHunk<cr>")
keymap.set("n", "]<leader>g", ":GitGutterNextHunk<cr>")
keymap.set("n", "[<leader>g", ":GitGutterPrevHunk<cr>")

-- keymap.set({ "n", "v" }, "<Leader>hh", require("hop").hint_anywhere)
-- keymap.set({ "n", "v" }, "<Leader>hp", require("hop").hint_patterns)
-- keymap.set({ "n", "v" }, "<Leader>hw", require("hop").hint_words)
-- keymap.set({ "n", "v" }, "<Leader>hl", require("hop").hint_lines_skip_whitespace)
-- keymap.set({ "n", "v" }, "<Leader>hc", require("hop").hint_char1)

keymap.set({ "n", "x", "o" }, "s", "<Cmd>Svart<CR>")        -- begin exact search
keymap.set({ "n", "x", "o" }, "S", "<Cmd>SvartRegex<CR>")   -- begin regex search
keymap.set({ "n", "x", "o" }, "gs", "<Cmd>SvartRepeat<CR>") -- repeat with last accepted query

-- Move line up/down
keymap.set("n", "<A-j>", ":m .+1<CR>==")
keymap.set("n", "<A-k>", ":m .-2<CR>==")
keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- F11 to fullscreen
-- nnoremap  <F11> :let g:neovide_fullscreen = (g:neovide_fullscreen == v:true, { silent = true }) ? v:false : v:true<cr>
keymap.set(
	"n",
	"<F11>",
	":let g:neovide_fullscreen = (g:neovide_fullscreen == v:true) ? v:false : v:true<cr>",
	{ silent = true }
)

-- replace currently selected text with default register
-- without yanking it
keymap.set("v", "<leader>p", '"_dP')

keymap.set("n", "<leader>:", ":Telescope commands<cr>")
keymap.set("c", "<C-v>", "<C-r>+")

function ChangeScaleFactor(delta)
	g.neovide_scale_factor = g.neovide_scale_factor * delta
end

keymap.set("n", "<C-Up>", function()
	ChangeScaleFactor(1.25)
end)
keymap.set("n", "<C-Down>", function()
	ChangeScaleFactor(1 / 1.25)
end)

keymap.set("n", "<c-a>", "<Plug>CycleNext", { silent = true })
keymap.set("v", "<c-a>", "<Plug>CycleNext", { silent = true })
keymap.set("n", "<c-x>", "<Plug>CyclePrev", { silent = true })
keymap.set("v", "<c-x>", "<Plug>CyclePrev", { silent = true })
keymap.set("n", "<Plug>CycleFallbackNext", "<C-a>", { silent = true })
keymap.set("n", "<Plug>CycleFallbackPrev", "<C-x>", { silent = true })

-- Semicolon at EOL
-- nnoremap <leader>; <C-v>$A;<Esc>
keymap.set("n", "<Leader>;", "<Plug>(cosco-commaOrSemiColon)", { silent = true })

keymap.set("n", "<leader>P", function()
	vim.cmd("Telescope projections")
end)

keymap.set("n", "<leader>{", ":TSJSplit<cr>")
keymap.set("n", "<leader>}", ":TSJJoin<cr>")

local easy_opts = { silent = true, remap = false }
-- trigger easy-action.
keymap.set("n", "<leader>e", "<cmd>BasicEasyAction<cr>", easy_opts)

-- To insert something and jump back after you leave the insert mode
keymap.set("n", "<leader>ei", function()
	require("easy-action").base_easy_action("i", nil, "InsertLeave")
end, easy_opts)

-- Show currently hovered texts' highlight group for colorscheme fixups
-- vim.api.nvim_exec(
-- [[
-- map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
-- \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
-- \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
-- ]],
-- true)
