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
    if not Config.CocaPlant[loc].taken then
        Config.CocaPlant[loc].taken = true
        GlobalState.CocaPlant = Config.CocaPlant
        TriggerClientEvent("coke:removeCane", -1, loc)
        CaneCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem(Config.rewardItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.rewardItem], "add")
    end
end)


RegisterServerEvent('md-drugs:server:makepowder', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local randomchance = math.random(1,100)
		
	if randomchance <= 80 then 
		if Player.Functions.RemoveItem("coca_leaf", 1) then
    		Player.Functions.AddItem("coke", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "add", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove", 1)
        end
	elseif randomchance >= 81 and randomchance <= 95 then
       if Player.Functions.RemoveItem("coca_leaf", 1) then
    		Player.Functions.AddItem("cokestagetwo", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokestagetwo'], "add", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove", 1)
        end
	else
    	if Player.Functions.RemoveItem("coca_leaf", 1) then
    		Player.Functions.AddItem("cokestagethree", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokestagethree'], "add", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove", 1)
        end
	end
end)


RegisterServerEvent('md-drugs:server:cutcokeone', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.RemoveItem('coke', 1 ) then
		if Player.Functions.RemoveItem('bakingsoda', 1 ) then
			if Player.Functions.AddItem('loosecoke', 1) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecoke'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", 1)
			
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got baking soda", "error")
		end
	elseif Player.Functions.RemoveItem('cokestagetwo', 1 ) then
		if Player.Functions.RemoveItem('bakingsoda', 1 ) then
			if Player.Functions.AddItem('loosecokestagetwo', 1) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecokestagetwo'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokestagetwo'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", 1)
			
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got baking soda", "error")
		end
	elseif Player.Functions.RemoveItem('cokestagethree', 1 ) then
		if Player.Functions.RemoveItem('bakingsoda', 1 ) then
			if Player.Functions.AddItem('loosecokestagethree', 1) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecokestagethree'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokestagethree'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", 1)
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got baking soda", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
	end	
end)

RegisterServerEvent('md-drugs:server:bagcoke', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,3)
	if Player.Functions.RemoveItem('loosecoke', 1 ) then
		if Player.Functions.RemoveItem('empty_weed_bag', 1) then
			if Player.Functions.AddItem('cokebaggy', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggy'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecoke'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "you got bags", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
		end
	elseif Player.Functions.RemoveItem('loosecokestagetwo', 1 ) then
		if Player.Functions.RemoveItem('empty_weed_bag', 1) then
			if Player.Functions.AddItem('cokebaggystagetwo', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggystagetwo'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecokestagetwo'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "you got bags", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
		end
	elseif Player.Functions.RemoveItem('loosecokestagethree', 1 ) then
		if Player.Functions.RemoveItem('empty_weed_bag', 1) then
			if Player.Functions.AddItem('cokebaggystagethree', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggystagethree'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecokestagethree'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "you got bags", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the supplies", "error")
	end
end)
