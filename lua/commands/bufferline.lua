vim.api.nvim_create_user_command(
	"BufferLineCloseAllButCurrentOrPinned",
	function ()
		local bufferline = require("bufferline")
		local commands = require("bufferline.commands")

		local current = vim.api.nvim_get_current_buf()
		vim.schedule(function()
			for _, e in ipairs(bufferline.get_elements().elements) do
				local is_current = e.id == current
				local is_pinned = bufferline.groups._is_pinned(e)
				if not is_current and not is_pinned then
					commands.unpin_and_close(e.id)
				end
			end
		end)
	end,
	{}
)
