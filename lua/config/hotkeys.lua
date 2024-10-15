local g = vim.g
-- Don't use nvim_set_keymap, it is the early interface and is not recommended
-- vim.keymap.set calls it with the appropriate arguments
local keymap = vim.keymap
local telescope = require("telescope.builtin")
local modes = require("consts").modes

-- Trouble nvim is very buggy.
keymap.set(modes.NORMAL, "<CR>", function()
	if vim.bo.buftype == "quickfix" then
		return "<CR>:bd#<CR>"
	else
		return "<CR>"
	end
end, {
	expr = true,
	silent = true,
	desc = "In quickfix list, replace the current buffer on enter instead of opening a new one.",
})

-- vim.g.maplocalleader = " "
keymap.set({ modes.NORMAL, modes.VISUAL_AND_SELECT }, "j", "gj", { desc = "Navigate down by visual line instead of text line." })
keymap.set({ modes.NORMAL, modes.VISUAL_AND_SELECT }, "k", "gk", { desc = "Navigate up by visual line instead of text line." })
keymap.set({ modes.NORMAL, modes.VISUAL_AND_SELECT }, "<C-s>", ":update<CR>", { silent = true, desc = "Ctrl+s to save." })
keymap.set({ modes.NORMAL }, "<leader>=", "m`va{==````", { desc = "Autoformat around current {} scope" })

keymap.set(modes.NORMAL, "<leader><esc>", ":noh<CR>", { silent = true, desc = "Clear search highlighting" })
keymap.set(modes.NORMAL, "<Leader>w", ":set list!<CR>", { desc = "Show whitespace."})

keymap.set(modes.NORMAL, "<Leader>u", ":GundoToggle<CR>")

-- keymap.set(modes.NORMAL, "<leader>P", function()
--     vim.cmd("Telescope projections")
-- end)

-- BufferLine
-- These commands will navigate through buffers in order
-- regardless of which mode you are using  e.g. if you change
-- the order of buffers :bnext and :bprevious will not respect the custom ordering
keymap.set(modes.NORMAL, "<right>", ":BufferLineCycleNext<CR>", { silent = true })
keymap.set(modes.NORMAL, "<left>", ":BufferLineCyclePrev<CR>", { silent = true })
keymap.set(modes.NORMAL, "<C-Right>", ":BufferLineMoveNext<CR>", { silent = true })
keymap.set(modes.NORMAL, "<C-Left>", ":BufferLineMovePrev<CR>", { silent = true })
keymap.set(modes.NORMAL, "<leader>bp", ":BufferLineTogglePin<CR>")
keymap.set(modes.NORMAL, "<leader>P", ":BufferLinePick<CR>")

keymap.set(modes.NORMAL, "<leader>bq", ":BD<CR>")
-- pop
keymap.set(modes.NORMAL, "<leader>p", ":BD<CR>")
keymap.set(modes.NORMAL, "<leader>wq", ":q<CR>")

keymap.set(modes.NORMAL, "<A-Right>", ":tabnext<CR>", { silent = true })
keymap.set(modes.NORMAL, "<A-Left>", ":tabprev<CR>", { silent = true })

keymap.set(modes.NORMAL, "<leader>gh", ":GitGutterPreviewHunk<cr>")
keymap.set(modes.NORMAL, "<leader>gu", ":GitGutterUndoHunk<cr>")
keymap.set(modes.NORMAL, "]g", ":GitGutterNextHunk<cr>")
keymap.set(modes.NORMAL, "[g", ":GitGutterPrevHunk<cr>")

-- keymap.set({ modes.NORMAL, modes.VISUAL }, "<Leader>hh", require("hop").hint_anywhere)
-- keymap.set({ modes.NORMAL, modes.VISUAL }, "<Leader>hp", require("hop").hint_patterns)
-- keymap.set({ modes.NORMAL, modes.VISUAL }, "<Leader>hw", require("hop").hint_words)
-- keymap.set({ modes.NORMAL, modes.VISUAL }, "<Leader>hl", require("hop").hint_lines_skip_whitespace)
-- keymap.set({ modes.NORMAL, modes.VISUAL }, "<Leader>hc", require("hop").hint_char1)

-- keymap.set({ modes.NORMAL, "x", "o" }, "s", "<Cmd>Svart<CR>") -- begin exact search
-- keymap.set({ modes.NORMAL, "x", "o" }, "S", "<Cmd>SvartRegex<CR>") -- begin regex search
-- keymap.set({ modes.NORMAL, "x", "o" }, "gs", "<Cmd>SvartRepeat<CR>") -- repeat with last accepted query

-- Move line up/down
keymap.set(modes.NORMAL, "<A-j>", ":m .+1<CR>==")
keymap.set(modes.NORMAL, "<A-k>", ":m .-2<CR>==")
keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
keymap.set(modes.VISUAL_AND_SELECT, "<A-j>", ":m '>+1<CR>gv=gv")
keymap.set(modes.VISUAL_AND_SELECT, "<A-k>", ":m '<-2<CR>gv=gv")

-- F11 to fullscreen
keymap.set(
	modes.NORMAL,
	"<F11>",
	":let g:neovide_fullscreen = (g:neovide_fullscreen == v:true) ? v:false : v:true<cr>",
	{ silent = true }
)

keymap.set(modes.VISUAL_AND_SELECT, "<leader>p", '"_dP', { desc = "repalce currently selected text with paste, without yanking it"})

keymap.set(modes.COMMAND, "<a-\\>", "<C-v>", { desc = "Escape next char." })
keymap.set(modes.COMMAND, "<C-v>", "<C-r>+", { desc = "Paste in command mode." })

keymap.set(modes.NORMAL, "<c-a>", "<Plug>CycleNext", { silent = true })
keymap.set(modes.VISUAL_AND_SELECT, "<c-a>", "<Plug>CycleNext", { silent = true })
keymap.set(modes.NORMAL, "<c-x>", "<Plug>CyclePrev", { silent = true })
keymap.set(modes.VISUAL_AND_SELECT, "<c-x>", "<Plug>CyclePrev", { silent = true })
keymap.set(modes.NORMAL, "<Plug>CycleFallbackNext", "<C-a>", { silent = true })
keymap.set(modes.NORMAL, "<Plug>CycleFallbackPrev", "<C-x>", { silent = true })

-- Semicolon at EOL
-- nnoremap <leader>; <C-v>$A;<Esc>
keymap.set(modes.NORMAL, "<Leader>;", "<Plug>(cosco-commaOrSemiColon)", { silent = true })

keymap.set(modes.NORMAL, "<leader>{", ":TSJSplit<cr>")
keymap.set(modes.NORMAL, "<leader>}", ":TSJJoin<cr>")

-- local easy_opts = { silent = true, remap = false }
-- trigger easy-action.
-- keymap.set(modes.NORMAL, "<leader>e", "<cmd>BasicEasyAction<cr>", easy_opts)

-- To insert something and jump back after you leave the insert mode
-- keymap.set(modes.NORMAL, "<leader>ei", function()
	-- require("easy-action").base_easy_action("i", nil, "InsertLeave")
-- end, easy_opts)

function ChangeScaleFactor(delta)
	g.neovide_scale_factor = g.neovide_scale_factor * delta
end
keymap.set(modes.NORMAL, "<C-Up>", function()
	ChangeScaleFactor(1.25)
end)
keymap.set(modes.NORMAL, "<C-Down>", function()
	ChangeScaleFactor(1 / 1.25)
end)


-- Show currently hovered texts' highlight group for colorscheme fixups
-- vim.api.nvim_exec(
-- [[
-- map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
-- \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
-- \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
-- ]],
-- true)

-- == spellcheck-mode ==
keymap.set(modes.NORMAL, "<Leader>sc", ":set spell!<CR>", { silent = true })
--toggle suggestions
keymap.set(modes.NORMAL, "<Leader>s", "z=", { silent = true })
keymap.set(modes.NORMAL, "<Leader><C-s>", "z=", { silent = true })
keymap.set(modes.NORMAL, "<Leader>sl", "]s", { silent = true })
keymap.set(modes.NORMAL, "<Leader>sh", "[s", { silent = true })
keymap.set(modes.NORMAL, "<Leader>sL", "]S", { silent = true })
keymap.set(modes.NORMAL, "<Leader>sH", "[S", { silent = true })
-- Spell-add
keymap.set(modes.NORMAL, "<Leader>sa", "zg", { silent = true })
-- ==/ spellcheck mode /==

-- keymap.set(modes.INSERT, "<Tab>", function() luasnip.expand_or_jump() end, {silent = true, noremap = false})
-- keymap.set(modes.INSERT, "<S-Tab>", function() luasnip.jump(-1) end, {silent = true})
--
-- keymap.set(modes.SELECT, "<Tab>", function() luasnip.jump(1) end, {silent = true})
-- keymap.set(modes.SELECT, "<S-Tab>", function() luasnip.jump(-1) end, {silent = true})

-- keymap.set({modes.INSERT, modes.SELECT}, "<C>", function()
	-- if luasnip.choice_active() then
		-- luasnip.change_choice(1)
	-- end
-- end, {silent = true})


-- keymap.set({modes.INSERT, modes.SELECT, modes.NORMAL}, "<leader>p", function()
	-- -- print(vim.inspect(require("cmp").get_active_entry()))
	-- print(vim.inspect(require("cmp").get_active_entry() == nil))
-- end)
