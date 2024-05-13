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
    end)
end

RegisterNetEvent("coke:pickupCane")
AddEventHandler("coke:pickupCane", function(loc)
	local playerPed = GetPlayerPed(source)
	
	if CheckDist(source, playerPed, Config.CocaPlant[loc].location) then return end
    if not Config.CocaPlant[loc].taken then
        Config.CocaPlant[loc].taken = true
        GlobalState.CocaPlant = Config.CocaPlant
        TriggerClientEvent("coke:removeCane", -1, loc)
        CaneCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        AddItem('coca_leaf', 1)
    end
end)


RegisterServerEvent('md-drugs:server:makepowder', function(num)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.MakePowder[num]['loc']) then return end
	if not Itemcheck(Player, 'coca_leaf', 1, 'true') then return end
	if Config.TierSystem then		
		local coke = Player.PlayerData.metadata['coke']
		if coke <= Config.Tier1 then
			if RemoveItem("coca_leaf", 1) then AddItem("coke", 1) end
		elseif coke >= Config.Tier1 and coke <= Config.Tier2 then
			if RemoveItem("coca_leaf", 1) then AddItem("cokestagetwo", 1) end
		else
			if RemoveItem("coca_leaf", 1) then AddItem("cokestagethree", 1) end
		end
	else
		if  RemoveItem("coca_leaf", 1) then AddItem("coke", 1) end
	end	
end)


RegisterServerEvent('md-drugs:server:cutcokeone', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player,'bakingsoda', 1, 'true') then return end
	if Config.TierSystem then
		local coke = Player.Functions.GetItemByName('coke')
		local coke2 = Player.Functions.GetItemByName('cokestagetwo')
		local coke3 = Player.Functions.GetItemByName('cokestagethree')
		if coke then
			RemoveItem('coke', 1 ) 
			RemoveItem('bakingsoda', 1 ) 
			AddItem('loosecoke', 1) 
		elseif coke2 then
			RemoveItem('cokestagetwo', 1 ) 
			RemoveItem('bakingsoda', 1 ) 
			AddItem('loosecokestagetwo', 1) 
		elseif coke3 then
			RemoveItem('cokestagethree', 1 ) 
			RemoveItem('bakingsoda', 1 ) 
			AddItem('loosecokestagethree', 1) 
		else
			Notifys(Lang.Coke.nocutcoke, "error")
		end	
	else
		if RemoveItem('coke', 1 ) then
			RemoveItem('bakingsoda', 1 ) 
			AddItem('loosecoke', 1) 
		else
			Notifys(Lang.Coke.nocutcoke, "error")
		end	
	end
end)

RegisterServerEvent('md-drugs:server:bagcoke', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player, 'empty_weed_bag', 1, 'true') then return end
	if Config.TierSystem then
		local coke = Player.PlayerData.metadata['coke']
		local locoke = Player.Functions.GetItemByName('loosecoke')
		local locoke2 = Player.Functions.GetItemByName('loosecokestagetwo')
		local locoke3 = Player.Functions.GetItemByName('loosecokestagethree')
		if locoke then
			RemoveItem('loosecoke', 1 ) 
			RemoveItem('empty_weed_bag', 1) 
			AddItem('cokebaggy', 1) 
			Player.Functions.SetMetaData('coke',  (coke + 1))
		elseif locoke2 then
			RemoveItem('loosecokestagetwo', 1 ) 
			RemoveItem('empty_weed_bag', 1) 
			AddItem('cokebaggystagetwo', 1) 
			Player.Functions.SetMetaData('coke',  (coke + 1))
		elseif locoke3 then
			RemoveItem('loosecokestagethree', 1 ) 
			RemoveItem('empty_weed_bag', 1) 
			AddItem('cokebaggystagethree', 1)
			Player.Functions.SetMetaData('coke',  (coke + 1))
		else
			Notifys(Lang.Coke.nobagcoke, "error")
		end
	else
		if RemoveItem('loosecoke', 1 ) then
			RemoveItem('empty_weed_bag', 1) 
			AddItem('cokebaggy', 1) 
		else
			Notifys(Lang.Coke.nobagcoke, "error")
		end
	end
end)

