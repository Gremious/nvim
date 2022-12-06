-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append({ c = true })

local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspkind = require("lspkind")

-- local lsp_status = require('lsp-status')

mason_lspconfig.setup({
	ensure_installed = { "sumneko_lua", "rust_analyzer" },
})

mason.setup({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

local function on_attach(client, buffer)
	local keymap = vim.keymap
	local keymap_opts = { buffer = buffer, silent = true }

	if client.name == "rust_analyzer" then
		keymap.set("n", "<leader>h", ":RustHoverActions<cr>", keymap_opts)
		keymap.set("n", "<leader>gp", ":RustParentModule<cr>", keymap_opts)
	else
		keymap.set("n", "<leader>h", vim.lsp.buf.hover, keymap_opts)
	end

	-- Code navigation and shortcuts
	keymap.set("n", "<leader>m", vim.diagnostic.open_float, keymap_opts)
	keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
	keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
	keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, keymap_opts)
	keymap.set("n", "<leader>gr", ":Telescope lsp_references<cr>", keymap_opts)
	keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
	keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
	keymap.set("n", "<a-CR>", vim.lsp.buf.code_action, keymap_opts)
	keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
	keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, keymap_opts)
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)

	-- Show diagnostic popup on cursor hover
	local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
	vim.api.nvim_create_autocmd("CursorHold", {
		callback = function()
			vim.diagnostic.open_float(nil, { focusable = false })
		end,
		group = diag_float_grp,
	})

	-- Goto previous/next diagnostic warning/error
	keymap.set("n", "[d", vim.diagnostic.goto_prev, keymap_opts)
	keymap.set("n", "]d", vim.diagnostic.goto_next, keymap_opts)
end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local rust_tools = {
	runnables = {
		use_telescope = true,
	},
	inlay_hints = {
		auto = true,
		show_parameter_hints = true,
		parameter_hints_prefix = "<-",
		other_hints_prefix = "->",
	},
}

-- all the opts to send to nvim-lspconfig
-- these override the defaults set by rust-tools.nvim
-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
local server = {
	-- on_attach is a callback called when the language server attachs to the buffer
	on_attach = on_attach,
	settings = {
		-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
		["rust-analyzer"] = {
			diagnostics = {
				disabled = {
					"macro-error",
					"unresolved-macro-call",
					"unresolved-import",
					"incorrect-ident-case",
					"unresolved-proc-macro",
					"missing-ok-or-some-in-tail-expr",
					"missing-unsafe",
					"mismatched-arg-count",
				},
			},
			cargo = {
				loadOutDirsFromCheck = true,
			},
			procMacro = {
				enable = false,
			},
			checkOnSave = {
				command = "clippy",
				allTargets = false,
			},
			--	server = {
			--		extraEnv = {
			--			CARGO_TARGET_DIR = "target/rust-analyzer-check"
			--		}
			--	}
		},
	},
}

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp_server in ipairs(mason_lspconfig.get_installed_servers()) do
	if lsp_server == "rust_analyzer" then
		require("rust-tools").setup({ tools = rust_tools, server = server, capabilities = capabilities })
	-- if lsp_server == "rust_analyzer" then require("lspconfig")["rust_analyzer"].setup(server)
	elseif lsp_server == "sumneko_lua" then
		require("lspconfig").sumneko_lua.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
				},
			},
		})
	else
		require("lspconfig")[lsp_server].setup({ on_attach = on_attach, capabilities = capabilities })
	end
end

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require("cmp")
cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				path = "[Path]",
				cmp_tabnine = "[T9]",
			},
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		-- Add tab support
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	},

	-- Installed sources
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "cmp_tabnine" },
	},
})

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.wo.signcolumn = "yes"

-- " Set updatetime for CursorHold
-- " 300ms of no cursor movement to trigger CursorHold
-- set updatetime=300
vim.opt.updatetime = 1000
