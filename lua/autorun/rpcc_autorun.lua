-- This Addon was created by:
-- Neural Studios
-- https://discord.gg/MABm3uVxeZ
--
-- !! any questions, please contact us
local hashs = util.JSONToTable(file.Read("neuralstudio/hashs/rpcc_hashs.json", "DATA") or file.Read("rpcc_hashs.json", "LUA") or "{}") -- read the hashes from the file to do check for corruption
local Enabled = false -- set to error checking on or off

local function LoadAllFiles(dir)
    local files, dirs = file.Find( dir .. "/*", "LUA" )
    for k, v in pairs( files ) do
        if SERVER and Enabled then 
            if not string.find(v, "_config.lua") or not string.find(v, "_autorun.lua")  then   -- ignore config files
                if string.find(v, "module") then continue end
                if string.find(v, "plugins") then continue end
                if string.find(v, "commandpacks") then continue end
                local data = file.Read(dir .. "/" .. v, "LUA")
                local hash = util.SHA256(data)
                if hashs[dir .. "/" .. v] then
                    if hashs[dir .. "/" .. v] != hash then
                        MsgC(Color(255,0,0), "[RP ChatCommands]: File (" .. dir .. "/" .. v .. ") has been modified, please reinstall Vital Files\n")
                    end
                end
            end
        end

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
        if string.find(v, "module") then continue end
        if string.find(v, "plugins") then continue end
        if string.find(v, "commandpacks") then continue end

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
