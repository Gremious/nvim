require("lazy").setup({
	"michaelb/do-nothing.vim", -- !! Important
	"nvim-lua/plenary.nvim", -- lib other plugins use
	{
		-- Pretty windows for things that use vim.ui like rust-tools
		-- Immediately nicer for lsp rename
		-- Every plugin that uses vim.ui will basically use
		-- ether pretty windows or telescope automatically
		"stevearc/dressing.nvim",
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			modes = {
				search = {
					enabled = false,
				},
				-- dynamic configuration for ftFT motions
				char = {
					-- hide after jump when not using jump labels
					autohide = true,
					-- set to `false` to use the current line only
					multi_line = true,
					-- by default all keymaps are enabled, but you can disable some of them,
					-- by removing them from the list.
					-- If you rather use another key, you can map them
					-- to something else, e.g., { [";"] = "L", [","] = H }
					keys = { "f", "F", "t", "T", ";", "," },
					---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
					-- The direction for `prev` and `next` is determined by the motion.
					-- `left` and `right` are always left and right.
					char_actions = function(motion)
						return {
							[";"] = "right", -- set to `right` to always go right
							[","] = "left", -- set to `left` to always go left
							-- clever-f style
							[motion:lower()] = "right",
							[motion:upper()] = "left",
						}
					end,
					jump = { register = false },
				},
			},
			jump = {
				nohlsearch = true,
				-- autojump = true,
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump({
						search = { forward = true, wrap = false, multi_window = true },
					})
				end,
				desc = "Flash forwards only.",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump({
						search = { forward = false, wrap = false, multi_window = true },
					})
				end,
				desc = "Flash backwards only",
			},
			-- {
				-- "ts",
				-- mode = { "n", "o", "x" },
				-- function()
					-- require("flash").treesitter()
				-- end,
				-- desc = "Flash Treesitter",
			-- },
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			-- {
				-- "hw",
				-- mode = {"n"},
				-- function()
					-- require("flash").jump({
						-- pattern = ".", -- initialize pattern with any char
						-- search = {
							-- forward = true,
							-- wrap = false,
							-- multi_window = true,
							-- mode = function(pattern)
								-- -- remove leading dot
								-- if pattern:sub(1, 1) == "." then
									-- pattern = pattern:sub(2)
								-- end
								-- -- return word pattern and proper skip pattern
								-- return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
							-- end,
						-- },
					-- })
				-- end
			-- },
			-- {
				-- "hW",
				-- mode = {"n"},
				-- function()
					-- require("flash").jump({
						-- pattern = ".", -- initialize pattern with any char
						-- search = {
							-- forward = false,
							-- wrap = false,
							-- multi_window = true,
							-- mode = function(pattern)
								-- -- remove leading dot
								-- if pattern:sub(1, 1) == "." then
									-- pattern = pattern:sub(2)
								-- end
								-- -- return word pattern and proper skip pattern
								-- return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
							-- end,
						-- },
					-- })
				-- end
			-- }
		},
		config = function()
		   vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffcb6b", underline = true })
		end
	},

	-- ==/ themes /==
	"chriskempson/base16-vim",
	"tiagovla/tokyodark.nvim",

	"franbach/miramare",
	"kaicataldo/material.vim", -- theme
	"nvim-tree/nvim-web-devicons",
	"Yazeed1s/minimal.nvim",
	"Yazeed1s/oh-lucy.nvim",
	"sainnhe/sonokai",

	{ "catppuccin/nvim", name = "catppuccin" },
	{ "embark-theme/vim", name = "embark" },
	-- Does not work on gvim outside of terminalm, e.g. neovide, nvim-qt... :(
	-- (It looks a lot better if instead of this, u run in terminal with set notermguicolors?)
	-- "dylanaraps/wal.vim",

	{
		"kyazdani42/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			filesystem_watchers = {
				enable = false
			},
			hijack_unnamed_buffer_when_opening = true,

			actions = {
				open_file = {
					quit_on_open = true,
					window_picker = {
						enable = false,
					},
				},
			},
			view = {
				width = 40,
				adaptive_size = true,
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = false,
				debounce_delay = 50,
				severity = {
					min = vim.diagnostic.severity.WARN,
					max = vim.diagnostic.severity.ERROR,
				},
			},

			-- update the focused file on `bufenter`, un-collapses the folders recursively until it finds the file.
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			-- changes the tree root directory on `dirchanged` and refreshes the tree.
			sync_root_with_cwd = false,
			-- will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
			respect_buf_cwd = true,

			-- prefer startup root directory when updating root directory of the tree.
			prefer_startup_root = true,
		},
	},
	-- ==/ Highlights/Syntax /==
	{
		-- syntax highlighter
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "rust", "markdown", "lua", "vimdoc" },
				highlight = {
					enable = true,
				},
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = 4000,
				},
				indent = {
					enable = false,
				},
				keymaps = {
					goto_next_usage = "<]-u>",
					goto_previous_usage = "<[-u>",
				}
			})
		end,
	},
	"nvim-treesitter/playground", -- treesitter debug
	{ "fladson/vim-kitty", branch = "main" }, -- kitty config highlighting
	"imsnif/kdl.vim", -- kdl highlighting
	"vmchale/dhall-vim", -- dhall highlighting
	"ron-rs/ron.vim", -- ron highlighting
	"GutenYe/json5.vim", -- json5 highlighting
	"HiPhish/rainbow-delimiters.nvim", -- rainbow brackets
	"machakann/vim-highlightedyank", -- on yank, highlights yanked text for a second
	{
		-- Highlights TODO/INFO/etc.
		"folke/todo-comments.nvim",
		opts = {
			keywords = {
				TODO = { icon = " ", color = "warning" },
			},
		},
	},

	-- Markdown live preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	-- shows follow-up hotkey options in status bar
	-- {
	--	   "folke/which-key.nvim",
	--	   config = function()
	--	   vim.o.timeout = true
	--	   vim.o.timeoutlen = 300
	--	   -- require("which-key").setup({
	--	   --	  -- your configuration comes here
	--	   --	  -- or leave it empty to use the default settings
	--	   --	  -- refer to the configuration section below
	--	   -- })
	--	   end,
	-- },

	-- "mg979/vim-visual-multi", -- Multiple cursors
	"tpope/vim-repeat", -- remaps . in a way that plugins can tap into it
	"chentoast/marks.nvim", -- show marks in sign column
	{

		-- TODO: Remove diagnostics from lsp-status cause lualine already shows them.
		-- go to lsp status and check their config i think they updated
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			extensions = { "nvim-tree", "fugitive", "nvim-dap-ui", "quickfix" },
			sections = {
				lualine_x = {
					function()
						return require("lsp-status").status()
					end,
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		},
	},
	{
		"tpope/vim-abolish",
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			-- NOTE: Just opts does not work, breaks scope vim
			require("bufferline").setup({
				options = {
					-- TODO: Custom insert fn: if current buff pinned, insert at leftmost (relative) else, after current
					-- Waiting on pinned status to be exposed
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
					-- separator_style = "thick",

					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = true,

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
					-- always_show_bufferline = true,
				},
			})
		end
	},
	-- Scrope buffers to vim tabs, :bnext and :bprev are workspaces basically
	{
		"tiagovla/scope.nvim",
		-- lazy = false,
		opts = { restore_state = false },
	},
	-- Don't close the whole tab/window on :bd - use :BD instead
	"qpkorr/vim-bufkill",
	{
		-- Toggle comments
		"scrooloose/nerdcommenter",
		config = function()
			vim.g.NERDCreateDefaultMappings = true
			vim.g.NERDSpaceDelims = true
			vim.g.NERDCommentEmptyLines = true
			vim.g.NERDTrimTrailingWhitespace = true
		end,
	},
	{
		-- undo tree
		-- need to run:
		-- python -m pip install --user --upgrade pynvim
		"sjl/gundo.vim",
		config = function()
			-- GUNDO breaks without python3
			if vim.fn.has("python3") then
				vim.g.gundo_prefer_python3 = 1
			end
		end,
	},
	{
		-- Open/close brackets, statements, etc
		"Wansmer/treesj",
		opts = {
			use_default_keymaps = false,
			check_syntax_error = false,
			max_join_length = 160,
		},
		dependencies = { "nvim-treesitter" },
	},
	"godlygeek/tabular", -- Tab/Spaces aligner
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	"tpope/vim-fugitive", -- git
	"airblade/vim-gitgutter", -- git in gutter
	"RRethy/vim-illuminate", -- Highlight hovered vairables (lsp compatible)
	"tpope/vim-surround", -- suround things with any text
	"wellle/targets.vim",
	-- use 'RishabhRD/popfix' -- Floating pop-ups library
	-- use 'RishabhRD/nvim-lsputils' -- Floating pop up for lsp stuff
	{
		-- resize splits when focusing them
		"nvim-focus/focus.nvim",
		commit = "1e2752aa3233497a17640e6474dbd6b35aaeeb26",
		config = function()
			require("focus").setup({
				excluded_filetypes = {'TelescopePrompt'},
			})
		end,
	},

	{
		-- Center buffer to center of screen (or monitor, for me)
		"shortcuts/no-neck-pain.nvim",
		-- opts = {
			--
		-- },
	},
	-- Smart comma/semicolon insert
	"lfilho/cosco.vim",
	{
		-- C-a/x cycle throgh bools/etc.
		"bootleq/vim-cycle",
		config = function()
			vim.g.cycle_no_mappings = true
			vim.g.cycle_phased_search = true
			vim.fn["cycle#add_groups"]({
				{ "true", "false" },
				{ "yes", "no" },
				{ "on", "off" },
				{ "+", "-" },
				{ ">", "<" },
				{ '"', "'" },
				{ "==", "!=" },
				-- { "0", "1" },
				{ "and", "or" },
				{ "in", "out" },
				{ "up", "down" },
				{ "left", "right" },
				{ "min", "max" },
				{ "get", "set" },
				{ "add", "remove" },
				{ "to", "from" },
				{ "read", "write" },
				{ "only", "except" },
				{ "without", "with" },
				{ "exclude", "include" },
				{ "asc", "desc" },
				{ ":)", ":(" },
				{ "c:", ":c" },
				{ "fn", "pub fn", "pub(super) fn", "pub(crate) fn", "async fn", "pub async fn", "pub(crate) async fn" },
				{ "let ", "let mut " },
				{ { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }, "hard_case" },
			})
		end,
	},
	{
		-- Auto-trim trailing whitespace on :write
		"zakharykaplan/nvim-retrail",
		lazy = false,
		-- main = "retrail",
		config = function()
			require("retrail").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					layout_config = { height = 0.95 },
					mappings = {
						i = {
							["<esc>"] = require("telescope.actions").close,
							["<C-Down>"] = require("telescope.actions").cycle_history_next,
							["<C-Up>"] = require("telescope.actions").cycle_history_prev,
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
		end,
	},

	-- (The actual CLI fzf on your system does not hook into vim plugins, and although you could, it'd be way slower)
	-- So, you have to build this from scratch. You need clang and MS C++ Visual Studio Build Toolds
	-- if you don't mind not using telescope, you can always still use
	-- { "junegunn/fzf", build = ":call fzf#install()" }
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = function()
			if vim.fn.has("win32") == 1 then
				return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -G \"Visual Studio 17 2022\" && cmake --build build --config Release && cmake --install build --prefix build"
			else
				return "make"
			end
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},

	-- ==/ LSP /==
	-- https://github.com/sharksforarms/neovim-rust/

	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			-- lazy doesn't seem to do this one auto
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
	},

	-- Autocompletion framework
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "saecki/crates.nvim" },
	},
	{
		-- cmp LSP completion
		"hrsh7th/cmp-nvim-lsp",
		-- Auto-complete using fn params
		"hrsh7th/cmp-nvim-lsp-signature-help",
		-- Auto-complete document symbols
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		-- cmp Snippet completion
		{
			"saadparwaiz1/cmp_luasnip",
			config = function()
				require("luasnip.loaders.from_snipmate").lazy_load()
			end,
		},
		-- {
			-- Various language snippets for luasnip
			-- I just copied them myself cause I wanted to edit the rust ones
			-- "honza/vim-snippets",
			-- dependencies = { "saadparwaiz1/cmp_luasnip" },
		-- },
		-- cmp Path completion
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		-- vim ':' cmdline
		"hrsh7th/cmp-cmdline",

		-- AI-Completion
		-- Powershell doesn't work for me in vim so I just use pwsh 7
		{
			"tzachar/cmp-tabnine",
			cond = function()
				if vim.fn.has("win32") == 1 then
					return true
				else
					return false
				end
			end,
			build = function()
				if vim.fn.has("win32") == 1 then
					return "pwsh ./install.ps1"
				else
					return "sh ./install.sh"
				end
			end,
		},

		dependencies = { "hrsh7th/nvim-cmp" },
	},
	{
		-- Snippet engine
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	},

	-- Icons for cmp
	"onsails/lspkind.nvim",

	-- Formatter (e.g. rustfmt)
	"mhartington/formatter.nvim",

	-- Debugging
	"mfussenegger/nvim-dap",

	-- Adds extra functionality over rust analyzer
	{
		"simrat39/rust-tools.nvim",
		dependencies = { "mfussenegger/nvim-dap" },
	},

	-- Very cool crates.io completion commands
	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
		config = function()
			require('crates').setup({
				src = {
					cmp = {
						enabled = true,
					},
				},
			})
		end,
	},

	-- Lsp progress in statusline
	"nvim-lua/lsp-status.nvim",
	-- "j-hui/fidget.nvim",
	-- "nvim-lua/popup.nvim",

	"folke/trouble.nvim", -- pretty lsp info/diagnostics window

	-- ==/ Silly /==
	"Eandrju/cellular-automaton.nvim",

	{
		"tamton-aquib/duck.nvim",
		config = function()
			-- Quite a mellow cat
			vim.keymap.set("n", "<leader>dc", function()
				require("duck").hatch("🐈", 0.75)
			end, {})
			vim.keymap.set("n", "<leader>dn", function()
				require("duck").hatch()
			end, {})
			vim.keymap.set("n", "<leader>dk", function()
				require("duck").cook()
			end, {})
		end,
	},

	-- {
		-- "Weissle/easy-action",
		-- dependencies = {
			-- {
				-- "kevinhwang91/promise-async",
				-- module = { "async" },
			-- },
		-- },
	-- },
	-- TODO: Telescope provides this, maybe use that instead. Perhaps without a preview cause confusing to me?
	"yegappan/mru", -- most recently used files so i can undo a close

	-- ==/ Off /==
	-- Don't rly use it
	-- "ciaranm/detectindent", -- adds :DetectIndent, sets shiftwidth, expandtab and tabstop based on existing use

	-- Cool but I just use :telescope commands?
	-- "LinArcX/telescope-command-palette.nvim", -- Define custom things for the pretty search menu

	-- -- Allows for the creations of 'submodes'
	-- use 'https://github.com/Iron-E/nvim-libmodal'

	-- Very laggy
	-- "gelguy/wilder.nvim",
	-- Maybe only load in small files?
	--
	-- local wilder = require("wilder")
	-- wilder.setup({ modes = { ":", "/", "?" } })
	-- wilder.set_option(
	--     "renderer",
	--     wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
	--         highlighter = wilder.basic_highlighter(),
	--         highlights = {
	--             border = "Normal",
	--             -- The color of the search match
	--             accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
	--         },
	--         left = { " ", wilder.popupmenu_devicons() },
	--         right = { " ", wilder.popupmenu_scrollbar() },
	--         border = "rounded",
	--         -- min_height = 8,
	--         max_height = 8,
	--     }))
	-- )
})
