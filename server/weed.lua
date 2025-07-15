
local QBCore = exports['qb-core']:GetCoreObject()
local weedPlant = {
    { location = vector3(1064.84, -3199.84, -42.70),    heading = 334.49,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1063.88, -3198.69, -42.70),    heading = 329.56,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1061.68, -3196.46, -42.70),    heading = 25.16,     model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1061.62, -3199.63, -42.70),    heading = 21.52,     model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.82, -3197.70, -42.70),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1064.69, -3196.31, -42.70),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1062.92, -3198.78, -42.70),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.73, -3201.92, -42.70),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1052.94, -3202.21, -42.70),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1051.93, -3201.17, -42.70),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.98, -3201.13, -42.70),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.89, -3200.07, -42.70),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1050.89, -3198.95, -42.70),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
    { location = vector3(1049.72, -3198.95, -42.70),    heading = 202.97,    model = "bkr_prop_weed_lrg_01b"},
   
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
    if CheckDist(source, weedPlant[loc].location) then return end
    if not weedPlant[loc].taken then
        weedPlant[loc].taken = true
        GlobalState.WeedPlant = weedPlant
        TriggerClientEvent("weed:removeCane", -1, loc)
        WeedCooldown(loc)
        AddItem(source, 'wetcannabis', 1)
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
	CUI(v, function(source, item) TriggerClientEvent('md-drugs:client:makeBluntWrap', source) end)
end

local bluntwraps = {'leanbluntwrap', 'dextrobluntwrap', 'bluntwrap'}

for k, v in pairs (bluntwraps) do 
	CUI(v, function(source, item) TriggerClientEvent('md-drugs:client:rollBlunt', source) end)
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


CUI("dabrig", function(source, item)
    local src = source
    local Player = getPlayer(src)

    if Player.Functions.GetItemByName("butanetorch") then 
    	if RemoveItem(src, "shatter", 1) then
        	TriggerClientEvent("md-drugs:client:dodabs", src)
        end
    else
    	Notifys(src, 'You Need A Butane Torch', 'error')
    end
end)

CUI("weedgrinder", function(source, item)
    local src = source
    local Player = getPlayer(src)
    local has = Player.Functions.GetItemByName("drycannabis")
    if not has then Notifys(src, 'You Need Dried Cannabis', 'error') return end
     local check = ps.callback('md-drugs:client:uncuff', src, 'Grinding Weed')
    if not check then return end
    if RemoveItem(src, "drycannabis",1 ) then 
    	AddItem(src, "grindedweed", 1)
    end
end)

CUI("mdwoods", function(source, item)
	local src = source
	local Player = getPlayer(src)
     local check = ps.callback('md-drugs:client:uncuff', src, 'Breaking Blunt Open')
    if not check then return end
	if RemoveItem(src, "mdwoods",1 ) then 
		AddItem(src, "bluntwrap", 5)
		AddItem(src, "tobacco", 5)
	end
end)
