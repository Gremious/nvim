return {
    -- TODO: would be cool to have live telesacope swithcer, and there's a plugin for per project themes
    "nvim-tree/nvim-web-devicons",
    "Yazeed1s/minimal.nvim",
    "Yazeed1s/oh-lucy.nvim",
    "chriskempson/base16-vim",
    -- Actually funcitonal pywal
    "sonjiku/yawnc.nvim",
    {
        "franbach/miramare",
        config = function()
        vim.g.miramare_enable_italic = false
        vim.g.miramare_disable_italic_comment = true
        end,
    },
    {
        "kaicataldo/material.vim",
        config = function()
        vim.g.material_theme_style = "ocean"
        vim.g.material_terminal_italics = true
        end,
    },
    {
        "sainnhe/sonokai",
        config = function()
        -- vim.g.sonokai_style = "default"
        -- vim.g.sonokai_style = "atlantis"
        -- vim.g.sonokai_style = 'andromeda'
        -- vim.g.sonokai_style = "shusia"
        vim.g.sonokai_style = "maia"
        -- vim.g.sonokai_style = "espresso"
        -- vim.g.sonokai_better_performance = 1
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
        -- vim.g.catppuccin_flavour  = "latte"
        -- vim.g.catppuccin_flavour  = "frappe"
        -- vim.g.catppuccin_flavour  = "mocha"
        vim.g.catppuccin_flavour  = "mocha"
        end,
    },
    { "embark-theme/vim", name = "embark" },
    { "rose-pine/neovim", name = "rose-pine" },
}
