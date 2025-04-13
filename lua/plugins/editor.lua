return {
    {
        "folke/flash.nvim",
        opts = {
            search = {
                multi_window = true,
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
            jump = {
                autojump = true,
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
                "latex",
            })

            return opts
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_hidden = true,
                },
                hijack_netrw_behavior = "disabled",
            },
            close_if_last_window = true,
        },
    },
}
