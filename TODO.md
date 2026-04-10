TODO:
 indentexpr for custom indent rules to not put 3 spaces after a dot newline break in parentheses... (default vim behaviour???)

TODO: Don't comment out empyt lines, and just configure commenter better

TODO: 1. Full file path in statusline
		2. On item hover, full crtate module path in statusline
TODO: Disable highlght on super long lines, lags to hell on e.g. massive single line json
TODO:
Figure out spaces/tab options (plugin?)
move all things to insttall file, maybe organize it better?

TODO:
	Make a script on tabnew to rename the tabs from 1/2/3... to working dir? https://github.com/tiagovla/scope.nvim/issues/3
	Actually bufferline now merged a pr that enabels renaming of tabpages so check that out
	-
	Also, would be cool to write a autocmd that replaces the current tab if it wasn't written in?
	Like default vim behaviour. Idk how nice that would really be.

	a lil rust thing to auto insert #[derive(|)]? Also maybe Snippets to
	surround in Option<>/Result<> (for types not values)
	surround with .tap(|&element|), pipe whole chain?

	Some command to quicklist-do search repalce + update?

	A "close split/buffer" button that checks if buffer currently exists twice
	in window (e.g. how when :BD sends out warning) and if it does it calls :q
	else it calls :BD
	Leader qw is a decent hotkey for closing windows

	<space>d to delete whitespace and maybe merge from line down?

	dsw - delete surrounding wrapper - will `dw`, check if there's a (/{/[ etc under cursor, then `ds(` it - fast remove Some(...)

	custom hop searches for frequently used edits:
	e.g. place caret in the {:|?}, ?}|" or item|) in a println/log::debug!("{:?}", item)
