local modes = require("consts").modes

return {
	{
		"nvim-telescope/telescope.nvim",
		-- Debian works on 0.1.6 since it uses vim 0.10
		-- tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				fname_width = 80,
				vimgrep_arguments = {
					-- Default:
					-- These options are all necessary 
					-- for telescope to parse is correctly
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",

					-- Extra: don't respect .gitignore, we only use .ignore instead
					-- that way we can search for selective files that normally might be ignored
					"--no-ignore-vcs",
					"--hidden",
				},
				layout_strategy = "vertical",
				layout_config = {
					height = 0.95,
					width = 0.95,
				},
				-- These are while inside a search
				mappings = {
					i = {
						["<esc>"] = require("telescope.actions").close,
						["<C-Down>"] = require("telescope.actions").cycle_history_next,
						["<C-Up>"] = require("telescope.actions").cycle_history_prev,
						["<C-f>"] = require("telescope.actions").to_fuzzy_refine
					},
				},
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
				grep_string = {
					-- hide line number
					disable_coordinates = true,
				},
				lsp_references = {
					include_declaration = false,
					-- just show path only, on selector
					-- we have a preview window
					show_line = false,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
		},
		keys = function ()
			local tbuiltin = require("telescope.builtin")
			return {
				{ "<leader>fs", function() tbuiltin.lsp_document_symbols() end },
				{ "<leader>fS", function() tbuiltin.lsp_dynamic_workspace_symbols() end },
				{ "<leader>?", function() tbuiltin.resume() end },
				{ "<leader>:", function() tbuiltin.commands() end },
				{ "<leader>fg", function() tbuiltin.live_grep({ use_regex = true }) end },
				{ "<leader>ff", function()
					-- fzf native only sorts best scores and has some filters (e.g. 'word),
					-- grep actually does the search
					-- so, we grep search for "" e.g. everything
					-- and then run that through fzf
					tbuiltin.grep_string({
						search = "",
						only_sort_text = true,
						-- filename only
						path_display = "tail",
						-- consider:
						-- slower, but show as little as necessary for paths to be unique
						-- path_display = "smart",
						--
						-- consider this for  :tcd/tab workspaces?
						-- cwd = vim.fn.getcwd(),
					})
				end,
			},
			{ "<leader>fF", function()
				tbuiltin.find_files({
					cwd = vim.fn.getcwd(),
					find_command = function()
						local cmd = "fd";
						local maybe_debian = vim.uv.fs_stat("/etc/debian_version");
						if maybe_debian then cmd = "fdfind"; end
						return { cmd, "--type", "f", "--color", "never", "--hidden", "--no-ignore-vcs" };
					end,
				})
			end
		}
		}
		end,
	},
	{
		--[[
		-- (The actual CLI fzf on your system does not hook into vim plugins, and although you could, it'd be way slower)
		-- So, you have to build this from scratch. You need clang and MS C++ Visual Studio Build Tools if on Windows
		-- if you don't mind not using telescope, you can always still use
		{ "junegunn/fzf", build = ":call fzf#install()" }
		--]]
		"nvim-telescope/telescope-fzf-native.nvim",
		-- build = "make"
		build = function()
			if vim.fn.has("win32") == 1 then
				return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -G \"Visual Studio 17 2022\" && cmake --build build --config Release && cmake --install build --prefix build"
			else
				-- Seems like you have to run make yourself in
				-- /home/gremious/.local/share/nvim/lazy/telescope-fzf-native.nvim/
				return "make"
			end
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
}
