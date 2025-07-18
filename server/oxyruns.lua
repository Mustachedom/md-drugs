local prices = {
	payfortruck = 500,
	hotchance = 30,
	itemChance = 20,
}
local onRoute = {}
ps.registerCallback('md-drugs:server:payfortruck', function(source)
	local src = source
	if ps.removeMoney(src, 'cash', prices.payfortruck) or ps.removeMoney(src, 'bank', prices.payfortruck) then
		onRoute[src] = true
		ps.notify(src, ps.lang('oxy.paid') .. prices.payfortruck, "success")
		return true
	else
		ps.notify(src, ps.lang('oxy.broke'), "error")
		return false
	end
end)


RegisterServerEvent('md-drugs:server:giveoxybox', function()
	local src = source
	if not onRoute[src] then
		ps.notify(src, ps.lang('oxy.notonroute'), "error")
		return
	end

	if not ps.checkDistance(src, GlobalState.MDDrugsLocs.oxylocations[onRoute[src]], 3.5) then
		ps.notify(src, ps.lang('oxy.toofar'), "error")
		return
	end

	local cash = math.random(50, 200)
	local itemchance = math.random(1,100)
	local itemList = {
		{item = 'oxy', amount = 2},
    	{item = 'houselockpick', amount = 1},
	}
	local item = itemList[math.random(1, #itemList)]
	ps.addMoney(src,"cash", cash)
	if itemchance <= prices.itemChance then 
		ps.addItem(src, item.item, item.amount)
	end
end)

ps.registerCallback('md-drugs:server:getRoute', function(source)
	if not onRoute[source] then return false end
	local giveLocation = math.random(1, 10)
	if giveLocation == 10 then
		onRoute[source] = nil
		return false
	else
		onRoute[source] = math.random(1, #GlobalState.MDDrugsLocs.oxylocations)
		return GlobalState.MDDrugsLocs.oxylocations[onRoute[source]]
	end
end)

