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
        
        if commandObj.map and not commandObj.map[game.GetMap()] then return end

        if not rpcc.config.bypassCatergory[ply:getJobTable().category] and not rpcc.config.bypassRank[ply:GetUserGroup()] then 
            if DarkRP then
                if #commandObj.allowedCatergory > 0 and not commandObj.allowedCatergory[ply:getJobTable().category] then
                    DarkRP.notify(ply, 1, 4, "You are not Allowed to use this Command.")
                    return ""
                end

                if #commandObj.allowedJob > 0 and not commandObj.allowedJob[ply:getJobTable().name] then 
                    DarkRP.notify(ply, 1, 4, "You are not Allowed to use this Command.")
                    return ""
                end
            end

            if #commandObj.allowedRank > 0 and not commandObj.allowedRank[ply:GetUserGroup()] then 
                DarkRP.notify(ply, 1, 4, "You are not Allowed to use this Command.")
                return ""
            end
        end

        table.insert(allowedCommands, "rpcc " .. k)
    end

    return allowedCommands
end)