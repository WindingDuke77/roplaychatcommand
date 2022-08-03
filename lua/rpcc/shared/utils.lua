// Use to see if a player can use a command.
function rpcc.PlyCheck(commandObj, ply)
    if not commandObj then return false end

    if commandObj.map and not commandObj.map[game.GetMap()] then return false end 

    // check if the player is not in a bypass group
    if not rpcc.config.bypassRank[ply:GetUserGroup()] and (DarkRP and not rpcc.config.bypassCatergory[ply:getJobTable().category]) then 
        if DarkRP then
            // check if the player is in the right Catergory
            if commandObj.allowedCatergory and not commandObj.allowedCatergory[ply:getJobTable().category] then
                if SERVER then
                    rpcc.notify(ply, 1, 4, "You are not Allowed to use this Command. [Category]")
                end

                return false
            end

            // check if the player is in the right Job
            if commandObj.allowedJob and not commandObj.allowedJob[ply:getJobTable().name] then 
                if SERVER then
                    rpcc.notify(ply, 1, 4, "You are not Allowed to use this Command. [Job]")
                end
                return false
            end
        end

        // check if the player is in the right Group
        if commandObj.allowedRank and not commandObj.allowedRank[ply:GetUserGroup()] then 
            if SERVER then
                rpcc.notify(ply, 1, 4, "You are not Allowed to use this Command. [Rank]")
            end
            return false 
        end
    end

    return true
end