local modes = require("consts").modes

-- This is not the bottom bar - that's lualine
-- this is "tabs"
return {
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		lazy = false,
		opts =  {
			options = {
				-- TODO: Custom insert fn: if current buff pinned, insert at leftmost (relative) else, after current
				-- https://github.com/akinsho/bufferline.nvim/issues/736
				sort_by = "insert_after_current",
				show_close_icon = false,
				show_buffer_close_icons = false,
				modified_icon = "✏",

				indicator = {
					icon = ">", -- this should be omitted if indicator style is not 'icon'
					-- style = "underline",
					style = "icon",
				},
				-- separator_style = "slant" | "thick" | "thin" | { 'any', 'any' },
				separator_style = "thin",

				diagnostics = "nvim_lsp",

				--- diagnostics_dict is a dictionary from error level ("error", "warning" or "info") to number of errors for each level.
				diagnostics_indicator = function(_count, _level, diagnostics_dict, _context)
					local ret = " "
					for diag_type, count in pairs(diagnostics_dict) do
						local sym = diag_type == "error" and " " or (diag_type == "warning" and " " or "")
						ret = ret .. count .. sym
					end
					return ret
				end,

				-- enforce_regular_tabs = false | true,
				always_show_bufferline = true,
			},
		},
		-- TODO: Custom delete fn: 
		-- BD or bd as appropriate
		keys = function ()
			local bufferline = require("bufferline");
			return {
				{ "<left>", function() bufferline.cycle(-1) end },
				{ "<right>", function() bufferline.cycle(1) end },
				{ "<c-left>", function() bufferline.move(-1) end },
				{ "<c-right>", function() bufferline.move(1) end },
				{ "<leader>bp", ":BufferLineTogglePin<CR>" },
				{ "<leader>P", function() bufferline.pick() end },
				{ "<leader>bq", ":BD<CR>" },
				{ "<leader>bd", function()
					local buffers = vim.api.nvim_list_bufs();
					local active_buffers = {};

					for buf in pairs(buffers) do
						if vim.api.nvim_buf_is_loaded(buf) then
							table.insert(active_buffers, buf)
						end
					end
				end },
			}
		end
	},
}
