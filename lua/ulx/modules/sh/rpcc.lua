local catergory_name = "RPCC"

local function forcestopFunc(calling, target, weapon, amount)
    if rpcc.FullStop then
        rpcc.SendToClient(calling, Color(255,0,0), "The command is already stopped.")
        return
    end
    rpcc.FullStop = true
    if reason then
        for k, v in pairs(player.GetAll()) do
            rpcc.SendToClient(v, Color(255,0,0), "A staff member has stopped the Command with the following reason: " .. reason)
        end
    end
    if rpcc.MODULE then
        rpcc.MODULE:Log("{1} ran FullStop.", GAS.Logging:FormatPlayer(ply))
    end
end
local forcestop = ulx.command( catergory_name, "ulx forcestop", forcestopFunc, "!forcestop" )
forcestop:help( "Stop the current command." )
forcestop:defaultAccess( ULib.ACCESS_SUPERADMIN )