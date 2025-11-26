return {
    {
        "NotAShelf/direnv.nvim",
        config = function()
            require("direnv").setup({})
        end,
        cmd = {
            "Direnv",
        },
    },
    -- {
    --     "neovim/nvim-lspconfig",
    --     opts = {
    --         setup = {
    --             ruff = function(_, opts)
    --                 opts.capabilities.offsetEncoding = { "utf-16" }
    --                 opts.capabilities.general.positionEncoding = { "utf-16" }
    --             end,
    --         },
    --     },
    -- },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ruff = {
                    capabilities = {
                        general = {
                            positionEncodings = { "utf-16" },
                        },
                        offsetEncoding = { "utf-16" },
                    },
                },
            },
        },
    },
}
