local lspkind = require("lspkind")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lsp_status = require("lsp-status")

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append({ c = true })

mason_lspconfig.setup({
	ensure_installed = { "lua_ls", "rust_analyzer", "bashls", "efm" },
})

lsp_status.register_progress()

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

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
	keymap.set("n", "<a-p>", vim.lsp.buf.signature_help, keymap_opts)
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
	keymap.set("n", "]d", vim.diagnostic.goto_next, keymap_opts)
	keymap.set("n", "[d", vim.diagnostic.goto_prev, keymap_opts)

	-- on_attach(client)
	lsp_status.on_attach(client)
end

-- TODO: Don't show when i have opened the config
--
-- " Set updatetime for CursorHold
-- " 300ms of no cursor movement to trigger CursorHold
-- set updatetime=300
vim.opt.updatetime = 1000

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.wo.signcolumn = "yes"

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local rust_tools_config = {
	-- executor = require("rust-tools.executors").quickfix,

	inlay_hints = {
		auto = true,
		parameter_hints_prefix = "<-",
		other_hints_prefix = "->",
	},
	server = {
		standalone = false,
	},
	dap = function()
		local install_root_dir = vim.fn.stdpath "data" .. "/mason"
		local extension_path = install_root_dir .. "/packages/codelldb/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

		return {
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
		}
	end,
}

local rust_tools_rust_server = {
	on_attach = on_attach,
	settings = {
		-- List of all options:
		-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
		["rust-analyzer"] = {
			check = {
				command = "cranky",
				-- extraArgs = { "--all", "--", "-W", "clippy::all" },
			},

			-- rust-analyzer.server.extraEnv
			-- neovim doesn"t have custom client-side code to honor this setting, it doesn't actually work
			-- https://github.com/neovim/nvim-lspconfig/issues/1735
			-- it's in init.vim as a real env variable
			server = {
				extraEnv = {
					CARGO_TARGET_DIR = "target/rust-analyzer-check"
				}
			},

			-- Doesn't seem to really work...
			rustfmt = {
				rangeFormatting = {
					enable = true,
				},
			},
		},
	},
}

mason_lspconfig.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have a dedicated handler.
	function(server_name)
		require("lspconfig")[server_name].setup({ on_attach = on_attach, capabilities = capabilities })
	end,

	["lua_ls"] = function()
		require("lspconfig").lua_ls.setup({
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
	end,

	["rust_analyzer"] = function()
		require("rust-tools").setup({
			-- rust_tools specific settings
			tools = rust_tools_config,
			-- on_attach is actually bound rust-tools server
			server = rust_tools_rust_server,
			-- I use lsp-status which adds itself to the capabilities table
			capabilities = capabilities,
		})
	end,

	["efm"] = function()
		require("lspconfig").efm.setup {
			init_options = {
				documentFormatting = true,
				documentRangeFormatting = true,
			},
			settings = {
				rootMarkers = {".git/"},
				languages = {
					rust = {
						{ formatCommand = "rustfmt", formatStdin = true }
					}
				}
			}
		}
	end
})

