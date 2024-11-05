local QBCore = exports['qb-core']:GetCoreObject()
GlobalState.PoppyPlants = Config.PoppyPlants


Citizen.CreateThread(function()
    for _, v in pairs(Config.PoppyPlants) do
        v.taken = false
    end
end)


function heroinCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        Config.PoppyPlants[loc].taken = false
        GlobalState.PoppyPlants = Config.PoppyPlants
        Wait(1000)
        TriggerClientEvent('heroin:respawnCane', -1, loc)
		Log('Heroin Plant Respawned At ' .. Config.PoppyPlants[loc].location, 'heroin')
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
	if CheckDist(source, Config.PoppyPlants[loc].location) then return end
    if not Config.PoppyPlants[loc].taken then
        Config.PoppyPlants[loc].taken = true
        GlobalState.PoppyPlants = Config.PoppyPlants
        TriggerClientEvent("heroin:removeCane", -1, loc)
        heroinCooldown(loc)
        AddItem(source, 'poppyresin', 1)
        Log(GetName(source) .. ' Picked A Poppies With a distance of ' .. dist(source, Config.PoppyPlants[loc].location) .. ' vectors', 'heroin')
    end
end)

RegisterServerEvent('md-drugs:server:dryplant', function(num)
	local src = source
	if CheckDist(source, Config.dryplant[num]['loc']) then return end
	if not Itemcheck(source, 'poppyresin', 1) then return end
	if Config.TierSystem then
		local heroin = getRep(src, 'heroin')
		if heroin <= Config.Tier1 then
			if not GetRecipe(src, 'heroin', 'dryheroin', 'tier1') then return end
			Log(GetName(src) ..' Made Heroin Powder With a distance of ' .. dist(source, Config.dryplant[num]['loc']) .. ' vectors', 'heroin')
		elseif heroin >= Config.Tier1 and heroin <= Config.Tier2 then
			if not GetRecipe(src, 'heroin', 'dryheroin', 'tier2') then return end
			Log(GetName(src) ..' Made Heroin Powder Tier 2 With a distance of ' .. dist(source, Config.dryplant[num]['loc']) .. ' vectors', 'heroin')
		else
			if not GetRecipe(src, 'heroin', 'dryheroin', 'tier3') then return end
			Log(GetName(src) ..' Made Heroin Powder  Tier 3 With a distance of ' .. dist(source, Config.dryplant[num]['loc']) .. ' vectors', 'heroin')
		end
	else
		if not GetRecipe(src, 'heroin', 'dryheroin', 'tier1') then return end
		Log(GetName(src) ..' Made Heroin Powder With a distance of ' .. dist(source, Config.dryplant[num]['loc']) .. ' vectors', 'heroin')
	end
end)


RegisterServerEvent('md-drugs:server:cutheroin', function(num)
	local src = source
    local Player = getPlayer(src)
	if CheckDist(source, Config.cutheroinone[num]['loc']) then return end
	if not Itemcheck(src, 'bakingsoda', 1) then return end
	if Config.TierSystem then
		local rawh = Player.Functions.GetItemByName('heroin')
		local rawh2 = Player.Functions.GetItemByName('heroinstagetwo')
		local rawh3 = Player.Functions.GetItemByName('heroinstagethree')
		if rawh then
			if not GetRecipe(src, 'heroin', 'cutheroin', 'tier1') then return end
			Log(GetName(src) ..' Cut Heroin With a distance of ' .. dist(source, Config.cutheroinone[num]['loc']) .. ' vectors', 'heroin')
		elseif rawh2 then
			if not GetRecipe(src, 'heroin', 'cutheroin', 'tier2') then return end
			Log(GetName(src) ..' Cut Heroin Tier 2 With a distance of ' .. dist(source, Config.cutheroinone[num]['loc']) .. ' vectors', 'heroin')
		elseif rawh3 then
			if not GetRecipe(src, 'heroin', 'cutheroin', 'tier3') then return end
			Log(GetName(src) .. ' Cut Heroin Tier 3 With a distance of ' .. dist(source, Config.cutheroinone[num]['loc']) .. ' vectors', 'heroin')
		else
			Notifys(src, Lang.Heroin.noheroin, "error")
		end
	else
		if not GetRecipe(src, 'heroin', 'cutheroin', 'tier1') then return end
		Log(GetName(src) ..' Cut Heroin With a distance of ' .. dist(source, Config.cutheroinone[num]['loc']) .. ' vectors', 'heroin')
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkit', function()
	local src = source
	local Player = getPlayer(src)

	if CheckDist(source, vector3(Config.buyheroinlabkit.x,Config.buyheroinlabkit.y,Config.buyheroinlabkit.z)) then return end
	if Player.Functions.RemoveMoney('cash', Config.heroinlabkitprice) then
		AddItem(src, 'heroinlabkit', 1)
		Log(GetName(src) ..' Bought A Heroin lab Kit ' .. dist(source, vector3(Config.buyheroinlabkit.x,Config.buyheroinlabkit.y,Config.buyheroinlabkit.z)) .. ' vectors', 'heroin')
	else
		Notifys(src, 'You Need '.. Config.heroinlabkitprice .. ' In Cash For This', 'error')
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkitback', function()
local src = source
local Player = getPlayer(src)
	if AddItem(src, "heroinlabkit", 1) then
		Log(GetName(src) ..' Picked Up Their Heroin Lab Kit Back At ' .. GetCoords(src) .. '!', 'heroin')
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
			Log(GetName(src) ..' Made A Vial Of Heroin', 'heroin')
		elseif cuth2 then
			if not GetRecipe(src, 'heroin', 'fillvial', 'tier2') then return end
			Log(GetName(src) ..' Made A Vial Of Heroin Tier 2', 'heroin')
		elseif cuth3 then
			if not GetRecipe(src, 'heroin', 'fillvial', 'tier3') then return end
			Log(GetName(src) ..' Made A Vial Of Heroin Tier 3', 'heroin')
		else
			Notifys(src, 'no cut heroin', "error")
		end
	else
		if not GetRecipe(src, 'heroin', 'fillvial', 'tier1') then return end
		Log(GetName(src) ..' Made A Vial Of Heroin', 'heroin')
	end
end)

RegisterServerEvent('md-drugs:server:failheatingheroin', function()
local src = source
local Player = getPlayer(src)
local cuth = Player.Functions.GetItemByName('heroincut')
local cuth2 = Player.Functions.GetItemByName('heroincutstagetwo')
local cuth3 = Player.Functions.GetItemByName('heroincutstagethree')
Log(GetName(src) ..' Sucks And Burned Their Heroin', 'heroin')
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
	if CheckDist(source, Config.fillneedle[num]['loc']) then return end
	if not Itemcheck(src, 'needle', 1) then return end
	if Config.TierSystem then
		local heroin = getRep(src, 'heroin')
		local vh = Player.Functions.GetItemByName('heroinvial')
		local vh2 = Player.Functions.GetItemByName('heroinvialstagetwo')
		local vh3 = Player.Functions.GetItemByName('heroinvialstagethree')
		if vh then
			if not GetRecipe(src, 'heroin', 'fillneedle', 'tier1') then return end
			AddRep(src, 'heroin')
			Log(GetName(src) ..' Filled A Needle Of Heroin And Now Has A Rep Of ' .. heroin + 1 .. '!' , 'heroin')
		elseif vh2 then
			if not GetRecipe(src, 'heroin', 'fillneedle', 'tier2') then return end
			AddRep(src, 'heroin')
			Log(GetName(src) ..' Filled A Needle Of Heroin Tier 2 And Now Has A Rep Of ' .. heroin + 1 .. '!' , 'heroin')
		elseif vh3 then
			if not GetRecipe(src, 'heroin', 'fillneedle', 'tier3') then return end
			AddRep(src, 'heroin')
			Log(GetName(src) ..' Filled A Needle Of Heroin Tier 3 And Now Has A Rep Of ' .. heroin + 1  .. '!' , 'heroin')
		else
			Notifys(src,Lang.Heroin.nofill, "error")
		end
	else
		if not GetRecipe(src, 'heroin', 'fillneedle', 'tier1') then return end
		Log(GetName(src) ..' Filled A Needle Of Heroin!' , 'heroin')
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

