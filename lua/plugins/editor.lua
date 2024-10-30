return {
    {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            local actions = require("telescope.actions")
            opts.defaults.mappings.i["<C-i>"] = actions.cycle_history_next
            opts.defaults.mappings.i["<C-o>"] = actions.cycle_history_prev

            return opts
        end,
    },
    {
        "folke/flash.nvim",
        opts = {
            search = {
                forward = true,
            },
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    enabled = false,
                },
            },
        },
        keys = {
            { "<c-s>", false },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            -- add tsx and treesitter
            vim.list_extend(opts.ensure_installed, {
                "python",
                "rust",
                "bash",
                "html",
                "c",
                "zig",
                "systemverilog",
            })

            return opts
        end,
    },
}
