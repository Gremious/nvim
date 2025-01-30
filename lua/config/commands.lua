local api, cmd = vim.api, vim.cmd
local env = vim.env
local telescope = require("telescope.builtin")

local num_args = {
	NONE = "0",
	ANY = "*",
	EXACTLY_ONE = "1",
	ZERO_OR_ONE = "?",
	AT_LEAST_ONE = "+",
}

local function create_command(name, fn)
	api.nvim_create_user_command(name, fn, {})
end

local function open_config_file(file)
	api.nvim_command(cmd.edit(vim.fn.stdpath("config") .. "/" .. file))
end

-- Type config -> get config
-- create_command("Config", function()
	-- open_config_file("init.lua")
-- end)

create_command("Config", function()
	telescope.find_files({ cwd = vim.fn.stdpath("config") })
end)

-- Replicate :Rg command with telescope
api.nvim_create_user_command("Rg", function(args)
	telescope.grep_string({ search = args.fargs[1], use_regex = true })
end, { nargs = num_args.ZERO_OR_ONE })

create_command("RG", function(args)
	-- cmd_args = args.fargs;
	-- { search_dirs = { cmd_args[1] } }
	telescope.live_grep()
end, { nargs = num_args.ZERO_OR_ONE })

-- Copy filepath to clipboard
create_command("Cc", function()
	-- command Cc     :let @+ = expand("%:p")
end)

create_command("BufferLineCloseAllButCurrentOrPinned", function ()
  local bufferline = require("bufferline")
  local commands = require("bufferline.commands")

  local current = api.nvim_get_current_buf()
  vim.schedule(function()
    for _, e in ipairs(bufferline.get_elements().elements) do
      local is_current = e.id == current
      local is_pinned = bufferline.groups._is_pinned(e)
      if not is_current and not is_pinned then
        commands.unpin_and_close(e.id)
      end
    end
  end)
end)
