
local prices = {
	heroinlabkitprice = 10000
}
local heroinLabKits = {}
local h = {
	{ location = vector3(-2251.3, -99.18, 100.11),    heading = 334.49,    model = "prop_plant_01b"},
    { location = vector3(-2249.63, -92.97, 101.8),    heading = 329.56,    model = "prop_plant_01b"},
    { location = vector3(-2245.57, -85.12, 104.5),    heading = 25.16,     model = "prop_plant_01b"},
    { location = vector3(-2240.81, -88.48, 105.88),   heading = 21.52,     model = "prop_plant_01b"},
    { location = vector3(-2240.87, -93.36, 103.88),   heading = 334.49,    model = "prop_plant_01b"},
    { location = vector3(-2236.0, -95.34, 102.55),    heading = 329.56,    model = "prop_plant_01b"},
    { location = vector3(-2240.6, -100.01, 100.49),   heading = 25.16,     model = "prop_plant_01b"},
    { location = vector3(-2246.29, -104.92, 99.27),   heading = 21.52,     model = "prop_plant_01b"},
    { location = vector3(-2243.64, -107.99, 96.71),   heading = 334.49,    model = "prop_plant_01b"},
    { location = vector3(-2254.22, -108.76, 97.25),   heading = 329.56,    model = "prop_plant_01b"},
    { location = vector3(-2247.33, -108.92, 97.70),   heading = 25.16,     model = "prop_plant_01b"},
    { location = vector3(-2250.96, -111.22, 97.50),   heading = 21.52,     model = "prop_plant_01b"},
    { location = vector3(465.95, -1021.32, 31.78),    heading = 21.52,     model = "prop_plant_01b"},
}

GlobalState.PoppyPlants = h
Citizen.CreateThread(function()
    for _, v in pairs(h) do
        v.taken = false
    end
end)

function heroinCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
		h[loc].taken = false
        GlobalState.PoppyPlants = h
        Wait(1000)
        TriggerClientEvent('heroin:respawnCane', -1, loc)
		Log('Heroin Plant Respawned At ' .. h[loc].location, 'heroin')
    end)
end

lib.callback.register('removeCleaningkit', function(source)
	local Player = getPlayer(source)
	for k, v in pairs(heroinLabKits) do
		if v.ownerid == getCid(source) then
			RemoveItem(source, 'cleaningkit', 1)
			return true
		end
	end
	return false
end)

RegisterServerEvent("heroin:pickupCane", function(loc)
	if CheckDist(source, h[loc].location) then return end
    if not h[loc].taken then
		h[loc].taken = true
        GlobalState.PoppyPlants = h
        TriggerClientEvent("heroin:removeCane", -1, loc)
        heroinCooldown(loc)
        AddItem(source, 'poppyresin', 1)
    end
end)

RegisterServerEvent('md-drugs:server:dryplant', function(num)
	local src = source
	if not checkLoc(source, 'dryplant', num) then return end
	if not Itemcheck(source, 'poppyresin', 1) then return end
	if Config.TierSystem then
		local heroin = getRep(src, 'heroin')
		if heroin <= Config.Tier1 then
			if not GetRecipe(src, 'heroin', 'dryheroin', 'tier1') then return end
		elseif heroin >= Config.Tier1 and heroin <= Config.Tier2 then
			if not GetRecipe(src, 'heroin', 'dryheroin', 'tier2') then return end
		else
			if not GetRecipe(src, 'heroin', 'dryheroin', 'tier3') then return end
		end
	else
		if not GetRecipe(src, 'heroin', 'dryheroin', 'tier1') then return end
	end
end)

RegisterServerEvent('md-drugs:server:cutheroin', function(num)
	local src = source
    local Player = getPlayer(src)
	if not checkLoc(source, 'cutheroinone', num) then return end
	if not Itemcheck(src, 'bakingsoda', 1) then return end
	if Config.TierSystem then
		local heroin = {
			heroin = 'tier1',
			heroinstagetwo = 'tier2',
			heroinstagethree = 'tier3'
		}
		for k, v in pairs (heroin) do
			if hasItem(src, k, 1) then
				if not GetRecipe(src, 'heroin', 'cutheroin', v) then return end
				return
			end
		end
		Notifys(src, Lang.Heroin.noheroin, "error")
	else
		if not GetRecipe(src, 'heroin', 'cutheroin', 'tier1') then return end
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkit', function()
	local src = source
	if not checkLoc(src, 'singleSpot', 'buyheroinlabkit') then return end
	if hasItem(src, 'heroinlabkit', 1) then Notifys(src, Lang.Heroin.haskit, 'error') return end
	if removeMoney(src, 'cash', prices.heroinlabkitprice) then
		AddItem(src, 'heroinlabkit', 1)
	else
		Notifys(src, 'You Need '.. prices.heroinlabkitprice .. ' In Cash For This', 'error')
	end
end)

local function hasHKit(src)
	local src = source
	local Player = getPlayer(src)
	for k, v in pairs(heroinLabKits) do
		if v.ownerid == getCid(source) then
			return true
		end
	end
	return false
end

RegisterServerEvent('md-drugs:server:getheroinlabkitback', function()
	local src = source
	if not hasHKit(src) then return end
	for k, v in pairs (heroinLabKits) do
		if v.ownerid == getCid(source) then
			table.remove(heroinLabKits, k)
			AddItem(src, 'heroinlabkit', 1)
		end
	end
end)


CUI('heroinlabkit', function(source, item)
	local src = source
	if not Itemcheck(source, 'heroinlabkit', 1) then return end
	local placed, loc = lib.callback.await('md-drugs:client:setheroinlabkit', src)
	if placed then 
		RemoveItem(src, 'heroinlabkit', 1)
		table.insert(heroinLabKits, {
			src = src, 
			ownerid = getCid(source),
			coords = loc,
			name = GetName(src)
		})
		Notifys(src, Lang.Heroin.placed, "success")
	end
end)

RegisterServerEvent('md-drugs:server:heatliquidheroin', function()
local src = source
	if not hasHKit(src) then return end
	if not Itemcheck(source, 'emptyvial', 1) then return end
	if Config.TierSystem then
		local heroin = {
			heroincut = 'tier1',
			heroincutstagetwo = 'tier2',
			heroincutstagethree = 'tier3'
		}
		for k, v in pairs (heroin) do
			if hasItem(src, k, 1) then
				if not GetRecipe(src, 'heroin', 'fillvial', v) then return end
				return
			end
		end
		Notifys(src, 'no cut heroin', "error")
	else
		if not GetRecipe(src, 'heroin', 'fillvial', 'tier1') then return end
	end
end)

RegisterServerEvent('md-drugs:server:failheatingheroin', function()
	local src = source
	if not hasHKit(src) then return end
	local heroin = {'heroincut', 'heroincutstagetwo', 'heroincutstagethree'}
	for k, v in pairs (heroin) do 
		if hasItem(src, v, 1) then
			RemoveItem(src, v, 1)
			Notifys(src, Lang.Heroin.fail, "error")
			return
		end
	end
end)

RegisterServerEvent('md-drugs:server:fillneedle', function(num)
	local src = source
	if not checkLoc(source, 'fillneedle', num) then return end
	if not Itemcheck(src, 'needle', 1) then return end
	if Config.TierSystem then
		local vials = {
			heroinvial = 'tier1',
			heroinvialstagetwo = 'tier2',
			heroinvialstagethree = 'tier3'
		}
		for k, v in  pairs (vials) do
			if hasItem(src, k, 1) then
				if not GetRecipe(src, 'heroin', 'fillneedle', v) then return end
				AddRep(src, 'heroin')
				return
			end
		end
	else
		if not GetRecipe(src, 'heroin', 'fillneedle', 'tier1') then return end
	end
end)

RegisterServerEvent('md-drugs:server:failheroin', function()
	local src = source
	Log(GetName(src) ..' Sucks And Burned Their Heroin', 'heroin')
	if Config.TierSystem then
		local heroin = {'heroinvial', 'heroinvialstagetwo', 'heroinvialstagethree'}
		for k, v in pairs (heroin) do 
			if hasItem(src, v, 1) then
				RemoveItem(src, v, 1)
				Notifys(src, Lang.Heroin.fail, "error")
				return
			end
		end
	else
		RemoveItem(src, 'heroinvial', 1)
	end
end)

AddEventHandler('playerDropped', function()
	local src = source
	local Player = getPlayer(src)
	for k, v in pairs(heroinLabKits) do
		if v.src == src then
			table.remove(heroinLabKits, k)
			AddItem(src, 'heroinlabkit', 1)
		end
	end
end)