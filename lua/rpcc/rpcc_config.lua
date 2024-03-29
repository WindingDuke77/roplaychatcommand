rpcc = rpcc or {}
rpcc.config = rpcc.config or {}
rpcc.config.Commands = rpcc.config.Commands or {}
local config = rpcc.config
// Do not touch above this line

config.preflix = "/"
config.Debug = false  // Set to true to enable debug mode and disable cooldown

config.bypassCatergory = { // allowes certain categories of jobs to bypass the restrictions
    ["Administration"] = true,
}

config.bypassRank = { // allowes certain ranks to bypass the restrictions
    ["superadmin"] = true ,
    ["Head-Of-Staff"] = true,
}

config.Replacements = { // when using Say or PSay these will be replace by the return string
    ["plyName"] = function (ply) // [string That will be replaced] = function (ply) // return string // end
        return ply:Nick()
    end,
    ["plyJob"] = function (ply)
        if not DarkRP then return "Not Installed" end
        return ply:getJobTable().name
    end
}

config.CommandPacks = { // The CommandPacks you wish to enabled
    ["starwars_commands"] = true,
}

config.DiscordEmbed = {
    relay = "https://neuralstudio.co.uk/php/discordrelay.php", // Do not touch unless you are hosting your own relay
    webhook = "", // Discord Webhook URL
    title = "RP Chat Commands", // Title of the embed
    color = "#FFA500", // Color of the embed, in Hex
    author = "RPCC", // Author of the embed
    authorimg = "", // Author image of the embed
}
// Commands

/*  All Step Types
    {"Type", "Value1", "Value2"}
    {"Door", id, "option"}  // allows you to do stuff with doors // you can find the option of a door hl2 wiki using inputs of the class
    {"Say", "message"} // allows you chat to the entire server
    {"PSay", "message"} // Only messages caller
    {"Defcon", id} // changes defcon
    {"Delay", time} // overrights default delay
    {"Function", function} // runs the function with ply args
    {"Discord", "Text", "Ping"}
    {"Sound", {
        file = "sound.mp3",
        volume = 75,
    }, player / players / "all" }
*/ 

config.Commands["Example"] = { // name of command
    delay = 1, // Delay between each chat message (in seconds)
    cooldown = 60, // Cooldown between use of command (in seconds)
    color  = Color(3, 0,208), // Color of chat message
    hide = true, // Hide the command on the Datapad
    allowedCatergory = { // Categories that can use this command // optional
        ["Civillian"] = true, 
    },
    allowedRank = { // Ranks that can use this Command  // optional
        ["superadmin"] = true,
    },
    allowedJob = { // Jobs that can use this command // optional
        ["Hobo"] = true, 
    },
    map = { // Maps that this command is enabled // optional
        ["rp_downtown_tits_v1"] = true,
    },
    steps = {
        {"Say", "Hello plyName"},
        {"Say", "This is a chat Command"},
        {"Delay", 5},
        {"Door", 190, "Open"},
        {"Say", "You are a plyJob"},
    }
}


