local prices = {
	payfortruck = 500,
	hotchance = 30,
	itemChance = 20,
}
local onRoute = {}

local oxyLocs = {
	OxyPayForTruck = {
        {loc = vector3(1437.64, -1491.91, 63.62), truckSpawn = vector4(1450.87, -1482.13, 63.22, 69.95), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
	oxylocations = {
        vector4(-2352.32, 266.78, 165.3, 23.46),
        vector4(-1467.49, 874.01, 183.59, 298.45),
        vector4(-856.71, 874.26, 202.85, 205.3),
        vector4(950.58, -128.49, 74.42, 205.3),
        vector4(1152.71, -328.43, 69.21, 205.3),
	    vector4(112.66, -1955.67, 20.75, 37.94),
	    vector4(-544.4, -1684.8, 19.89, 252.07),
	    vector4(-1185.02, -1805.4, 3.91, 184.83),
	    vector4(-1641.4, -981.99, 7.58, 35.38),
	    vector4(-1827.93, 782.36, 138.29, 219.99),
	    vector4(-320.84, 2818.73, 59.45, 337.22),
	    vector4(474.88, 2609.56, 44.48, 357.0),
    }
}

ps.registerCallback('md-drugs:server:GetOxyLocs', function(source)
	return oxyLocs
end)

ps.registerCallback('md-drugs:server:payfortruck', function(source)
	local src = source
	if ps.removeMoney(src, 'cash', prices.payfortruck) or ps.removeMoney(src, 'bank', prices.payfortruck) then
		onRoute[src] = true
		ps.notify(src, ps.lang('oxy.paid', prices.payfortruck), "success")
		return true
	else
		ps.notify(src, ps.lang('Catches.notEnoughMoney'), "error")
		return false
	end
end)


RegisterServerEvent('md-drugs:server:giveoxybox', function()
	local src = source
	if timeOut(src, 'md-drugs:server:giveoxybox') then return end
	if not onRoute[src] then
		ps.notify(src, ps.lang('oxy.notOn'), "error")
		return
	end

	if not ps.checkDistance(src, oxyLocs.oxylocations[onRoute[src]], 3.5) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
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
	if giveLocation >= 8 then
		onRoute[source] = nil
		return false
	else
		onRoute[source] = math.random(1, #oxyLocs.oxylocations)
		return oxyLocs.oxylocations[onRoute[source]]
	end
end)

