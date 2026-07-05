return {
	{ "fladson/vim-kitty", branch = "main" }, -- kitty config highlighting
	"imsnif/kdl.vim", -- kdl highlighting
	"vmchale/dhall-vim", -- dhall highlighting
	"ron-rs/ron.vim", -- ron highlighting
	"GutenYe/json5.vim", -- json5 highlighting

	-- Color Highlighting
	{"mikevskater/nvim-float"},
	{
		"mikevskater/nvim-colorpicker",
		dependencies = { "mikevskater/nvim-float" },
		lazy = false,
		cmd = { "ColorPicker", "ColorPickerAtCursor", "ColorPickerMini" },
		-- keys = {
		--     { "<leader>cp", "<Plug>(colorpicker)", desc = "Color Picker" },
		--     { "<leader>cc", "<Plug>(colorpicker-at-cursor)", desc = "Pick at Cursor" },
		--     { "<leader>cm", "<Plug>(colorpicker-mini)", desc = "Mini Picker" },
		--     { "<leader>ch", "<Plug>(colorpicker-highlight-toggle)", desc = "Toggle Highlighting" },
		-- },
		opts = {
			alpha_enabled = true,
			presets = { "web", "tailwind" },
			highlight = {
				enable = true,
			},
		},
	}
}
