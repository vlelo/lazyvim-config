return {
    {
        "lervag/vimtex",
        config = function(_, _)
            -- vimtex
            vim.g.vimtex_imaps_enabled = 1
            -- vim.g.vimtex_imaps_leader = ';'

            -- syntax highlighting
            vim.g.vimtex_syntax_enabled = 1
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
            vim.g.vimtex_compiler_latexmk_engines = {
                _ = "-lualatex",
                pdfdvi = "-pdfdvi",
                pdfps = "-pdfps",
                pdflatex = "-pdf",
                luatex = "-lualatex",
                lualatex = "-lualatex",
                xelatex = "-xelatex",
            }
            vim.g.vimtex_compiler_latexmk = {
                aux_dir = "aux",
                out_dir = "out/pdf",
                callback = 1,
                continuous = 1,
                executable = "latexmk",
                hooks = {},
                options = {
                    "-lualatex",
                    "-verbose",
                    "-bibtex-cond",
                    "-bibfudge",
                    "-shell-escape",
                    "-halt-on-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                    "-recorder",
                    -- "-file-line-error",
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
            vim.g.vimtex_quickfix_method = "pplatex"
            -- vim.g.vimtex_quickfix_ignore_filters = {
            --     "Overfull",
            --     "Underfull",
            -- }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            highlight = {
                enable = true,
                disable = { "latex" },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "barreiroleo/ltex-extra.nvim" },
        },
        opts = {
            servers = {
                ltex_plus = {
                    cmd = { "ltex-ls-plus" },
                    on_attach = function(client, bufnr)
                        require("ltex_extra").setup()
                    end,
                    settings = {
                        ltex = {
                            language = "en-US",
                        },
                    },
                },
                texlab = {
                    settings = {
                        texlab = {
                            build = {
                                executable = "latexmk",
                                args = {
                                    "-lualatex",
                                    "-bibtex-cond",
                                    "-bibfudge",
                                    "-interaction=nonstopmode",
                                    "-auxdir=./build/",
                                    "-outdir=./build/",
                                    "-synctex=1",
                                    "%f",
                                },
                                forwardSearchAfter = false,
                                auxDirectory = "./aux/",
                                logDirectory = "./aux/",
                                pdfDirectory = "./out/pdf/",
                            },
                            forwardSearch = {
                                executable = "skim",
                            },
                            completion = { matcher = "prefix-ignore-case" },
                            experimental = {
                                -- Include custom package dependencies into the dependency graph:
                                followPackageLinks = true,
                                -- List of *additional* environments to consider as enumeration/math/verbatim:
                                enumEnvironments = {},
                                mathEnvironments = {},
                                verbatimEnvironments = { "lstlisting" },
                            },
                        },
                    },
                },
            },
        },
    },
}
