-- TODO: Lazy load LSP stuff, maybe some other stuff too

return require("packer").startup(function(use)
	-- !! Important
	use("michaelb/do-nothing.vim")

	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim") -- lib other plugins use

	-- themes
	use({ "kaicataldo/material.vim", branch = "main" }) -- theme
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("chriskempson/base16-vim")
	use("folke/tokyonight.nvim")
	use("Yazeed1s/oh-lucy.nvim")
	-- use("vim-airline/vim-airline-themes")
	use({ "embark-theme/vim", as = "embark" })
	use({ "franbach/miramare" })
	use("kyazdani42/nvim-web-devicons")
	use("Yazeed1s/minimal.nvim")

	use("stevearc/dressing.nvim") -- Pretty windows for things that use vim.ui like rust-tools

	-- Startup screen
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	-- Filetree
	use("kyazdani42/nvim-tree.lua")

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- syntax highlighter
	use("nvim-treesitter/playground") -- treesitter debug
	use({ "fladson/vim-kitty", branch = "main" }) -- kitty config highlighting
	use("vmchale/dhall-vim")

	-- use("tpope/vim-obsession") -- Per-directory session management (remember layout, etc.)
	use("gnikdroy/projections.nvim")

	-- use 'luochen1990/rainbow' -- Rainbow brackets
	use("p00f/nvim-ts-rainbow") -- rainbow parens for treesitter
	use("machakann/vim-highlightedyank") -- on yank, highlights yanked text for a second

	use("mg979/vim-visual-multi") -- Multiple cursors
	use("folke/todo-comments.nvim") -- Highlights TODO/INFO/etc.
	use("tpope/vim-repeat") -- remaps . in a way that plugins can tap into it
	use("svermeulen/vim-extended-ft") -- f and t searches go through lines, ignore case, can be repeated with ; and ,
	use("chentoast/marks.nvim") -- show marks in sign column
	-- use("vim-airline/vim-airline")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("akinsho/bufferline.nvim") -- Buffer Tabs
	use("tiagovla/scope.nvim") -- Scrope buffers to vim tabs, :bnext and :bprev are workspaces basically
	use("qpkorr/vim-bufkill") -- Don't close the whole tab/window on :bd - use :BD instead
	-- use 'romgrk/barbar.nvim' -- Buffer Tabs

	use("scrooloose/nerdcommenter") -- Toggle comments
	use("sjl/gundo.vim") -- undo tree
	use("yegappan/mru") -- most recently used files so i can undo a close
	use({
		"Wansmer/treesj",
		requires = { "nvim-treesitter" },
	})
	-- use({ "junegunn/fzf", run = ":call fzf#install()" })
	-- use({ "junegunn/fzf.vim" })
	use("godlygeek/tabular") -- Tab/Spaces aligner
	use("ciaranm/detectindent") -- adds :DetectIndent, sets shiftwidth, expandtab and tabstop based on existing use
	use("lukas-reineke/indent-blankline.nvim") -- Visible indents
	use("tpope/vim-fugitive") -- git
	use("airblade/vim-gitgutter") -- git in gutter
	use("airblade/vim-rooter") -- changes working dir to project root whenever you open files
	use("RRethy/vim-illuminate") -- Highlight hovered vairables (lsp compatible)
	use("tpope/vim-surround") -- suround things with any text
	use("wellle/targets.vim")
	use("gelguy/wilder.nvim")
	-- use 'RishabhRD/popfix' -- Floating pop-ups library
	-- use 'RishabhRD/nvim-lsputils' -- Floating pop up for lsp stuff
	use("beauwilliams/focus.nvim") -- resize splits when focusing them
	use("phaazon/hop.nvim") -- EasyMotion but better, jump around places
	use("lfilho/cosco.vim") -- Smart comma/semicolon insert

	use("bootleq/vim-cycle") -- C-a/x cycle throgh bools/etc.

	use("zakharykaplan/nvim-retrail") -- Auto-trim trailing whitespace on :write

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- A `C` port of FZF that hooks direcntly into telescope.
	-- (The actual CLI fzf on your system does not hook into vim plugins, and although you could, it'd be way slower)
	-- So, you have to build this from scratch.
	-- You'll need make and clang or gcc (on windows, winget install GnuWin32.Make)
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	-- ===== LSP =====
	-- https://github.com/sharksforarms/neovim-rust/

	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Autocompletion framework
	use("hrsh7th/nvim-cmp")
	use({
		-- cmp LSP completion
		"hrsh7th/cmp-nvim-lsp",
		-- cmp Snippet completion
		"saadparwaiz1/cmp_luasnip",
		-- cmp Path completion
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",

		-- AI-Completion
		use({ "tzachar/cmp-tabnine", run = "powershell ./install.ps1" }),

		after = { "hrsh7th/nvim-cmp" },
		requires = { "hrsh7th/nvim-cmp" },
	})

	-- Snippet engine
	use("L3MON4D3/LuaSnip")

	-- Icons for cmp
	use("onsails/lspkind.nvim")

	-- Debugging
	use("mfussenegger/nvim-dap")

	-- Adds extra functionality over rust analyzer
	use("simrat39/rust-tools.nvim")

	-- Optional
	-- Visualize lsp progress
	-- use 'nvim-lua/lsp-status.nvim' in status line
	use("j-hui/fidget.nvim")

	-- use("nvim-lua/popup.nvim")

	-- ==/ Silly /==
	use("Eandrju/cellular-automaton.nvim")
	use({
		"tamton-aquib/duck.nvim",
		config = function()
			-- vim.keymap.set('n', '<leader>dc', function() require("duck").hatch("🐈", 0.75) end, {}) -- Quite a mellow cat
			vim.keymap.set("n", "<leader>dd", function()
				require("duck").hatch()
			end, {})
			vim.keymap.set("n", "<leader>dk", function()
				require("duck").cook()
			end, {})
		end,
	})

	-- ==/ Off /==
	-- -- pywal theme support (broken in neovide? :c)
	-- use 'dylanaraps/wal.vim'

	-- Cool but I just use :telescope commands?
	-- use("LinArcX/telescope-command-palette.nvim") -- Define custom things for the pretty search menu

	-- -- Allows for the creations of 'submodes'
	-- use 'https://github.com/Iron-E/nvim-libmodal'
end)
