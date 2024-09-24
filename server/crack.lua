local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('md-drugs:server:makecrackone', function(num)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if CheckDist(src, Config.makecrack[num]['loc']) then return end
	if Config.TierSystem then
		local locoke = Player.Functions.GetItemByName('loosecoke')
		local locoke2 = Player.Functions.GetItemByName('loosecokestagetwo')
		local locoke3 = Player.Functions.GetItemByName('loosecokestagethree')
		if locoke then
			if not GetRecipe(src, 'crack', 'cookcrack', 'tier1') then return end
			Log(GetName(src)  .. ' Cut Crack', 'crack')
		elseif locoke2 then
			if not GetRecipe(src, 'crack', 'cookcrack', 'tier2') then return end
			Log(GetName(src)  .. ' Cut Crack', 'crack')
		elseif locoke3 then
			if not GetRecipe(src, 'crack', 'cookcrack', 'tier3') then return end
			Log(GetName(src) .. ' Cut Crack', 'crack')
		else
			Notifys(src,Lang.Crack.nocoke, 'error')
		end			
	else
		if not GetRecipe(src, 'crack', 'cookcrack', 'tier1') then return end
		Log(GetName(src)  .. ' Cut Crack', 'crack')
	end
end)

RegisterServerEvent('md-drugs:server:bagcrack', function(num)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if CheckDist(src, Config.bagcrack[num]['loc']) then  return end
	if Config.TierSystem then
		local rock = Player.Functions.GetItemByName('crackrock')
		local rock2 = Player.Functions.GetItemByName('crackrockstagetwo')
		local rock3 = Player.Functions.GetItemByName('crackrockstagethree')
		if rock then
			if not GetRecipe(src, 'crack', 'bagcrack', 'tier1') then return end
			Log(GetName(src)  .. ' Bagged Crack', 'crack')
		elseif rock2 then
			if not GetRecipe(src, 'crack', 'bagcrack', 'tier2') then return end
			Log(GetName(src)  .. ' Bagged Crack', 'crack')
		elseif rock3 then
			if not GetRecipe(src, 'crack', 'bagcrack', 'tier3') then return end
			Log(GetName(src)  .. ' Bagged Crack', 'crack')
		else
			Notifys(src, Lang.Crack.nocoke, "error")
		end
	else
		if not GetRecipe(src, 'crack', 'bagcrack', 'tier1') then return end
		Log(GetName(src) .. ' Bagged Crack', 'crack')
	end
end)

local cokecut = {crackrockstagetwo = 2, crackrockstagethree = 3}
for k, v in pairs (cokecut) do
	QBCore.Functions.CreateUseableItem(k, function(source, item)
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		if Player.Functions.GetItemByName(item.name) then
			if not Itemcheck(src, 'bakingsoda', 1) then return end
			TriggerClientEvent('md-drugs:client:minusTier', src, {type = 'crack', xt = 'bakingsoda', item = k, amount =  v,recieve = 'crackrock'})
		end
	end)
end