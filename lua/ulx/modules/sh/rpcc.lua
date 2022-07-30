CATEGORY_NAME = "RPCC"

local waittime = 60
local lasttimeusage = -waittime
function ulx.forcestop( calling_ply, reason )
	if lasttimeusage + waittime > CurTime() then
		ULib.tsayError( calling_ply, "I just told you what time it is! Please wait " .. waittime .. " seconds before using this command again", true )
		return
	end

	lasttimeusage = CurTime()
    rpcc.FullStop = true
    if reason then
        for k, v in pairs(player.GetAll()) do
            v:ChatPrint(reason)
        end
    end
end
local forcestop = ulx.command( CATEGORY_NAME, "ulx fullstop", ulx.forcestop, "!fullstop" )
forcestop:defaultAccess( ULib.ACCESS_ADMIN )
forcestop:addParam{ type=ULib.cmds.StringArg, hint="reason", ULib.cmds.optional, ULib.cmds.takeRestOfLine, completes=ulx.common_kick_reasons }
forcestop:help( "Stop the current command." )