rpcc = rpcc or {}
rpcc.config = rpcc.config or {}
rpcc.config.Commands = rpcc.config.Commands or {}
rpcc.config.plugins = rpcc.config.plugins or {}
rpcc.cooldown = rpcc.cooldown or {}
rpcc.RunningCommands = rpcc.RunningCommands or {}

util.AddNetworkString("roplaycommands.send")



hook.Add("PlayerSay", "rpcc.PlayerSay", function (ply, message)
    if not string.StartWith(message, rpcc.config.preflix) then return end
    local command = string.sub(message, string.len(rpcc.config.preflix) + 1)

    return rpcc.FindCommand(ply, command)

end)

function rpcc.FindCommand(ply, command)
    local commandObj = rpcc.config.Commands[command]
    if not commandObj then return end
    
    if commandObj.map and not commandObj.map[game.GetMap()] then return end

    if not rpcc.config.bypassRank[ply:GetUserGroup()] and (DarkRP and not rpcc.config.bypassCatergory[ply:getJobTable().category]) then 
        if DarkRP then
            if commandObj.allowedCatergory and not commandObj.allowedCatergory[ply:getJobTable().category] then
                rpcc.notify(ply, 1, 4, "You are not Allowed to use this Command. [Category]")
                return ""
            end

            if commandObj.allowedJob and not commandObj.allowedJob[ply:getJobTable().name] then 
                rpcc.notify(ply, 1, 4, "You are not Allowed to use this Command. [JOB]")
                return ""
            end
        end

        if commandObj.allowedRank and not commandObj.allowedRank[ply:GetUserGroup()] then 
            rpcc.notify(ply, 1, 4, "You are not Allowed to use this Command. [RANK]")
            return ""
        end
    end

    if not commandObj.steps then
        rpcc.convertOld(command, commandObj)
        commandObj = rpcc.config.Commands[command]
    end

    if not rpcc.config.Debug then
        if rpcc.RunningCommands[command] then
            rpcc.notify(ply, 1, 4, "This Command is already Running.")
            return ""
        end

        if rpcc.cooldown[command] and rpcc.cooldown[command] >= CurTime() then
            rpcc.notify(ply, 1, 4, "You are on cooldown for this command.")
            return ""
        end 
    end

    hook.Call("rpcc.Command.run", nil, ply, command)


    commandObj.stepId = 1
    rpcc.Step(ply, commandObj, command)
    return ""


end

function rpcc.Step(ply, commandObj, command)
    local step = commandObj.steps[commandObj.stepId]

    if not step then return end

    local plugin = rpcc.config.plugins[step[1]]

    if rpcc.FullStop then 
        rpcc.FullStop = false
        return
    end

    plugin.run(ply, commandObj, step[2], step[3])

    rpcc.cooldown[command] = CurTime() + commandObj.cooldown
    commandObj.stepId = commandObj.stepId + 1

    if  commandObj.steps[commandObj.stepId] and commandObj.steps[commandObj.stepId][1] == "Delay" then
        timer.Simple(commandObj.steps[commandObj.stepId][2], function()
            commandObj.stepId = commandObj.stepId + 1
            rpcc.Step(ply, commandObj, command)
        end)
    else
        timer.Simple(commandObj.delay, function()
            rpcc.Step(ply, commandObj, command)
        end)
    end
        
end

util.AddNetworkString("roplaycommands.send")

net.Receive("roplaycommands.send", function (len, ply)
    local command = net.ReadString()
    rpcc.FindCommand(ply, command)
end)

function rpcc.convertOld(name, commandObj)
    if commandObj.steps then return end

    commandObj.steps = {}
    if commandObj.messages then
        for k, v in pairs(commandObj.messages) do
            table.insert(commandObj.steps, {"Say", v})
        end
    end

    if commandObj.doors then
       for k, v in pairs(commandObj.doors) do
            table.insert(commandObj.steps, {"Door", v, commandObj.type})
        end 
    end

    if commandObj.defcon then
        table.insert(commandObj.steps, {"Defcon", commandObj.defcon})
    end

    rpcc.config.Commands[name] = commandObj
end