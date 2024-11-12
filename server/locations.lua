local Target = {
    MakePowder = { -- where you chop your coca leaves to make powder
        {loc = vector3(1086.20, -3195.30, -39.20), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(1090.15, -3199.5, -39.18), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(1093.09, -3199.53, -39.05), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    CuttingCoke = { -- only active if Config.FancyCokeAnims = false
        {loc = vector3(1095.61, -3195.62, -39.13), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    BaggingCoke = { -- only active if Config.FancyCokeAnims = false
        {loc = vector3(1095.61, -3195.62, -39.13), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    makecrack = { -- make crack with baking soda with cut coke 1-3
        {loc = vector3(2434.07, 4969.39, 42.35), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    bagcrack = {  ---  bag crack 1-3 stages
        {loc = vector3(2435.85, 4965.3, 42.35), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    lysergicacid = { -- get lysergic acid
        {loc = vector3(-1381.21, -327.75, 39.85), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2405.53, 5008.39, 46.02), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    diethylamide = {  -- get diethylamide
        {loc = vector3(-1371.71, -316.02, 39.53), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2408.38, 5011.18, 46.08), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    gettabs = { -- buy tab paper
        {loc = vector3(-1370.77, -314.51, 39.58), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2409.59, 5012.45, 46.09), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    dryplant = {  -- turn resin into powder
        {loc = vector3(-1353.77, -335.58, 43.92), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    cutheroinone = {  -- cut heroin stage 1-3 with baking soda
        {loc = vector3(-1360.14, -337.03, 43.92), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    }, 
    fillneedle = { -- fill needles with heroin
        {loc = vector3(-1366.32, -334.40, 44.44), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    isosafrole = { -- where to steal isosafrole
        {loc = vector3(844.39, -902.92, 25.42), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    mdp2p = { -- where to steal mdp2p
        {loc = vector3(844.4, -898.79, 25.23), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    rawxtcloc = { --  where to combine the 2 ingridents to make raw xtc
        {loc = vector3(844.71, -910.33, 25.37), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    stamp = {  --  where to stamp pills
        {loc = vector3(844.71, -900.56, 25.43), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    FillPrescription = { -- where to fill out your prescription
        {loc = vector3(2432.89, 4252.2, 36.35), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    singleSpot = {
        cutcoke = vector3(1093.17, -3195.74, -39.19),
        bagcokepowder = vector3(1090.29, -3195.66, -39.13),
        CokeTeleIn = vector3(198.16, -1276.92, 29.33), -- where you target to go inside coke
        CokeTeleOut =  vector3(1088.81, -3187.57, -38.99), -- where you target to leave coke
        buylsdlabkit = vector4(2598.47, 5033.06, 105.86, 283.51), --  buy lab kit for lsd
        buyheroinlabkit = vector4(-1358.77, -339.12, 43.92, 302.13), --  buy lab kit for heroin
        buypress = vector3(845.82, -884.79, 25.18), --  buy lab kit for xtc
        DryOut = vector3(2638.22, 4237.93, 44.78), -- Place to dry out mescaline into usuable drug
        SyrupVendor = vector4(365.21, -578.77, 39.30, 347.23), -- where the mission ped starts
        weedTelein = vector3(244.74, 374.54, 105.74), -- where you target to tele in
        weedTeleout = vector3(1066.31, -3183.36, -39.16),  -- where you target to tele out
        MakeButter = vector3(1045.48, -3198.49, -38.22), -- where you make cannabutter and baked edibles
        MakeOil = vector3(1038.90, -3198.66, -38.17), -- where you make shatter
        WeedSaleman = vector4(1030.77, -3203.18, -38.2, 262.37), -- where the weed saleman is
        MethTeleIn = vector3(-2222.04, 303.99, 174.6),  -- where you target to tele in meth
        MethTeleOut = vector3(996.91, -3200.83, -36.39),  -- where you target to tele out meth
        MethHeistStart = vector3(-1102.93, -3066.76, 14.00), -- where you get the mission to get ingridients if meth heist = true
        truckspawn = vector4(1450.87, -1482.13, 63.22, 69.95), --- where the truck will spawn when you pay for it 
        Payfortruck = vector3(1437.64, -1491.91, 63.62), --- where you pay for the truck
    },
    MethEph = { -- get ephedrine
        {loc = vector3(3559.86, 3673.9, 28.13), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    Methace = { -- get acetone
        {loc = vector3(3535.41, 3661.05, 28.12), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    StartLoc = { -- where truck spawns for lean and meth missions
        vector3(-2307.22, 434.77, 174.47),
        vector3(614.75, 1786.26, 199.39),
        vector3(-224.89, 6388.32, 31.59)
    },
    WeedDry = {
        {loc = vector3(1043.0, -3191.59, -38.39),},
        {loc = vector3(1041.0, -3191.59, -38.39),},
        {loc = vector3(1045.0, -3191.59, -38.39),},
        {loc = vector3(1039.0, -3191.59, -38.39),},
    },
    Travellingmerchant = { -- where the travelling merchant can spawn
        vector4(-119.66, -977.43, 304.25, 88.21),
        vector4(-1522.93, 1476.01, 111.45, 41.25),
        vector4(-3278.98, 973.38, 5.35, 101.53),
    },
    oxylocations = {
        vector4(-2352.32, 266.78, 165.3, 23.46),
        vector4(-1467.49, 874.01, 183.59, 298.45),
        vector4(-856.71, 874.26, 202.85, 205.3),
        vector4(950.58, -128.49, 74.42, 205.3),
        vector4(1152.71, -328.43, 69.21, 205.3),
	    vector4(112.66, -1955.67, 20.75, 37.94),
	    vector4(-544.4, -1684.8, 19.89, 252.07),
	    vector4(-1185.02, -1805.4, 3.91, 184.83),
	    vector4(-1641.4, -981.99, 7.58, 35.38),
	    vector4(-1827.93, 782.36, 138.29, 219.99),
	    vector4(-320.84, 2818.73, 59.45, 337.22),
	    vector4(474.88, 2609.56, 44.48, 357.0),
    }
}

function checkLoc(source, event, num)
    local ped = source
    local pos = GetPlayerPed(ped)
    local coord = GetEntityCoords(pos)
    local loc = ''
    if type(num) =='string' then 
        loc = Target[event][num]
    else
        loc = Target[event][num].loc
    end
    local dist = #(coord - loc)
    if dist < 2.5 then
        return true
    else
        Notifys(source, 'You are not in the correct location', 'error')
        return false
    end
end

lib.callback.register('md-drugs:server:getLocs', function()
    return Target
end)