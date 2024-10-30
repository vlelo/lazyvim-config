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
vim.g.lazyvim_picker = "telescope"
