local drugModels = {
    cocaine = "prop_plant_01a",
    heroin = "prop_plant_01b",
    mescaline = "prop_cactus_03",
    shrooms = "prop_stoneshroom2",
    weed = "bkr_prop_weed_lrg_01b"
}
local drugModelsBuzz = {
    cocaine = "bzzz_plant_coca_c",
    heroin = "bzzz_plants_poppy_1c",
    shrooms = "bzzz_mushrooms_amanita_a",
    weed = "bzzz_plant_weed_pot_green_d"
}
local function propsLabels(drugType)
    if Config.Bzz[drugType] then
        return drugModelsBuzz[drugType]
    else
        return drugModels[drugType]
    end
end

local plants = {
    cocaine = {
        { location = vector3(1474.25, -2643.87, 42.88),    heading = 334.49,     model = propsLabels('cocaine'), taken = false },
        { location = vector3(1472.35, -2649.3, 41.87),     heading = 329.56,     model = propsLabels('cocaine'), taken = false }, 
        { location = vector3(1475.7, -2652.9, 40.8),       heading = 25.16,      model = propsLabels('cocaine'), taken = false }, 
        { location = vector3(1481.0, -2654.99, 39.86),     heading = 21.52,      model = propsLabels('cocaine'), taken = false }, 
        { location = vector3(1480.9, -2660.63, 38.68),     heading = 202.97,     model = propsLabels('cocaine'), taken = false },
        { location = vector3(1477.18, -2666.53, 38.19),    heading = 202.97,     model = propsLabels('cocaine'), taken = false },
        { location = vector3(1477.58, -2670.82, 37.73),    heading = 202.97,     model = propsLabels('cocaine'), taken = false },
        { location = vector3(1476.56, -2675.82, 37.46),    heading = 202.97,     model = propsLabels('cocaine'), taken = false },
        { location = vector3(1474.8, -2680.19, 37.03),     heading = 202.97,     model = propsLabels('cocaine'), taken = false },
        { location = vector3(1471.52, -2685.0, 36.82),     heading = 202.97,     model = propsLabels('cocaine'), taken = false },
        { location = vector3(1462.82, -2676.58, 38.83),    heading = 202.97,     model = propsLabels('cocaine'), taken = false },
        { location = vector3(1461.31, -2667.74, 39.67),    heading = 202.97,     model = propsLabels('cocaine'), taken = false },
        { location = vector3(1456.3, -2647.61, 43.39),     heading = 202.97,     model = propsLabels('cocaine'), taken = false },
        { location = vector3(1453.65, -2641.56, 45.0),     heading = 202.97,     model = propsLabels('cocaine'), taken = false },
    },
    heroin = {
        { location = vector3(-2251.3, -99.18, 100.11),    heading = 334.49,    model = propsLabels('heroin'), taken = false},
        { location = vector3(-2249.63, -92.97, 101.8),    heading = 329.56,    model = propsLabels('heroin'), taken = false},
        { location = vector3(-2245.57, -85.12, 104.5),    heading = 25.16,     model = propsLabels('heroin'), taken = false},
        { location = vector3(-2240.81, -88.48, 105.88),   heading = 21.52,     model = propsLabels('heroin'), taken = false},
        { location = vector3(-2240.87, -93.36, 103.88),   heading = 334.49,    model = propsLabels('heroin'), taken = false},
        { location = vector3(-2236.0, -95.34, 102.55),    heading = 329.56,    model = propsLabels('heroin'), taken = false},
        { location = vector3(-2240.6, -100.01, 100.49),   heading = 25.16,     model = propsLabels('heroin'), taken = false},
        { location = vector3(-2246.29, -104.92, 99.27),   heading = 21.52,     model = propsLabels('heroin'), taken = false},
        { location = vector3(-2243.64, -107.99, 96.71),   heading = 334.49,    model = propsLabels('heroin'), taken = false},
        { location = vector3(-2254.22, -108.76, 97.25),   heading = 329.56,    model = propsLabels('heroin'), taken = false},
        { location = vector3(-2247.33, -108.92, 97.70),   heading = 25.16,     model = propsLabels('heroin'), taken = false},
        { location = vector3(-2250.96, -111.22, 97.50),   heading = 21.52,     model = propsLabels('heroin'), taken = false},
        { location = vector3(465.95, -1021.32, 31.78),    heading = 21.52,     model = propsLabels('heroin'), taken = false},
    },
    mescaline = {
        { location = vector3(2598.73, 4207.89, 41.02),    heading = 334.49,    model = "prop_cactus_03", taken = false},
        { location = vector3(2601.46, 4199.34, 40.62),    heading = 329.56,    model = "prop_cactus_03", taken = false},
        { location = vector3(2611.63, 4194.18, 41.18),    heading = 25.16,     model = "prop_cactus_03", taken = false},
        { location = vector3(2620.18, 4202.69, 41.5),     heading = 21.52,     model = "prop_cactus_03", taken = false},
        { location = vector3(2624.26, 4211.75, 42.34),    heading = 334.49,    model = "prop_cactus_03", taken = false},
        { location = vector3(2635.21, 4207.5, 42.49),     heading = 329.56,    model = "prop_cactus_03", taken = false},
        { location = vector3(2644.97, 4193.51, 42.11),    heading = 25.16,     model = "prop_cactus_03", taken = false},
        { location = vector3(2654.21, 4195.31, 41.23),    heading = 21.52,     model = "prop_cactus_03", taken = false},
        { location = vector3(2653.32, 4206.49, 41.62),    heading = 334.49,    model = "prop_cactus_03", taken = false},
        { location = vector3(2647.45, 4213.94, 42.49),    heading = 329.56,    model = "prop_cactus_03", taken = false},
        { location = vector3(2636.3, 4218.49, 43.03),     heading = 25.16,     model = "prop_cactus_03", taken = false},
        { location = vector3(2627.37, 4223.2, 42.88),     heading = 21.52,     model = "prop_cactus_03", taken = false},
        { location = vector3(2617.86, 4230.38, 42.63),    heading = 21.52,     model = "prop_cactus_03", taken = false},
        { location = vector3(2609.8, 4222.12, 41.19),     heading = 21.52,     model = "prop_cactus_03", taken = false},
        { location = vector3(2602.96, 4194.05, 41.01),    heading = 21.52,     model = "prop_cactus_03", taken = false},
        { location = vector3(2614.39, 4188.3, 41.68),     heading = 21.52,     model = "prop_cactus_03", taken = false},
        { location = vector3(2623.82, 4189.97, 41.44),    heading = 21.52,     model = "prop_cactus_03", taken = false},
    },
    shrooms = {
        { location = vector3(2185.14, 5183.81, 57.48),    heading = 334.49,    model = propsLabels('shrooms'), taken = false},
        { location = vector3(2174.45, 5187.85, 57.43),    heading = 329.56,    model = propsLabels('shrooms'), taken = false},
        { location = vector3(2166.22, 5196.56, 58.0),     heading = 25.16,     model = propsLabels('shrooms'), taken = false},
        { location = vector3(2166.82, 5204.83, 58.63),    heading = 21.52,     model = propsLabels('shrooms'), taken = false},
        { location = vector3(2174.84, 5205.82, 59.19),    heading = 334.49,    model = propsLabels('shrooms'), taken = false},
        { location = vector3(2184.46, 5201.23, 59.2),     heading = 329.56,    model = propsLabels('shrooms'), taken = false},
        { location = vector3(2192.45, 5194.89, 58.86),    heading = 25.16,     model = propsLabels('shrooms'), taken = false},
        { location = vector3(2207.53, 5187.81, 58.95),    heading = 21.52,     model = propsLabels('shrooms'), taken = false},
        { location = vector3(2213.46, 5191.11, 59.81),    heading = 334.49,    model = propsLabels('shrooms'), taken = false},
        { location = vector3(2218.31, 5180.0, 58.18),     heading = 329.56,    model = propsLabels('shrooms'), taken = false},
        { location = vector3(2212.75, 5172.35, 57.2),     heading = 25.16,     model = propsLabels('shrooms'), taken = false},
        { location = vector3(2208.56, 5167.06, 56.34),    heading = 21.52,     model = propsLabels('shrooms'), taken = false},
        { location = vector3(2196.9, 5158.59, 54.84),     heading = 21.52,     model = propsLabels('shrooms'), taken = false},
        { location = vector3(2191.62, 5174.91, 56.68),    heading = 21.52,     model = propsLabels('shrooms'), taken = false},
        { location = vector3(2190.18, 5182.54, 57.47),    heading = 21.52,     model = propsLabels('shrooms'), taken = false},
        { location = vector3(2185.85, 5190.49, 58.1),     heading = 21.52,     model = propsLabels('shrooms'), taken = false},
        { location = vector3(2179.95, 5194.19, 58.26),    heading = 21.52,     model = propsLabels('shrooms'), taken = false},
    },
    weed = {
        { location = vector3(1064.84, -3199.84, -42.70),    heading = 334.49,    model = propsLabels('weed'), taken = false},
        { location = vector3(1063.88, -3198.69, -42.70),    heading = 329.56,    model = propsLabels('weed'), taken = false},
        { location = vector3(1061.68, -3196.46, -42.70),    heading = 25.16,     model = propsLabels('weed'), taken = false},
        { location = vector3(1061.62, -3199.63, -42.70),    heading = 21.52,     model = propsLabels('weed'), taken = false},
        { location = vector3(1062.82, -3197.70, -42.70),    heading = 202.97,    model = propsLabels('weed'), taken = false},
        { location = vector3(1064.69, -3196.31, -42.70),    heading = 202.97,    model = propsLabels('weed'), taken = false},
        { location = vector3(1062.92, -3198.78, -42.70),    heading = 202.97,    model = propsLabels('weed'), taken = false},
        { location = vector3(1049.73, -3201.92, -42.70),    heading = 202.97,    model = propsLabels('weed'), taken = false},
        { location = vector3(1052.94, -3202.21, -42.70),    heading = 202.97,    model = propsLabels('weed'), taken = false},
        { location = vector3(1051.93, -3201.17, -42.70),    heading = 202.97,    model = propsLabels('weed'), taken = false},
        { location = vector3(1050.98, -3201.13, -42.70),    heading = 202.97,    model = propsLabels('weed'), taken = false},
        { location = vector3(1050.89, -3200.07, -42.70),    heading = 202.97,    model = propsLabels('weed'), taken = false},
        { location = vector3(1050.89, -3198.95, -42.70),    heading = 202.97,    model = propsLabels('weed'), taken = false},
        { location = vector3(1049.72, -3198.95, -42.70),    heading = 202.97,    model = propsLabels('weed'), taken = false},
    }
}

local plantRespawnTimers = {
    coke = 100,
    heroin = 100,
    mescaline = 100,
    shrooms = 100,
    weed = 100
}

local plantData = {
    {
        label = 'coke',
        plants = plants.cocaine,
        globalState = function()
            GlobalState.CocaPlant = plants.cocaine
        end,
        itemGive = function(src)
            ps.addItem(src, 'coca_leaf', 1)
        end,
        coolDown = function(loc)
            CreateThread(function()
                Wait(plantRespawnTimers.coke * 1000)
                plants.cocaine[loc].taken = false
                GlobalState.CocaPlant = plants.cocaine
                TriggerClientEvent('coke:respawnCane', -1, loc)
            end)
        end,
        allow = Config.Drugs.cocaine
    },
    {
        label = 'heroin',
        plants = plants.heroin,
        globalState = function()
            GlobalState.PoppyPlants = plants.heroin
        end,
        itemGive = function(src)
            ps.addItem(src, 'poppyresin', 1)
        end,
        coolDown = function(loc)
            CreateThread(function()
                Wait(plantRespawnTimers.heroin * 1000)
                plants.heroin[loc].taken = false
                GlobalState.PoppyPlants = plants.heroin
                TriggerClientEvent('heroin:respawnCane', -1, loc)
            end)
        end,
        allow = Config.Drugs.heroin
    },
    {
        label = 'Mescaline',
        plants = plants.mescaline,
        globalState = function()
            GlobalState.Mescaline = plants.mescaline
        end,
        itemGive = function(src)
            ps.addItem(src, 'cactusbulb', 1)
        end,
        coolDown = function(loc)
            CreateThread(function()
                Wait(plantRespawnTimers.mescaline * 1000)
                plants.mescaline[loc].taken = false
                GlobalState.Mescaline = plants.mescaline
                TriggerClientEvent('Mescaline:respawnCane', -1, loc)
            end)
        end,
        allow = Config.Drugs.mescaline
    },
    {
        label = 'shrooms',
        plants = plants.shrooms,
        globalState = function()
            GlobalState.shrooms = plants.shrooms
        end,
        itemGive = function(src)
            ps.addItem(src, 'shrooms', 1)
        end,
        coolDown = function(loc)
            CreateThread(function()
                Wait(plantRespawnTimers.shrooms * 1000)
                plants.shrooms[loc].taken = false
                GlobalState.shrooms = plants.shrooms
                TriggerClientEvent('shrooms:respawnCane', -1, loc)
            end)
        end,
        allow = Config.Drugs.shrooms
    },
    {
        label = 'weed',
        plants = plants.weed,
        globalState = function()
            GlobalState.WeedPlant = plants.weed
        end,
        itemGive = function(src)
            ps.addItem(src, 'wetcannabis', 1)
        end,
        coolDown = function(loc)
            CreateThread(function()
                Wait(plantRespawnTimers.weed * 1000)
                plants.weed[loc].taken = false
                GlobalState.WeedPlant = plants.weed
                TriggerClientEvent('weed:respawnCane', -1, loc)
            end)
        end,
        allow = Config.Drugs.weed
    }
}

for k, v in pairs (plantData) do
    if not v.allow then goto continue end
    v.globalState()
    RegisterNetEvent(v.label ..":pickupCane", function(loc)
        local src = source
        if timeOut(src, v.label .. ":pickupCane") then return end
        if ps.checkDistance(src, v.plants[loc].location, 5.0) then
            if not v.plants[loc].taken then
                v.plants[loc].taken = true
                v.globalState()
                TriggerClientEvent(v.label ..":removeCane", -1, loc)
                v.coolDown(loc)
                v.itemGive(src)
            end
        else
            ps.notify(src, ps.lang('Catches.notIn'), 'error')
            return
        end
    end)
    ::continue::
end