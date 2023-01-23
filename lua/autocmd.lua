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

local session = require("projections.session")
local switcher = require("projections.switcher")

nvim_create_autocmd({ "VimLeavePre" }, {
	desc = "Autostore session on VimExit",

	callback = function()
		session.store(vim.loop.cwd())
	end,
})

-- -- if vim was started with arguments, do nothing
-- -- if in some project's root, attempt to restore that project's session
-- -- if not, restore last session
-- -- if no sessions, do nothing
-- nvim_create_autocmd({ "vimenter" }, {
--     desc = "restore last session automatically.",
--
--     callback = function()
--         if vim.fn.argc() ~= 0 then return end
--
--         if session.info(vim.loop.cwd()) == nil then
--             session.restore_latest()
--         else
--             session.restore(vim.loop.cwd())
--         end
--     end
-- })

nvim_create_autocmd({ "VimEnter" }, {
	desc = "Switch to project if vim was started in a project dir.",

	callback = function()
		if vim.fn.argc() == 0 then
			switcher.switch(vim.loop.cwd())
		end
	end,
})

-- Haven't had problems with md files yet?
-- nvim_create_autocmd({ "BufRead, BufNewFile" },
--		{
--			group = group_filetypes,
--			pattern = "*.md",
--			callback = function()
--				vim.opt.filetype = "markdown"
--			end
--		}
-- )

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

nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
	pattern = "*",
	desc = "Allow for a _project.vim file, which will override vim setting per project.",

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

-- " exclude quickfix buffers from :bnext and :bprev
-- augroup qf
--	   autocmd FileType qf set nobuflisted
-- augroup END
--
-- " exclude terminal from :bnext and :bprev
-- " augroup term
-- "	 autocmd TermOpen * setlocal nobuflisted
-- " augroup END
