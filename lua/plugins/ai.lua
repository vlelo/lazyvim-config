return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim", branch = "master" },
            {
                "folke/edgy.nvim",
                optional = true,
                opts = function(_, opts)
                    opts.right = opts.right or {}
                    for _, view in pairs(opts.right) do
                        if view.ft == "copilot-chat" then
                            view.size.width = 100
                        end
                    end
                end,
            },
        },
        build = "make tiktoken",
        opts = {
            model = "claude-3.5-sonnet",
            selection = function(source)
                local select = require("CopilotChat.select")
                return select.visual(source) or select.buffer(source)
            end,
            window = {
                width = 0.5,
            },
        },
    },
}
