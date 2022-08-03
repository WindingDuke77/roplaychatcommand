local plugin = {}

plugin.name = "Say"

function plugin.run(ply, commandObj, value1, value2)

    value1 = rpcc.StringReplacement(value1, ply)

    for k, v in ipairs(player.GetAll()) do

        rpcc.SendToClient(v, commandObj.color, value1)

    end

end

return plugin

