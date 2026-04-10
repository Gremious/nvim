return {
	-- Scopes/hides buffers to vim tabs, :bnext and :bprev are now workspaces basically
	{
		"tiagovla/scope.nvim",
		opts = { restore_state = false },
	},
	-- Don't close the whole tab/window on :bd - use :BD instead
	"qpkorr/vim-bufkill",
}
