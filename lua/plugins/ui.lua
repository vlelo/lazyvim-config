return {
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     opts = {
    --         exclude = { filetypes = { "oil" } },
    --     },
    -- },
    {
        "folke/edgy.nvim",
        opts = {
            keys = {
                -- increase width
                ["<M-l>"] = function(win)
                    win:resize("width", 2)
                end,
                -- decrease width
                ["<M-h>"] = function(win)
                    win:resize("width", -2)
                end,
                -- increase height
                ["<M-k>"] = function(win)
                    win:resize("height", 2)
                end,
                -- decrease height
                ["<M-j>"] = function(win)
                    win:resize("height", -2)
                end,
                -- increase width
                ["<M-Right>"] = function(win)
                    win:resize("width", 2)
                end,
                -- decrease width
                ["<M-Left>"] = function(win)
                    win:resize("width", -2)
                end,
                -- increase height
                ["<M-Up>"] = function(win)
                    win:resize("height", 2)
                end,
                -- decrease height
                ["<M-Down>"] = function(win)
                    win:resize("height", -2)
                end,
            },
        },
    },
    -- {
    --     "OXY2DEV/foldtext.nvim",
    --     -- lazy = false,
    --     opts = {
    --         styles = {
    --             default = {
    --                 {
    --                     kind = "bufline",
    --                     delimiter = "...",
    --                     hl = "@comment",
    --                 },
    --                 {
    --                     kind = "section",
    --                     output = {
    --                         { " ", "@comment" },
    --                         { "----", "@comment" },
    --                     },
    --                 },
    --                 {
    --                     kind = "fold_size",
    --                     condition = function()
    --                         return true
    --                     end,
    --                     hl = "@number",
    --
    --                     icon = "󰘕 ",
    --                     icon_hl = "@string",
    --
    --                     padding_left = " ",
    --                     padding_left_hl = nil,
    --                     padding_right = " ",
    --                     padding_right_hl = nil,
    --                 },
    --                 -- {
    --                 --     kind = "section",
    --                 --     output = {
    --                 --         { "----", "@comment" },
    --                 --     },
    --                 -- },
    --                 -- {
    --                 --     kind = "section",
    --                 --     output = function(_, window)
    --                 --         local diag_icons = {
    --                 --             [vim.diagnostic.severity.ERROR] = "󰅙 ",
    --                 --             [vim.diagnostic.severity.WARN] = " ",
    --                 --             [vim.diagnostic.severity.INFO] = " ",
    --                 --             [vim.diagnostic.severity.HINT] = "󱠃 ",
    --                 --         }
    --                 --         local diag_hls = {
    --                 --             [vim.diagnostic.severity.ERROR] = "DiagnosticError",
    --                 --             [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
    --                 --             [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    --                 --             [vim.diagnostic.severity.HINT] = "DiagnosticHint",
    --                 --         }
    --                 --
    --                 --         local diag_counts = {}
    --                 --         for lnum = vim.v.foldstart - 1, vim.v.foldend - 1 do
    --                 --             for severity, value in pairs(vim.diagnostic.count(0, { lnum = lnum })) do
    --                 --                 diag_counts[severity] = value + (diag_counts[severity] or 0)
    --                 --             end
    --                 --         end
    --                 --
    --                 --         local chunks = {}
    --                 --         for severity = vim.diagnostic.severity.ERROR, vim.diagnostic.severity.HINT do
    --                 --             if diag_counts[severity] then
    --                 --                 table.insert(chunks, {
    --                 --                     string.format(" %s%d", diag_icons[severity], diag_counts[severity]),
    --                 --                     diag_hls[severity],
    --                 --                 })
    --                 --                 table.insert(chunks, { " --", "@comment" })
    --                 --             end
    --                 --         end
    --                 --         return chunks
    --                 --     end,
    --                 -- },
    --                 -- {
    --                 --     kind = "section",
    --                 --     output = {
    --                 --         { "--", "@comment" },
    --                 --     },
    --                 -- },
    --                 -- {
    --                 --     kind = "section",
    --                 --     condition = function()
    --                 --         return vim.o.hlsearch and vim.v.hlsearch ~= 0
    --                 --     end,
    --                 --     output = function(_, window)
    --                 --         -- if not vim.o.hlsearch or vim.v.hlsearch == 0 then
    --                 --         --     return {}
    --                 --         -- end
    --                 --         local sucess, matches =
    --                 --             pcall(vim.fn.matchbufline, 0, vim.fn.getreg("/"), vim.v.foldstart, vim.v.foldend)
    --                 --         if not sucess then
    --                 --             return
    --                 --         end
    --                 --
    --                 --         local searchcount = #matches
    --                 --         -- if searchcount > 0 then
    --                 --         return {
    --                 --             { " ", "@comment" },
    --                 --             { " ", "@string" },
    --                 --             { tostring(searchcount), "@number" },
    --                 --             { " ", "@comment" },
    --                 --         }
    --                 --         -- end
    --                 --     end,
    --                 -- },
    --                 -- {
    --                 --     kind = "section",
    --                 --     output = function(_, window)
    --                 --         local width = vim.api.nvim_win_get_width(window)
    --                 --         local textoff = vim.fn.getwininfo(window)[1].textoff
    --                 --
    --                 --         width = width - textoff
    --                 --
    --                 --         local size = (vim.v.foldend - vim.v.foldstart) + 1
    --                 --         local len = vim.fn.strdisplaywidth(" " .. tostring(size) .. " lines ")
    --                 --
    --                 --         return {
    --                 --             { string.rep("-", math.ceil(width - len)), "@comment" },
    --                 --         }
    --                 --     end,
    --                 -- },
    --             },
    --         },
    --     },
    -- },
    { "tiagovla/scope.nvim", config = true },
    {
        "nvim-zh/colorful-winsep.nvim",
        config = true,
        event = { "WinLeave" },
    },
}
