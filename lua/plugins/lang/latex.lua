return {
    {
        "lervag/vimtex",
        config = function(_, _)
            -- vimtex
            vim.g.vimtex_imaps_enabled = 1
            -- vim.g.vimtex_imaps_leader = ';'

            -- syntax highlighting
            vim.g.vimtex_syntax_enabled = 0
            vim.g.vimtex_syntax_conceal_disable = 1

            -- indentation
            vim.g.vimtex_indent_enabled = 0

            -- completion
            vim.g.vimtex_complete_enabled = 0

            -- folding
            vim.g.vimtex_fold_enabled = 1

            -- formatting
            vim.g.vimtex_format_enabled = 1

            -- indentation
            vim.g.vimtex_indent_enabled = 1

            -- compilation
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "aux",
                out_dir = "out/pdf",
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                hooks = {},
                options = {
                    "-lualatex",
                    "-shell-escape",
                    "-halt-on-error",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                    "-recorder",
                },
            }
            local uname = (vim.uv or vim.loop).os_uname().sysname
            if uname == "Darwin" then
                vim.g.vimtex_view_method = "skim"
                vim.g.vimtex_view_skim_sync = 1
                vim.g.vimtex_view_skim_activate = 1
            elseif uname == "Linux" then
                vim.g.vimtex_view_general_viewer = "okular"
                vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
            end

            vim.g.vimtex_quickfix_open_on_warning = 0
            vim.g.vimtex_quickfix_ignore_filters = {
                "Overfull",
                "Underfull",
                "inputenc package ignored with utf8 based engines.",
            }
        end,
    },
}
