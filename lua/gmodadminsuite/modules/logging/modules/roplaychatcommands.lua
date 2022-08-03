rpcc = rpcc or {}
rpcc.MODULE = GAS.Logging:MODULE()
rpcc.MODULE.Category = "Neural Studio"
rpcc.MODULE.Name = "RP ChatCommands"
rpcc.MODULE.Colour = Color(153,0,255)

rpcc.MODULE:Setup(function()
	rpcc.MODULE:Hook("rpcc.Command.run", "blogs-commandrun", function(ply, command)
		rpcc.MODULE:Log("{1} ran {2} command.", GAS.Logging:FormatPlayer(ply), GAS.Logging:Highlight(command))
	end)
end)


GAS.Logging:AddModule( rpcc.MODULE )