return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            svlangserver = {
                init_options = {
                    settings = {
                        includeIndexing = { "**/*.{sv,svh}" },
                        excludeIndexing = { "sim/**/*.sv*" },
                        defines = {},
                        -- launchConfiguration = "/opt/homebrew/bin/verilator -sv -Wall --lint-only",
                        launchConfiguration = "verilator -sv -Wall --lint-only",
                        -- formatCommand = "/Users/vleo/.local/share/nvim/mason/bin/verible-verilog-format",
                        formatCommand = "verible-verilog-format"
                            .. "--assignment_statement_alignment=align"
                            .. "--case_items_alignment=align"
                            .. "--class_member_variable_alignment=align"
                            .. " --distribution_items_alignment=align"
                            .. "--enum_assignment_statement_alignment=align"
                            .. "--port_declarations_alignment=align"
                            .. "--port_declarations_indentation=indent",
                    },
                },
            },
        },
    },
}
