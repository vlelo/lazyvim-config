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
            local mappings = require("yanky.telescope.mapping")

            opts.picker = {
                select = {
                    action = actions.set_register(utils.get_default_register()),
                },
                telescope = {
                    mappings = {
                        default = mappings.set_register(utils.get_default_register()),
                    },
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
        "hrsh7th/nvim-cmp",
        dependencies = {
            "micangl/cmp-vimtex",
            "hrsh7th/cmp-cmdline",
        },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local cmp = require("cmp")

            -- sources
            table.insert(opts.sources, { name = "vimtex" })

            -- mappings
            opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
                ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1)),
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1)),
                ["<C-c>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ["<C-k>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                }),
            })

            opts.window = {
                documentation = cmp.config.window.bordered(),
                completion = cmp.config.window.bordered(),
            }

            return opts
        end,
        init = function()
            local cmp = require("cmp")
            vim.cmd([[
               func EatcharAbbr(pat)
                let c = nr2char(getchar(0))
                return (c =~ a:pat) ? '' : c
               endfunc
               cabbr <silent> e e ./<C-R>=EatcharAbbr('\s')<CR>
            ]])
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline({
                    ["<C-k>"] = {
                        c = function()
                            cmp.confirm({
                                behavior = cmp.ConfirmBehavior.Insert,
                                select = true,
                            })
                            cmp.complete()
                        end,
                    },
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                confirm_opts = {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                },
                -- sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
                sources = cmp.config.sources({
                    {
                        name = "path",
                        priority = 1,
                    },
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = { "edit" },
                        },
                    },
                }),
                formatting = {
                    format = function(entry, item)
                        if entry.source.name == "cmdline" then
                            item.kind = ""
                        else
                            local icons = LazyVim.config.icons.kinds
                            if icons[item.kind] then
                                item.kind = icons[item.kind] .. item.kind
                            end
                        end
                        return item
                    end,
                },
            })
        end,
    },
}
