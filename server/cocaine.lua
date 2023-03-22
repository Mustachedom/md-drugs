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
		Player.Functions.RemoveItem("coca_leaf", 1)
		Player.Functions.AddItem("coke", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "add", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove", 1)
	elseif randomchance >= 81 and randomchance <= 95 then
		Player.Functions.RemoveItem("coca_leaf", 1)
		Player.Functions.AddItem("cokestagetwo", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokestagetwo'], "add", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove", 1)
	else
		Player.Functions.RemoveItem("coca_leaf", 1)
		Player.Functions.AddItem("cokestagethree", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokestagethree'], "add", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coca_leaf'], "remove", 1)
	end
end)


RegisterServerEvent('md-drugs:server:cutcokeone', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,4)
	if Player.Functions.RemoveItem('coke', chance ) then
		if Player.Functions.RemoveItem('bakingsoda', chance ) then
			if Player.Functions.AddItem('loosecoke', chance) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecoke'], "add", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "remove", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", chance)
			
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got baking soda", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
	end
end)

RegisterServerEvent('md-drugs:server:cutcoketwo', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,4)
	if Player.Functions.RemoveItem('cokestagetwo', chance ) then
		if Player.Functions.RemoveItem('bakingsoda', chance ) then
			if Player.Functions.AddItem('loosecokestagetwo', chance) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecokestagetwo'], "add", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokestagetwo'], "remove", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", chance)
			
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got baking soda", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
	end
end)

RegisterServerEvent('md-drugs:server:cutcokethree', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,4)
	if Player.Functions.RemoveItem('cokestagethree', chance ) then
		if Player.Functions.RemoveItem('bakingsoda', chance ) then
			if Player.Functions.AddItem('loosecokestagethree', chance) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecokestagethree'], "add", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['coke'], "remove", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", chance)
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
	if Player.Functions.RemoveItem('loosecoke', chance ) then
		if Player.Functions.RemoveItem('empty_weed_bag', chance) then
			if Player.Functions.AddItem('cokebaggy', chance) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggy'], "add", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecoke'], "remove", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", chance)
				TriggerClientEvent('QBCore:Notify', src, "you got bags", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the supplies", "error")
	end
end)

RegisterServerEvent('md-drugs:server:bagcoketwo', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,3)
	if Player.Functions.RemoveItem('loosecokestagetwo', chance ) then
		if Player.Functions.RemoveItem('empty_weed_bag', chance) then
			if Player.Functions.AddItem('cokebaggystagetwo', chance) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggystagetwo'], "add", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecokestagetwo'], "remove", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", chance)
				TriggerClientEvent('QBCore:Notify', src, "you got bags", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the supplies", "error")
	end
end)

RegisterServerEvent('md-drugs:server:bagcokethree', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,3)
	if Player.Functions.RemoveItem('loosecokestagethree', chance ) then
		if Player.Functions.RemoveItem('empty_weed_bag', chance) then
			if Player.Functions.AddItem('cokebaggystagethree', chance) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggystagethree'], "add", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecokestagethree'], "remove", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", chance)
				TriggerClientEvent('QBCore:Notify', src, "you got bags", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the supplies", "error")
	end
end)

