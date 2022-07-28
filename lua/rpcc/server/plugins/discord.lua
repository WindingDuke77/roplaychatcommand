local plugin = {}

plugin.name = "Discord"

function plugin.run(ply, commandObj, value1, value2)

    for k, v in pairs(rpcc.config.Replacements) do
        value1 =  string.Replace(value1, k , v(ply))
    end
    http.Post("https://www.frostfirehosting.net/php/discordrelay.php",
    {
        ["url"] = rpcc.config.DiscordEmbed.webhook,
        ["author"] = rpcc.config.DiscordEmbed.author,
        ["authorimg"] = rpcc.config.DiscordEmbed.authorimg,
        ["title"] = rpcc.config.DiscordEmbed.title,
        ["bar_color"] = rpcc.config.DiscordEmbed.color,
        ["description"] = value1
    })
end

return plugin

