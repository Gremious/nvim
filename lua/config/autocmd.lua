--[[
	[ -- Lua augroups now auto-clear by default if group is already defined.
	[ -- Don't need `autocmd!` anymore
	[ -- Also, just the 1 group is enough I recon.
	[ -- Unless you really want to compartmentalize for some reason.
--]]

-- TODO: Disable git-gutter on long files.
local empty = vim.fn.empty
local fnamemodify = vim.fn.fnamemodify
local getbufvar = vim.fn.getbufvar
local mkdir = vim.fn.mkdir
local nvim_create_augroup = vim.api.nvim_create_augroup
local nvim_exec = vim.api.nvim_exec

local default_augroup = nvim_create_augroup("default_augroup ", {})

--- Like the regular one, but defaults the group.
--- Also complains if you don't have a description.
local function nvim_create_autocmd(event, opts)
	local opts_constructor = {
		pattern = opts.pattern,
		desc = opts.desc,
		callback = opts.callback,
	}

	if opts.group ~= nil then
		opts_constructor.group = opts.group
	else
		opts_constructor.group = default_augroup
	end

	assert(opts.desc ~= nil and opts.desc ~= "", "Please provide an autocommand description!")

	vim.api.nvim_create_autocmd(event, opts_constructor)
end

-- "Beware that, unlike some other scripting languages,
-- Lua considers both zero and the empty string as true in conditional tests"...
-- (and I like my functions returning a boolean)
local function isdirectory(path)
	return vim.fn.isdirectory(path) == 1
end

local function filereadable(path)
	return vim.fn.filereadable(path) == 1
end

nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.tpl",
	desc = "Highlight tpl files as c++.",

	callback = function()
		vim.opt.filetype = "cpp"
	end,
})

nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*",
	desc = "When trying to write to a file in a non-existant directory - make dirs as necessary.",

	callback = function(args)
		local file = args.file
		local buf = args.buf

		-- buftype check that it's a normal file and not e.g. help/quickfix/etc.
		-- regex idk - inherited
		if empty(getbufvar(buf, "&buftype")) and not string.match(file, "\v^\\w+\\:\\/") then
			-- strp the file from the path, leaving only it's dir
			local dir = fnamemodify(file, ":h")

			if isdirectory(dir) then
				-- "p" is an option for mkdir to make intermediate directories
				mkdir(dir, "p")
			end
		end
	end,
})

nvim_create_autocmd({ "VimEnter" }, {
	pattern = "*",
	desc = "Allow for _project.vim file, which will override vim setting per project.",

	callback = function(args)
		local file = args.match

		if file ~= "" and isdirectory(file) then
			local dir = file
			nvim_exec(string.format('exe "cd %s"', dir), {})

			if filereadable("_project.vim") then
				vim.cmd("source _project.vim")
			end
		end
	end,
})

