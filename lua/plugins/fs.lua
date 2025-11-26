local marks_path = vim.fn.stdpath("data") .. "/oil_marks.json"

local function load_marks()
    local f = io.open(marks_path, "r")
    if f then
        local content = f:read("*a")
        f:close()
        return vim.fn.json_decode(content)
    end
    return {}
end

local function save_marks(favorites)
    local f = io.open(marks_path, "w")
    if f then
        f:write(vim.fn.json_encode(favorites))
        f:close()
    end
end

local columns_simple = true
local permission_hlgroups = {
    ["-"] = "NonText",
    ["r"] = "DiagnosticSignWarn",
    ["w"] = "DiagnosticSignError",
    ["x"] = "DiagnosticSignOk",
}

local oil_group = vim.api.nvim_create_augroup("OilMarks", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = oil_group,
    callback = function()
        vim.g.oil_marks = load_marks()
    end,
    desc = "Load Oil bookmarks from file",
    pattern = "*",
})
vim.api.nvim_create_autocmd({ "ExitPre" }, {
    group = oil_group,
    callback = function()
        local marks = vim.g.oil_marks
        if marks then
            save_marks(marks)
        else
            save_marks({})
        end
    end,
    desc = "Save Oil bookmarks to file",
    pattern = "*",
})

return {
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        -- Optional dependencies
        dependencies = {
            { "nvim-mini/mini.icons", opts = {} },
            { "chrishrb/gx.nvim" },
        },
        opts = {
            default_file_explorer = true,
            default_to_trash = true,
            skip_confirms_for_simple_edits = true,
            -- columns = {
            --     {
            --         "permissions",
            --         highlight = function(permission_str)
            --             local hls = {}
            --             for i = 1, #permission_str do
            --                 local char = permission_str:sub(i, i)
            --                 table.insert(hls, { permission_hlgroups[char], i - 1, i })
            --             end
            --             return hls
            --         end,
            --     },
            --     { "size", highlight = "Special" },
            --     { "mtime", highlight = "Number" },
            --     {
            --         "icon",
            --         add_padding = false,
            --     },
            -- },
            view_options = {
                show_hidden = true,
                natural_order = true,
                is_always_hidden = function(name, _)
                    return name == "." or name == ".." or name == ".git"
                end,
            },
            keymaps = {
                ["<c-j>"] = { "actions.select", desc = "Open entry under the cursor" },
                ["<C-CR>"] = { "actions.open_terminal", desc = "Open terminal in folder" },
                ["gv"] = {
                    function()
                        if columns_simple then
                            require("oil").set_columns({
                                {
                                    "permissions",
                                    highlight = function(permission_str)
                                        local hls = {}
                                        for i = 1, #permission_str do
                                            local char = permission_str:sub(i, i)
                                            table.insert(hls, { permission_hlgroups[char], i - 1, i })
                                        end
                                        return hls
                                    end,
                                },
                                { "size", highlight = "Special" },
                                {
                                    "mtime",
                                    highlight = "Number",
                                },
                                {
                                    "icon",
                                    add_padding = false,
                                },
                            })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                        columns_simple = not columns_simple
                    end,
                    desc = "Toggle column view",
                },
                ["go"] = {
                    function()
                        local dir = require("oil").get_current_dir()
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
                    end,
                    desc = "Open folder",
                },
                ["ga"] = {
                    function()
                        local dir = require("oil").get_current_dir()
                        local marks = vim.g.oil_marks
                        if not vim.tbl_contains(marks, dir) then
                            table.insert(marks, dir)
                        end
                        vim.g.oil_marks = marks
                    end,
                    desc = "Add folder to bookmarks",
                },
                ["gd"] = {
                    function()
                        local dir = require("oil").get_current_dir()
                        local marks = vim.g.oil_marks
                        local new_marks = vim.tbl_filter(function(fav)
                            return fav ~= dir
                        end, marks)
                        vim.g.oil_marks = new_marks
                    end,
                    desc = "Remove folder to bookmarks",
                },
                ["gf"] = {
                    function()
                        local p = require("snacks.picker")({
                            layout = { preset = "ivy", layout = { position = "bottom" }, cycle = true },
                            finder = function()
                                local items = {}
                                for i, item in ipairs(vim.g.oil_marks) do
                                    table.insert(items, {
                                        idx = i,
                                        file = item,
                                        text = item,
                                    })
                                end
                                return items
                            end,
                            format = function(item, _)
                                local file = item.file
                                local ret = {}
                                local a = Snacks.picker.util.align
                                local icon, icon_hl = Snacks.util.icon(file.ft, "directory")
                                ret[#ret + 1] = { a(icon, 3), icon_hl }
                                ret[#ret + 1] = { " " }
                                ret[#ret + 1] = { a(file, 20) }

                                return ret
                            end,
                            actions = {
                                confirm = function(picker, item)
                                    picker:close()
                                    if not item then
                                        return
                                    end
                                    require("oil").open(item.file)
                                end,
                            },
                        })
                    end,
                    desc = "Browse bookmarks.",
                },
                ["<C-/>"] = {
                    function()
                        Snacks.picker.lines()
                    end,
                    desc = "Fuzzy search",
                },
            },
            win_options = {
                wrap = true,
            },
        },
        keys = {
            { "-", "<cmd>Oil<CR>", desc = "Open Oil" },
        },
        cmd = { "Oil" },
        lazy = false,
    },
}
