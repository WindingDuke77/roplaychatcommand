concommand.Add("rpcc", function ( ply, cmd, args )
    if #args < 1 then
        return 
    end
    if SERVER then
        rpcc.FindCommand(ply, args[1])
    end

    if CLIENT then
        net.Start("roplaycommands.send")
            net.WriteString(table.concat(args, " "))
        net.SendToServer()
    end
end,
function (cmd, stringargs)
    if not CLIENT then return end
    
    local ply = LocalPlayer()

    local allowedCommands = {}

    for k,v in pairs(rpcc.config.Commands) do
        local commandObj = v
        
        if commandObj.map and not commandObj.map[game.GetMap()] then continue end

        if not rpcc.config.bypassRank[ply:GetUserGroup()] and (DarkRP and not rpcc.config.bypassCatergory[ply:getJobTable().category]) then 
            if DarkRP then
                if commandObj.allowedCatergory and not commandObj.allowedCatergory[ply:getJobTable().category] then
                    continue
                end

                if commandObj.allowedJob and not commandObj.allowedJob[ply:getJobTable().name] then 
                    continue
                end
            end

            if commandObj.allowedRank and not commandObj.allowedRank[ply:GetUserGroup()] then 
                continue
            end
        end

        table.insert(allowedCommands, "rpcc " .. k)
    end

    return allowedCommands
end)