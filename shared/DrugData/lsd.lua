Config.LSD = {
    Recipes = {
        vial = {
            heat = {take = {lysergic_acid = 1, diethylamide = 1,}, give = {lsd_one_vial = 1}}
        },
    },
    Locations = {
        lysergicacid = { -- get lysergic acid
            {loc = vector3(-1381.21, -327.75, 39.85),size = vector3(1.0, 1.0, 2.0), gang = ""},
            {loc = vector3(2405.53, 5008.39, 46.02), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
        diethylamide = {  -- get diethylamide
            {loc = vector3(-1372.89, -319.47, 39.05), size = vector3(1.0, 1.0, 2.0), gang = ""},
            {loc = vector3(2408.38, 5011.18, 46.08), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
        gettabs = { -- buy tab paper
            {loc = vector3(-1378.26, -336.56, 39.31), size = vector3(1.0, 1.0, 2.0), gang = ""},
            {loc = vector3(2409.59, 5012.45, 46.09), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
        buyLSDkit = {
            {ped = 'g_f_y_families_01', loc = vector4(-1376.66, -325.52, 39.63, 142.1), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
    },
    prices = {
    	tabcost = 100, -- price per piece of tab paper event does 10 at a time
    	lsdlabkitcost = 10000 -- price of the lsd lab kit
    }
}