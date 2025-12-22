return {
	{
		-- Open/close brackets, statements, etc
		"Wansmer/treesj",
		opts = {
			use_default_keymaps = false,
			check_syntax_error = false,
			max_join_length = 160,
		},
		dependencies = { "nvim-treesitter" },
	}
}
