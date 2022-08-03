local plugin = {}

plugin.name = "PSay"

function plugin.run(ply, commandObj, value1, value2)

    value1 = rpcc.StringReplacement(value1, ply)
    
    rpcc.SendToClient(ply, commandObj.color, value1)

end

return plugin

