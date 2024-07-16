QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:payfortruck', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if Player.Functions.RemoveMoney('cash', Config.TruckPrice ) or Player.Functions.RemoveMoney('bank', Config.TruckPrice ) then
		TriggerClientEvent("md-drugs:Client:getoxylocation", src)
		Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Rented A Van For OxyRuns', 'oxy')
	else
		Notifys(Lang.oxy.broke, "error")
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
		Notifys(Lang.oxy.hot, "error")
		Player.Functions.AddMoney("cash", cash * 0.5)
		if itemchance <= Config.OxyItemChance then 
			AddItem(item, Config.OxyItemAmount)
			Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Got ' .. Config.OxyItemAmount .. ' Of ' .. item .. ' For This Drop Off', 'oxy')
		end	
	else
		Notifys(Lang.oxy.next, "success")
		TriggerClientEvent("md-drugs:client:getoxylocationroute", src)
		Player.Functions.AddMoney("cash", cash)
		if itemchance <= Config.OxyItemChance then 
			AddItem(item, Config.OxyItemAmount)
			Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Got ' .. Config.OxyItemAmount .. ' Of ' .. item .. ' For This Drop Off', 'oxy')
		end
	end
	
end)

