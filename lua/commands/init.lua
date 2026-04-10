local telescope = require("telescope.builtin")
local num_args = require("consts").num_args

vim.api.nvim_create_user_command(
	"Config",
	function()
		telescope.find_files({ cwd = vim.fn.stdpath("config"), search_dirs = { "./lua" } })
	end,
	{ desc = "Type config -> get config" }
)

vim.api.nvim_create_user_command(
	"Rg",
	function(args)
		telescope.grep_string({ search = args.fargs[1], use_regex = true })
	end,
	{
		nargs = num_args.ZERO_OR_ONE,
		desc = "Replicate :Rg command with telescope",
	}
)

vim.api.nvim_create_user_command(
	"RG",
	function() telescope.live_grep() end,
	{ nargs = num_args.ZERO_OR_ONE }
)

require("commands.bufferline");
