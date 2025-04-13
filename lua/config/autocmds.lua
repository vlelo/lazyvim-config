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

vim.api.nvim_create_user_command("R", function()
    vim.cmd("tabnew")
    vim.cmd("tabclose #")
    vim.fn.chdir(vim.fn.expand("~", nil, nil))
    local startpage = vim.api.nvim_get_current_buf()
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        if buf ~= startpage then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
    for _, lsp in pairs(vim.lsp.get_clients()) do
        vim.lsp.stop_client(lsp.id)
    end
    require("snacks").dashboard()
end, { desc = "Restart Neovim session" })

-- vim.api.nvim_create_autocmd("FileType", {
--     group = augroup("set_formatoptions"),
--     command = "set formatoptions-=o",
--     desc = "Remove `o` formatoptions set by most ftplugins.",
-- })

if vim.g.neovide then
    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "ExitPreventCleanup",
        group = augroup("exit_is_reset_callback"),
        callback = function()
            vim.cmd("tabclose #")
            require("snacks").dashboard()
            vim.fn.chdir(vim.fn.expand("~", nil, nil))
            local startpage = vim.api.nvim_get_current_buf()
            local buffers = vim.api.nvim_list_bufs()
            for _, buf in ipairs(buffers) do
                if buf ~= startpage then
                    vim.api.nvim_buf_delete(buf, { force = true })
                end
            end
        end,
        desc = "Cleanup after preventing vim from exiting.",
    })

    if vim.fn.argc() ~= 0 then
        vim.g.force_exit = true
    end

    vim.api.nvim_create_autocmd({ "ExitPre" }, {
        group = augroup("exit_is_reset"),
        callback = function()
            if vim.g.force_exit == true then
                return
            end
            vim.cmd("tabnew ~")
            vim.api.nvim_exec_autocmds("User", {
                pattern = "ExitPreventCleanup",
            })
        end,
        desc = "Close all buffers and reset to Home when exiting in GUI and not forcing",
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
