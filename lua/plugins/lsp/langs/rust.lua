local function configuration(on_attach)
	return {
		on_attach = on_attach,
		cmd_env = { CARGO_TARGET_DIR = "target/rust-analyzer-check" },
		settings = {
			["rust-analyzer"] = {
				--[[
				-- rust-analyzer.server.extraEnv
				-- neovim doesn"t have custom client-side code to honor this setting, it doesn't actually work
				it's in init.vim as a real env variable
				server = {
					extraEnv = {
						CARGO_TARGET_DIR = "target/rust-analyzer-check"
					}
				},
				--]]
				check = {
					command = "clippy",
					-- extraArgs = { "--all", "--", "-W", "clippy::all" },
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

				-- enable with <leader>t
				inlayHints = {
					bindingModeHints = { enable = true },
					closureReturnTypeHints = { enable = true },
					lifetimeElisionHints = { useParameterNames = true, enable = "skip_trivial" },
					closingBraceHints = { minLines = 0 },
					parameterHints = { enable = false },
					maxLength = 999,
				},
				-- TODO:
				-- would be cool to have a hotkey that toggles this and reloads rust_analyzer
				cargo = {
					features = "all",
				},
			},
		},
	}
end

return { config = configuration }
