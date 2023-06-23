require("lazy").setup({
	-- !! Important
	"michaelb/do-nothing.vim",

	"nvim-lua/plenary.nvim", -- lib other plugins use

	-- themes
	{ "kaicataldo/material.vim" }, -- theme
	{ "catppuccin/nvim", name = "catppuccin" },
	"chriskempson/base16-vim",
	"folke/tokyonight.nvim",
	"Yazeed1s/oh-lucy.nvim",
	-- "vim-airline/vim-airline-themes",
	{ "embark-theme/vim", name = "embark" },
	"franbach/miramare",
	"kyazdani42/nvim-web-devicons",
	"Yazeed1s/minimal.nvim",

	-- Markdown live preview
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	"stevearc/dressing.nvim", -- Pretty windows for things that use vim.ui like rust-tools

	-- Startup screen
	-- {
	--	   "goolord/alpha-nvim",
	--	   requires = { "nvim-tree/nvim-web-devicons" },
	-- },
	{
		"kyazdani42/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
	},
	-- ==/ Highlights/Syntax /==
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- syntax highlighter
	"nvim-treesitter/playground", -- treesitter debug
	{ "fladson/vim-kitty", branch = "main" }, -- kitty config highlighting
	"imsnif/kdl.vim", -- kdl highlighting
	"vmchale/dhall-vim", -- dhall highlighting
	"ron-rs/ron.vim", -- ron highlighting
	"GutenYe/json5.vim", -- json5 highlighting
	-- use 'luochen1990/rainbow' -- Rainbow brackets
	"p00f/nvim-ts-rainbow", -- rainbow parens for treesitter
	"machakann/vim-highlightedyank", -- on yank, highlights yanked text for a second
	"folke/todo-comments.nvim", -- Highlights TODO/INFO/etc.

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
	"svermeulen/vim-extended-ft", -- f and t searches go through lines, ignore case, can be repeated with ; and ,
	"chentoast/marks.nvim", -- show marks in sign column
	-- "vim-airline/vim-airline",
	{
		"Weissle/easy-action",
		dependencies = {
			{
				"kevinhwang91/promise-async",
				module = { "async" },
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	-- use 'romgrk/barbar.nvim' -- Buffer Tabs
	"tiagovla/scope.nvim", -- Scrope buffers to vim tabs, :bnext and :bprev are workspaces basically
	"qpkorr/vim-bufkill", -- Don't close the whole tab/window on :bd - use :BD instead

	"scrooloose/nerdcommenter", -- Toggle comments
	{
		-- undo tree
		-- need to run:
		-- python -m pip install --user --upgrade pynvim
		"sjl/gundo.vim",
	},
	"yegappan/mru", -- most recently used files so i can undo a close
	{
		"Wansmer/treesj",
		requires = { "nvim-treesitter" },
	},
	-- { "junegunn/fzf", build = ":call fzf#install()" }
	-- { "junegunn/fzf.vim" }
	"godlygeek/tabular", -- Tab/Spaces aligner
	"ciaranm/detectindent", -- adds :DetectIndent, sets shiftwidth, expandtab and tabstop based on existing use
	"lukas-reineke/indent-blankline.nvim", -- Visible indents
	"tpope/vim-fugitive", -- git
	"airblade/vim-gitgutter", -- git in gutter
	"airblade/vim-rooter", -- changes working dir to project root whenever you open files
	"RRethy/vim-illuminate", -- Highlight hovered vairables (lsp compatible)
	"tpope/vim-surround", -- suround things with any text
	"wellle/targets.vim",
	-- "gelguy/wilder.nvim",
	-- use 'RishabhRD/popfix' -- Floating pop-ups library
	-- use 'RishabhRD/nvim-lsputils' -- Floating pop up for lsp stuff
	"beauwilliams/focus.nvim", -- resize splits when focusing them

	-- "phaazon/hop.nvim", -- EasyMotion but better, jump around places
	-- {
	--	   "ggandor/leap.nvim",
	--	   config = function()
	--	   require('leap').add_default_mappings()
	--	   end,
	-- },
	"https://gitlab.com/madyanov/svart.nvim",
	-- {
	--	   "madyanov/svart.nvim",
	--	   setup = function ()
	--	   vim.api.nvim_set_hl(0, "SvartLabel", { fg = "#ffcb6b", underline = true })
	--
	--	   end
	-- },
	"lfilho/cosco.vim", -- Smart comma/semicolon insert

	"bootleq/vim-cycle", -- C-a/x cycle throgh bools/etc.

	"zakharykaplan/nvim-retrail", -- Auto-trim trailing whitespace on :write

	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.0",
		-- requires = { { "nvim-lua/plenary.nvim" } },
	},

	-- A `C` port of FZF that hooks direcntly into telescope.
	-- (The actual CLI fzf on your system does not hook into vim plugins, and although you could, it'd be way slower)
	-- So, you have to build this from scratch. You need clang and MS C++ Visual Studio Build Toolds
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = function()
			if vim.fn.has("win32") == 1 then
				return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
			else
				return "make"
			end
		end,
	},
	-- "gnikdroy/projections.nvim",
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
			})
		end,
	},
	{
		"rmagatti/session-lens",
		dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
	},
	-- ===== LSP =====
	-- https://github.com/sharksforarms/neovim-rust/

	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
	},
	"williamboman/mason-lspconfig.nvim",

	-- Autocompletion framework
	"hrsh7th/nvim-cmp",
	{
		-- cmp LSP completion
		"hrsh7th/cmp-nvim-lsp",
		-- cmp Snippet completion
		"saadparwaiz1/cmp_luasnip",
		-- cmp Path completion
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",

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

		-- after = { "hrsh7th/nvim-cmp" },
		-- requires = { "hrsh7th/nvim-cmp" },
	},

	-- Snippet engine
	"L3MON4D3/LuaSnip",

	-- Icons for cmp
	"onsails/lspkind.nvim",

	-- Formatter (e.g. rustfmt)
	"mhartington/formatter.nvim",

	-- Debugging
	"mfussenegger/nvim-dap",
	-- {
	--	   "rcarriga/nvim-dap-ui",
	--	   -- version = "v3.2.2",
	--	   requires = {
	--	   "mfussenegger/nvim-dap",
	--	   "theHamsta/nvim-dap-virtual-text",
	--	   "jbyuki/one-small-step-for-vimkind",
	--	   },
	--	   config = function()
	--	   require("dapui").setup()
	--	   end,
	-- },

	-- Adds extra functionality over rust analyzer
	"simrat39/rust-tools.nvim",
	-- Very cool crates.io completion commands
	{
		"saecki/crates.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	-- Optional
	-- Visualize lsp progress
	"nvim-lua/lsp-status.nvim", -- Lsp progress in statusline
	-- "j-hui/fidget.nvim",

	-- "nvim-lua/popup.nvim",
	-- "folke/trouble.nvim", -- pretty lsp info/diagnostics window

	-- ==/ Silly /==
	-- "Eandrju/cellular-automaton.nvim",

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

	-- ==/ Off /==
	-- -- pywal theme support (broken in neovide? :c)
	-- use 'dylanaraps/wal.vim'

	-- Cool but I just use :telescope commands?
	-- "LinArcX/telescope-command-palette.nvim", -- Define custom things for the pretty search menu

	-- -- Allows for the creations of 'submodes'
	-- use 'https://github.com/Iron-E/nvim-libmodal'
})
