local plugin = {}

plugin.name = "PSay"

function plugin.run(ply, commandObj, value1, value2)

    for k, v in pairs(rpcc.config.Replacements) do
        value1 =  string.Replace(value1, k , v(ply))
    end
    
    rpcc.SendToClient(ply, commandObj.color, value1)

end

return plugin

