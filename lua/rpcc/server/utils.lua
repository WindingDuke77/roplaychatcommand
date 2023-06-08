function rpcc.notify(ply, msgtype, len, msg)
    if not istable(ply) then
        if not IsValid(ply) then
            return
        end

        ply = {ply}
    end

    local rcf = RecipientFilter()
    for _, v in pairs(ply) do
        rcf:AddPlayer(v)
    end

    umsg.Start("rpcc_Notify", rcf)
        umsg.String(msg)
        umsg.Short(msgtype)
        umsg.Long(len)
    umsg.End()
end

util.AddNetworkString("rpcc.ChatSend")

function rpcc.SendToClient(ply, Color, Msg)

    if not IsValid(ply) then
        return
    end

    net.Start("rpcc.ChatSend")
        net.WriteString(Msg)
        net.WriteColor(Color)
    net.Send(ply)
end
    
function rpcc.StringReplacement(string, ply)
    for k, v in pairs(rpcc.config.Replacements) do
        string =  string.Replace(string, k , v(ply))
    end
    return string
end

local ClientConfigCompare = {}

// Turn the Default Config into Client Config // Removing any Private Configs
function GetClientConfig()
    local ClientConfig = {}
    ClientConfig.Commands = {}
    for k, v in pairs(rpcc.config.Commands) do
        ClientConfig.Commands[k] = {
            delay = v.delay,
            cooldown = v.cooldown,
            color  = v.color,
            hide = v.hide,
            allowedCatergory = v.allowedCatergory,
            allowedRank = v.allowedRank,
            allowedJob = v.allowedJob,
            map = v.map,
            name = v.name
        }
    end

    ClientConfig.bypassCatergory = rpcc.config.bypassCatergory
    ClientConfig.bypassRank = rpcc.config.bypassRank 

    return ClientConfig
end


ClientConfigCompare = GetClientConfig()

util.AddNetworkString("rpcc.ClientConfig")

local function compressTable(table)
    local returnTable = util.Compress(util.TableToJSON(table))
    return returnTable, #returnTable
end

// Send the Client Config to the Client
hook.Add("PlayerInitialSpawn", "rpcc.PlayerInitialSpawn", function(ply)
    net.Start("rpcc.ClientConfig")
        net.WriteInt(compressTable(ClientConfigCompare)[2], 32)
        net.WriteData(compressTable(ClientConfigCompare)[1])
    net.Send(ply)
end)

local wait = 10
local nextCheck = CurTime() + wait
// Check if the Client Config is different then the Server Config 
// If it is, then send the Client Config to the Client
hook.Add("Think", "rpcc.Think", function ()
    if nextCheck > CurTime() then return end

    local ClientConfig = GetClientConfig()
    if ClientConfig == ClientConfigCompare then
        nextCheck = CurTime() + wait
        return
    end

    ClientConfigCompare = ClientConfig
    nextCheck = CurTime() + wait
    net.Start("rpcc.ClientConfig")
        net.WriteInt(compressTable(ClientConfig)[2], 32)
        net.WriteData(compressTable(ClientConfig)[1])
    net.Broadcast()
end)