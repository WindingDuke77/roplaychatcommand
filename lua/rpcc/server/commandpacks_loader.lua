rpcc = rpcc or {}
rpcc.config = rpcc.config or {}
rpcc.config.Commands = rpcc.config.Commands or {}
rpcc.config.plugins = rpcc.config.plugins or {}
local config = rpcc.config

timer.Simple(1, function ()
    // Get all Files in Commandpacks folder
    local files, dirs = file.Find( "rpcc/server/commandpacks" .. "/*", "LUA" )

    for k, v in pairs( files ) do
        local success, res = pcall( function (v)
    
            if ( v:sub( 1, 1 ) != "." ) then
                local commands = include( "rpcc/server/commandpacks/" .. v )
                local name = v:sub( 1, #v - 4 )
                // Check if the CommandPack is enabled
                if config.CommandPacks[name] then
                    for k, v in pairs( commands ) do
                        config.Commands[k] = v
                    end
                end
            end
            
        end, v )

    end
end)


