return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return math.floor(vim.o.lines * 0.3)
                elseif term.direction == "vertical" then
                    return math.floor(vim.o.columns * 0.4)
                end
            end,
            open_mapping = "<F12>",
            direction = "float",
            close_on_exit = false,
            float_opts = {
                border = "curved",
                width = function()
                    return math.floor(vim.o.columns * 0.7)
                end,
                height = function()
                    return math.floor(vim.o.lines * 0.7)
                end,
            },
            -- winbar = {
            --     enabled = true,
            --     name_formatter = function(term) --  term: Terminal
            --         return term.name
            --     end,
            -- },
            -- highlights = {
            --     Normal = {
            --         link = "Normal",
            --     },
            -- },
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)
            vim.api.nvim_create_autocmd("TermEnter", {
                pattern = "term://*toggleterm#*",
                callback = function(event)
                    vim.keymap.set(
                        "t",
                        "<c-\\>",
                        '<Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>',
                        { buffer = event.buf }
                    )
                    vim.keymap.set(
                        "t",
                        "<c-]>",
                        '<Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>',
                        { buffer = event.buf }
                    )
                end,
                desc = "Attach toggleterm bindings to toggleterm buffers",
                group = vim.api.nvim_create_augroup("ToggleTermKeys", { clear = true }),
            })
        end,
        cmd = { "ToggleTerm" },
        keys = {
            {
                "<c-\\>",
                '<cmd>execute v:count1 . "ToggleTerm direction=float"<cr>',
                desc = "Floating terminal",
                mode = { "n", "i" },
            },
            {
                "<C-]>",
                '<cmd>execute v:count1 . "ToggleTerm direction=horizontal"<cr>',
                desc = "Horizontal terminal",
                mode = { "n", "i" },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            extensions = {
                "toggleterm",
                "man",
                "quickfix",
            },
        },
    },
}
