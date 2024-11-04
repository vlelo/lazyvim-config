-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- remove default mapping and keep digraphs
vim.keymap.set("i", "<C-i>", "<C-k>", { desc = "Digraphs" })

-- vim.keymap.del("n", "<S-h>")
-- vim.keymap.del("n", "<S-l>")

-- vim.keymap.set("n", "gw", "*N")
-- vim.keymap.set("x", "gw", "*N")

vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>")
vim.keymap.set({ "", "n", "v", "x", "s", "o", "!", "i", "l", "t" }, "<M-w>", "<cmd>write<cr>", { desc = "Save file" })

vim.keymap.set(
    { "", "n", "v", "x", "s", "o", "!", "i", "l", "t" },
    "<M-s>",
    "<cmd>set list!<cr>",
    { desc = "Save file" }
)

-- vim.keymap.del("n", "<leader>l")
-- vim.keymap.del("n", "<leader>L")
--
-- vim.keymap.del("n", "]b")
-- vim.keymap.del("n", "[b")
-- vim.keymap.del("n", "]q")
-- vim.keymap.del("n", "[q")
-- vim.keymap.del("n", "]e")
-- vim.keymap.del("n", "[e")

-- local diagnostic_goto = function(next, severity)
--     local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
--     severity = severity and vim.diagnostic.severity[severity] or nil
--     return function()
--         go({ severity = severity })
--     end
-- end
-- vim.keymap.set("n", "]r", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
-- vim.keymap.set("n", "[r", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })

vim.keymap.set("n", "<c-c><c-c>", function()
    vim.g.force_exit = true
    vim.api.nvim_input("<cmd>qa<cr>")
end, { desc = "Quit Noevim Force" })

vim.keymap.set("t", "##", "<cmd>put #<cr>", { desc = "Insert alternate file name in terminal" })
