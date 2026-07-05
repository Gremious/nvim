local function random_theme()
    local themes = {
        "randomhue",

        "minimal",
        "oh-lucy-evening",
        "miramare",
        "sonokai",
        "catppuccin",
        "embark",
        "rose-pine-main",
        "unokai",

        "base16-apathy",
        "base16-atlas",
        "base16-atelier-sulphurpool",
        "base16-heetch",
        "base16-hopscotch",
        "base16-paraiso",
        "base16-gruvbox-dark-pale",
        "base16-gruvbox-dark-hard",
        "base16-outrun-dark",

		-- "matugen"
    };

    local len = 0
    for _ in pairs(themes) do len = len + 1 end;

    local pick = (vim.fn.rand() % len) + 1;

	if pick == "matugen" then
		require('matugen').setup()
	else
		vim.cmd("colorscheme " .. themes[pick])
	end

end

random_theme()
