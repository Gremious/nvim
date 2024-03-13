local lsp_status = require("lsp-status")

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append({ c = true })

lsp_status.register_progress()

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

local function on_attach(client, bufnr)
	local keymap = vim.keymap
	local keymap_opts = { buffer = bufnr, silent = true }

	if client.name == "rust_analyzer" then
		keymap.set("n", "<leader>h", vim.lsp.buf.hover, keymap_opts)
		-- keymap.set("n", "<leader>h", function() vim.cmd.RustLsp { 'hover', 'actions' } end, keymap_opts)
		keymap.set("n", "<leader>gp", function() vim.cmd.RustLsp('parentModule') end, keymap_opts)
		keymap.set("n", "<a-CR>", function() vim.cmd.RustLsp('codeAction') end, keymap_opts)
	else
		keymap.set("n", "<leader>h", vim.lsp.buf.hover, keymap_opts)
		keymap.set("n", "<a-CR>", vim.lsp.buf.code_action, keymap_opts)
	end

	-- Code navigation and shortcuts
	keymap.set("n", "<leader>m", vim.diagnostic.open_float, keymap_opts)
	keymap.set("n", "<leader>M", function() vim.cmd.RustLsp('renderDiagnostic') end, keymap_opts)
	keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
	keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
	keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, keymap_opts)
	keymap.set("n", "<leader>gr", ":Telescope lsp_references<cr>", keymap_opts)
	keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
	keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
	keymap.set("n", "<a-p>", vim.lsp.buf.signature_help, keymap_opts)
	keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, keymap_opts)
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)

	-- Show diagnostic popup on cursor hover
	-- Nice but also annoying cause it overwrites actual popups
	-- local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
	-- vim.api.nvim_create_autocmd("CursorHold", {
		-- callback = function()
			-- vim.diagnostic.open_float(nil, { focusable = false })
		-- end,
		-- group = diag_float_grp,
	-- })

	-- Goto previous/next diagnostic warning/error
	keymap.set("n", "]d", vim.diagnostic.goto_next, keymap_opts)
	keymap.set("n", "[d", vim.diagnostic.goto_prev, keymap_opts)

	-- on_attach(client)
	lsp_status.on_attach(client)
	require("lsp-inlayhints").on_attach(client, bufnr)
	-- if client.server_capabilities.inlayHintProvider then
		-- vim.lsp.inlay_hint.enable(bufnr, true)
	-- end
end

vim.g.rustaceanvim = {
	tools = {
		code_actions = {
			ui_select_fallback = true
		},
	},
	server = {
		cmd = function()
			local mason_registry = require('mason-registry')
			local package = mason_registry.get_package('rust-analyzer')
			local install_dir = package:get_install_path()
			-- find out where the binary is in the install dir, and append it to the install dir
			local ra_bin = install_dir .. '/' .. 'rust-analyzer.exe' -- this may need tweaking
			return { ra_bin } -- you can add additional args like `'--logfile', '/path/to/logfile'` to the list
		end,
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
					closingBraceHints = { minLines = 0 },
					lifetimeElisionHints = { useParameterNames = true, enable = "skip_trivial" },
				},
			},
		},
	},
}

-- TODO: Don't show when i have opened the config
--
-- " Set updatetime for CursorHold
-- " 300ms of no cursor movement to trigger CursorHold
-- set updatetime=300
vim.opt.updatetime = 1000

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.wo.signcolumn = "yes"

