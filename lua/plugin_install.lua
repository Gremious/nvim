return require('packer').startup(
	function(use)
		use 'wbthomason/packer.nvim'
		use 'nvim-lua/plenary.nvim' -- lib other plugins use

		-- themes
		use { 'kaicataldo/material.vim', branch = 'main' } -- theme
		use { 'catppuccin/nvim', as = 'catppuccin'}
		use 'chriskempson/base16-vim'
		use 'vim-airline/vim-airline-themes'
		use { 'embark-theme/vim', as = 'embark' }
		use { 'franbach/miramare' }

		use 'kyazdani42/nvim-web-devicons'
		use 'kyazdani42/nvim-tree.lua'

		use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- syntax highlighter
		use 'nvim-treesitter/playground' -- treesitter debug
		use { 'fladson/vim-kitty', branch = 'main' } -- kitty config highlighting
		use 'vmchale/dhall-vim'

		use 'tpope/vim-obsession' -- Per-directory session management (remember layout, etc.)
		-- use 'luochen1990/rainbow' -- Rainbow brackets
		use 'p00f/nvim-ts-rainbow' -- rainbow parens for treesitter
		use 'machakann/vim-highlightedyank' -- on yank, highlights yanked text for a second

		use 'folke/todo-comments.nvim'
		use 'tpope/vim-repeat' -- remaps . in a way that plugins can tap into it
		use 'svermeulen/vim-extended-ft' -- f and t searches go through lines, ignore case, can be repeated with ; and ,
		use 'vim-airline/vim-airline'
		use 'chentoast/marks.nvim' -- show marks in sign column

		use 'akinsho/bufferline.nvim' -- Buffer Tabs
		use 'tiagovla/scope.nvim' -- Scrope buffers to vim tabs, :bnext and :bprev are workspaces basically
		use 'qpkorr/vim-bufkill' -- Don't close the whole tab/window on :bd - use :BD instead
		-- use 'romgrk/barbar.nvim' -- Buffer Tabs

		use 'scrooloose/nerdcommenter' -- Toggle comments
		use 'sjl/gundo.vim' -- undo tree
		use 'yegappan/mru'	-- most recently used files so i can undo a close

		use { 'junegunn/fzf', run = ":call fzf#install()" }
		use { 'junegunn/fzf.vim' }
		use 'godlygeek/tabular' -- Tab/Spaces aligner
		use 'ciaranm/detectindent' -- adds :DetectIndent, sets shiftwidth, expandtab and tabstop based on existing use
		use 'lukas-reineke/indent-blankline.nvim' -- Visible indents
		use 'tpope/vim-fugitive' -- git 
		use 'airblade/vim-gitgutter' -- git in gutter
		use 'airblade/vim-rooter' -- changes working dir to project root whenever you open files 
		use 'RRethy/vim-illuminate' -- Highlight hovered vairables (lsp compatible)
		use 'tpope/vim-surround' -- suround things with any text
		use 'wellle/targets.vim'
		-- use 'RishabhRD/popfix' -- Floating pop-ups library
		-- use 'RishabhRD/nvim-lsputils' -- Floating pop up for lsp stuff
		use 'beauwilliams/focus.nvim' -- resize splits when focusing them
		use 'phaazon/hop.nvim' -- EasyMotion but better, jump around places
		use 'lfilho/cosco.vim' -- Smart comma/semicolon insert

		use 'bootleq/vim-cycle' -- C-a/x cycle throgh bools/etc.
		-- ===== LSP =====
		-- https://github.com/sharksforarms/neovim-rust/

		use 'neovim/nvim-lspconfig'
		use 'williamboman/mason.nvim'
		use 'williamboman/mason-lspconfig.nvim'

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
			use { 'tzachar/cmp-tabnine', run = "powershell ./install.ps1" },

			after = { "hrsh7th/nvim-cmp" },
			requires = { "hrsh7th/nvim-cmp" },
		})

		-- Snippet engine
		use 'L3MON4D3/LuaSnip'

		-- Icons for cmp
		use 'onsails/lspkind.nvim'

		-- Adds extra functionality over rust analyzer
		use 'simrat39/rust-tools.nvim'

		-- Optional
		-- Visualize lsp progress
		-- use 'nvim-lua/lsp-status.nvim' in status line
		use({
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup()
			end
		})

		use 'nvim-lua/popup.nvim'
		use 'nvim-telescope/telescope.nvim'

		-- ==/ Silly /==
		use 'Eandrju/cellular-automaton.nvim'

		-- ==/ Off /==
		-- -- pywal theme support (broken in neovide? :c)
		-- use 'dylanaraps/wal.vim'

		-- -- Allows for the creations of 'submodes'
		-- use 'https://github.com/Iron-E/nvim-libmodal'
	end
)
