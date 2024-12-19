return {
    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            svlangserver = {
                settings = {
                    systemverilog = {
                        includeIndexing = { "**/*.{sv,svh}" },
                        -- libraryIndexing = { "**/*.sv" },
                        linter = "verilator",
                        launchConfiguration = "/opt/homebrew/bin/verilator -sv -Wall --lint-only --timing",
                        -- launchConfiguration = "verilator -sv -Wall -Wno-parameter-name-style --lint-only",
                        formatCommand = "/Users/vleo/.local/share/nvim/mason/bin/verible-verilog-format"
                            .. " --indentation_spaces=4"
                            .. " --assignment_statement_alignment=align"
                            .. " --case_items_alignment=align"
                            .. " --class_member_variable_alignment=align"
                            .. " --distribution_items_alignment=align"
                            .. " --enum_assignment_statement_alignment=align"
                            .. " --port_declarations_alignment=align"
                            .. " --port_declarations_indentation=indent",
                    },
                },
            },
            verible = {
                cmd = { "verible-verilog-ls", "--rules_config_search" },
            },
        },
    },
}
