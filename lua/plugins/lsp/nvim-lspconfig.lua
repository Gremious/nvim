local function set_hotkeys(bufnr)
	local keymap = vim.keymap
	local keymap_opts = { buffer = bufnr, silent = true }

	keymap.set("n", "<leader>h", vim.lsp.buf.hover, keymap_opts)
	keymap.set("n", "<a-CR>", vim.lsp.buf.code_action, keymap_opts)

	keymap.set("n", "<leader>lp", vim.lsp.buf.signature_help, keymap_opts)
	keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
	keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
	keymap.set("n", "<leader>gr", ":Telescope lsp_references<cr>", keymap_opts)
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, keymap_opts)

	keymap.set("n", "<leader>T", vim.lsp.buf.type_definition, keymap_opts)
	keymap.set("n", "<leader>t", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, keymap_opts)

	-- Diagnostics
	keymap.set("n", "]d", vim.diagnostic.goto_next, keymap_opts)
	keymap.set("n", "[d", vim.diagnostic.goto_prev, keymap_opts)
	keymap.set("n", "<leader>ld", vim.diagnostic.open_float, keymap_opts)

end

local function customize_floating_window()
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
		opts = opts or {}
		opts.border = opts.border or border
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end
end

local function pretty_diagnostics()
	-- have a fixed column for the diagnostics to appear in
	-- this removes the jitter when warnings/errors flow in
	vim.wo.signcolumn = "yes"

	vim.diagnostic.config({
		float = true,
		severity_sort = true,
		virtual_lines = {
			current_line = false,
			severity = { min = vim.diagnostic.severity.WARN },
			format = function(diagnostic)
				-- Rust diagnostics are multilitne, we just wanna show the key message
				local until_newline = "[^\r\n]+";
				return diagnostic.message:gmatch(until_newline)()
			end,
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = '',
				[vim.diagnostic.severity.WARN] = '',
				[vim.diagnostic.severity.INFO] = ''

			}
		}
	});
end

return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Disable inlays by default, toggle with <leader>t
		vim.lsp.inlay_hint.enable(false)

		customize_floating_window();
		pretty_diagnostics();

		local function on_attach(client, bufnr)
			set_hotkeys(bufnr)
		end

		local rust = require("plugins.lsp.langs.rust");
		vim.lsp.config("rust_analyzer", rust.config(on_attach))

		local lua = require("plugins.lsp.langs.lua");
		vim.lsp.config("lua_ls", lua.config(on_attach))


		vim.lsp.config("ts_ls", { on_attach = on_attach })

		vim.lsp.config("gdscript", {
			on_attach = on_attach,
			filetypes = { "gd", "gdscript", "gdscript3" },
		})

		vim.lsp.config("phpactor", {
			on_attach = on_attach,
			init_options = {
				["language_server_phpstan.enabled"] = false,
				["language_server_psalm.enabled"] = false,
			},
		})
	end
}

