
local weedPlant = {
    { location = vector3(1049.63, -3202.12, -36.75),    heading = 334.49,    model = "prop_weed_01"},
    { location = vector3(1050.85, -3202.15, -36.75),    heading = 329.56,    model = "prop_weed_01"},
    { location = vector3(1052.01, -3202.22, -36.75),    heading = 25.16,     model = "prop_weed_01"},
    { location = vector3(1052.99, -3202.15, -36.75),    heading = 21.52,     model = "prop_weed_01"},
    { location = vector3(1053.08, -3201.11, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1052.91, -3199.99, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1053.02, -3198.97, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1051.95, -3198.93, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1051.96, -3199.86, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1051.93, -3201.17, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1050.98, -3201.13, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1050.89, -3200.07, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1050.89, -3198.95, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1049.72, -3198.95, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1049.98, -3200.1,  -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1049.82, -3201.01, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1053.07, -3194.51, -36.75),    heading = 334.49,    model = "prop_weed_01"},
    { location = vector3(1052.97, -3195.55, -36.75),    heading = 329.56,    model = "prop_weed_01"},
    { location = vector3(1052.82, -3196.58, -36.75),    heading = 25.16,     model = "prop_weed_01"},
    { location = vector3(1052.94, -3197.59, -36.75),    heading = 21.52,     model = "prop_weed_01"},
    { location = vector3(1051.92, -3197.54, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1051.88, -3196.61, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1051.82, -3195.52, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1051.95, -3194.38, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1050.88, -3194.31, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1050.78, -3195.29, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1050.76, -3196.49, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1050.77, -3197.62, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1049.64, -3197.61, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1049.64, -3196.59, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1049.62, -3195.51, -36.75),    heading = 202.97,    model = "prop_weed_01"},
    { location = vector3(1049.66, -3194.36, -36.75),    heading = 202.97,    model = "prop_weed_01"},
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
    local check = lib.callback.await('md-drugs:client:uncuff', src, 'Grinding Weed')
    if not check then return end
    if RemoveItem(src, "drycannabis",1 ) then 
    	AddItem(src, "grindedweed", 1)
    end
end)

CUI("mdwoods", function(source, item)
	local src = source
	local Player = getPlayer(src)
    local check = lib.callback.await('md-drugs:client:uncuff', src, 'Breaking Blunt Open')
    if not check then return end
	if RemoveItem(src, "mdwoods",1 ) then 
		AddItem(src, "bluntwrap", 5)
		AddItem(src, "tobacco", 5)
	end
end)
