return {
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                border = "rounded",
            },
        },
    },

    {
        "neovim/nvim-lspconfig",
        init = function()
            local win = require("lspconfig.ui.windows")
            win.default_options.border = "rounded"

            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or "rounded"
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            local float = { focusable = true, style = "minimal", border = "rounded" }
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float)
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
        end,
        opts = {
            diagnostics = {
                float = {
                    border = "rounded",
                },
            },
        },
    },

    {
        "folke/noice.nvim",
        opts = {
            presets = {
                lsp_doc_border = true,
            },
        },
    },
    {
        "folke/which-key.nvim",
        opts = {
            replace = {
                desc = {
                    { "gG", "Toggle Capslock" },
                },
            },
            icons = {
                breadcrumb = "»",
                separator = "➜",
                group = "·",
            },
            win = {
                border = "rounded",
            },
        },
    },
}
