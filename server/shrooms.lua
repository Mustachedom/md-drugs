local QBCore = exports['qb-core']:GetCoreObject()

local s = {
    { location = vector3(2185.14, 5183.81, 57.48),    heading = 334.49,    model = "mushroom"},
    { location = vector3(2174.45, 5187.85, 57.43),    heading = 329.56,    model = "mushroom"},
    { location = vector3(2166.22, 5196.56, 58.0),     heading = 25.16,     model = "mushroom"},
    { location = vector3(2166.82, 5204.83, 58.63),    heading = 21.52,     model = "mushroom"},
    { location = vector3(2174.84, 5205.82, 59.19),    heading = 334.49,    model = "mushroom"},
    { location = vector3(2184.46, 5201.23, 59.2),     heading = 329.56,    model = "mushroom"},
    { location = vector3(2192.45, 5194.89, 58.86),    heading = 25.16,     model = "mushroom"},
    { location = vector3(2207.53, 5187.81, 58.95),    heading = 21.52,     model = "mushroom"},
    { location = vector3(2213.46, 5191.11, 59.81),    heading = 334.49,    model = "mushroom"},
    { location = vector3(2218.31, 5180.0, 58.18),     heading = 329.56,    model = "mushroom"},
    { location = vector3(2212.75, 5172.35, 57.2),     heading = 25.16,     model = "mushroom"},
    { location = vector3(2208.56, 5167.06, 56.34),    heading = 21.52,     model = "mushroom"},
    { location = vector3(2196.9, 5158.59, 54.84),     heading = 21.52,     model = "mushroom"},
    { location = vector3(2191.62, 5174.91, 56.68),    heading = 21.52,     model = "mushroom"},
    { location = vector3(2190.18, 5182.54, 57.47),    heading = 21.52,     model = "mushroom"},
    { location = vector3(2185.85, 5190.49, 58.1),     heading = 21.52,     model = "mushroom"},
    { location = vector3(2179.95, 5194.19, 58.26),    heading = 21.52,     model = "mushroom"},
}
GlobalState.shrooms = s
Citizen.CreateThread(function()
    for _, v in pairs(s) do
        v.taken = false
    end
end)


function shroomsCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        s[loc].taken = false
        GlobalState.shrooms = s
        Wait(1000)
        TriggerClientEvent('shrooms:respawnCane', -1, loc)
        Log('Cactus Respawned At ' .. s[loc].location, 'shrooms')
    end)
end

RegisterNetEvent("shrooms:pickupCane", function(loc)
	if CheckDist(source, s[loc].location) then return end
    if not s[loc].taken then
        s[loc].taken = true
        GlobalState.shrooms = s
        TriggerClientEvent("shrooms:removeCane", -1, loc)
        shroomsCooldown(loc)
        AddItem(source, 'shrooms', 1)
        Log(GetName(source) .. ' Picked A Shroom With a distance of ' .. dist(source,s[loc].location) .. ' vectors', 'shrooms')
    end
end)

CUI('shrooms', function(source, item)
local src = source
if TriggerClientEvent('md-drugs:client:takeshrooms', src, item.name) then
	RemoveItem(src, 'shrooms', 1)
    Log(GetName(source) .. ' Took Some Mushrooms', 'shrooms')
    Notifys(src, 'You Took Some Shrooms!', 'success')
	end
end)

