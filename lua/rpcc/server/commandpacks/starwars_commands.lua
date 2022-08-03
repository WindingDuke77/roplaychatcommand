local Commands = {}

local AllowedCatergorys = { // Change this to your liking
    ["Imperial Engineer Corps"] = true,
    ["Naval Command"] = true,
    ["Imperial Security Bureau"] = true,
}

Commands["Sectorscan"] = {
    name = "Sectorscan",
    delay = 10, 
    cooldown = 10, 
    color  = Color(3, 0,208), 
    allowedCatergory = AllowedCatergorys,
    steps = {
        {"Say", "[AI Core] : Signing in..."},
        {"Delay", 1},
        {"Say", "[AI Core] : Welcome plyName"},
        {"Delay", 1},
        {"Say", "[AI Core] : Starting sector scan for hostiles"},
        {"Say", "[AI Core] : Sector Scan | 10%"},
        {"Say", "[AI Core] : Sector Scan | 20%"},
        {"Say", "[AI Core] : Sector Scan | 30%"},
        {"Say", "[AI Core] : Sector Scan | 40%"},
        {"Say", "[AI Core] : Sector Scan | 50%"},
        {"Say", "[AI Core] : Sector Scan | 60%"},
        {"Say", "[AI Core] : Sector Scan | 70%"},
        {"Say", "[AI Core] : Sector Scan | 80%"},
        {"Say", "[AI Core] : Sector Scan | 90%"},
        {"Say", "[AI Core] : Sector Scan | 100%"},
        {"Say", "[AI Core] : Scans for all hostile ships in the sector. (Ask EP for results)"}
    },
}

Commands["Hostilescan"] = {
    name = "Hostilescan",
    delay = 10, 
    cooldown = 10, 
    color  = Color(3, 0,208), 
    allowedCatergory = AllowedCatergorys,
    steps = {
        {"Say", "[AI Core] : Signing in..."},
        {"Delay", 1},
        {"Say", "[AI Core] : Welcome plyName"},
        {"Delay", 1},
        {"Say", "[AI Core] : Starting ship/base wide scan for hostiles"},
        {"Say", "[AI Core] : Hostile Scan | 10%"},
        {"Say", "[AI Core] : Hostile Scan | 20%"},
        {"Say", "[AI Core] : Hostile Scan | 30%"},
        {"Say", "[AI Core] : Hostile Scan | 40%"},
        {"Say", "[AI Core] : Hostile Scan | 50%"},
        {"Say", "[AI Core] : Hostile Scan | 60%"},
        {"Say", "[AI Core] : Hostile Scan | 70%"},
        {"Say", "[AI Core] : Hostile Scan | 80%"},
        {"Say", "[AI Core] : Hostile Scan | 90%"},
        {"Say", "[AI Core] : Hostile Scan | 100%"},
        {"Say", "[AI Core] : Scans the ship/base for all hostile within. (Ask EP for results)"},
    },
}

Commands["Diagnostic"] = {
    name = "Diagnostic",
    delay = 10,
    cooldown = 10,
    color  = Color(3, 0,208),
    allowedCatergory = AllowedCatergorys,
    steps = { 
        {"Say", "[AI Core] : Signing in..."},
        {"Delay", 1},
        {"Say", "[AI Core] : Welcome plyName"},
        {"Delay", 1},
        {"Say", "[AI Core] : Starting ship/base diagnostic scan"},
        {"Say", "[AI Core] : Diagnostic Scan | 10%"},
        {"Say", "[AI Core] : Diagnostic Scan | 20%"},
        {"Say", "[AI Core] : Diagnostic Scan | 30%"},
        {"Say", "[AI Core] : Diagnostic Scan | 40%"},
        {"Say", "[AI Core] : Diagnostic Scan | 50%"},
        {"Say", "[AI Core] : Diagnostic Scan | 60%"},
        {"Say", "[AI Core] : Diagnostic Scan | 70%"},
        {"Say", "[AI Core] : Diagnostic Scan | 80%"},
        {"Say", "[AI Core] : Diagnostic Scan | 90%"},
        {"Say", "[AI Core] : Diagnostic Scan | 100%"},
        {"Say", "[AI Core] : Scans the current state of the ship/base and how damaged it is. (Ask EP for results)"}
    },
}

Commands["SAI-MHB"] = {
    name = "Main Hanger Bay",
    delay = 1,
    cooldown = 5, 
    color  = Color(55, 255,0),
    allowedCatergory = AllowedCatergorys,
    map = {
        ["rp_stardestroyer_v2_6_inf"] = true 
    },
    steps = {
        {"Say", "[Ship AI] : Opening / Closing Main Hanger Bay doors"},
        {"Door", {365, 367, 368, 369, 370, 371}, "Toggle"}
    }
}

Commands["SAI-SHB"] = {
    name = "Side Hanger Bay",
    delay = 1,
    cooldown = 5,
    color  = Color(55, 255,0), 
    allowedCatergory = AllowedCatergorys,
    map = {
        ["rp_stardestroyer_v2_6_inf"] = true 
    },
    steps = {
        {"Say", "[Ship AI] : Opening / Closing Side Hanger Bay doors"},
        {"Door", {872}, "Toggle"}
    }
}

Commands["SAI-THB"] = {
    name = "Tie Hanger Bay",
    delay = 1, 
    cooldown = 5,
    color  = Color(55, 255,0), 
    allowedCatergory = AllowedCatergorys,
    map = {
        ["rp_stardestroyer_v2_6_inf"] = true 
    },
    steps = {
        {"Say", "[Ship AI] : Opening / Closing Tie Hanger Bay doors"},
        {"Door", {338}, "Toggle"}
    }
}

Commands["SAI-MPHB"] = {
    name = "Moonpool Hanger Bay",
    delay = 1,
    cooldown = 5,
    color  = Color(55, 255,0),
    allowedCatergory = AllowedCatergorys,
    map = {
        ["rp_stardestroyer_v2_6_inf"] = true 
    },
    steps = {
        {"Say", "[Ship AI] : Opening / Closing Moonpool Bay doors"},
        {"Door", {900, 901}, "Toggle"}
    }
}

Commands["SAI-Jump"] = { 
    name = "Jump",
    delay = 10, 
    cooldown = 1, 
    color  = Color(3, 0,208), 
    allowedCatergory = AllowedCatergorys,
    steps = {
        {"Say", "[NAVCOM] : Signing in..."},
        {"Delay", 5},
        {"Say", "[NAVCOM] : Welcome plyName"},
        {"Delay", 1},
        {"Say", "[NAVCOM] : Starting Hyper Space Jump sequence"},
        {"Delay", 5},
        {"Say", "[NAVCOM] : Plotting course to location"},
        {"Delay", 5},
        {"Say", "[NAVCOM] : Course set starting Jump Drive"},
        {"Delay", 1},
        {"Say", "[NAVCOM] : Jump Drive charging | 10%"},
        {"Say", "[NAVCOM] : Jump Drive charging | 20%"},
        {"Say", "[NAVCOM] : Jump Drive charging | 30%"},
        {"Say", "[NAVCOM] : Jump Drive charging | 40%"},
        {"Say", "[NAVCOM] : Jump Drive charging | 50%"},
        {"Say", "[NAVCOM] : Jump Drive charging | 60%"},
        {"Say", "[NAVCOM] : Jump Drive charging | 70%"},
        {"Delay", 0},
        {"Door", {365, 367, 368, 369, 370, 371, 338, 868, 893, 894}, "Close"},
        {"Say", "[NAVCOM] : Jump Drive charging | 80%"},
        {"Say", "[NAVCOM] : Jump Drive charging | 90%"},
        {"Delay", 0},
        {"Defcon", 4},
        {"Say", "[NAVCOM] : Jump Drive charging | 100%"},
        {"Say", "[NAVCOM] : Jump Drive Charged, Ready to jump!"},
    },
    map = {
        ["rp_stardestroyer_v2_6_inf"] = true,
    },
}

return Commands
