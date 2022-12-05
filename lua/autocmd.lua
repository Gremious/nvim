--[[
   [ -- Lua augroups now auto-clear by default if group is already defined.
   [ -- Don't need `autocmd!` anymore
   [ -- Also, just the 1 group is enough I recon.
   [ -- Unless you really want to compartmentalize for some reason.
--]]

local nvim_create_augroup = vim.api.nvim_create_augroup
local nvim_create_autocmd = vim.api.nvim_create_autocmd
local isdirectory = vim.fn.isdirectory
local filereadable = vim.fn.filereadable
local fnamemodify = vim.fn.fnamemodify

local default_augroup = nvim_create_augroup("default_augroup ", {})

-- Haven't had problems with md files yet?
-- nvim_create_autocmd({ "BufRead, BufNewFile" },
--     {
--         group = group_filetypes,
--         pattern = "*.md",
--         callback = function()
--             vim.opt.filetype = "markdown"
--         end
--     }
-- )

nvim_create_autocmd({ "BufRead", "BufNewFile" },
	{
		pattern = "*.tpl",
		group = default_augroup,
		desc = "Highlight tpl files as c++",
		callback = function()
			vim.opt.filetype = "cpp"
		end
	}
)

nvim_create_autocmd({ "BufRead", "BufNewFile" },
	{
		pattern = "*.rs",
		group = default_augroup,
		desc = "Override rust lsp whitespace formatting",
		callback = function()
			vim.opt.tabstop = 4
			vim.opt.softtabstop = 4
			vim.opt.shiftwidth = 4
			-- vim.opt.noexpandtab = true
		end
	}
)

local function make_non_existant_directory(file, buf)
--     if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
--         let dir=fnamemodify(a:file, ':h')
--         if !isdirectory(dir)
--             call mkdir(dir, 'p')
--         endif
--     endif
end

nvim_create_autocmd({ "BufWritePre" },
	{
		pattern = "*",
		group = default_augroup,
		desc = "When trying to write to a file in a non-existant directory - make dirs as necessary.",
		callback = function(args)
			make_non_existant_directory(args.file, args.buf)
		end
	}
)

-- idk what this is about
local function maybe_enter_directory(file)
	if (file ~= '' and isdirectory(file))
	then
		local dir = file
		vim.api.nvim_exec(string.format('exe \"cd %s\"', dir))
		if filereadable("_project.vim") then
			vim.cmd('source _project.vim')
			print("Loaded project file")
		end
	end
end

nvim_create_autocmd({ "BufEnter", "VimEnter" },
	{
		pattern = "*",
		group = default_augroup,
		desc = "",
		callback = function(args)
			maybe_enter_directory(args.match)
		end
	}
)

-- " exclude quickfix buffers from :bnext and :bprev
-- augroup qf
--     autocmd!
--     autocmd FileType qf set nobuflisted
-- augroup END
--
-- " exclude terminal from :bnext and :bprev
-- " augroup term
-- "     autocmd!
-- "     autocmd TermOpen * setlocal nobuflisted
-- " augroup END
