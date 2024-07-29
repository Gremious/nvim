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
					multi_window = false,
				},
				modes = {
					search = {
						enabled = false,
					},
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
			-- {
				-- -- rebind the search feature to a different keystroke
				-- "//", mode = { "n", "x", "o" },
				-- function() require("flash").jump() end,
				-- desc = "Flash"
			-- },
			{
				"<Leader>ss",
				mode = {"n", "x", "o"},
				function()
					local function pattern()
						local current_line = vim.api.nvim_get_current_line()
						local curr_column = vim.api.nvim_win_get_cursor(0)[2]
						local line_after_cursor = current_line:sub(curr_column + 1);
						local char_under_cursor = current_line:sub(curr_column + 1, curr_column + 1)

						-- if is whitespace
						if string.match(char_under_cursor, "%s") then
							local next_non_blank_at = line_after_cursor:match("^%s*"):len()
							local next_non_blank = line_after_cursor:sub(next_non_blank_at+1, next_non_blank_at+1)

							-- is non-alphanumeric
							if next_non_blank:match("%W") then
								return next_non_blank
							else
								return vim.fn.expand("<cword>")
							end
						elseif char_under_cursor:match("%W") then
							return char_under_cursor
						else
							return vim.fn.expand("<cword>")
						end
					end

					require("flash").jump({ pattern = pattern() })
				end
			},
			-- {
--
				-- "<Leader>sd",
				-- mode = {"n", "x", "o"},
				-- function()
					-- local function pattern()
						-- ---@param diag Diagnostic
						-- return vim.tbl_map(function(diag)
							-- return {
								-- pos = { diag.lnum + 1, diag.col },
								-- end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
							-- }
						-- end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)).pos)
					-- end
					-- require("flash").jump({ pattern = pattern() })
				-- end
			-- },
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
				"<leader>r",
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
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			-- {
				-- "<leader>xX",
				-- "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				-- desc = "Buffer Diagnostics (Trouble)",
			-- },
			-- {
				-- "<leader>cs",
				-- "<cmd>Trouble symbols toggle focus=false<cr>",
				-- desc = "Symbols (Trouble)",
			-- },
			-- {
				-- "<leader>cl",
				-- "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				-- desc = "LSP Definitions / references / ... (Trouble)",
			-- },
			-- {
				-- "<leader>xL",
				-- "<cmd>Trouble loclist toggle<cr>",
				-- desc = "Location List (Trouble)",
			-- },
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	-- ==/ themes /==
	-- TODO: would be cool to have live telesacope swithcer, and there's a plugin for per project themes
	"Yazeed1s/minimal.nvim",
	"Yazeed1s/oh-lucy.nvim",
	"chriskempson/base16-vim",
	"franbach/miramare",
	"kaicataldo/material.vim",
	"nvim-tree/nvim-web-devicons",
	"sainnhe/sonokai",
	"tiagovla/tokyodark.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "embark-theme/vim", name = "embark" },
	{ "rose-pine/neovim", name = "rose-pine" },
	-- Actually funcitonal pywal
	"sonjiku/yawnc.nvim",

	{
		"nvim-tree/nvim-tree.lua",
		-- nvim-tree recomends explicitly not lazy loading,
		-- and lazy.nvim does not call setup automatically when lazy = false
		lazy = false,
		config = function()
			require("nvim-tree").setup({
				update_focused_file = {
					enable = true,
				},
				filters = {
					git_ignored = false,
					dotfiles = false,
				},
				actions = {
					open_file = {
						quit_on_open = true,
						window_picker = {
							enable = false,
						},
					},
				},
				view = {
					-- Table means "dynamic"
					width = {},
					number = true,
					relativenumber = true,
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = false,
					severity = {
						min = vim.diagnostic.severity.WARN,
						max = vim.diagnostic.severity.ERROR,
					},
				},
				-- https://github.com/nvim-tree/nvim-tree.lua/issues/2851
				-- hijack_unnamed_buffer_when_opening = true,
				renderer = {
					highlight_git = "all",
					-- highlight_modified = "all",
					icons = {
						glyphs = {
							git = {
								unstaged = "📝",
								staged = "✔️",
								unmerged = "",
								renamed = "🔄️",
								untracked = "🆕",
								deleted = "❌",
								ignored = "◌",
							}
						},
					},
				},
			})
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- opts = {
	},

	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},

	-- ==/ Highlights/Syntax /==
	{
		-- syntax highlighter
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- To customize the syntax highlighting of a capture, simply define or link a highlight group of the same name:
			-- -- Highlight the @foo.bar capture group with the "Identifier" highlight group
			-- vim.api.nvim_set_hl(0, "@foo.bar", { link = "Identifier" })

			require("nvim-treesitter.configs").setup({
				-- ensure_installed = "all",
				ensure_installed = {
					"rust",
					"markdown",
					"lua",
					"vimdoc",
					"yaml",
					"css",
					"html",
					"cpp",
					"javascript",
				},
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
		dependencies = {
			-- additional parser
			{ "nushell/tree-sitter-nu" },
		},
	},
	"nvim-treesitter/playground", -- treesitter debug
	-- { "fladson/vim-kitty", branch = "main" }, -- kitty config highlighting
	"imsnif/kdl.vim", -- kdl highlighting
	"vmchale/dhall-vim", -- dhall highlighting
	"ron-rs/ron.vim", -- ron highlighting
	"GutenYe/json5.vim", -- json5 highlighting
	{
		-- rainbow brackets
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		}
	},
	"machakann/vim-highlightedyank", -- on yank, highlights yanked text for a second
	"nickel-lang/vim-nickel",

	{
		-- Highlights TODO/INFO/etc.
		"folke/todo-comments.nvim",
		opts = {
			keywords = {
				TODO = { icon = " ", color = "warning" },
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
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
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("textcase").setup({
				prefix = "<leader>tc"
			})
			require("telescope").load_extension("textcase")
		end,
		keys = {
			"<leader>tc",
			--Prefix for the default builting keymaps
			{ "<leader>tc.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
		},
		-- lazy = false,
	},

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
				lualine_c = {
					{
						'filename',
						path = 1
					}
				},
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
		-- TODO: set this up, it prevents u from typoing sepErated lol
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
					always_show_bufferline = true,
				},
			})
		end
	},
	-- Scopes/hides buffers to vim tabs, :bnext and :bprev are now workspaces basically
	{
		"tiagovla/scope.nvim",
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
		"shellRaining/hlchunk.nvim",
		event = { "UIEnter" },
		config = function()
			require("hlchunk").setup({
				blank = {
					enable = false,
				}
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	"tpope/vim-fugitive", -- git
	"airblade/vim-gitgutter", -- git in gutter
	"RRethy/vim-illuminate", -- Highlight hovered vairables (lsp compatible)
	"tpope/vim-surround", -- suround things with any text
	"wellle/targets.vim",
	-- use 'RishabhRD/popfix' -- Floating pop-ups library
	-- use 'RishabhRD/nvim-lsputils' -- Floating pop up for lsp stuff
	-- {
		-- -- resize splits when focusing them
		-- "nvim-focus/focus.nvim",
		-- commit = "1e2752aa3233497a17640e6474dbd6b35aaeeb26",
		-- opts = {
			-- excluded_filetypes = {'TelescopePrompt'},
		-- },
	-- },

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
				{ "greater", "equal", "less" },
				{ "column", "row" },
				{ "that", "which" },
				{ "trace", "debug", "info", "warn", "error" },
				{ "&str", "String", "impl Into<std::borrow::Cow<'a, str>>" },
				{ "Google", "YouTube", "Twitch", "Facebook", "TikTok" }
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
					layout_config = {
						height = 0.95,
						width = 0.95,
					},
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
	{
		-- (The actual CLI fzf on your system does not hook into vim plugins, and although you could, it'd be way slower)
		-- So, you have to build this from scratch. You need clang and MS C++ Visual Studio Build Toolds
		-- if you don't mind not using telescope, you can always still use
		-- { "junegunn/fzf", build = ":call fzf#install()" }
		"nvim-telescope/telescope-fzf-native.nvim",
		-- build = "make"
		build = function()
			-- if vim.fn.has("win32") == 1 then
				return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -G \"Visual Studio 17 2022\" && cmake --build build --config Release && cmake --install build --prefix build"
			-- else
				-- return "make"
			-- end
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},

	-- ==/ LSP /==
	{
		"neovim/nvim-lspconfig",
		-- opts = {
			-- inlay_hints = { enabled = true },
		-- },
	},

	{
		"lvimuser/lsp-inlayhints.nvim",

		config = function()
			require("lsp-inlayhints").setup()
			vim.cmd('highlight! link LspInlayHint Comment')
		end,
	},

	-- Setup rust
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			-- lazy doesn't seem to do this one auto
			require("mason").setup()
		end,
	},
	-- {
		-- "williamboman/mason-lspconfig.nvim",
		-- dependencies = { "williamboman/mason.nvim" },
		-- config = function()
			-- require("mason-lspconfig").setup({
				-- ensure_installed = { "rust_analyzer", "lua_ls", "bashls", "vimls" },
--
				-- -- Don't hook up rust-analyzer via mason-lspconfig
				-- -- It's hooked up via rustacean.
				-- -- mason-lspconfig is for all the other lsps
				-- servers = {
					-- rust_analyzer = {},
				-- },
				-- setup = {
					-- rust_analyzer = function()
						-- return true
					-- end,
				-- },
			-- })
--
			-- -- require("mason-lspconfig").setup_handlers({
				-- -- -- The first entry (without a key) will be the default handler
				-- -- -- and will be called for each installed server that doesn't have a dedicated handler.
				-- -- function(server_name)
					-- -- require("lspconfig")[server_name].setup({ on_attach = on_attach, capabilities = capabilities })
				-- -- end,
-- --
				-- -- ["lua_ls"] = function()
					-- -- require("lspconfig").lua_ls.setup({
						-- -- on_attach = on_attach,
						-- -- capabilities = capabilities,
						-- -- settings = {
							-- -- Lua = {
								-- -- diagnostics = {
									-- -- -- Get the language server to recognize the `vim` global
									-- -- globals = { "vim" },
								-- -- },
							-- -- },
						-- -- },
					-- -- })
				-- -- end,
-- --
				-- -- -- ["efm"] = function()
					-- -- -- require("lspconfig").efm.setup {
						-- -- -- init_options = {
							-- -- -- documentFormatting = true,
							-- -- -- documentRangeFormatting = true,
						-- -- -- },
						-- -- -- settings = {
							-- -- -- rootMarkers = {".git/"},
							-- -- -- languages = {
								-- -- -- rust = {
									-- -- -- { formatCommand = "rustfmt", formatStdin = true }
								-- -- -- }
							-- -- -- }
						-- -- -- }
					-- -- -- }
				-- -- end
			-- -- })
		-- end,
	-- },
	{
		'mrcjkb/rustaceanvim',
		version = '^4', -- Recommended
		ft = { 'rust' },
		dependencies = { "williamboman/mason.nvim" },
		-- config = function()
			-- print("hello rustacnea")
		-- end
	},


	{
		-- Autocompletion framework
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							nvim_lsp = "[LSP]",
							nvim_lsp_signature_help = "[Signature]",
							nvim_lsp_document_symbol = "[Symbol]",
							luasnip = "[LuaSnip]",
							buffer = "[Buffer]",
							path = "[Path]",
							cmp_tabnine = "[T9]",
							crates = "[crates.io]",
						},
					}),
				},
				completion = {
					-- don't preselct entries (so it doesn't start at the middle)
					completeopt = "noselect",
				},

				-- ignore preselect requests from language servers (go does this mostly so idc rn I think)
				-- preselect = cmp.PreselectMode.None,

				mapping = {
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),

					-- ["<C-e>"] = cmp.mapping.close(),
					["<Esc>"] = function(default)
						vim.cmd('stopinsert')
						default()
					end,

					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = false,
					}),

						-- ["<S-Tab>"] = cmp.mapping.select_prev_item(),
						-- ["<Tab>"] = cmp.mapping.select_next_item(),
--
						["<Tab>"] = cmp.mapping.select_next_item(),
						["<S-Tab>"] = cmp.mapping.select_prev_item(),

						-- ["<CR>"] = cmp.mapping(function(fallback)
							-- if cmp.visible() then
								-- if cmp.get_selected_entry() ~= nil then
									-- cmp.confirm({
										-- behavior = cmp.ConfirmBehavior.Replace,
										-- select = false,
									-- })
								-- elseif luasnip.locally_jumpable(1) then
									-- SetUndoBreakpoint()
									-- luasnip.jump(1)
								-- else
									-- fallback()
								-- end
							-- elseif luasnip.locally_jumpable(1) then
								-- SetUndoBreakpoint()
								-- luasnip.jump(1)
							-- else
								-- fallback()
							-- end
						-- end, { "i", "s" }),
						--
						-- ["<S-CR>"] = cmp.mapping(function(fallback)
							-- if cmp.visible() then
							-- cmp.select_prev_item()
							-- elseif luasnip.jumpable(-1) then
							-- SetUndoBreakpoint()
							-- luasnip.jump(-1)
							-- else
							-- fallback()
							-- end
							-- end, { "i", "s" }),
						},

						-- Installed sources
						sources = {
							{ name = "nvim_lsp" },
							{ name = "nvim_lsp_signature_help" },
							{ name = "nvim_lsp_document_symbol" },
							{ name = "luasnip" },
							{ name = "path" },
							{ name = "buffer" },
							{ name = "crates" },
							{ name = "cmp_tabnine" },
						},
					})

					cmp.setup.cmdline(':', {
						mapping = cmp.mapping.preset.cmdline(),
						sources = cmp.config.sources(
						{
							{ name = 'path' }
						},
						{
							{
								name = 'cmdline',
								option = {
									ignore_cmds = { 'Man', '!' }
								}
							}
						}
						)
					})
				end,
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
	"github/copilot.vim",
	{
		-- Snippet engine
		--
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*",
	},

	-- Icons for cmp
	"onsails/lspkind.nvim",

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		config = function()
			local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

			require("dap").adapters.lldb = {
				type = 'server',
				host = '127.0.0.1',
				port = 13000,
				executable = {
					command = codelldb_path ,
					args = {"--port", "13000"},

					-- on windows you may have to uncomment this:
					-- detached = false,
				},
			}
		end,
	},

	-- Crates.io
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
	{
		"olimorris/persisted.nvim",
		lazy = false,
		config = function()
			require("persisted").setup({
				autoload = true,
				ignored_dirs = { "~" },
			})
			require("telescope").load_extension("persisted")
		end,
		dependencies = { "nvim-telescope/telescope.nvim" },
	},

	-- ==/ Silly /==
	{
		"Eandrju/cellular-automaton.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		}
	},

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

	-- TODO: Telescope provides this, maybe use that instead. Perhaps without a preview cause confusing?
	-- though it doesn't seem to sort them the same idk needs testing
	"yegappan/mru", -- most recently used files so i can undo a close

	-- ==/ Off /==
	-- Don't rly use it
	-- "ciaranm/detectindent", -- adds :DetectIndent, sets shiftwidth, expandtab and tabstop based on existing use

	-- -- Allows for the creations of 'submodes'
	-- rly like the idea, don't have uses for it
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
