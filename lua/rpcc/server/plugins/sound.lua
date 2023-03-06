local plugin = {}

plugin.name = "Sound"

function plugin.run(ply, commandObj, value1, value2)

    if not value1 then return end
    if not value2 then return end

    if value2 == "all" then
        value2 = player.GetAll()
    end

    if not type(value2) == "table" then
        value2 = {value2}
    end

    local Soundfile = value1.file
    local Soundvolume = value1.volume or 75

    for k, v in pairs(value2) do
        if not IsValid(v) then continue end
        v:EmitSound(Soundfile, Soundvolume)
    end


end

return plugin

