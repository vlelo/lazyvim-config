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
                ["<c-j>"] = { "actions.select" },
                ["<C-CR>"] = { "actions.open_terminal", desc = "Open terminal in folder" },
            },
            win_options = {
                wrap = true,
            },
        },
        keys = {
            { "-", "<cmd>Oil<CR>", desc = "Open Oil" },
        },
        cmd = { "Oil" },
        lazy = false,
        -- init = function()
        --     -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
        --     -- because `cwd` is not set up properly.
        --     vim.api.nvim_create_autocmd("BufEnter", {
        --         group = vim.api.nvim_create_augroup("Oil_start_directory", { clear = true }),
        --         desc = "Start Oil with directory",
        --         once = true,
        --         callback = function()
        --             if package.loaded["oil"] then
        --                 return
        --             else
        --                 local stats = vim.uv.fs_stat(vim.fn.argv(0))
        --                 if stats and stats.type == "directory" then
        --                     require("oil")
        --                 end
        --             end
        --         end,
        --     })
        -- end,
    },
}
