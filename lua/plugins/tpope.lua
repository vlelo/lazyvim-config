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
        event = "VeryLazy",
        opts = {
            default_keymaps = false,
            keymaps = {
                previous = {
                    mapping = "[a",
                    description = "Previous file in arglist",
                    dot_repeat = true,
                },
                next = {
                    mapping = "]a",
                    description = "Next file in arglist",
                    dot_repeat = true,
                },
                first = {
                    mapping = "[A",
                    description = "First file in arglist",
                    dot_repeat = false,
                },
                last = {
                    mapping = "]A",
                    description = "Last file in arglist",
                    dot_repeat = false,
                },
                bprevious = {
                    mapping = "[b",
                    description = "Previous buffer",
                    dot_repeat = true,
                },
                bnext = {
                    mapping = "]b",
                    description = "Next buffer",
                    dot_repeat = true,
                },
                bfirst = {
                    mapping = "[B",
                    description = "First buffer",
                    dot_repeat = false,
                },
                blast = {
                    mapping = "]B",
                    description = "Last buffer",
                    dot_repeat = false,
                },
                lprevious = {
                    mapping = "[l",
                    description = "Previous entry in loclist",
                    dot_repeat = true,
                },
                lnext = {
                    mapping = "]l",
                    description = "Next entry in loclist",
                    dot_repeat = true,
                },
                lfirst = {
                    mapping = "[L",
                    description = "First entry in loclist",
                    dot_repeat = false,
                },
                llast = {
                    mapping = "]L",
                    description = "Last entry in loclist",
                    dot_repeat = false,
                },
                lpfile = {
                    mapping = "[<C-l>",
                    description = "Last entry of [count] previous file in loclist",
                    dot_repeat = true,
                },
                lnfile = {
                    mapping = "]<C-l>",
                    description = "First entry of [count] next file in loclist",
                    dot_repeat = true,
                },
                -- cprevious = {
                --     mapping = "[q",
                --     description = "Previous entry in qflist",
                --     dot_repeat = true,
                -- },
                -- cnext = {
                --     mapping = "]q",
                --     description = "Next entry in qflist",
                --     dot_repeat = true,
                -- },
                cfirst = {
                    mapping = "[Q",
                    description = "First entry in qflist",
                    dot_repeat = false,
                },
                clast = {
                    mapping = "]Q",
                    description = "Last entry in qflist",
                    dot_repeat = false,
                },
                cpfile = {
                    mapping = "[<C-q>",
                    description = "Last entry of [count] previous file in qflist",
                    dot_repeat = true,
                },
                cnfile = {
                    mapping = "]<C-q>",
                    description = "First entry of [count] next file in qflist",
                    dot_repeat = true,
                },
                -- tprevious = false,
                -- tnext = false,
                -- tfirst = false,
                -- tlast = false,
                -- ptprevious = false,
                -- ptnext = false,
                -- previous_file = {
                --     mapping = '[f',
                --     description = 'Previous file in directory. :colder in qflist',
                --     dot_repeat = true,
                -- },
                -- next_file = {
                --     mapping = ']f',
                --     description = 'Next file in directory. :cnewer in qflist',
                --     dot_repeat = true,
                -- },
                blank_above = {
                    mapping = "[<Space>",
                    description = "Add [count] blank lines above",
                    dot_repeat = true,
                },
                blank_below = {
                    mapping = "]<Space>",
                    description = "Add [count] blank lines below",
                    dot_repeat = true,
                },
                exchange_above = {
                    mapping = "[e",
                    description = "Exchange line with [count] lines above",
                    dot_repeat = true,
                },
                exchange_below = {
                    mapping = "]e",
                    description = "Exchange line with [count] lines below",
                    dot_repeat = true,
                },
                exchange_section_above = {
                    mapping = "[e",
                    description = "Move section [count] lines up",
                    dot_repeat = true,
                },
                exchange_section_below = {
                    mapping = "]e",
                    description = "Move section [count] lines down",
                    dot_repeat = true,
                },
            },
        },
    },
}
