local modes = require("consts").modes

return {
	{
		"nvim-telescope/telescope.nvim",
		-- Debian works on 0.1.6 since it uses vim 0.10
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
		local tbuiltin = require("telescope.builtin")

		require("telescope").setup({
			defaults = {
				vimgrep_arguments = {
					-- Default:
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					-- Extra: don't respect .gitignore, we only use .ignore instead
					-- "--no-ignore-vcs"
				},
				layout_strategy = "vertical",
				layout_config = {
					height = 0.95,
					width = 0.95,
				},
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
				lsp_references = {
					include_declaration = false,
					-- just show path only, on selector
					-- we have a preview window
					show_line = false,
				},
				lsp_workspace_symbols = {
					fname_width = 80,
				},
				lsp_dynamic_workspace_symbols = {
					fname_width = 80,
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
		})

		vim.keymap.set(modes.NORMAL, "<Leader>fg", function()
		tbuiltin.live_grep({ use_regex = true })
		end)
		vim.keymap.set(modes.NORMAL, "<Leader>ff", function()
		-- fzf native only sorts best scores and has some filters (e.g. 'word),
					   -- grep actually does the search
					   tbuiltin.grep_string({
						   -- normally it would do `require("telescope.utils").buffer_dir()`
						   -- but I want current tab dir cause i use :tcd/tab workspaces
						   cwd = vim.fn.getcwd(),
											search = "",
											use_regex = true,
											additional_args = { "--glob=!*.gltf" },
					   })
					   end)
		vim.keymap.set(modes.NORMAL, "<Leader>fF", function()
		tbuiltin.find_files({
			cwd = vim.fn.getcwd(),
				find_command = function()
				local cmd = "fd";
				local maybe_debian = vim.uv.fs_stat("/etc/debian_version");
				if maybe_debian then cmd = "fdfind"; end
				return { cmd, "--type", "f", "--color", "never", "--hidden", "--no-ignore-vcs" };
			end,
		})
		end)
		vim.keymap.set(modes.NORMAL, "<Leader>fs", function()
		tbuiltin.lsp_document_symbols()
		end)
		vim.keymap.set(modes.NORMAL, "<Leader>fS", function()
		tbuiltin.lsp_dynamic_workspace_symbols()
		end)
		vim.keymap.set(modes.NORMAL, "<Leader>?", function()
		tbuiltin.resume()
		end)
		vim.keymap.set(modes.NORMAL, "<leader>:", function()
		tbuiltin.commands()
		end)
		end,
	},
	{
		-- (The actual CLI fzf on your system does not hook into vim plugins, and although you could, it'd be way slower)
		-- So, you have to build this from scratch. You need clang and MS C++ Visual Studio Build Toolds
		-- if you don't mind not using telescope, you can always still use
		-- { "junegunn/fzf", build = ":call fzf#install()" }
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
