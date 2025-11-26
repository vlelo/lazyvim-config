local LazyVim = require("lazyvim.util")
local function dash_header()
    if vim.g.neovide then
        return [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███████╗ ███████╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║██╔═══██╗██╔════╝
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██║   ██║█████╗  
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║   ██║██╔══╝  
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║███████╔╝███████╗
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚══════╝ ╚══════╝]]
    else
        return [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]
    end
end
return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        opts = {
            experimental = { check_rtp_message = false },
            html = {
                enable = false,
            },
            latex = {
                enable = false,
            },
        },
    },

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
            --  enabled = true,
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
            options = {
                disabled_filetypes = { winbar = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
            },
            winbar = {
                lualine_a = {},
                lualine_b = { { LazyVim.lualine.pretty_path() } },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    {
                        "aerial",
                        sep = " ", -- separator between symbols
                        sep_icon = "", -- separator between icon and symbol
                        depth = 5,
                        dense = false,
                        dense_sep = ".",
                        colored = true,
                    },
                },
            },
            lualine_z = {},
            inactive_winbar = {
                lualine_a = {},
                lualine_b = { { LazyVim.lualine.pretty_path() } },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            extensions = {
                "man",
                "quickfix",
                "fzf",
                "lazy",
                "mason",
                "neo-tree",
                "overseer",
                "trouble",
                {
                    filetypes = { "toggleterm" },
                    sections = {
                        lualine_a = {
                            function()
                                return "ToggleTerm #" .. vim.b.toggle_number
                            end,
                        },
                        lualine_b = {
                            "mode",
                            function()
                                return require("capslock").status_string()
                            end,
                        },
                        lualine_z = {
                            function()
                                local id = vim.b.terminal_job_id
                                if id then
                                    local info = vim.api.nvim_get_chan_info(id)
                                    if info and info.argv then
                                        return info.argv[1]
                                    end
                                end

                                -- This will be only the starting process (shell)
                                local bufname = vim.api.nvim_buf_get_name(0)
                                -- term://{cwd}//{pid}:{cmd}
                                -- or in toggleterm:
                                -- term://{cwd}//{pid}:{cmd};#toggleterm#{num}
                                return bufname:match("term://.*//%d+:(.+);#toggleterm#%d+") or bufname
                            end,
                        },
                    },
                },
                {
                    filetypes = { "oil" },
                    sections = {
                        lualine_a = {
                            function()
                                local ok, oil = pcall(require, "oil")
                                if ok then
                                    return vim.fn.fnamemodify(oil.get_current_dir(), ":~")
                                else
                                    return ""
                                end
                            end,
                        },
                        lualine_z = {
                            {
                                function()
                                    return vim.fn.fnamemodify(vim.uv.cwd(), ":~")
                                end,
                                color = "WarningMsg",
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            -- brute force remove copilot
            table.remove(opts.sections.lualine_x, 2)

            -- brute force remove aerial
            table.remove(opts.sections.lualine_c, #opts.sections.lualine_c)

            -- remove time
            table.remove(opts.sections.lualine_z, 1)
            return opts
        end,
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
            indent = {
                filter = function(buf)
                    return vim.g.snacks_indent ~= false
                        and vim.b[buf].snacks_indent ~= false
                        and vim.bo[buf].buftype == ""
                        and vim.bo[buf].filetype ~= "tex"
                end,
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
                math = {
                    latex = {
                        packages = {
                            "amsmath",
                            "amssymb",
                            "amsfonts",
                            "amscd",
                            "mathtools",
                            "bm",
                            "epmheq",
                            "xfrac",
                            "siunitx",
                            "mhchem",
                            "fmtcount",
                            "tikz",
                            "circuitikz",
                            "tikz-timing",
                            "nicematrix",
                        },
                    },
                },
            },
            picker = {
                win = {
                    input = {
                        keys = {
                            ["<M-n>"] = { "toggle_hidden", mode = { "i", "n" } },
                            ["<M-m>"] = { "toggle_maximize", mode = { "i", "n" } },
                        },
                    },
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
                    header = dash_header(),
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
                        cwd = true,
                    },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Projects",
                        section = "projects",
                        indent = 2,
                        padding = 1,
                        limit = 10,
                        pick = true,
                        session = false,
                    },
                    { section = "startup" },
                },
            },
        },
    },
    {
        "hat0uma/csvview.nvim",
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    },
}
