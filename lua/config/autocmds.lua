-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local function augroup(name)
    return vim.api.nvim_create_augroup("cfg_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("noTempUndofile"),
    desc = "Disable undofile for temporary files.",
    pattern = "/tmp/*",
    command = "setlocal noundofile",
})

-- local function RestartSession()
--     vim.cmd("wshada!")
--     vim.cmd("tabnew")
--     vim.cmd("tabclose #")
--
--     vim.fn.chdir(vim.fn.expand("~", nil, nil))
--
--     vim.lsp.stop_client(vim.lsp.get_clients(), false)
--
--     local dashboard = require("snacks").dashboard.open()
--
--     local buffers = vim.api.nvim_list_bufs()
--     for _, buf in ipairs(buffers) do
--         if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
--             vim.api.nvim_buf_delete(buf, { force = true })
--         end
--     end
-- end
--
-- vim.api.nvim_create_user_command("R", RestartSession, { desc = "Restart Neovim session" })
-- vim.keymap.set({ "n" }, "<leader>qr", RestartSession, { desc = "Restart Neovim session" })

if vim.g.neovide then
    -- vim.api.nvim_create_autocmd({ "User" }, {
    --     pattern = "ExitPreventCleanup",
    --     group = augroup("exit_is_reset_callback"),
    --     callback = RestartSession,
    --     desc = "Cleanup after preventing vim from exiting.",
    -- })

    if vim.fn.argc() ~= 0 then
        vim.g.force_exit = true
    end

    vim.api.nvim_create_autocmd({ "ExitPre" }, {
        group = augroup("exit_is_reset"),
        callback = function()
            vim.cmd("wshada!")
            if vim.g.force_exit == true then
                return
            end
            vim.cmd("restart")
        end,
        desc = "Start dashboard and reset to Home when exiting in GUI and not forcing",
    })
end

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    group = augroup("terminal_settings"),
    callback = function()
        vim.cmd("setlocal nonumber")
        vim.cmd("setlocal norelativenumber")
        vim.cmd("startinsert")
    end,
    desc = "Set stuff on :term",
    pattern = "*",
})

vim.api.nvim_create_autocmd({ "DirChanged" }, {
    pattern = "global",
    group = augroup("DirChanged secure.read"),
    callback = function()
        local ok = vim.secure.read(vim.fn.getcwd() .. "/.nvim.lua")
        if not ok then
            return
        elseif type(ok) == "boolean" then
            return
        elseif type(ok) == "string" then
            local f = loadstring(ok)
            if f then
                f()
            end
        end
    end,
    desc = "Read .nvim.lua on DirChanged",
})

-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--     group = augroup("porcodio"),
--     pattern = "*/etc/hosts",
--     command = "quit!",
-- })
