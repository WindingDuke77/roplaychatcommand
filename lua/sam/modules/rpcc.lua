if SAM_LOADED then return end

local sam, command, language = sam, sam.command, sam.language

local savetime = 0

command.set_category("RPCC")


command.new("ForceStop")
	:SetPermission("ForceStop", "superadmin")
    :AddArg("text", {hint = "reason", optional = true})

	:OnExecute(function(ply, reason)
        if rpcc.FullStop then 
            return rpcc.SendToClient(ply, Color(255,0,0), "RPCC is already stopped.")
        end
        rpcc.FullStop = true
        if reason then
            for k, v in pairs(player.GetAll()) do
                rpcc.SendToClient(v, Color(255,0,0), "A staff member has stopped the Command with the following reason: " .. reason)
            end
        end
        if rpcc.MODULE then
            rpcc.MODULE:Log("{1} ran ForceStop.", GAS.Logging:FormatPlayer(ply))
        end
	end)
:End()

