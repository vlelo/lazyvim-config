-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.hidden = true

vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true

vim.opt.formatoptions:remove("o")
vim.opt.formatoptions:append("1")

vim.opt.whichwrap:append(">")
vim.opt.whichwrap:append("<")

vim.opt.list = false
vim.opt.listchars:append("eol:↲")
vim.opt.listchars:append("tab:<->")
vim.opt.listchars:append("multispace:-+")
vim.opt.listchars:append("lead:·")
vim.opt.listchars:append("trail:+")

vim.opt.iskeyword:append("-")

-- LazyVim options
vim.g.lazyvim_python_lsp = "basedpyright"
-- vim.g.lazyvim_picker = "telescope"

if vim.g.neovide then
    local function update_env_from_login_shell()
        local shell = os.getenv("SHELL") or "/bin/zsh"
        local cmd = " -l -c " .. "source ~/.config/zsh/.zshenv;" .. "source ~/.config/zsh/.zshrc;" .. "env"
        local output = vim.fn.system(shell .. cmd)
        if vim.v.shell_error ~= 0 then
            vim.notify("Failed to get environment from login shell", vim.log.levels.ERROR)
            return
        end
        for line in output:gmatch("[^\r\n]+") do
            local key, value = line:match("^(.-)=(.*)$")
            if key and value then
                vim.env[key] = value
            end
        end
    end

    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_input_macos_option_key_is_meta = "both"
    vim.g.neovide_input_ime = false

    update_env_from_login_shell()

    if vim.fn.getcwd() == "/" then
        if vim.fn.argc() == 0 then
            vim.fn.chdir(vim.fn.expand("~", nil, nil))
        end
    end
end
