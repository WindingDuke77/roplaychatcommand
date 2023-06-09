rpcc = rpcc or {}
rpcc.config = rpcc.config or {}
rpcc.config.Commands = rpcc.config.Commands or {}
local config = rpcc.config
// Do not touch above this line



local notificationSound = "buttons/lightswitch2.wav"
local function DisplayNotify(msg)
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
    surface.PlaySound(notificationSound)
end
usermessage.Hook("rpcc_Notify", DisplayNotify)


net.Receive("rpcc.ChatSend", function(len)
    local msg = net.ReadString()
    local color = net.ReadColor()

    chat.AddText( color, msg )
end)

net.Receive("rpcc.ClientConfig", function(len)
    local length = net.ReadInt(32)
    local data = net.ReadData(length)

    local config = util.JSONToTable(util.Decompress(data))

    rpcc.config = config
end)