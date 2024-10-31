return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = true,
        cmd = { "Neogit" },
        keys = {
            { "<leader>G", ":Neogit<CR>", desc = "Neogit" },
        },
    },
}
