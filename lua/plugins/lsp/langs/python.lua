local function configuration(on_attach)
	return {
		on_attach = on_attach,
		settings = {
			["pylsp"] = {
				plugins = {
					pycodestyle = {
						maxLineLength = 120,
					},
				},
			},
		},
	}
end
return { config = configuration }
