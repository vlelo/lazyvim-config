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
        "barklan/capslock.nvim",
        lazy = true,
        config = function(_, opts)
            local c = require("capslock")

            c.setup()

            vim.keymap.set({ "i", "c" }, "<C-l>", c.toggle, { desc = "Toggle CapsLock" })
            vim.keymap.set({ "t" }, "<C-\\><C-l>", c.toggle, { desc = "Toggle CapsLock" })
            vim.keymap.set({ "n" }, "gC", c.toggle, { desc = "Toggle CapsLock" })
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            -- local c = require("capslock")

            vim.list_extend(opts.sections.lualine_a, {
                {
                    function()
                        local ok, c = pcall(require, "capslock")
                        if ok then
                            return c.status_string()
                        else
                            return ""
                        end
                    end,
                },
            })

            return opts
        end,
    },

    {
        "Tummetott/unimpaired.nvim",
        lazy = false,
    },
}
