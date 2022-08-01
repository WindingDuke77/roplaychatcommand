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