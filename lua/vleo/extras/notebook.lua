local Util = require("lazyvim.util")

local M = {}

M.spec = {
    {
        "benlubas/molten-nvim",
        dependencies = {
            {
                "3rd/image.nvim",
                config = {
                    backend = "kitty",
                    max_width = 100,
                    max_height = 12,
                    max_height_window_percentage = math.huge, -- this is necessary for a good experience
                    max_width_window_percentage = math.huge,
                    window_overlap_clear_enabled = true,
                    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
                },
            },
        },
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_output_win_max_height = 12
            vim.g.python3_host_prog = vim.fn.expand(vim.env.VENV_HOME .. "/neovim/bin/python3")
            -- I find auto open annoying, keep in mind setting this option will require setting
            -- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
            vim.g.molten_auto_open_output = true

            -- this guide will be using image.nvim
            -- Don't forget to setup and install the plugin if you want to view image outputs
            vim.g.molten_image_provider = "image.nvim"

            -- optional, I like wrapping. works for virt text and the output window
            vim.g.molten_wrap_output = true

            -- Output as virtual text. Allows outputs to always be shown, works with images, but can
            -- be buggy with longer images
            vim.g.molten_virt_text_output = true

            -- this will make it so the output shows up below the \`\`\` cell delimiter
            vim.g.molten_virt_lines_off_by_1 = true

            vim.keymap.set(
                "n",
                "<localleader>e",
                "<cmd>MoltenEvaluateOperator<CR>",
                { desc = "evaluate operator", silent = true }
            )
            vim.keymap.set(
                "n",
                "<localleader>os",
                "<cmd>noautocmd MoltenEnterOutput<CR>",
                { desc = "open output window", silent = true }
            )
            vim.keymap.set(
                "n",
                "<localleader>rr",
                ":MoltenReevaluateCell<CR>",
                { desc = "re-eval cell", silent = true }
            )
            vim.keymap.set(
                "v",
                "<localleader>r",
                "<cmd><C-u>MoltenEvaluateVisual<CR>gv",
                { desc = "execute visual selection", silent = true }
            )
            vim.keymap.set(
                "n",
                "<localleader>oh",
                "<cmd>MoltenHideOutput<CR>",
                { desc = "close output window", silent = true }
            )
            vim.keymap.set(
                "n",
                "<localleader>md",
                "<cmd>MoltenDelete<CR>",
                { desc = "delete Molten cell", silent = true }
            )

            -- if you work with html outputs:
            vim.keymap.set(
                "n",
                "<localleader>mx",
                "<cmd>MoltenOpenInBrowser<CR>",
                { desc = "open output in browser", silent = true }
            )
        end,
    },
}

return M.spec

-- venv project_name # activate the project venv
-- pip install ipykernel
-- python -m ipykernel install --user --name project_name
