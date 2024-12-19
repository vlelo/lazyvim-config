return {
    -- add gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        event = "VeryLazy",
        config = function()
            ---@class GruvboxPalette
            local colors = require("gruvbox").palette
            local config = require("gruvbox").config

            local NoicePopup = { fg = colors.neutral_blue, bg = colors.dark0, reverse = config.invert_signs }

            local overrides = {
                NormalFloat = { link = "Float" },
                NoiceCmdlinePopupBorder = NoicePopup,
                NoiceCmdlineIcon = NoicePopup,
                NoiceMini = { link = "DiagnosticSignInfo" },
                NoiceConfirm = NoicePopup,
                NoiceConfirmBorder = NoicePopup,
                BufferLineFill = { bg = colors.dark0 },

                TSURI = { link = "@text.uri" },
                TSNamespace = { link = "@namespace" },
                TSType = { link = "@type" },
                TSMethod = { link = "@Method" },
                TSField = { link = "@field" },
                TSConstructor = { link = "@constructor" },
                TSFunction = { link = "@function" },
                TSConstant = { link = "@constant" },
                TSString = { link = "@string" },
                TSNumber = { link = "@number" },
                TSBoolean = { link = "@boolean" },
                TSOperator = { link = "@operator" },
                TSParameter = { link = "@parameter" },
                --
                TreesitterContext = { link = "CursorLine" },
                TreesitterContextLineNumber = { link = "CursorLineNr" },
                --
                -- GitSignsChange = GruvboxAquaSign,
                -- GitSignsAdd = GruvboxGreenSign,
                -- GitSignsDelete = GruvboxRedSign,
                -- DapBreakpoint = groups.DiagnosticError,
                -- DapLogPoint = groups.DiagnosticInfo,
                -- DapStopped = groups.DiagnosticInfo,
                -- DapBreakpointRejected = groups.DiagnosticHint,
                BufferLineIndicatorSelected = { link = "GruvboxAqua" },
            }

            local signs = {
                GruvboxAquaSign = {},
                GruvboxGreenSign = {},
                GruvboxRedSign = {},
                GruvboxBlueSign = {},
                GruvboxOrangeSign = {},
                GruvboxPurpleSign = {},
                GruvboxYellowSign = {},
                SignColumn = {},
            }

            for val, color in pairs(signs) do
                color.link = val
                ---@diagnostic disable-next-line: undefined-field
                color.bg = colors.bg0
                overrides[val] = color
            end

            require("gruvbox").setup({
                terminal_colors = true,
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true,
                contrast = "",
                palette_overrides = {},
                overrides = overrides,
                dim_inactive = false,
                transparent_mode = false,
            })

            vim.cmd("hi TreesitterContextBottom gui=underline guisp=" .. colors.neutral_yellow)
        end,
    },
    {
        "catppuccin/nvim",
        event = "VeryLazy",
        opts = {
            flavour = "mocha",
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                grug_far = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        event = "VeryLazy",
        opts = {
            overrides = function(colors)
                local theme = colors.theme
                return {
                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },
                    DiagnosticSignInfo = { bg = "none" },
                    WinSeparator = { fg = theme.ui.nontext }, -- brighter
                    BlinkCmpMenu = { link = "Pmenu" },
                    BlinkCmpMenuSelection = { fg = "NONE", bg = theme.ui.pmenu.bg_sel },
                    BlinkCmpMenuBorder = { fg = theme.ui.bg_search, bg = theme.ui.pmenu.bg },
                    BlinkCmpScrollBarThumb = { link = "PmenuThumb" },
                    BlinkCmpScrollBarGutter = { link = "PmenuSbar" },
                    BlinkCmpLabel = { fg = theme.ui.pmenu.fg },
                    BlinkCmpLabelMatch = { fg = theme.syn.fun },
                    BlinkCmpLabelDeprecated = { fg = theme.syn.comment, strikethrough = true },
                    BlinkCmpGhostText = { fg = theme.syn.comment },
                    BlinkCmpDoc = { link = "NormalFloat" },
                    BlinkCmpDocBorder = { link = "FloatBorder" },
                    BlinkCmpDocCursorLine = { link = "Visual" },
                    BlinkCmpSignatureHelp = { link = "NormalFloat" },
                    BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
                    BlinkCmpSignatureHelpActiveParameter = { link = "LspSignatureActiveParameter" },

                    BlinkCmpItemKindText = { fg = theme.ui.fg },
                    BlinkCmpItemKindMethod = { link = "@function.method" },
                    BlinkCmpItemKindFunction = { link = "Function" },
                    BlinkCmpItemKindConstructor = { link = "@constructor" },
                    BlinkCmpItemKindField = { link = "@variable.member" },
                    BlinkCmpItemKindVariable = { fg = theme.ui.fg_dim },
                    BlinkCmpItemKindClass = { link = "Type" },
                    BlinkCmpItemKindInterface = { link = "Type" },
                    BlinkCmpItemKindModule = { link = "@module" },
                    BlinkCmpItemKindProperty = { link = "@property" },
                    BlinkCmpItemKindUnit = { link = "Number" },
                    BlinkCmpItemKindValue = { link = "String" },
                    BlinkCmpItemKindEnum = { link = "Type" },
                    BlinkCmpItemKindKeyword = { link = "Keyword" },
                    BlinkCmpItemKindSnippet = { link = "Special" },
                    BlinkCmpItemKindColor = { link = "Special" },
                    BlinkCmpItemKindFile = { link = "Directory" },
                    BlinkCmpItemKindReference = { link = "Special" },
                    BlinkCmpItemKindFolder = { link = "Directory" },
                    BlinkCmpItemKindEnumMember = { link = "Constant" },
                    BlinkCmpItemKindConstant = { link = "Constant" },
                    BlinkCmpItemKindStruct = { link = "Type" },
                    BlinkCmpItemKindEvent = { link = "Type" },
                    BlinkCmpItemKindOperator = { link = "Operator" },
                    BlinkCmpItemKindTypeParameter = { link = "Type" },
                    BlinkCmpItemKindCopilot = { link = "String" },
                }
            end,
        },
    },
}
