QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:payfortruck', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.RemoveMoney('cash', 500 ) or Player.Functions.RemoveMoney('bank', 500 ) then
		TriggerClientEvent("md-drugs:Client:getoxylocation", src)
		
	end
end)


RegisterServerEvent('md-drugs:server:giveoxybox', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,10)
	local cash = math.random(50,1000)
	local itemchance = math.random(1,10)
	local item = Config.OxyRandItems[math.random(1, #Config.OxyRandItems)]
	local amount = math.random(1,3)
	if chance <= 2 then 
		TriggerClientEvent('QBCore:Notify', src, "The Car Is Hot Now! Dump it", "error")
		Player.Functions.AddMoney("cash", cash * 0.5)
		if itemchance <= 9 then 
			Player.Functions.AddItem(item, amount)
			Player.Functions.AddItem("oxy", amount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add",  amount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["oxy"], "add",  amount)
		end	
	else
		TriggerClientEvent('QBCore:Notify', src, "Get To The Next Location", "success")
		TriggerClientEvent("md-drugs:client:getoxylocationroute", src)
		Player.Functions.AddMoney("cash", cash*2)
		if itemchance <= 9 then 
			Player.Functions.AddItem(item, amount)
			Player.Functions.AddItem("oxy", amount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add",  amount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["oxy"], "add",  amount)
		end
	end
	
end)

