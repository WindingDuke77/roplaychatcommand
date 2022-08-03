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
function (cmd, stringargs) // AutoComplete Func
    if not CLIENT then return end
    
    local ply = LocalPlayer()

    local allowedCommands = {}

    // loop through all commands and check if the user can use them
    for k, commandObj in pairs(rpcc.config.Commands) do
        
        if not rpcc.PlyCheck(commandObj, ply) then 
            continue 
        end

        table.insert(allowedCommands, "rpcc " .. k)
    end

    return allowedCommands
end)