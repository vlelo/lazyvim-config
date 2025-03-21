;extends

(
    (generic_command
        command: (command_name) @dlcommand
        (#eq? @dlcommand "\\directlua")
        arg: (curly_group
            (text) @injection.content
            (#set! injection.language "lua")
            (#set! injection.include-children)
            (#set! injection.combined)
        )
    )
)

(
    (luacode_environment 
        code: (source_code) @injection.content
            (#set! injection.language "lua")
            (#set! injection.include-children)
            (#set! injection.combined)
    ) @lcenv
)
