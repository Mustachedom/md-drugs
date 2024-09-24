local QBCore = exports['qb-core']:GetCoreObject()

GlobalState.CocaPlant = Config.CocaPlant

Citizen.CreateThread(function()
    for _, v in pairs(Config.CocaPlant) do
        v.taken = false
    end
end)

function CaneCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        Config.CocaPlant[loc].taken = false
        GlobalState.CocaPlant = Config.CocaPlant
        Wait(1000)
        TriggerClientEvent('coke:respawnCane', -1, loc)
		Log('Coca Plant Respawned At ' .. Config.CocaPlant[loc].location, 'coke')
    end)
end

RegisterNetEvent("coke:pickupCane")
AddEventHandler("coke:pickupCane", function(loc)
	local src = source
	if CheckDist(src, Config.CocaPlant[loc].location) then return end
    if not Config.CocaPlant[loc].taken then
        Config.CocaPlant[loc].taken = true
        GlobalState.CocaPlant = Config.CocaPlant
        TriggerClientEvent("coke:removeCane", -1, loc)
        CaneCooldown(loc)
        AddItem(src, 'coca_leaf', 1)
		Log(GetName(src) .. ' Picked A Coca Leaf With a distance of ' .. dist(src, Config.CocaPlant[loc].location) .. ' vectors', 'coke')
    end
end)

RegisterServerEvent('md-drugs:server:makepowder', function(num)
	local src = source
	if CheckDist(src, Config.MakePowder[num]['loc']) then return end
	if Config.TierSystem then		
		local coke = getRep(src, 'coke')
		if coke <= Config.Tier1 then
			if not GetRecipe(src, 'cocaine', 'cokepowder', 'tier1') then return end
			Log(GetName(src) .. ' Made Raw Coke' .. dist(src, Config.MakePowder[num]['loc']) .. ' vectors', 'coke')
		elseif coke >= Config.Tier1 and coke <= Config.Tier2 then
			if not GetRecipe(src, 'cocaine', 'cokepowder', 'tier2') then return end
			Log(GetName(src)  .. ' Made Raw Coke tier 2' .. dist(src, Config.MakePowder[num]['loc']) .. ' vectors', 'coke')
		else
			if not GetRecipe(src, 'cocaine', 'cokepowder', 'tier3') then return end
			Log(GetName(src) ..' Made Raw Coke tier 3' .. dist(src, Config.MakePowder[num]['loc']) .. ' vectors', 'coke')
		end
	else
		if not GetRecipe(src, 'cocaine', 'cokepowder', 'tier1') then return end
		Log(GetName(src) .. ' Made Raw Coke' .. dist(src, Config.MakePowder[num]['loc']) .. ' vectors', 'coke')
	end
end)

RegisterServerEvent('md-drugs:server:cutcokeone', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Config.TierSystem then
		local coke = Player.Functions.GetItemByName('coke')
		local coke2 = Player.Functions.GetItemByName('cokestagetwo')
		local coke3 = Player.Functions.GetItemByName('cokestagethree')
		if coke then
			if not GetRecipe(src, 'cocaine', 'cutcoke', 'tier1') then return end
			Log(GetName(src)  .. ' Cut Coke', 'coke')
		elseif coke2 then
			if not GetRecipe(src, 'cocaine', 'cutcoke', 'tier2') then return end
			Log(GetName(src)  .. ' Cut Coke tier 2', 'coke')
		elseif coke3 then
			if not GetRecipe(src, 'cocaine', 'cutcoke', 'tier3') then return end
			Log(GetName(src) .. ' Cut Coke tier 3', 'coke')
		else
			Notifys(src,Lang.Coke.nocutcoke, "error")
		end	
	else
		if not GetRecipe(src, 'cocaine', 'cutcoke', 'tier1') then return end
		Log(GetName(src)  .. ' Cut Coke', 'coke')
	end
end)

RegisterServerEvent('md-drugs:server:bagcoke', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Config.TierSystem then
		local coke = getRep(source, 'coke')
		local locoke = Player.Functions.GetItemByName('loosecoke')
		local locoke2 = Player.Functions.GetItemByName('loosecokestagetwo')
		local locoke3 = Player.Functions.GetItemByName('loosecokestagethree')
		if locoke then
			if not GetRecipe(src, 'cocaine', 'bagcoke', 'tier1') then return end
			AddRep(src, 'coke')
			Log(GetName(src)  .. ' Bagged Coke and now has a rep of ' .. coke + 1, 'coke')
		elseif locoke2 then
			if not GetRecipe(src, 'cocaine', 'bagcoke', 'tier1') then return end
			AddRep(src, 'coke')
			Log(GetName(src)  .. ' Bagged Coke tier 2 and now has a rep of ' .. coke + 1, 'coke')
		elseif locoke3 then
			if not GetRecipe(src, 'cocaine', 'bagcoke', 'tier3') then return end
			AddRep(src, 'coke')
			Log(GetName(source)  .. ' Bagged Coke tier 3 and now has a rep of ' .. coke + 1, 'coke')
		else
			Notifys(src, Lang.Coke.nobagcoke, "error")
		end
	else
		if not GetRecipe(src, 'cocaine', 'bagcoke', 'tier1') then return end
		Log(GetName(source)  .. ' Bagged Coke', 'coke')
	end
end)

local cokecut = {loosecokestagetwo = 2, loosecokestagethree = 3}
for k, v in pairs (cokecut) do
	QBCore.Functions.CreateUseableItem(k, function(source, item)
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		if Player.Functions.GetItemByName(item.name) then
			if not Itemcheck(src, 'bakingsoda', 1) then return end
			TriggerClientEvent('md-drugs:client:minusTier', src, {type = 'coke', xt = 'bakingsoda', item = k, amount =  v,recieve = 'loosecoke'})
		end
	end)
end