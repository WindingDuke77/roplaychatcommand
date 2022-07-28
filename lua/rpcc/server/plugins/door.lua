local plugin = {}

plugin.name = "Door"

function plugin.run(ply, commandObj, value1, value2)

    if type(value1) == "table" then
        for k, v in pairs(value1) do
            local v = Entity(v)
            v:Fire(value2)
        end
    else

        local door = Entity(value1)

        door:Fire(value2)
    end

end

return plugin

