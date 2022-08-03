TOOL.Category = "Admin"
TOOL.Name = "#tool.doorid.name"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.Information = {
	{ name = "left" },
} 

if CLIENT then
	language.Add("tool.doorid.name", "Door ID")
	language.Add("tool.doorid.desc", "Get the Id of a Door / Button.")

    language.Add("tool.doorid.left", "Get Door Id")
end

local cooldown = 0
function TOOL:LeftClick(trace)
	if CLIENT then return end
	local ply = self:GetOwner()
	
	if cooldown > CurTime() then return end
	cooldown = CurTime() + 1

	local ent = trace.Entity

	if not IsValid(ent) then return end
	local id = ent:MapCreationID()
	print(id)
	if id == nil or id == -1 then return end


	rpcc.SendToClient(ply, Color(166,0,216), ent:GetClass() .. ": "  .. id)
	ply:SendLua("SetClipboardText(".. id ..")")
end


