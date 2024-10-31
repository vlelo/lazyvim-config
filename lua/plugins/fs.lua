return {
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        -- Optional dependencies
        dependencies = {
            { "echasnovski/mini.icons", opts = {} },
            { "chrishrb/gx.nvim" },
        },
        opts = {
            default_file_explorer = true,
            default_to_trash = true,
            skip_confirms_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                natural_order = true,
                is_always_hidden = function(name, _)
                    return name == "." or name == ".." or name == ".git"
                end,
            },
            keymaps = {
                ["<c-j>"] = "actions.select",
            },
            win_options = {
                wrap = true,
            },
        },
        keys = {
            { "-", "<cmd>Oil<CR>", desc = "Open Oil" },
        },
        cmd = { "Oil" },
    },
}
