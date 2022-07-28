local MODULE = GAS.Logging:MODULE()
MODULE.Category = "Neural Studio"
MODULE.Name = "RP ChatCommands"
MODULE.Colour = Color(153,0,255)

MODULE:Setup(function()
	MODULE:Hook("rpcc.Command.run", "blogs-commandrun", function(ply, command)
		MODULE:Log("{1} ran {2} command.", GAS.Logging:FormatPlayer(ply), GAS.Logging:Highlight(command))
	end)
end)


GAS.Logging:AddModule( MODULE )