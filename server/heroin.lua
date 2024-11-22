local QBCore = exports['qb-core']:GetCoreObject()
local prices = {
	heroinlabkitprice = 10000
}
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

RegisterServerEvent('md-drugs:server:removecleaningkitheroin', function(data)
local src = source
	if RemoveItem(src,"cleaningkit", 1) then
		TriggerClientEvent("md-drugs:client:deletedirtyheroin", src, data)
		Log(GetName(src) .. ' Wiped Down Their Heroin Lab Kit!' , 'heroin')
	else
		Notifys(src, "You cant clean it with spit alone", "error")
	end
end)


RegisterServerEvent("heroin:pickupCane", function(loc)
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
		local rawh = Player.Functions.GetItemByName('heroin')
		local rawh2 = Player.Functions.GetItemByName('heroinstagetwo')
		local rawh3 = Player.Functions.GetItemByName('heroinstagethree')
		if rawh then
			if not GetRecipe(src, 'heroin', 'cutheroin', 'tier1') then return end
		elseif rawh2 then
			if not GetRecipe(src, 'heroin', 'cutheroin', 'tier2') then return end
		elseif rawh3 then
			if not GetRecipe(src, 'heroin', 'cutheroin', 'tier3') then return end
		else
			Notifys(src, Lang.Heroin.noheroin, "error")
		end
	else
		if not GetRecipe(src, 'heroin', 'cutheroin', 'tier1') then return end
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkit', function()
	local src = source
	local Player = getPlayer(src)
	if not checkLoc(source, 'singleSpot', 'buyheroinlabkit') then return end
	if Player.Functions.RemoveMoney('cash', prices.heroinlabkitprice) then
		AddItem(src, 'heroinlabkit', 1)
	else
		Notifys(src, 'You Need '.. prices.heroinlabkitprice .. ' In Cash For This', 'error')
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkitback', function()
local src = source
local Player = getPlayer(src)
	if AddItem(src, "heroinlabkit", 1) then
	end
end)

QBCore.Functions.CreateUseableItem('heroinlabkit', function(source, item)
local src = source
local Player = getPlayer(src)
	if not Itemcheck(source, 'heroinlabkit', 1) then return end
	if TriggerClientEvent("md-drugs:client:setheroinlabkit", src) then
		RemoveItem(src, "heroinlabkit", 1)
		Log(GetName(src) ..' Placed Their Heroin Lab Kit Back At ' .. GetCoords(src) .. '!', 'heroin')
	end
end)



RegisterServerEvent('md-drugs:server:heatliquidheroin', function()
local src = source
local Player = getPlayer(src)
	if not Itemcheck(source, 'emptyvial', 1) then return end
	if Config.TierSystem then
		local cuth = Player.Functions.GetItemByName('heroincut')
		local cuth2 = Player.Functions.GetItemByName('heroincutstagetwo')
		local cuth3 = Player.Functions.GetItemByName('heroincutstagethree')
		if cuth then
			if not GetRecipe(src, 'heroin', 'fillvial', 'tier1') then return end
		elseif cuth2 then
			if not GetRecipe(src, 'heroin', 'fillvial', 'tier2') then return end
		elseif cuth3 then
			if not GetRecipe(src, 'heroin', 'fillvial', 'tier3') then return end
		else
			Notifys(src, 'no cut heroin', "error")
		end
	else
		if not GetRecipe(src, 'heroin', 'fillvial', 'tier1') then return end
	end
end)

RegisterServerEvent('md-drugs:server:failheatingheroin', function()
local src = source
local Player = getPlayer(src)
local cuth = Player.Functions.GetItemByName('heroincut')
local cuth2 = Player.Functions.GetItemByName('heroincutstagetwo')
local cuth3 = Player.Functions.GetItemByName('heroincutstagethree')
	if cuth then
		RemoveItem(src, 'heroincut', 1) 
		Notifys(src,Lang.Heroin.fail, "error")
	elseif cuth2 then
		RemoveItem(src, 'heroincutstagetwo', 1) 
		Notifys(src,Lang.Heroin.fail, "error")
	elseif cuth3 then
		RemoveItem(src, 'heroincutstagethree', 1)
		Notifys(src,Lang.Heroin.fail, "error")
	end
end)


RegisterServerEvent('md-drugs:server:fillneedle', function(num)
	local src = source
    local Player = getPlayer(src)
	if not checkLoc(source, 'fillneedle', num) then return end
	if not Itemcheck(src, 'needle', 1) then return end
	if Config.TierSystem then
		local heroin = getRep(src, 'heroin')
		local vh = Player.Functions.GetItemByName('heroinvial')
		local vh2 = Player.Functions.GetItemByName('heroinvialstagetwo')
		local vh3 = Player.Functions.GetItemByName('heroinvialstagethree')
		if vh then
			if not GetRecipe(src, 'heroin', 'fillneedle', 'tier1') then return end
			AddRep(src, 'heroin')
		elseif vh2 then
			if not GetRecipe(src, 'heroin', 'fillneedle', 'tier2') then return end
			AddRep(src, 'heroin')
		elseif vh3 then
			if not GetRecipe(src, 'heroin', 'fillneedle', 'tier3') then return end
			AddRep(src, 'heroin')
		else
			Notifys(src,Lang.Heroin.nofill, "error")
		end
	else
		if not GetRecipe(src, 'heroin', 'fillneedle', 'tier1') then return end
	end
end)



RegisterServerEvent('md-drugs:server:failheroin', function()
	local src = source
    local Player = getPlayer(src)
	Log(GetName(src) ..' Sucks And Burned Their Heroin', 'heroin')
	if Config.TierSystem then
		local vh = Player.Functions.GetItemByName('heroinvial')
		local vh2 = Player.Functions.GetItemByName('heroinvialstagetwo')
		local vh3 = Player.Functions.GetItemByName('heroinvialstagethree')
		if vh then RemoveItem(src, 'heroinvialstagethree', 1 ) 
		elseif vh2 then RemoveItem(src, 'heroinvialstagetwo', 1) 
		elseif vh3 then RemoveItem(src, 'heroinvial', 1)
		end
	else
		RemoveItem(src, 'heroinvial', 1)
	end
end)

