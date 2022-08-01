local plugin = {}

plugin.name = "Say"

function plugin.run(ply, commandObj, value1, value2)
    for k, v in pairs(rpcc.config.Replacements) do
        value1 =  string.Replace(value1, k , v(ply))
    end

    for k, v in pairs(player.GetAll()) do

        rpcc.SendToClient(v, commandObj.color, value1)

    end

end

return plugin

