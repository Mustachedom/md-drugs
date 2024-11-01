
local QBCore = exports['qb-core']:GetCoreObject()

GlobalState.WeedPlant = Config.WeedPlant

Citizen.CreateThread(function()
    for _, v in pairs(Config.WeedPlant) do
        v.taken = false
    end
end)

function WeedCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        Config.WeedPlant[loc].taken = false
        GlobalState.WeedPlant = Config.WeedPlant
        Wait(1000)
        TriggerClientEvent('weed:respawnCane', -1, loc)
		Log('Weed Plant Respawned At ' .. Config.WeedPlant[loc].location, 'weed')
    end)
end

RegisterNetEvent("weed:pickupCane")
AddEventHandler("weed:pickupCane", function(loc)
	local src = source
    if not Config.WeedPlant[loc].taken then
        Config.WeedPlant[loc].taken = true
        GlobalState.WeedPlant = Config.WeedPlant
        TriggerClientEvent("weed:removeCane", -1, loc)
        WeedCooldown(loc)
        AddItem(src, 'wetcannabis', 1)
		Log(GetName(source) .. ' Picked Weed With a distance of ' .. dist(source, Config.WeedPlant[loc].location) .. ' vectors', 'weed')
    
    end
end)
--------------- events

RegisterServerEvent('md-drugs:server:dryoutweed', function()
	local src = source
    local Player = getPlayer(src)
	if RemoveItem(src,"wetcannabis", 1) then
    	AddItem(src,"drycannabis", 1)
		Log(GetName(source) .. ' Dried Weed', 'weed')
    else
		Notifys(src, Lang.Weed.nodry, "error")
	end
end)

local bluntwrap = {'mdreddextro','mdlean'}
for k, v in pairs (bluntwrap) do 
	QBCore.Functions.CreateUseableItem(v, function(source, item) 
		local src = source
		TriggerClientEvent('md-drugs:client:makeBluntWrap', src)
	end)
end

local bluntwraps = {'leanbluntwrap', 'dextrobluntwrap', 'bluntwrap'}

for k, v in pairs (bluntwraps) do 
	QBCore.Functions.CreateUseableItem(v, function(source, item)
		local src = source
		TriggerClientEvent('md-drugs:client:rollBlunt', source)
	end)
end


RegisterServerEvent('md-drugs:server:MakeWeedItems', function(data)
	local src = source
	local Player = getPlayer(src) 
	if not Player then return end
	if not GetRecipe(src, data.recipe, data.table, data.item) then return end
end)

RegisterServerEvent('md-drugs:server:makeoil', function(data)
	local src = source
	local Player = getPlayer(src) 
	if not Player then return end
	if not GetRecipe(src, 'weed', 'oil', 'shatter') then return end
end)

QBCore.Functions.CreateUseableItem("dabrig", function(source, item)
local src = source
local Player = getPlayer(src)

if Player.Functions.GetItemByName("butanetorch") then 
	if RemoveItem(src, "shatter", 1) then
		Notifys(src, 'test', 'success')
    	TriggerClientEvent("md-drugs:client:dodabs", src)
    end
end
end)

QBCore.Functions.CreateUseableItem("weedgrinder", function(source, item)
local src = source
if RemoveItem(src, "drycannabis",1 ) then 
	AddItem(src, "grindedweed", 1)
	TriggerClientEvent("md-drugs:client:grind", src)
else
	Notifys(src,'You Need Dried Weed', 'error')
end
end)

QBCore.Functions.CreateUseableItem("mdwoods", function(source, item)
local src = source
local Player = getPlayer(src)
TriggerClientEvent("md-drugs:client:rollanim", src)
Wait(4000)
if RemoveItem(src, "mdwoods",1 ) then 
	AddItem(src, "bluntwrap", 5)
	AddItem(src, "tobacco", 5)
end
end)


