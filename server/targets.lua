local Target = {
    MakePowder = {
        {loc = vector3(1086.20, -3195.30, -39.20), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(1090.15, -3199.5, -39.18), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(1093.09, -3199.53, -39.05), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    CuttingCoke = {
        {loc = vector3(1095.61, -3195.62, -39.13), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    BaggingCoke = {
        {loc = vector3(1095.61, -3195.62, -39.13), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    makecrack = {
        {loc = vector3(2434.07, 4969.39, 42.35), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    bagcrack = {
        {loc = vector3(2435.85, 4965.3, 42.35), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    lysergicacid = {
        {loc = vector3(-1381.21, -327.75, 39.85), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2405.53, 5008.39, 46.02), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    diethylamide = {
        {loc = vector3(-1371.71, -316.02, 39.53), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2408.38, 5011.18, 46.08), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    gettabs = {
        {loc = vector3(-1370.77, -314.51, 39.58), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2409.59, 5012.45, 46.09), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    dryplant = {
        {loc = vector3(-1353.77, -335.58, 43.92), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    cutheroinone = {
        {loc = vector3(-1360.14, -337.03, 43.92), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    }, 
    fillneedle = {
        {loc = vector3(-1366.32, -334.40, 44.44), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    isosafrole = {
        {loc = vector3(844.39, -902.92, 25.42), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    mdp2p = {
        {loc = vector3(844.4, -898.79, 25.23), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    rawxtcloc = {
        {loc = vector3(844.71, -910.33, 25.37), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    stamp = {
        {loc = vector3(844.71, -900.56, 25.43), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    FillPrescription = {
        {loc = vector3(2432.89, 4252.2, 36.35), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    singleSpot = {
        cutcoke = vector3(1093.17, -3195.74, -39.19),
        bagcokepowder = vector3(1090.29, -3195.66, -39.13),
        CokeTeleIn = vector3(198.16, -1276.92, 29.33),
        CokeTeleOut =  vector3(1088.81, -3187.57, -38.99),
        buylsdlabkit = vector4(2598.47, 5033.06, 105.86, 283.51),
        buyheroinlabkit = vector4(-1358.77, -339.12, 43.92, 302.13),
        buypress = vector3(845.82, -884.79, 25.18),
        DryOut = vector3(2638.22, 4237.93, 44.78),
        SyrupVendor = vector4(365.21, -578.77, 39.30, 347.23),
        weedTelein = vector3(244.74, 374.54, 105.74),
        weedTeleout = vector3(1066.31, -3183.36, -39.16),
        MakeButter = vector3(1045.48, -3198.49, -38.22),
        MakeOil = vector3(1038.90, -3198.66, -38.17),
        WeedSaleman = vector4(1030.77, -3203.18, -38.2, 262.37),
        MethTeleIn = vector3(-2222.04, 303.99, 174.6),
        MethTeleOut = vector3(996.91, -3200.83, -36.39),
        MethHeistStart = vector3(-1102.93, -3066.76, 14.00),
        truckspawn = vector4(1450.87, -1482.13, 63.22, 69.95),
        Payfortruck = vector3(1437.64, -1491.91, 63.62)
    },
    MethEph = {
        {loc = vector3(3559.86, 3673.9, 28.13), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    Methace = {
        {loc = vector3(3535.41, 3661.05, 28.12), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
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