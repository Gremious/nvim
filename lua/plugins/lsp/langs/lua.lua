local function config(on_attach)
	return {
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
			},
		},
	}
end

return { config = config }
