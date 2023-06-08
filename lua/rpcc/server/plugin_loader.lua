rpcc = rpcc or {}
rpcc.config = rpcc.config or {}
rpcc.config.Commands = rpcc.config.Commands or {}
rpcc.config.plugins = rpcc.config.plugins or {}

// Loads the plugins
timer.Simple(5, function ()
    // Get all Files in plugins folder
    local files, dirs = file.Find( "rpcc/server/plugins" .. "/*", "LUA" )

    for k, v in pairs( files ) do
        if ( v:sub( 1, 1 ) != "." ) then
            local success, res = pcall( function ( v )
                local plugin = include( "rpcc/server/plugins/" .. v )
                // add plugin to list
                rpcc.config.plugins[ plugin.name ] = plugin
                
            end, v )
            if ( !success ) then
                print( "Error loading plugin '" .. v .. "': " .. res )
            end
        end
    end
end)