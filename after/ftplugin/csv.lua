vim.keymap.set(
    "n",
    "<leader>cc",
    "<cmd>CsvViewToggle display_mode=border header_lnum=1<CR>",
    { noremap = true, silent = true, buffer = true }
)
