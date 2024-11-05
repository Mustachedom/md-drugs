local QBCore = exports['qb-core']:GetCoreObject()
GlobalState.Mescaline = Config.Mescaline

Citizen.CreateThread(function()
    for _, v in pairs(Config.Mescaline) do
        v.taken = false
    end
end)

function MescalineCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        Config.Mescaline[loc].taken = false
        GlobalState.Mescaline = Config.Mescaline
        Wait(1000)
        TriggerClientEvent('Mescaline:respawnCane', -1, loc)
        Log('Cactus Respawned At ' .. Config.Mescaline[loc].location, 'mescaline')
    end)
end


RegisterNetEvent("Mescaline:pickupCane", function(loc)
	if CheckDist(source, Config.Mescaline[loc].location) then return end
    if not Config.Mescaline[loc].taken then
        Config.Mescaline[loc].taken = true
        GlobalState.Mescaline = Config.Mescaline
        TriggerClientEvent("Mescaline:removeCane", -1, loc)
        MescalineCooldown(loc)
        AddItem(source,'cactusbulb', 1)
        Log(GetName(source) .. ' Picked Cactus Bulbs With a distance of ' .. dist(source, Config.Mescaline[loc].location) .. ' vectors', 'mescaline')
    end
end)

RegisterNetEvent("md-drugs:server:drymescaline", function()
    local src = source
    if not GetRecipe(src, 'mescaline', 'dry', 'dried') then return end
    Log(GetName(source) .. ' Dried Mescaline', 'mescaline')
end)

QBCore.Functions.CreateUseableItem("driedmescaline", function(source, item)
    local src = source
    if RemoveItem(src, "driedmescaline", 1) then 
	    TriggerClientEvent("md-drugs:client:takemescaline", src)
        Log(GetName(source) .. ' Consumed Mescaline', 'consume')
    end
end)
