QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register('md-drugs:server:payfortruck', function()
	local src = source
    local Player = getPlayer(src)
	if Player.Functions.RemoveMoney('cash', Config.TruckPrice ) or Player.Functions.RemoveMoney('bank', Config.TruckPrice ) then
		Log(GetName(src) .. ' Rented A Van For OxyRuns', 'oxy')
		return true
	else
		Notifys(src, Lang.oxy.broke, "error")
		return false
	end
end)


RegisterServerEvent('md-drugs:server:giveoxybox', function()
	local src = source
    local Player = getPlayer(src)
	local chance = math.random(1,100)
	local cash = Config.OxyRunCompleteCash
	local itemchance = math.random(1,100)
	local item = Config.OxyRandItems[math.random(1, #Config.OxyRandItems)]
	
	if chance <= Config.OxyRunDitchChance then 
		Notifys(src, Lang.oxy.hot, "error")
		Player.Functions.AddMoney("cash", cash * 0.5)
		if itemchance <= Config.OxyItemChance then 
			AddItem(src, item, Config.OxyItemAmount)
			Log(GetName(source) .. ' Got ' .. Config.OxyItemAmount .. ' Of ' .. item .. ' For This Drop Off', 'oxy')
		end	
	else
		Notifys(Lang.oxy.next, "success")
		TriggerClientEvent("md-drugs:client:getoxylocationroute", src)
		Player.Functions.AddMoney("cash", cash)
		if itemchance <= Config.OxyItemChance then 
			AddItem(src, item, Config.OxyItemAmount)
			Log(GetName(source) .. ' Got ' .. Config.OxyItemAmount .. ' Of ' .. item .. ' For This Drop Off', 'oxy')
		end
	end
	
end)

