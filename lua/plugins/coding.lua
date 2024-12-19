return {
    {
        "echasnovski/mini.surround",
        opts = {
            n_lines = 80,
            silent = true,
        },
    },
    {
        "gbprod/yanky.nvim",
        opts = function(_, opts)
            local utils = require("yanky.utils")
            local actions = require("yanky.picker").actions

            opts.picker = {
                select = {
                    action = actions.set_register(utils.get_default_register()),
                },
            }

            return opts
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        opts = function(_, opts)
            local types = require("luasnip.util.types")
            opts.ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { "<-", "Error" } },
                    },
                },
            }
        end,
        keys = {
            {
                "<c-x>",
                function()
                    require("luasnip").jump(1)
                end,
                mode = { "i", "s" },
            },
            {
                "<c-z>",
                function()
                    require("luasnip").jump(-1)
                end,
                mode = { "i", "s" },
            },
        },
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000, -- needs to be loaded in first
        config = function()
            vim.diagnostic.config({ virtual_text = false })
            require("tiny-inline-diagnostic").setup({
                preset = "modern",
                options = {
                    show_source = true,

                    multiple_diag_under_cursor = false,

                    multilines = true,

                    show_all_diags_on_cursorline = true,

                    virt_texts = {
                        priority = 2048,
                    },
                },
            })
        end,
    },
    {
        "saghen/blink.cmp",
        opts = {
            keymap = {
                ["<C-k>"] = { "select_and_accept" },
            },
            completion = {
                menu = {
                    border = "rounded",
                    scrollbar = true,
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        border = "rounded",
                        scrollbar = true,
                    },
                },
                ghost_text = {
                    enabled = true,
                },
            },
        },
    },
}
