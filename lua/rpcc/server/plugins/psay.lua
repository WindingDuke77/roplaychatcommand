local plugin = {}

plugin.name = "PSay"

function plugin.run(ply, commandObj, value1, value2)

    for k, v in pairs(rpcc.config.Replacements) do
        value1 =  string.Replace(value1, k , v(ply))
    end

    if DarkRP then
        
        DarkRP.talkToPerson(ply, commandObj.color, value1)

    else
        ply:ChatPrint(value1)
    end
end

return plugin

