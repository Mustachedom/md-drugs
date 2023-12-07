QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:payfortruck', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.RemoveMoney('cash', Config.TruckPrice ) or Player.Functions.RemoveMoney('bank', Config.TruckPrice ) then
		TriggerClientEvent("md-drugs:Client:getoxylocation", src)
		
	else
	TriggerClientEvent('QBCore:Notify', src, "Your Broke Ass Cant Afford these", "error")
	end
end)


RegisterServerEvent('md-drugs:server:giveoxybox', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,100)
	local cash = Config.OxyRunCompleteCash
	local itemchance = math.random(1,100)
	local item = Config.OxyRandItems[math.random(1, #Config.OxyRandItems)]
	
	if chance <= Config.OxyRunDitchChance then 
		TriggerClientEvent('QBCore:Notify', src, "The Car Is Hot Now! Dump it", "error")
		Player.Functions.AddMoney("cash", cash * 0.5)
		if itemchance <= Config.OxyItemChance then 
			Player.Functions.AddItem(item, Config.OxyItemAmount)
			Player.Functions.AddItem("oxy", Config.OxyItemAmount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add",  Config.OxyItemAmount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["oxy"], "add",  Config.OxyItemAmount)
		end	
	else
		TriggerClientEvent('QBCore:Notify', src, "Get To The Next Location", "success")
		TriggerClientEvent("md-drugs:client:getoxylocationroute", src)
		Player.Functions.AddMoney("cash", cash)
		if itemchance <= Config.OxyItemChance then 
			Player.Functions.AddItem(item, Config.OxyItemAmount)
			Player.Functions.AddItem("oxy", Config.OxyItemAmount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add",  Config.OxyItemAmount)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["oxy"], "add",  Config.OxyItemAmount)
		end
	end
	
end)

