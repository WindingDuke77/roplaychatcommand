local plugin = {}

plugin.name = "Discord"

function plugin.run(ply, commandObj, value1, value2)

    value1 = rpcc.StringReplacement(value1, ply)

    http.Post(rpcc.config.DiscordEmbed.relay,
    {
        ["url"] = rpcc.config.DiscordEmbed.webhook,
        ["author"] = rpcc.config.DiscordEmbed.author,
        ["authorimg"] = rpcc.config.DiscordEmbed.authorimg,
        ["title"] = rpcc.config.DiscordEmbed.title,
        ["bar_color"] = rpcc.config.DiscordEmbed.color,
        ["description"] = value1,
        ["ping"] = value2 or ""
    })
end

return plugin

