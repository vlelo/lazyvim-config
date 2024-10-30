vim.bo.textwidth = 90
vim.wo.colorcolumn = "90"
vim.o.formatoptions = vim.o.formatoptions .. "t"
vim.o.spell = true
vim.o.cmdheight = 1
vim.o.sidescrolloff = 0

-- vim.diagnostic.config({
-- 	update_in_insert = false,
-- })

vim.keymap.set("n", "<leader>lc", "<plug>(vimtex-compile)", { desc = "Compile document", buffer = true })
vim.keymap.set("n", "<leader>lc", "<plug>(vimtex-compile)", { desc = "Compile document", buffer = true })
vim.keymap.set("n", "<leader>lC", "<plug>(vimtex-compile-ss)", { desc = "Compile document one time", buffer = true })
vim.keymap.set("n", "<leader>lv", "<plug>(vimtex-compile-selected)", { desc = "Compile selected", buffer = true })
vim.keymap.set("n", "<leader>lw", "<cmd>VimtexCountWords<CR>", { desc = "Count words", buffer = true })
vim.keymap.set("n", "<leader>ll", "<plug>(vimtex-view)", { desc = "View line", buffer = true })
vim.keymap.set("n", "<leader>lr", "<plug>(vimtex-reverse-search)", { desc = "Reverse search", buffer = true })
vim.keymap.set("n", "<leader>lx", "<plug>(vimtex-clean)", { desc = "Clean", buffer = true })
vim.keymap.set("n", "<leader>lX", "<plug>(vimtex-clean-full)", { desc = "Full clean", buffer = true })
vim.keymap.set("n", "<leader>la", "<cmd>VimtexContextMenu<CR>", { desc = "Context menu", buffer = true })
vim.keymap.set("n", "<leader>lq", "<cmd>VimtexQFMode<cr>", { desc = "Toggle Quickfix mode", buffer = true })
vim.keymap.set("n", "gO", "<plug>(vimtex-toc-toggle)", { desc = "Toggle ToC", buffer = true })

vim.api.nvim_buf_create_user_command(0, "DeWordify", function()
    vim.cmd([[silent! %s/’/'/g]])
    vim.cmd([[silent! %s/“/``/g]])
    vim.cmd([[silent! %s/”/''/g]])
end, {
    bang = false,
})

vim.api.nvim_buf_create_user_command(0, "VimtexQFMode", function()
    if vim.g.vimtex_quickfix_open_on_warning == 1 then
        vim.g.vimtex_quickfix_open_on_warning = 0
        vim.g.vimtex_quickfix_ignore_filters = {
            -- "Warning",
            [[Entry type for ".*" isn't style-file defined]],
            [[Missing ".*" in]],
            "Overfull",
            "Underfull",
            "specifier changed to",
            "Token not allowed in a PDF string",
        }
    else
        vim.g.vimtex_quickfix_open_on_warning = 1
        vim.g.vimtex_quickfix_ignore_filters = {}
    end
end, {
    bang = false,
})

-- -- local config = require("nvim-surround.config")
-- require("nvim-surround").buffer_setup({
--     surrounds = {
--         -- ["e"] = {
--         --   add = function()
--         --     local env = require("nvim-surround.config").get_input ("Environment: ")
--         --     return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
--         --   end,
--         -- },
--         ["Q"] = {
--             add = { "``", "''" },
--             find = "%b``.-''",
--             delete = "^(``)().-('')()$",
--         },
--         ["q"] = {
--             add = { "`", "'" },
--             find = "`.-'",
--             delete = "^(`)().-(')()$",
--         },
--         ["b"] = {
--             add = { "\\textbf{", "}" },
--             -- add = function()
--             --   if vim.fn["vimtex#syntax#in_mathzone"]() == 1 then
--             --     return { { "\\mathbf{" }, { "}" } }
--             --   end
--             --   return { { "\\textbf{" }, { "}" } }
--             -- end,
--             find = "\\%a-bf%b{}",
--             delete = "^(\\%a-bf{)().-(})()$",
--         },
--         ["i"] = {
--             add = { "\\textit{", "}" },
--             -- add = function()
--             --   if vim.fn["vimtex#syntax#in_mathzone"]() == 1 then
--             --     return { { "\\mathit{" }, { "}" } }
--             --   end
--             --   return { { "\\textit{" }, { "}" } }
--             -- end,
--             find = "\\%a-it%b{}",
--             delete = "^(\\%a-it{)().-(})()$",
--         },
--         ["s"] = {
--             add = { "\\textsc{", "}" },
--             find = "\\textsc%b{}",
--             delete = "^(\\textsc{)().-(})()$",
--         },
--         ["t"] = {
--             add = { "\\texttt{", "}" },
--             -- add = function()
--             --   if vim.fn["vimtex#syntax#in_mathzone"]() == 1 then
--             --     return { { "\\mathtt{" }, { "}" } }
--             --   end
--             --   return { { "\\texttt{" }, { "}" } }
--             -- end,
--             find = "\\%a-tt%b{}",
--             delete = "^(\\%a-tt{)().-(})()$",
--         },
--         ["$"] = {
--             add = { "$", "$" },
--             -- find = "%b$.-$",
--             -- delete = "^($)().-($)()$",
--         },
--     },
-- })

-- PdfAnnots
local function PdfAnnots()
    local ok, pdf = pcall(vim.api.nvim_eval, "vimtex#context#get().handler.get_actions().entry.file")
    if not ok then
        vim.notify("No file found")
        return
    end

    local cwd = vim.fn.getcwd()
    vim.fn.chdir(vim.b.vimtex.root)

    if vim.fn.isdirectory("Annotations") == 0 then
        vim.fn.mkdir("Annotations")
    end

    local md = vim.fn.printf("Annotations/%s.md", vim.fn.fnamemodify(pdf, ":t:r"))
    vim.fn.system(vim.fn.printf('pdfannots -o "%s" "%s"', md, pdf))
    vim.cmd.split(vim.fn.fnameescape(md))

    vim.fn.chdir(cwd)
end

vim.api.nvim_buf_create_user_command(0, "PdfAnnots", PdfAnnots, { bang = false })
