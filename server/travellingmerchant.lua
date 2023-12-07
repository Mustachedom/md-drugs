local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("md-drugs:server:travellingmerchantox", function(amount, money, item, price)
	local src = source local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveMoney(tostring(money), tonumber(price) * tonumber(amount)) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
		Player.Functions.AddItem(item, amount)
	else
		TriggerClientEvent('QBCore:Notify', source,  "Broke Ass Cant Afford This", "error")
	end

end)