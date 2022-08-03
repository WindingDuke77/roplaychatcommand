// This Addon was created by:
// Neural Studios
// https://discord.gg/kp3AXXdEmQ
//
// any questions, please contact me

local function LoadAllFiles(dir)
    local files, dirs = file.Find( dir .. "/*", "LUA" )
    for k, v in pairs( files ) do
        if string.find(dir, "/client") then
            if SERVER then AddCSLuaFile( dir .. "/" .. v ) end
            if CLIENT then include( dir .. "/" .. v ) end
            MsgC(Color(255,217,0), "[RP ChatCommands]: Added " .. v .. "\n")
        elseif string.find(dir, "/server") then
            if SERVER then include( dir .. "/" .. v ) MsgC(Color(0,162,255), "[RP ChatCommands]: Added " .. v .. "\n") end
        elseif string.find(dir, "/shared") then
            if SERVER then AddCSLuaFile( dir .. "/" .. v ) include( dir .. "/" .. v ) end
            if CLIENT then include( dir .. "/" .. v ) end
            MsgC(Color(195,0,255), "[RP ChatCommands]: Added " .. v .. "\n")
        elseif string.find(dir, "rpcc") then
            if SERVER then include( dir .. "/" .. v ) MsgC(Color(0,162,255), "[RP ChatCommands]: Added " .. v .. "\n") end
        end
    end
    for k, v in pairs( dirs ) do
        if string.find(v, "module") then return end
        if string.find(v, "plugins") then return end
        if string.find(v, "commandpacks") then return end

        LoadAllFiles( dir .. "/" .. v )
    end
    
end
LoadAllFiles("rpcc")

timer.Simple(15, function () // Add Commands to the RD_DataPad 
    if not RDV then return end
    if not RDV.DEFCON then return end
    if SERVER then
        AddCSLuaFile("rd_datapad/plugins/commands/sh_plugin.lua")
        AddCSLuaFile("rd_datapad/plugins/commands/core/cl_plugin.lua")

        include("rd_datapad/plugins/commands/sh_plugin.lua")
    else
        include("rd_datapad/plugins/commands/core/cl_plugin.lua")
    end

end)
