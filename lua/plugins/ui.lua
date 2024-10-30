return {
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = function(_, opts)
            opts.indent = nil

            return opts
        end,
    },

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
}
