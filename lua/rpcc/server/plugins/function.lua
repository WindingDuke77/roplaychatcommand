local plugin = {}

plugin.name = "Function"

function plugin.run(ply, commandObj, value1, value2)

    value1(ply)

end

return plugin

