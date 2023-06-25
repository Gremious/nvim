local api, cmd = vim.api, vim.cmd
local env = vim.env
local telescope = require("telescope.builtin")

local function create_command(name, fn)
	api.nvim_create_user_command(name, fn, {})
end

local function open_config_file(file)
	api.nvim_command(cmd.edit(vim.fn.stdpath("config") .. "/" .. file))
end

-- Type config -> get config
create_command("Config", function()
	open_config_file("init.lua")
end)
create_command("ConfigSearch", function()
	require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end)

-- Replicate :Rg command with telescope
vim.api.nvim_create_user_command("Rg", function(args)
	telescope.grep_string({ search = args.fargs[1], use_regex = true })
end, { nargs = "?" })

create_command("RG", function()
	telescope.live_grep()
end)

-- kinda cool if you install dressing.nvim?
-- Asks for the regex in the lil pop-up pompt
-- local function grep_string()
--     vim.g.grep_string_mode = true
--     vim.ui.input({ prompt = 'Grep string', default = vim.fn.expand("<cword>") },
--     function(value)
--         if value ~= nil then
--             require('telescope.builtin').grep_string({ search = value })
--         end
--         vim.g.grep_string_mode = false
--     end)
-- end

-- Reload config: ":so $MYVIMRC"
-- create_command("Reload", function() vim.api.nvim_command(vim.cmd.source(vim.env.MYVIMRC)) end)
-- doesn't work, probably wanna do
-- https://stackoverflow.com/a/72504767

-- command Cc     :let @+ = expand("%:p")
-- Copy filepath to clipboard
-- create_command("Cc",
--	function(opts)
--		vim.api.nvim_command(vim.cmd.source(vim.env.MYVIMRC))
--	end
-- )
