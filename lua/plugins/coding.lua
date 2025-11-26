return {
    {
        "nvim-mini/mini.surround",
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
    { "rafamadriz/friendly-snippets", enabled = false },
    {
        "L3MON4D3/LuaSnip",
        opts = function(_, opts)
            local types = require("luasnip.util.types")
            require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
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
                desc = "LuaSnip jump forward",
            },
            {
                "<c-z>",
                function()
                    require("luasnip").jump(-1)
                end,
                mode = { "i", "s" },
                desc = "LuaSnip jump backward",
            },
            {
                "<c-c>",
                function()
                    if require("luasnip").choice_active() then
                        require("luasnip").change_choice(1)
                        -- require("luasnip.extras.select_choice")()
                    end
                end,
                mode = { "i", "s" },
                desc = "LuaSnip choice next",
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
        dependencies = {
            { "xzbdmw/colorful-menu.nvim" },
        },
        opts = {
            keymap = {
                ["<C-k>"] = { "select_and_accept" },
                ["<C-l>"] = {},
            },
            sources = {
                per_filetype = {
                    tex = { "lsp", "path", "snippets", "omni" },
                    latex = { "lsp", "path", "snippets", "omni" },
                },
            },
            completion = {
                menu = {
                    border = "rounded",
                    scrollbar = true,
                    draw = {
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                width = { fill = true, max = 60 },
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = {
                        -- border = "rounded",
                        scrollbar = true,
                    },
                },
                ghost_text = {
                    enabled = true,
                },
                accept = { auto_brackets = { enabled = false } },
            },
            cmdline = {
                enabled = true,
                keymap = {
                    ["<C-k>"] = { "select_and_accept" },
                },
                completion = {
                    menu = {
                        auto_show = function(ctx)
                            return vim.fn.getcmdtype() == ":"
                            -- enable for inputs as well, with:
                            -- or vim.fn.getcmdtype() == '@'
                        end,
                    },
                    ghost_text = {
                        enabled = true,
                    },
                },
            },
        },
    },
    {
        "jmbuhr/otter.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
        lazy = false,
    },
}
