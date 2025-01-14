local QBCore = exports['qb-core']:GetCoreObject()

local m = {
    { location = vector3(2598.73, 4207.89, 41.02),    heading = 334.49,    model = "prop_cactus_03"},
    { location = vector3(2601.46, 4199.34, 40.62),    heading = 329.56,    model = "prop_cactus_03"},
    { location = vector3(2611.63, 4194.18, 41.18),    heading = 25.16,     model = "prop_cactus_03"},
    { location = vector3(2620.18, 4202.69, 41.5),     heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2624.26, 4211.75, 42.34),    heading = 334.49,    model = "prop_cactus_03"},
    { location = vector3(2635.21, 4207.5, 42.49),     heading = 329.56,    model = "prop_cactus_03"},
    { location = vector3(2644.97, 4193.51, 42.11),    heading = 25.16,     model = "prop_cactus_03"},
    { location = vector3(2654.21, 4195.31, 41.23),    heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2653.32, 4206.49, 41.62),    heading = 334.49,    model = "prop_cactus_03"},
    { location = vector3(2647.45, 4213.94, 42.49),    heading = 329.56,    model = "prop_cactus_03"},
    { location = vector3(2636.3, 4218.49, 43.03),     heading = 25.16,     model = "prop_cactus_03"},
    { location = vector3(2627.37, 4223.2, 42.88),     heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2617.86, 4230.38, 42.63),    heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2609.8, 4222.12, 41.19),     heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2602.96, 4194.05, 41.01),    heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2614.39, 4188.3, 41.68),     heading = 21.52,     model = "prop_cactus_03"},
    { location = vector3(2623.82, 4189.97, 41.44),    heading = 21.52,     model = "prop_cactus_03"},
}
GlobalState.Mescaline = m
Citizen.CreateThread(function()
    for _, v in pairs(m) do
        v.taken = false
    end
end)

function MescalineCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        m[loc].taken = false
        GlobalState.Mescaline = m
        TriggerClientEvent('Mescaline:respawnCane', -1, loc)
        Log('Cactus Respawned At ' ..m[loc].location, 'mescaline')
    end)
end


RegisterNetEvent("Mescaline:pickupCane", function(loc)
	if CheckDist(source, m[loc].location) then return end
    if not m[loc].taken then
        m[loc].taken = true
        GlobalState.Mescaline = m
        TriggerClientEvent("Mescaline:removeCane", -1, loc)
        MescalineCooldown(loc)
        AddItem(source,'cactusbulb', 1)
    end
end)

RegisterNetEvent("md-drugs:server:drymescaline", function()
    local src = source
    if not checkLoc(src, 'singleSpot', 'DryOut') then return end
    if not GetRecipe(src, 'mescaline', 'dry', 'dried') then return end
end)

CUI("driedmescaline", function(source, item)
    local src = source
    if RemoveItem(src, "driedmescaline", 1) then 
	    TriggerClientEvent("md-drugs:client:takemescaline", src)
        Log(GetName(source) .. ' Consumed Mescaline', 'consume')
    end
end)
