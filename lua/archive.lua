
local function get_git_root()
local dot_git_path = vim.fn.finddir(".git", ".;")
return vim.fn.fnamemodify(dot_git_path, ":h")
end
vim.api.nvim_create_user_command("CdGitRoot", function()
vim.api.nvim_set_current_dir(get_git_root())
end, {})
vim.api.nvim_create_user_command("TcdGitRoot", function()
vim.cmd(string.format(":tcd %s", get_git_root()))
end, {})


function Hasmodule(module)
local function requiref(mod)
require(module)
end

return pcall(requiref, module)
end


-- Quick option debug
function Optinfo(o)
print(vim.inspect(vim_api.nvim_get_option_info(o)))
end

