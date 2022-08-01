TOOL.Category = "Admin"
TOOL.Name = "#tool.doorid.name"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.Information = {
	{ name = "left" },


} 

local currentEnt
local trace
local plyAngle

local rotation = 0



if CLIENT then
	language.Add("tool.doorid.name", "Door ID")
	language.Add("tool.doorid.desc", "Get the Id of a Door / Button.")

    language.Add("tool.doorid.left", "Get Door Id")

	local ply = LocalPlayer()
end


local cooldown = 0
function TOOL:LeftClick(trace)
	if SERVER then return end
	local ply = LocalPlayer()
	
	if cooldown > CurTime() then return end
	cooldown = CurTime() + 1

	local ent = trace.Entity

	if not IsValid(ent) then return end

	local id = tostring(ent)

	id = string.Split(id, "[")[2]

	id = string.Split(id, "]")[1]

	LocalPlayer():ChatPrint(ent:GetClass() .. ": "  .. id)
	SetClipboardText(id)
end



function TOOL:DrawHUD()

end



