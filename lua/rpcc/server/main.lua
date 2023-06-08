rpcc = rpcc or {}
rpcc.config = rpcc.config or {}
rpcc.config.Commands = rpcc.config.Commands or {}
rpcc.config.plugins = rpcc.config.plugins or {}
rpcc.cooldown = rpcc.cooldown or {}
rpcc.RunningCommands = rpcc.RunningCommands or {}

util.AddNetworkString("roplaycommands.send")


// Check if Player is trying to run a Command
hook.Add("PlayerSay", "rpcc.PlayerSay", function (ply, message)
    if not string.StartWith(message, rpcc.config.preflix) then return end
    local command = string.sub(message, string.len(rpcc.config.preflix) + 1)

    return rpcc.FindCommand(ply, command)

end)

function rpcc.FindCommand(ply, command)
    local commandObj = rpcc.config.Commands[command]
    if not commandObj then return end
    
    // Check if Player has Permission to run Command
    if not rpcc.PlyCheck(commandObj, ply) then 
        return "" 
    end

    // Check if Command is Valid
    if not commandObj.steps then
        return print("Command " .. command .. " has no steps")
    end

    commandObj.key = command

    // if Debug is enabled, no cooldown is applied
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

    // Hook is Called with the player who called the command and the command name
    hook.Call("rpcc.Command.run", nil, ply, command)


    // set the Steps of the Command
    commandObj.stepId = 1

    // Start going through the Steps
    rpcc.Step(ply, commandObj, command)
    return ""


end

function rpcc.Step(ply, commandObj, command)
    // get current Step
    local step = commandObj.steps[commandObj.stepId]

    if not step then return end

    local plugin = rpcc.config.plugins[step[1]]

    // check if Command need to stop
    if rpcc.FullStop then 
        rpcc.FullStop = false
        return
    end

    // Get the Plugin the wants to run the Command
    local success, res = pcall(plugin.run, plugin, ply, commandObj, step[2], step[3])
    if not success then
        print("Error in Plugin " .. step[1] .. " in Command ".. command .. " on Step: ".. commandObj.stepId .. "\n Error: " .. res)
    end

    // Set the cooldown of the Command
    rpcc.cooldown[command] = CurTime() + commandObj.cooldown

    commandObj.stepId = commandObj.stepId + 1

    // If the next step is Delay, it will override the default delay
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

// Allows the Player to send a Command via netString
net.Receive("roplaycommands.send", function (len, ply)
    local command = net.ReadString()
    rpcc.FindCommand(ply, command)
end)