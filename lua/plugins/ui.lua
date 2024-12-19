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
    {
        "OXY2DEV/foldtext.nvim",
        -- lazy = false,
        opts = {
            default = {
                -- {
                --     type = "indent",
                --     hl = "TabLineSel",
                -- },
                -- {
                --     type = "raw",
                --     text = " ",
                --     hl = "Title",
                -- },
                {
                    type = "raw",
                    text = function(_, buf)
                        local ln = vim.fn.getbufline(buf, vim.v.foldstart)

                        return ln
                    end,
                },
                {
                    type = "raw",
                    text = function(win, buf)
                        local ln = vim.fn.getbufline(buf, vim.v.foldstart)[1]:len()
                        local w = vim.api.nvim_win_get_width(win)
                        local off = vim.fn.getwininfo(win)[1].textoff
                        local diff = vim.fn.strchars(" " .. tostring(vim.v.foldend - vim.v.foldstart) .. " lines ")

                        return string.rep("─", math.floor((w - off - diff - ln) / 2))
                    end,
                    hl = "Comment",

                    gradient_repeat = true,
                },
                {
                    type = "fold_size",
                    prefix = " ",
                    postfix = " lines ",
                },
                {
                    type = "raw",
                    text = function(win, buf)
                        local ln = vim.fn.getbufline(buf, vim.v.foldstart)[1]:len()
                        local w = vim.api.nvim_win_get_width(win)
                        local off = vim.fn.getwininfo(win)[1].textoff
                        local diff = tostring(vim.v.foldend - vim.v.foldstart)

                        return string.rep("─", math.ceil((w - off - 2 - ln - vim.fn.strchars(diff)) / 2))
                    end,
                    hl = "Comment",

                    gradient_repeat = true,
                },
            },
        },
    },
    { "tiagovla/scope.nvim", config = true },
}
