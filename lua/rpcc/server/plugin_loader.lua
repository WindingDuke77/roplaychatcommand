rpcc = rpcc or {}
rpcc.config = rpcc.config or {}
rpcc.config.Commands = rpcc.config.Commands or {}
rpcc.config.plugins = rpcc.config.plugins or {}

timer.Simple(5, function ()
    local files, dirs = file.Find( "rpcc/server/plugins" .. "/*", "LUA" )

    for k, v in pairs( files ) do
        if ( v:sub( 1, 1 ) != "." ) then
            local plugin = include( "rpcc/server/plugins/" .. v )
            rpcc.config.plugins[ plugin.name ] = plugin
        end
    end
end)