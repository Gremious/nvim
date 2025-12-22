-- rust-analyzer.server.extraEnv
-- neovim doesn"t have custom client-side code to honor this setting, it doesn"t actually work
-- https://github.com/neovim/nvim-lspconfig/issues/1735
vim.env.CARGO_TARGET_DIR = "target/rust-analyzer-check"

vim_global.rust_recommended_style = false

return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
		-- lazy doesn't seem to do this one auto
		require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
		-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
		local border = {
			{"╭", "FloatBorder"},
			{"─", "FloatBorder"},
			{"╮", "FloatBorder"},
			{"│", "FloatBorder"},
			{"╯", "FloatBorder"},
			{"─", "FloatBorder"},
			{"╰", "FloatBorder"},
			{"│", "FloatBorder"},
		}
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		print("floating preview fn")
		opts = opts or {}
		opts.border = opts.border or border
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		local function on_attach(client, bufnr)
		local keymap = vim.keymap
		local keymap_opts = { buffer = bufnr, silent = true }

		keymap.set("n", "<leader>h", vim.lsp.buf.hover, keymap_opts)
		keymap.set("n", "<leader>h", vim.lsp.buf.hover, keymap_opts)
		keymap.set("n", "<a-CR>", vim.lsp.buf.code_action, keymap_opts)

		-- Code navigation and shortcuts
		keymap.set("n", "<leader>m", vim.diagnostic.open_float, keymap_opts)
		keymap.set("n", "<leader>M", function() vim.cmd.RustLsp('renderDiagnostic') end, keymap_opts)
		keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
		keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
		keymap.set("n", "<leader>gr", ":Telescope lsp_references<cr>", keymap_opts)
		keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
		keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
		keymap.set("n", "<a-p>", vim.lsp.buf.signature_help, keymap_opts)
		keymap.set("n", "<leader>T", vim.lsp.buf.type_definition, keymap_opts)
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)
		keymap.set("n", "<leader>t", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, keymap_opts)

		-- Show diagnostic popup on cursor hover
		-- Nice but also annoying cause it overwrites actual popups
		-- local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
		-- vim.api.nvim_create_autocmd("CursorHold", {
		-- callback = function()
		-- vim.diagnostic.open_float(nil, { focusable = false })
		-- end,
		-- group = diag_float_grp,
		-- })
		-- " Set updatetime for CursorHold
		-- " 300ms of no cursor movement to trigger CursorHold
		-- set updatetime=300
		-- vim.opt.updatetime = 1000
		--

		-- Goto previous/next diagnostic warning/error
		keymap.set("n", "]d", vim.diagnostic.goto_next, keymap_opts)
		keymap.set("n", "[d", vim.diagnostic.goto_prev, keymap_opts)
		end

		vim.lsp.config("rust_analyzer", {
			on_attach = on_attach,
			cmd_env = { CARGO_TARGET_DIR = "target/rust-analyzer-check" },
			settings = {
				["rust-analyzer"] = {
					-- check = {
					-- command = "clippy",
					-- -- extraArgs = { "--all", "--", "-W", "clippy::all" },
					-- },

					-- rust-analyzer.server.extraEnv
					-- neovim doesn"t have custom client-side code to honor this setting, it doesn't actually work
					-- https://github.com/neovim/nvim-lspconfig/issues/1735
					-- it's in init.vim as a real env variable
					-- server = {
					-- extraEnv = {
					-- CARGO_TARGET_DIR = "target/rust-analyzer-check"
					-- }
					-- },

					imports = {
						granularity = { enforce = true },
					},

					rustfmt = {
						enableRangeFormatting = true,
						rangeFormatting = {
							enable = true,
						},
					},

					inlayHints = {
						bindingModeHints = { enable = true },
				 closureReturnTypeHints = { enable = true },
				 lifetimeElisionHints = { useParameterNames = true, enable = "skip_trivial" },
				 closingBraceHints = { minLines = 0 },
				 parameterHints = { enable = false },
				 maxLength = 999,
					},
					cargo = {
						features = "all",
					},
				},
			},
		})

		vim.lsp.config("lua_ls", {
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
				},
			},
		})
		end
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
		vim.diagnostic.config({
			virtual_text = {
				current_line = true,
				format = function(diagnostic)
					if diagnostic.severity == vim.diagnostic.severity.INFO then return nil end
						if diagnostic.severity == vim.diagnostic.severity.HINT then return nil end

							return diagnostic.message:gmatch("[^\r\n]+")()
							end,
			},
			float = false,
			-- virtual_lines = {
			-- current_line = true,
			-- format = function(diagnostic)
		-- if diagnostic.severity == vim.diagnostic.severity.INFO then return diagnostic.message end
		-- if diagnostic.severity == vim.diagnostic.severity.HINT then return diagnostic.message end

		-- local result = {}
		-- for line in diagnostic.message:gmatch("[^\r\n]+") do
		-- if line:match("^for further information") then break end
		-- if not line:match(" on by default$") then
		-- table.insert(result, line)
		-- end
		-- end
		-- table.remove(result, 1)
		-- return table.concat(result, "\n")
		-- end,
		-- },
		severity_sort = true,
		});

		-- have a fixed column for the diagnostics to appear in
		-- this removes the jitter when warnings/errors flow in
		vim.wo.signcolumn = "yes"
		vim.lsp.inlay_hint.enable(false)
		-- ["gdscript"] = function()
		-- require('lspconfig').gdscript.setup({
		-- on_attach = on_attach,
		-- filetypes = { "gd", "gdscript", "gdscript3" },
		-- })
		-- end,
		-- ["ts_ls"] = function()
		-- require("lspconfig").ts_ls.setup({
		-- on_attach = on_attach,
		-- })
		-- end,

		-- ["phpactor"] = function()
		-- require("lspconfig").phpactor.setup({
		-- on_attach = on_attach,
		-- init_options = {
		-- ["language_server_phpstan.enabled"] = false,
		-- ["language_server_psalm.enabled"] = false,
		-- },
		-- })
		-- end,
		require("mason-lspconfig").setup({
			ensure_installed = { "rust_analyzer", "lua_ls" }
		});
		end,
	},
	{
		-- Autocompletion framework
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- "L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
		},
		config = function()
		local cmp = require("cmp")
		-- local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- Set completeopt to have a better completion experience
		-- :help completeopt
		-- menuone: popup even when there's only one match
		-- noinsert: Do not insert text until a selection is made
		-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
		vim.o.completeopt = "menuone,noinsert,noselect"

		-- Avoid showing extra messages when using completion
		vim.opt.shortmess:append({ c = true })

		cmp.setup({
			-- snippet = {
			-- expand = function(args)
		-- luasnip.lsp_expand(args.body)
		-- end,
		-- },
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				menu = {
					nvim_lsp = "[LSP]",
					nvim_lsp_signature_help = "[Signature]",
					nvim_lsp_document_symbol = "[Symbol]",
					-- luasnip = "[LuaSnip]",
					buffer = "[Buffer]",
					path = "[Path]",
					-- cmp_tabnine = "[T9]",
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

				  ["<CR>"] = cmp.mapping.confirm(),

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
			-- { name = "luasnip" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "crates" },
			-- { name = "cmp_tabnine" },
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
		-- {
		-- "saadparwaiz1/cmp_luasnip",
		-- config = function()
		-- require("luasnip.loaders.from_snipmate").lazy_load()
		-- end,
		-- },
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
		-- -- Powershell doesn't work for me in vim so I just use pwsh 6
		-- {
		-- "tzachar/cmp-tabnine",
		-- cond = function()
		-- if vim.fn.has("win32") == 1 then
		-- return true
		-- else
		-- return false
		-- end
		-- end,
		-- build = function()
		-- if vim.fn.has("win32") == 1 then
		-- return "pwsh ./install.ps1"
		-- else
		-- return "sh ./install.sh"
		-- end
		-- end,
		-- },

		-- dependencies = { "hrsh7th/nvim-cmp" },
	},
	-- "github/copilot.vim",
	-- {
	-- -- Snippet engine
	-- --
	-- "L3MON4D3/LuaSnip",
	-- -- follow latest release.
	-- version = "v2.*",
	-- },

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

		-- require("dap").adapters.godot = {
		-- type = "server",
		-- host = '127.0.0.1',
		-- port = 6006,
		-- }

		-- require("dap").configurations.gdscript = {
		-- {
		-- type = "godot",
		-- request = "launch",
		-- name = "Launch scene",
		-- project = "${workspaceFolder}",
		-- launch_scene = true,
		-- }
		-- }
		end,
	},

	-- Crates.io
	{
		"saecki/crates.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
	},

	-- Lsp progress in statusline
	{
		'linrongbin16/lsp-progress.nvim',
		dependencies = {
			"nvim-lualine/lualine.nvim",
		},
		config = function()
		require('lsp-progress').setup()
		vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			group = "lualine_augroup",
			pattern = "LspProgressStatusUpdated",
			callback = require("lualine").refresh,
		})
		end
	},
	-- "j-hui/fidget.nvim",
	-- "nvim-lua/popup.nvim",
}
