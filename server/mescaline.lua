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
    end)
end



RegisterNetEvent("Mescaline:pickupCane")
AddEventHandler("Mescaline:pickupCane", function(loc)
    if not Config.Mescaline[loc].taken then
        Config.Mescaline[loc].taken = true
        GlobalState.Mescaline = Config.Mescaline
        TriggerClientEvent("Mescaline:removeCane", -1, loc)
        MescalineCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem(Config.rewardMescaline, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.rewardItemheroin], "add")
    end
end)



RegisterNetEvent("md-drugs:server:drymescaline")
AddEventHandler("md-drugs:server:drymescaline", function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

 if Player.Functions.RemoveItem("cactusbulb", 1) then
	Player.Functions.AddItem("driedmescaline", 1)
	 TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[driedmescaline], "add", 1)
end
end)

QBCore.Functions.CreateUseableItem("driedmescaline", function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.RemoveItem("driedmescaline", 1) then 
	TriggerClientEvent("md-drugs:client:takemescaline", src)
end
end)