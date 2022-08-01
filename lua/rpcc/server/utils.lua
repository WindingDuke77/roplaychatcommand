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

    umsg.Start("rpcc_Notify_Notify", rcf)
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
    
