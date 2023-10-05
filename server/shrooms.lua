local QBCore = exports['qb-core']:GetCoreObject()
GlobalState.shrooms = Config.shrooms


Citizen.CreateThread(function()
    for _, v in pairs(Config.shrooms) do
        v.taken = false
    end
end)


function shroomsCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        Config.shrooms[loc].taken = false
        GlobalState.shrooms = Config.shrooms
        Wait(1000)
        TriggerClientEvent('shrooms:respawnCane', -1, loc)
    end)
end


RegisterNetEvent("shrooms:pickupCane")
AddEventHandler("shrooms:pickupCane", function(loc)
local chance = math.random(1,10)
    if not Config.shrooms[loc].taken then
        Config.shrooms[loc].taken = true
        GlobalState.shrooms = Config.shrooms
        TriggerClientEvent("shrooms:removeCane", -1, loc)
        shroomsCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem(Config.rewardshrooms, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.rewardshrooms], "add")
		if chance <= 2 then
			Player.Functions.AddItem("lockpick",1 )
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["lockpick"], "add")
		end
    end
end)

QBCore.Functions.CreateUseableItem('shrooms', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)


if TriggerClientEvent('md-drugs:client:takeshrooms', src, item.name) then
	Player.Functions.RemoveItem('shrooms', 1)
	TriggerClientEvent('QBCore:Notify', src,"You have a good trip!", "success")
	end
end)

