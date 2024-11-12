QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register('md-drugs:server:payfortruck', function()
	local src = source
    local Player = getPlayer(src)
	if Player.Functions.RemoveMoney('cash', 500) or Player.Functions.RemoveMoney('bank', 500) then
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
	local cash = 200
	local itemchance = math.random(1,100)
	local itemList = {
		{item = 'oxy', amount = 2},
    	{item = 'lockpick', amount = 1},
    	{item = 'cryptostick', amount = 1},
	}
	local item = itemList[math.random(1, #itemList)]
	if chance <= 30 then 
		Notifys(src, Lang.oxy.hot, "error")
		Player.Functions.AddMoney("cash", cash * 0.5)
		if itemchance <= 30 then 
			AddItem(src, item.item, item.amount)
		end	
	else
		Notifys(Lang.oxy.next, "success")
		TriggerClientEvent("md-drugs:client:getoxylocationroute", src)
		Player.Functions.AddMoney("cash", cash)
		if itemchance <= 30 then 
			AddItem(src, item.item, item.amount)
		end
	end
	
end)

