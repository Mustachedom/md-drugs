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
        Log('Cactus Respawned At ' .. Config.shrooms[loc].location, 'shrooms')
    end)
end


RegisterNetEvent("shrooms:pickupCane")
AddEventHandler("shrooms:pickupCane", function(loc)
    local chance = math.random(1,10)
    local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.shrooms[loc].location) then return end
    if not Config.shrooms[loc].taken then
        Config.shrooms[loc].taken = true
        GlobalState.shrooms = Config.shrooms
        TriggerClientEvent("shrooms:removeCane", -1, loc)
        shroomsCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        AddItem('shrooms', 1)
        Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Picked A Shroom With a distance of ' .. dist(source, playerPed, Config.shrooms[loc].location) .. ' vectors', 'shrooms')
    end
end)

QBCore.Functions.CreateUseableItem('shrooms', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if TriggerClientEvent('md-drugs:client:takeshrooms', src, item.name) then
	Player.Functions.RemoveItem('shrooms', 1)
    Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Took Some Mushrooms', 'shrooms')
    TriggerClientEvent("QBCore:Notify", src, Lang.Shrooms.trip, 'success')
	end
end)

