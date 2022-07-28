if SAM_LOADED then return end

local sam, command, language = sam, sam.command, sam.language

local savetime = 0

command.set_category("RPCC")


command.new("ForceStop")
	:SetPermission("ForceStop", "superadmin")
    :AddArg("text", {hint = "reason", optional = true})

	:OnExecute(function(ply, reason)
        rpcc.FullStop = true
        if reason then
            for k, v in pairs(player.GetAll()) do
                v:ChatPrint(reason)
            end
        end
	end)
:End()

