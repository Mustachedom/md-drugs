local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('md-drugs:server:makecrackone', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.RemoveItem('loosecoke', 1 ) then
		if Player.Functions.RemoveItem('bakingsoda', 1) then
			if Player.Functions.AddItem('crackrock', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrock'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecoke'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "nice crack!", "success")
			end
		else
		TriggerClientEvent('QBCore:Notify', src, "you aint got that soda", "error")
		end
	elseif Player.Functions.RemoveItem('loosecokestagetwo', 1 ) then
		if Player.Functions.RemoveItem('bakingsoda', 1) then
			if Player.Functions.AddItem('crackrockstagetwo', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrockstagetwo'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecokestagetwo'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "nice crack!", "success")
			end
		else
		TriggerClientEvent('QBCore:Notify', src, "you aint got that soda", "error")
		end
	elseif Player.Functions.RemoveItem('loosecokestagethree', 1 ) then
		if Player.Functions.RemoveItem('bakingsoda', 1) then
			if Player.Functions.AddItem('crackrockstagethree', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrockstagethree'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecokestagethree'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "nice crack!", "success")
			end
		else
		TriggerClientEvent('QBCore:Notify', src, "you aint got that soda", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the supplies", "error")
	end
end)

RegisterServerEvent('md-drugs:server:bagcrack', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local luck = math.random(1,100)
	if Player.Functions.RemoveItem('crackrock', 1 ) then
		if Player.Functions.RemoveItem('empty_weed_bag', 1) then
			if luck <= 10 then
				Player.Functions.AddItem('baggedcracked', 4) 
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['baggedcracked'], "add", 4)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrock'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "nice crack!", "success")
			else
			    Player.Functions.AddItem('baggedcracked', 1) 
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['baggedcracked'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrock'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "nice crack!", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
		end
	elseif Player.Functions.RemoveItem('crackrockstagetwo', 1 ) then
		if Player.Functions.RemoveItem('empty_weed_bag', 1) then
			if luck <= 10 then
				Player.Functions.AddItem('baggedcrackedstagetwo', 4) 
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['baggedcrackedstagetwo'], "add", 4)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrockstagetwo'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "nice crack!", "success")
			else Player.Functions.AddItem('baggedcrackedstagetwo', 1) 
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['baggedcrackedstagetwo'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrockstagetwo'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "nice crack!", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
		end
	elseif Player.Functions.RemoveItem('crackrockstagethree', 1 ) then
		if Player.Functions.RemoveItem('empty_weed_bag', 1) then
			if luck <= 10 then
				Player.Functions.AddItem('baggedcrackedstagethree', 4) 
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['baggedcrackedstagethree'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrockstagethree'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "nice crack!", "success")
			else
			    Player.Functions.AddItem('baggedcrackedstagethree', 1) 
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['baggedcrackedstagethree'], "add", 4)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrockstagethree'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['empty_weed_bag'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "nice crack!", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the supplies", "error")
	end
end)