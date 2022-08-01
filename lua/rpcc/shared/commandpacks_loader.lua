rpcc = rpcc or {}
rpcc.config = rpcc.config or {}
rpcc.config.Commands = rpcc.config.Commands or {}
rpcc.config.plugins = rpcc.config.plugins or {}
local config = rpcc.config

timer.Simple(1, function ()
    local files, dirs = file.Find( "rpcc/shared/commandpacks" .. "/*", "LUA" )

    for k, v in pairs( files ) do
        if ( v:sub( 1, 1 ) != "." ) then
            local commands = include( "rpcc/shared/commandpacks/" .. v )
            local name = v:sub( 1, #v - 4 )
            if config.CommandPacks[name] then
                for k, v in pairs( commands ) do
                    config.Commands[k] = v
                end
            end
        end
    end
end)


