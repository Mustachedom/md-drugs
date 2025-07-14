local QBCore = exports['qb-core']:GetCoreObject()

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

ps.registerCallback('removeCleaningkit', function(source)
	for k, v in pairs(heroinLabKits) do
		if v.ownerid == ps.getIdentifier(source) then
			ps.removeItem(source, 'cleaningkit', 1)
			return true
		end
	end
	return false
end)

RegisterServerEvent("heroin:pickupCane", function(loc)
	local src = source
	if ps.checkDistance(src, h[loc].location, 3.0) then return end
    if not h[loc].taken then
		h[loc].taken = true
        GlobalState.PoppyPlants = h
        TriggerClientEvent("heroin:removeCane", -1, loc)
        heroinCooldown(loc)
        ps.addItem(src, 'poppyresin', 1)
    end
end)

RegisterServerEvent('md-drugs:server:dryplant', function(num)
	local src = source
	if not ps.checkDistance(src, GlobalState.MDDrugsLocs.dryplant[num].loc, 3.0) then return end
	if not ps.hasItem(src, 'poppyresin', 1) then return end
	if Config.TierSystem then
		local heroin = getRep(src, 'heroin')
		if heroin <= Config.Tier1 then
			if not GetRecipe(src, 'heroin', 'dryheroin', 'tier1') then return end
		elseif heroin >= Config.Tier1 and heroin <= Config.Tier2 then
			if not GetRecipe(src, 'heroin', 'dryheroin', 'tier2') then return end
		else
			if not GetRecipe(src, 'heroin', 'dryheroin', 'tier3') then return end
		end
		return
	end
	if not GetRecipe(src, 'heroin', 'dryheroin', 'tier1') then return end
end)

RegisterServerEvent('md-drugs:server:cutheroin', function(num)
	local src = source
	if not ps.checkDistance(src, GlobalState.MDDrugsLocs.cutheroinone[num].loc, 3.0) then return end
	if not ps.hasItem(src, 'bakingsoda', 1) then return end
	if Config.TierSystem then
		local itemList = {
			heroin = 'tier1',
			heroinstagetwo = 'tier2',
			heroinstagethree = 'tier3'
		}
		for k, v in pairs(itemList) do
			local cuth = ps.hasItem(src, k)
			if cuth then 
				if not GetRecipe(src, 'heroin', 'cutheroin', v) then return end
				AddRep(src, 'heroin')
				return
			end
		end
	else
		if not GetRecipe(src, 'heroin', 'cutheroin', 'tier1') then return end
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkit', function()
	local src = source
	if not ps.checkDistance(src, GlobalState.MDDrugsLocs.singleSpot.buyheroinlabkit, 3.0) then return end
	local has = ps.hasItem(src, 'heroinlabkit')
	if has then ps.notify(src, Lang.Heroin.haskit, 'error') return end
	if ps.removeMoney(src, 'cash', prices.heroinlabkitprice) then
		ps.addItem(src, 'heroinlabkit', 1)
	else
		ps.notify(src, 'You Need '.. prices.heroinlabkitprice .. ' In Cash For This', 'error')
	end
end)

local function hasHKit(src)
	for k, v in pairs(heroinLabKits) do
		if v.ownerid == ps.getIdentifier(src) then
			return true
		end
	end
	return false
end

RegisterServerEvent('md-drugs:server:getheroinlabkitback', function()
	local src = source
	if not hasHKit(src) then return end
	for k, v in pairs (heroinLabKits) do
		if v.ownerid == ps.getIdentifier(src) then
			table.remove(heroinLabKits, k)
			ps.addItem(src, 'heroinlabkit', 1)
		end
	end
end)


ps.createUseable('heroinlabkit', function(source, item)
	local src = source
	if not ps.hasItem(src, 'heroinlabkit', 1) then return end
	local placed, loc = ps.callback('md-drugs:client:setheroinlabkit', src)
	if placed then 
		ps.removeItem(src, 'heroinlabkit', 1)
		table.insert(heroinLabKits, {
			src = src,
			ownerid = ps.getIdentifier(src),
			coords = loc,
			name = ps.getPlayerName(src)
		})
		ps.notify(src, Lang.Heroin.placed, "success")
	end
end)

RegisterServerEvent('md-drugs:server:heatliquidheroin', function()
	local src = source
	if not hasHKit(src) then return end
	if not ps.itemCheck(src, 'emptyvial', 1) then return end
	if Config.TierSystem then
		local itemList = {
			heroincut = 'tier1',
			heroincutstagetwo = 'tier2',
			heroincutstagethree = 'tier3'
		}
		for k, v in pairs(itemList) do
			local cuth = ps.hasItem(src, k)
			if cuth then
				if not GetRecipe(src, 'heroin', 'fillvial', v) then return end
				AddRep(src, 'heroin')
				return
			end
		end
	else
		if not GetRecipe(src, 'heroin', 'fillvial', 'tier1') then return end
	end
end)

RegisterServerEvent('md-drugs:server:failheatingheroin', function()
	local src = source
	if not hasHKit(src) then return end
	local itemList = {
		heroincut = 1,
		heroincutstagetwo = 1,
		heroincutstagethree = 1
	}
	for k, v in pairs(itemList) do
		local cuth = ps.hasItem(src, k)
		if cuth then
			ps.removeItem(src, k, v)
			ps.notify(src, Lang.Heroin.fail, "error")
			return
		end
	end
end)

RegisterServerEvent('md-drugs:server:fillneedle', function(num)
	local src = source
	if not ps.checkDistance(src, GlobalState.MDDrugsLocs.fillneedle[num].loc, 3.0) then
		ps.notify(src, Lang.Heroin.noloc, 'error')
		return
	end
	if not ps.hasItem(src, 'needle', 1) then return end
	if Config.TierSystem then
		local itemList = {
			{item = 'heroinvial', 		  	tier = 'tier1',   log = ' Filled Heroin Needle'},
			{item = 'heroinvialstagetwo',   tier = 'tier2', log = ' Filled Heroin Needle tier 2'},
			{item = 'heroinvialstagethree', tier = 'tier3', log = ' Filled Heroin Needle tier 3'}
		}
		for k, v in pairs(itemList) do
			local vh = ps.hasItem(src, v.item)
			if vh then
				if not GetRecipe(src, 'heroin', 'fillneedle', v.tier) then return end
				AddRep(src, 'heroin')
				Log(ps.getPlayerName(src) .. v.log, 'heroin')
				return
			end
		end
		ps.notify(src,Lang.Heroin.nofill, "error")
	else
		if not GetRecipe(src, 'heroin', 'fillneedle', 'tier1') then return end
	end
end)

RegisterServerEvent('md-drugs:server:failheroin', function()
	local src = source
	Log(ps.getPlayerName(src) ..' Sucks And Burned Their Heroin', 'heroin')
	if Config.TierSystem then
		local itemList = {
			heroinvial = 1,
			heroinvialstagetwo = 1,
			heroinvialstagethree = 1
		}
		for k, v in pairs (itemList) do
			local cuth = ps.hasItem(src, k)
			if cuth then
				ps.removeItem(src, k, v)
				ps.notify(src, Lang.Heroin.failneedle, "error")
				return
			end
		end
	else
		ps.removeItem(src, 'heroinvial', 1)
	end
end)

AddEventHandler('playerDropped', function()
	local src = source
	for k, v in pairs(heroinLabKits) do
		if v.src == src then
			table.remove(heroinLabKits, k)
			ps.addItem(src, 'heroinlabkit', 1)
		end
	end
end)