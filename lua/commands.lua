local api, cmd = vim.api, vim.cmd
local env = vim.env

function create_command(name, fn)
	api.nvim_create_user_command(name, fn, {})
end

function open_config_file(file)
	api.nvim_command(cmd.edit(vim.env.CONFIG .. "/" .. file))
end

-- Type config -> get config
-- Todo: Telescope!?!?!
create_command("Config",         function() open_config_file("init.lua") end)
create_command("ConfigPacker",   function() open_config_file("lua/plugin_install.lua") end)
create_command("ConfigPlugins",  function() open_config_file("lua/plugin_settings.lua") end)
create_command("ConfigLsp",      function() open_config_file("lua/lsp.lua") end)
create_command("ConfigCommands", function() open_config_file("lua/commands.lua") end)
create_command("ConfigHotkeys",  function() open_config_file("lua/hotkeys.lua") end)
create_command("ConfigAutocmd",  function() open_config_file("lua/autocmd.lua") end)

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
