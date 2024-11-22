
local QBCore = exports['qb-core']:GetCoreObject()
local weedPlant = {
	{ location = vector3(1049.63, -3202.12, -39.15),    heading = 334.49,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.85, -3202.15, -39.15),    heading = 329.56,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.01, -3202.22, -39.13),    heading = 25.16,     model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.99, -3202.15, -39.15),    heading = 21.52,     model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1053.08, -3201.11, -39.13),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.91, -3199.99, -39.14),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1053.02, -3198.97, -39.11),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.95, -3198.93, -39.11),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.96, -3199.86, -39.12),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.93, -3201.17, -39.12),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.98, -3201.13, -39.14),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.89, -3200.07, -39.12),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.89, -3198.95, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.72, -3198.95, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.98, -3200.1,  -39.14),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.82, -3201.01, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1053.07, -3194.51, -39.15),    heading = 334.49,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.97, -3195.55, -39.15),    heading = 329.56,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.82, -3196.58, -39.15),    heading = 25.16,     model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.94, -3197.59, -39.15),    heading = 21.52,     model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.92, -3197.54, -39.14),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.88, -3196.61, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.82, -3195.52, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.95, -3194.38, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.88, -3194.31, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.78, -3195.29, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.76, -3196.49, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.77, -3197.62, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.64, -3197.61, -39.14),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.64, -3196.59, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.62, -3195.51, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.66, -3194.36, -39.15),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
}
GlobalState.WeedPlant = weedPlant

Citizen.CreateThread(function()
    for _, v in pairs(weedPlant) do
        v.taken = false
    end
end)

function WeedCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        weedPlant[loc].taken = false
        GlobalState.WeedPlant = weedPlant
        Wait(1000)
        TriggerClientEvent('weed:respawnCane', -1, loc)
		Log('Weed Plant Respawned At ' .. weedPlant[loc].location, 'weed')
    end)
end

RegisterNetEvent("weed:pickupCane", function(loc)
	local src = source
    if not weedPlant[loc].taken then
        weedPlant[loc].taken = true
        GlobalState.WeedPlant = weedPlant
        TriggerClientEvent("weed:removeCane", -1, loc)
        WeedCooldown(loc)
        AddItem(src, 'wetcannabis', 1)
		Log(GetName(source) .. ' Picked Weed With a distance of ' .. dist(source, weedPlant[loc].location) .. ' vectors', 'weed')
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


