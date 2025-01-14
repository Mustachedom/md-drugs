QBCore = exports['qb-core']:GetCoreObject()
local prices = {
	payfortruck = 500,
	hotchance = 30,
	itemChance = 20,
}
lib.callback.register('md-drugs:server:payfortruck', function()
	local src = source
    local Player = getPlayer(src)
	if Player.Functions.RemoveMoney('cash', prices.payfortruck) or Player.Functions.RemoveMoney('bank', prices.payfortruck) then
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
    	{item = 'houselockpick', amount = 1},
	}
	local item = itemList[math.random(1, #itemList)]
	if chance <= prices.hotchance then 
		Notifys(src, Lang.oxy.hot, "error")
		Player.Functions.AddMoney("cash", cash * 0.5)
		if itemchance <= prices.itemChance then 
			AddItem(src, item.item, item.amount)
		end	
	else
		Notifys(Lang.oxy.next, "success")
		TriggerClientEvent("md-drugs:client:getoxylocationroute", src)
		Player.Functions.AddMoney("cash", cash)
		if itemchance <= prices.itemChance then 
			AddItem(src, item.item, item.amount)
		end
	end
	
end)

