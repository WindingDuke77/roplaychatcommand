properties.Add( "Get Id", {
	MenuLabel = "#Id", -- Name to display on the context menu
	Order = 10001, -- The order to display this property relative to other properties
	MenuIcon = "icon16/door.png", -- The icon to display next to the property

	Filter = function( self, ent, ply ) -- A function that determines whether an entity is valid for this property
        return true
	end,
	Action = function( self, ent ) -- The action to perform upon using the property ( Clientside )

		self:MsgStart()
			net.WriteEntity( ent )
		self:MsgEnd()
	end,
	Receive = function( self, length, ply ) -- The action to perform upon using the property ( Serverside )
        local ent = net.ReadEntity()

        if not IsValid(ent) then return end
        local id = ent:MapCreationID()
        if id == nil or id == -1 then return end


        rpcc.SendToClient(ply, Color(166,0,216), ent:GetClass() .. ": "  .. id)
        ply:SendLua("SetClipboardText(".. id ..")")
	end 
} )

timer.Simple(0, function ()
    if SERVER then 
        GAMEMODE.Config.allowedProperties["Get Id"] = true
    end
end)
