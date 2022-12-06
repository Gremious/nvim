local lsp_status = require("lsp-status")
lsp_status.register_progress()
-- https://github.com/nvim-lua/lsp-status.nvim/issues/7
-- use LSP SymbolKinds themselves as the kind labels
local kind_labels_mt = {
	__index = function(_, k)
		return k
	end,
}
local kind_labels = {}
setmetatable(kind_labels, kind_labels_mt)

lsp_status.register_progress()
lsp_status.config({
	kind_labels = kind_labels,
	indicator_errors = "Err:",
	indicator_warnings = "Warn:",
	indicator_info = "info:",
	indicator_hint = "hint:",
	-- spinner_frames = { '🌕', '🌖', '🌗', '🌘', '🌑', '🌒', '🌓', '🌔' },
	-- the default is a wide codepoint which breaks absolute and relative
	-- line counts if placed before airline's Z section
	status_symbol = "",
})

-- see https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
-- and https://github.com/simrat39/rust-tools.nvim/issues/89
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
	local opts = {
		tools = {
			autoSetHints = true,
			hover_with_actions = true,
			runnables = {
				use_telescope = true,
			},
			inlay_hints = {
				show_parameter_hints = true,
				parameter_hints_prefix = "",
				other_hints_prefix = "",
			},
		},
		server = {
			settings = {
				["rust_analyzer"] = {
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
						enable = true,
					},
					checkOnSave = {
						command = "clippy",
						allTargets = false,
					},
				},
			},
		},
	}

	local tools_opts = {
		autoSetHints = true,
		hover_with_actions = true,
		runnables = {
			use_telescope = true,
		},
	}

	local server_opts = {
		settings = {
			["rust_analyzer"] = {

				cargo = {
					loadOutDirsFromCheck = true,
				},
				procMacro = {
					enable = true,
				},
				checkOnSave = {
					command = "clippy",
					allTargets = false,
				},
			},
		},
	}

	local server_test = vim.tbl_deep_extend("force", server:get_default_options(), server_opts)
	vim.g["server_test"] = server_test

	if server.name == "rust_analyzer" then
		-- Initialize the LSP via rust-tools instead
		require("rust-tools").setup({
			server = vim.tbl_deep_extend("force", server:get_default_options(), settings),
			tools = tools_opts,
			on_attach = lsp_status.on_attach,
			capabilities = lsp_status.capabilities,
		})
		server:attach_buffers()
		-- Only if standalone support is needed
		-- require("rust-tools").start_standalone_if_reuired()
	else
		server:setup(server_opts)
	end
end)

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
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
		{ name = "vsnip" },
		{ name = "path" },
		{ name = "buffer" },
	},
})
