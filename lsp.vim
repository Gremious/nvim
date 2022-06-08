" See https://github.com/sharksforarms/neovim-rust

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Debug lsp
" lua vim.lsp.set_log_level("debug")

lua << EOF
local nvim_lsp_installer = require("nvim-lsp-installer")
local lsp_status = require('lsp-status')

nvim_lsp_installer.setup {
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗"
		}
	}
}

lsp_status.register_progress()

-- https://github.com/nvim-lua/lsp-status.nvim/issues/7
-- use LSP SymbolKinds themselves as the kind labels

local kind_labels_mt = {__index = function(_, k) return k end}
local kind_labels = {}
setmetatable(kind_labels, kind_labels_mt)

lsp_status.register_progress()
lsp_status.config({
	kind_labels = kind_labels,
	indicator_errors = "Err:",
	indicator_warnings = "Warn:",
	indicator_info = "info:",
	indicator_hint = "hint:",
	-- the default is a wide codepoint which breaks absolute and relative
	-- line counts if placed before airline's Z section
	status_symbol = "",
})

local keymap_opts = { noremap=true, silent=true }
-- vim.keymap.set('n', '<leader>m', vim.diagnostic.open_float, keymap_opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, keymap_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, keymap_opts)
-- vim.keymap.set('n', '<leader>ll', vim.diagnostic.setloclist, keymap_opts)

local on_attach = function(client)
	require('illuminate').on_attach(client)

	if client.name == "rust_analyzer"
	then
		vim.keymap.set('n', '<leader>gp', ':RustParentModule<cr>')
	end

	-- These will exist only in an lsp buffer
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', '<leader>m', vim.diagnostic.open_float, bufopts)
	-- lists all diagnostics in a list
	vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, bufopts)
	vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<leader><C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wl', function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<a-CR>', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>mt', vim.lsp.buf.formatting, bufopts)
end

tools = {
	autoSetHints = true,
	hover_with_actions = true,
	inlay_hints = {
		show_parameter_hints = true,
		parameter_hints_prefix = "<-",
		other_hints_prefix = "->",
	}
}

server = {
	on_attach = on_attach,
	settings = {
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
					"mismatched-arg-count"
				}
			},
			cargo = {
				loadOutDirsFromCheck = true
			},
			procMacro = {
				enable = false
			},
			checkOnSave = {
				command = "clippy",
				allTargets = false
			},
			server = {
				extraEnv = {
					CARGO_TARGET_DIR = "target/rust-analyzer-check"
				}
			}
		}
	}
}

for _, lsp_server in ipairs(nvim_lsp_installer.get_installed_servers())
do
	if lsp_server.name == "rust_analyzer" then require("rust-tools").setup({ tools = tools, server = server })
	-- if lsp_server.name == "rust_analyzer" then require("lspconfig")["rust_analyzer"].setup(server)
	else require('lspconfig')[lsp_server.name].setup({ on_attach = on_attach })
	end
end

EOF

" Statusline
function! LspStatus() abort
	if luaeval('#vim.lsp.buf_get_clients() > 0')
		return luaeval("require('lsp-status').status()")
	endif

	return ''
endfunction

call airline#parts#define_function('lsp_status', 'LspStatus')
call airline#parts#define_condition('lsp_status', 'luaeval("#vim.lsp.buf_get_clients() > 0")')
let g:airline#extensions#nvimlsp#enabled = 0
let g:airline_section_warning = airline#section#create_right(['lsp_status'])

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
		vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		-- Add tab support
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	},

	-- Installed sources
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'path' },
		{ name = 'buffer' },
	},
})
EOF

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Set updatetime for CursorHold
" 1000ms of no cursor movement to trigger CursorHold
set updatetime=1000
" Show diagnostic popup on cursor hover
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

