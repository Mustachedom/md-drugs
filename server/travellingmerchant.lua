local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("md-drugs:server:travellingmerchantox", function(amount, money, item, price,table,num)
	local src = source local Player = QBCore.Functions.GetPlayer(src)
	
	if not table[num]['name'] == item then return end
	if Player.Functions.RemoveMoney(tostring(money), tonumber(price) * tonumber(amount)) then
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
		Player.Functions.AddItem(item, amount)
		Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Bought ' .. amount .. ' Of ' .. item .. ' For ' .. tonumber(price) * tonumber(amount) .. '!', 'merchant')
	end

end)