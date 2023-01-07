CATEGORY_NAME = "RPCC"

local waittime = 60
local lasttimeusage = -waittime
function ulx.forcestop( calling_ply, reason )
	if lasttimeusage + waittime > CurTime() then
		ULib.tsayError( calling_ply, "Please wait " .. waittime .. " seconds before using this command again", true )
		return
	end

	lasttimeusage = CurTime()
    rpcc.FullStop = true
    if reason then
        for k, v in pairs(player.GetAll()) do
            rpcc.SendToClient(v, Color(255,0,0), "A staff member has stopped the Command with the following reason: " .. reason)
        end
    end
    rpcc.MODULE:Log("{1} ran FullStop.", GAS.Logging:FormatPlayer(ply))
end
local forcestop = ulx.command( CATEGORY_NAME, "ulx fullstop", ulx.forcestop, "!fullstop" )
forcestop:defaultAccess( ULib.ACCESS_ADMIN )
forcestop:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional }
forcestop:help( "Stop the current command." )