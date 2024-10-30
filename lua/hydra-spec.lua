local Util = require("lazyvim.util")
local tsc = require("treesitter-context")

local M = {}

local function vim_option(option)
  return function()
    local flag = vim.o[option]
    if flag then
      return "󰝥 "
    else
      return "󰝦 "
    end
  end
end

local function toggle_vim_option(option)
  return function()
    if vim.o[option] == true then
      ---@diagnostic disable-next-line: assign-type-mismatch
      vim.o[option] = false
    else
      ---@diagnostic disable-next-line: assign-type-mismatch
      vim.o[option] = true
    end
  end
end

M.options_hint = [[
^^^ ^ Neovim

  _n_ %{lv_number}^^^^^^^^^^^^ Numbers                _h_ %{lv_hlsearch}^^^^^^^^^^^^ Search highlight
  _r_ %{lv_relative_number}^^^ Relative numbers       _w_ %{lv_wrap}^^^^^^^^^^^^^^^^ Line wrap       
  _v_ %{lv_virtualedit}^^^^^^^ Virtual edit           _c_ %{lv_cursorline}^^^^^^^^^^ Cursor line     
  _l_ %{lv_list}^^^^^^^^^^^^^^ Invisible characters   _s_ %{lv_spell}^^^^^^^^^^^^^^^ Spell check     
  _C_ %{lv_conceallevel}^^^^^^ Conceal
  ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^                        ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^^^                 
  ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^                        ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^^^                 
^^^ ^ Editor
  _d_ %{lv_diagnostics}^^^^^^^ Diagnostics            _f_ %{lv_autoformat}^^^^^^^^^^ Autoformat
  _I_ %{lv_inlay_hints}^^^^^^^ Inlay hints
^^^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^                        ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^^^                 
^^^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^                        ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^^^                 
^^^ ^ Coding
  _p_ %{lv_autopairs}^^^^^^^^^ Autopairs              _t_ %{lv_ts_context}^^^^^^^^^^ Tree-sitter context   ^
^^^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^                        ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^^^                 
^^^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^                        ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^^^                 
  _q_ ^^^^^^^^^^^^^^^^^^^^^^^^                        ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^^^                   _<Esc>_^
^^^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^                        ^ ^ ^^^^^^^^^^^^^^^^^^^^^^^^^^                 
]]

M.spec = {
  "nvimtools/hydra.nvim",
  keys = {
    {
      "<leader>o",
      function()
        M.options_hydra:activate()
      end,
      desc = "Options toggle menu",
    },
  },
  config = function()
    local Hydra = require("hydra")

    M.options_hydra = Hydra({
      name = "Toggle Options",
      mode = "n",
      -- body = "<leader>o",
      body = nil,
      hint = M.options_hint,
      config = {
        hint = {
          position = "top",
          float_opts = {
            -- row, col, height, width, relative, and anchor should not be
            -- overridden
            style = "minimal",
            focusable = false,
            noautocmd = true,
            border = "rounded",
          },
          exit = false,
          color = "amaranth",
          invoke_on_body = true,
          timeout = false,
          funcs = {
            lv_number = vim_option("number"),
            lv_relative_number = vim_option("relativenumber"),
            lv_virtualedit = function()
              if vim.o.virtualedit == "all" then
                return "󰝥 "
              else
                return "󰝦 "
              end
            end,
            lv_list = vim_option("list"),
            lv_hlsearch = vim_option("hlsearch"),
            lv_wrap = vim_option("wrap"),
            lv_cursorline = vim_option("cursorline"),
            lv_spell = vim_option("spell"),
            lv_conceallevel = function()
              if vim.o.conceallevel == 3 then
                return "󰝥 "
              else
                return "󰝦 "
              end
            end,
            --editor
            lv_diagnostics = function()
              if vim.diagnostic.is_disabled(0) then
                return "󰝦 "
              else
                return "󰝥 "
              end
            end,
            lv_autoformat = function()
              if vim.g.autoformat == true then
                return "󰝥 "
              else
                return "󰝦 "
              end
            end,
            lv_inlay_hints = function()
              local ih = vim.lsp.inlay_hint
              if type(ih) == "function" or ih.is_enabled() then
                return "󰝥 "
              else
                return "󰝦 "
              end
            end,
            -- coding
            lv_autopairs = function()
              if vim.g.minipairs_disable then
                return "󰝦 "
              else
                return "󰝥 "
              end
            end,
            lv_ts_context = function()
              if Util.inject.get_upvalue(tsc.toggle, "enabled") then
                return "󰝥 "
              else
                return "󰝦 "
              end
            end,
          },
        },
        desc = "Toggle Options",
      },
      heads = {
        {
          "n",
          toggle_vim_option("number"),
        },
        {
          "r",
          toggle_vim_option("relativenumber"),
        },
        {
          "v",
          function()
            if vim.o.virtualedit == "all" then
              vim.o.virtualedit = "block"
            else
              vim.o.virtualedit = "all"
            end
          end,
        },
        {
          "l",
          toggle_vim_option("list"),
        },
        {
          "h",
          toggle_vim_option("hlsearch"),
        },
        {
          "w",
          toggle_vim_option("wrap"),
        },
        {
          "c",
          toggle_vim_option("cursorline"),
        },
        {
          "s",
          toggle_vim_option("spell"),
        },
        {
          "C",
          function()
            if vim.o.conceallevel == 3 then
              vim.o.conceallevel = 0
            else
              vim.o.conceallevel = 3
            end
          end,
        },
        --- Editor
        {
          "d",
          Util.toggle.diagnostics,
        },
        {
          "f",
          Util.format.toggle,
        },
        {
          "I",
          Util.toggle.inlay_hints,
        },
        --- Coding
        {
          "p",
          function()
            vim.g.minipairs_disable = not vim.g.minipairs_disable
          end,
        },
        {
          "t",
          tsc.toggle,
        },
        --- exit
        { "q", nil, { exit = true } },
        { "<Esc>", nil, { exit = true } },
        { "<C-c>", nil, { desc = false, exit = true } },
      },
    })
  end,
}

return M.spec
