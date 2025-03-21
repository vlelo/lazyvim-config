return {
    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },

    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git" },
    },

    {
        "tpope/vim-capslock",
        event = "VeryLazy",
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            sections = {
                lualine_a = {
                    function()
                        if vim.fn["CapsLockStatusline"](true) == true then
                            return "CAPS"
                        else
                            return ""
                        end
                    end,
                    cond = nil,
                },
            },
        },
    },
    {
        "Tummetott/unimpaired.nvim",
        lazy = false,
    },
}
