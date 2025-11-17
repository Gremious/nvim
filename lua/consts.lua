-- :h map-modes
-- :h nvim_set_keymap
local modes = {
	MAP = "",
	NORMAL = "n",
	VISUAL_AND_SELECT = "v",
	SELECT = "s",
	VISUAL = "x",
	OPERATOR_PENDING = "o",
	INSERT_AND_COMMAND = "!",
	INSERT = "i",
	INSERT_COMMAN_AND_LANG = "l",
	COMMAND = "c",
	TERMINAL = "t",
}

-- :h filename_modifiers
-- :h fname_modify
--
-- The file name modifiers can be used after "%", "#", "#n", "<cfile>", "<sfile>",
-- "<afile>" or "<abuf>".  They are also used with the |fnamemodify()| function.
local filename_modifiers = {
	-- Expands relative paths/'~'/etc.
	FULL_PATH = ":p",
	MS_DOS = ":8",
	RELATIVE_TO_HOME = ":~",
	RELATIVE_TO_CWD = ":.",

	-- one up dir
	HEAD = ":h",
	-- Last component
	-- Cannot be used with :e, :r or :t.
	TAIL = ":t",
	-- Must precede any :r or :e.
	FILENAME_ROOT = ":r",
	EXTENSION = ":e",

	ESCAPE_SPECIAL_CHARS = ":S",
	-- :s?pat?sub?
	-- :gs?pat?sub?
}

return {
	modes = modes,
       filename_modifiers = filename_modifiers,
}
