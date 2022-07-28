local plugin = {}

plugin.name = "Defcon"

function plugin.run(ply, commandObj, value1, value2)
    if not RDV then return end
    if RDV.DEFCON then
        RDV.DEFCON.SetDefcon(value1, ply)
    end
end

return plugin

