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
            direction = "tab",
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
                        "<c-/>",
                        '<Cmd>exe v:count1 . "ToggleTerm direction=tab"<CR>',
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
                "<c-/>",
                '<cmd>execute v:count1 . "ToggleTerm direction=tab"<cr>',
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
        "folke/edgy.nvim",
        opts = {
            bottom = {
                -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
                {
                    ft = "toggleterm",
                    size = { height = 0.4 },
                    filter = function(buf, win)
                        local terms = require("toggleterm.terminal")
                        local _, term = terms.identify()
                        return vim.api.nvim_win_get_config(win).relative == ""
                            and term ~= nil
                            and term.direction ~= "tab"
                    end,
                },
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
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            styles = {
                snacks_image = {
                    relative = "editor",
                    col = -1,
                },
            },
            image = {
                enabled = true,
                wo = {
                    winhighlight = "FloatBorder:WhichKeyBorder",
                },
                doc = {
                    inline = false,
                    max_width = 45,
                    max_height = 20,
                },
            },
            dashboard = {
                enabled = true,
                pane_gap = 6,
                preset = {
                    keys = {
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.dashboard.pick('files')",
                        },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Find Text",
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                        },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        {
                            icon = "󰒲 ",
                            key = "l",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        {
                            icon = " ",
                            key = "/",
                            desc = "Terminal",
                            action = ":execute v:count1 . 'ToggleTerm direction=tab'",
                        },
                        {
                            icon = " ",
                            key = "q",
                            desc = "Quit",
                            action = function()
                                vim.g.force_exit = true
                                vim.cmd("qa")
                            end,
                        },
                    },
                    header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
                },
                sections = {
                    { section = "header", pane = 1 },
                    { section = "keys", gap = 1, padding = 1, pane = 1 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        indent = 2,
                        padding = 1,
                        limit = 10,
                    },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Projects",
                        section = "projects",
                        indent = 2,
                        padding = 1,
                        limit = 10,
                    },
                    { section = "startup" },
                },
            },
        },
    },
}
