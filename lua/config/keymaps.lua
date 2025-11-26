-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- remove default mapping and keep digraphs
vim.keymap.set("i", "<C-;>", "<C-k>", { desc = "Digraphs" })

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

--
-- Disable stupid LazyVim mappings
--
vim.keymap.del("n", "<leader>gG") -- lazygit in root

require("unimpaired").setup({
    default_keymaps = false,
    keymaps = {
        previous = {
            mapping = "[a",
            description = "Previous file in arglist",
            dot_repeat = true,
        },
        next = {
            mapping = "]a",
            description = "Next file in arglist",
            dot_repeat = true,
        },
        first = {
            mapping = "[A",
            description = "First file in arglist",
            dot_repeat = false,
        },
        last = {
            mapping = "]A",
            description = "Last file in arglist",
            dot_repeat = false,
        },
        bprevious = {
            mapping = "[b",
            description = "Previous buffer",
            dot_repeat = true,
        },
        bnext = {
            mapping = "]b",
            description = "Next buffer",
            dot_repeat = true,
        },
        bfirst = {
            mapping = "[B",
            description = "First buffer",
            dot_repeat = false,
        },
        blast = {
            mapping = "]B",
            description = "Last buffer",
            dot_repeat = false,
        },
        lprevious = {
            mapping = "[l",
            description = "Previous entry in loclist",
            dot_repeat = true,
        },
        lnext = {
            mapping = "]l",
            description = "Next entry in loclist",
            dot_repeat = true,
        },
        lfirst = {
            mapping = "[L",
            description = "First entry in loclist",
            dot_repeat = false,
        },
        llast = {
            mapping = "]L",
            description = "Last entry in loclist",
            dot_repeat = false,
        },
        lpfile = {
            mapping = "[<C-l>",
            description = "Last entry of [count] previous file in loclist",
            dot_repeat = true,
        },
        lnfile = {
            mapping = "]<C-l>",
            description = "First entry of [count] next file in loclist",
            dot_repeat = true,
        },
        -- cprevious = {
        --     mapping = "[q",
        --     description = "Previous entry in qflist",
        --     dot_repeat = true,
        -- },
        -- cnext = {
        --     mapping = "]q",
        --     description = "Next entry in qflist",
        --     dot_repeat = true,
        -- },
        cfirst = {
            mapping = "[Q",
            description = "First entry in qflist",
            dot_repeat = false,
        },
        clast = {
            mapping = "]Q",
            description = "Last entry in qflist",
            dot_repeat = false,
        },
        cpfile = {
            mapping = "[<C-q>",
            description = "Last entry of [count] previous file in qflist",
            dot_repeat = true,
        },
        cnfile = {
            mapping = "]<C-q>",
            description = "First entry of [count] next file in qflist",
            dot_repeat = true,
        },
        -- tprevious = false,
        -- tnext = false,
        -- tfirst = false,
        -- tlast = false,
        -- ptprevious = false,
        -- ptnext = false,
        -- previous_file = {
        --     mapping = '[f',
        --     description = 'Previous file in directory. :colder in qflist',
        --     dot_repeat = true,
        -- },
        -- next_file = {
        --     mapping = ']f',
        --     description = 'Next file in directory. :cnewer in qflist',
        --     dot_repeat = true,
        -- },
        blank_above = {
            mapping = "[<Space>",
            description = "Add [count] blank lines above",
            dot_repeat = true,
        },
        blank_below = {
            mapping = "]<Space>",
            description = "Add [count] blank lines below",
            dot_repeat = true,
        },
        exchange_above = {
            mapping = "[e",
            description = "Exchange line with [count] lines above",
            dot_repeat = true,
        },
        exchange_below = {
            mapping = "]e",
            description = "Exchange line with [count] lines below",
            dot_repeat = true,
        },
        exchange_section_above = {
            mapping = "[e",
            description = "Move section [count] lines up",
            dot_repeat = true,
        },
        exchange_section_below = {
            mapping = "]e",
            description = "Move section [count] lines down",
            dot_repeat = true,
        },
    },
})

vim.keymap.set({ "i" }, "<D-v>", "<C-r><C-o>+", { desc = "MacOS Paste" })
vim.keymap.set({ "n" }, "<D-v>", '<ESC>"+p', { desc = "MacOS Paste" })
vim.keymap.set({ "t" }, "<D-v>", '<C-\\><C-n>"+p', { desc = "MacOS Paste" })

vim.keymap.set({ "v" }, "<D-c>", '"+y', { desc = "MacOS Copy" })
vim.keymap.set({ "n" }, "<leader>qq", function()
    vim.g.force_exit = true
    vim.cmd("qa")
end, { desc = "Quit All" })

if vim.g.neovide then
    -- vim.keymap.set("n", "<D-n>", "<cmd>silent exec '!cd ~ && neovide --fork'<cr>", { desc = "Open new Neovide window" })
    vim.keymap.set("n", "<D-n>", function()
        ---@diagnostic disable-next-line: missing-fields
        local handle, pid = vim.uv.spawn("neovide", {
            args = { "--fork" },
            cwd = vim.fn.expand("~", nil, nil),
        }, function(code, signal) end)

        vim.uv.unref(handle)
    end, { desc = "Open new Neovide window" })
end

vim.keymap.del("n", "<leader>l")
vim.keymap.del("n", "<leader>L")

vim.keymap.set("n", "go", function()
    local dir = vim.fn.expand("%:p:h")
    local uname = vim.loop.os_uname().sysname
    if uname == "Linux" then
        os.execute("xdg-open " .. dir)
    elseif uname == "Darwin" then
        os.execute("open " .. dir)
    elseif uname == "Windows_NT" then
        os.execute("explorer.exe " .. dir)
    else
        vim.notify("Unsupported OS: " .. uname)
    end
end, {
    desc = "Open folder",
})
