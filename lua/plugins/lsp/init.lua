local vim_global = vim.g
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
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = { "rust_analyzer", "lua_ls" }
		}
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
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),

					--[[
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if cmp.get_selected_entry() ~= nil then
								cmp.confirm({
									behavior = cmp.ConfirmBehavior.Replace,
									select = false,
								})
							elseif luasnip.locally_jumpable(1) then
								SetUndoBreakpoint()
								luasnip.jump(1)
							else
								fallback()
							end
						elseif luasnip.locally_jumpable(1) then
							SetUndoBreakpoint()
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							SetUndoBreakpoint()
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					--]]
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
	-- cmp LSP completion
	"hrsh7th/cmp-nvim-lsp",
	-- Auto-complete using fn params
	"hrsh7th/cmp-nvim-lsp-signature-help",
	-- Auto-complete document symbols
	"hrsh7th/cmp-nvim-lsp-document-symbol",
	-- cmp Path completion
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	-- vim ':' cmdline
	"hrsh7th/cmp-cmdline",
	-- Icons for cmp
	"onsails/lspkind.nvim",
	--[[
	cmp Snippet completion
	{
		"saadparwaiz1/cmp_luasnip",
		config = function()
			require("luasnip.loaders.from_snipmate").lazy_load()
		end,
	},
	{
		Various language snippets for luasnip
		I just copied them myself cause I wanted to edit the rust ones
		"honza/vim-snippets",
		dependencies = { "saadparwaiz1/cmp_luasnip" },
	},
	"github/copilot.vim",
	{
		-- Snippet engine
		--
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*",
	},
	--]]

	-- Debugging
	{
		"mfussenegger/nvim-dap",
		config = function()
			local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"

			-- This should work, I just don't use it
			--[[
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

			require("dap").adapters.godot = {
				type = "server",
				host = '127.0.0.1',
				port = 6006,
			}

			require("dap").configurations.gdscript = {
				{
					type = "godot",
					request = "launch",
					name = "Launch scene",
					project = "${workspaceFolder}",
					launch_scene = true,
				}
			}
			--]]
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
