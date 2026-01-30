Locations = Locations or {}
local prices = {
	payfortruck = 500,
	hotchance = 30,
	itemChance = 20,
}
local onRoute = {}
local vehicles = {}
Locations.Oxy = {
	OxyPayForTruck = {
        {loc = vector3(1437.64, -1491.91, 63.62), truckSpawn = vector4(1450.87, -1482.13, 63.22, 69.95),size = vector3(1.0, 1.0, 2.0), gang = ""},
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
GlobalState.MDDrugsLocations = Locations


Bridge.Callback.Register('md-drugs:server:payfortruck', function(source, loc)
	local src = source
	if timeOut(src, 'md-drugs:server:payfortruck') then return false end
	if onRoute[src] then
		return false
	end
	if not checkDistance(src, Locations.Oxy.OxyPayForTruck[loc].loc, 2.0, 'md-drugs:server:payfortruck') then
		return false
	end
	if not Bridge.Framework.RemoveAccountBalance(src, 'cash', prices.payfortruck) then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('oxy.notEnoughCash'), "error")
		return false
	end
	onRoute[src] = {
		amount = math.random(1, #Locations.Oxy.oxylocations),
		current = 0
	}
	return true
end)


RegisterServerEvent('md-drugs:server:giveoxybox', function()
	local src = source
	if timeOut(src, 'md-drugs:server:giveoxybox') then return end
	if not onRoute[src] then
		Bridge.Prints.Warn(Bridge.Language.Locale('oxy.notOnOxyRun', Bridge.Framework.GetPlayerIdentifier(src)))
		return
	end

	if not checkDistance(src, Locations.Oxy.oxylocations[onRoute[src].current], 3.5, 'md-drugs:server:giveoxybox') then
		return
	end

	local vehicle = vehicles[src]
	if not vehicle or GetEntityModel(vehicle) ~= GetHashKey("burrito3") then
		Bridge.Prints.Warn(Bridge.Language.Locale('oxy.mismatchOxyVan', Bridge.Framework.GetPlayerIdentifier(src), vehicle))
		return
	end

	if not checkDistance(src, GetEntityCoords(vehicle), 35.0, 'md-drugs:server:giveoxybox') then
		return
	end

	local cash = math.random(50, 200)
	local itemchance = math.random(1,100)
	local itemList = {
		{item = 'oxy', amount = 2},
    	{item = 'houselockpick', amount = 1},
	}
	local item = itemList[math.random(1, #itemList)]
	Bridge.Framework.AddAccountBalance(src, 'cash', cash)
	if itemchance <= prices.itemChance then 
		Bridge.Inventory.AddItem(src, item.item, item.amount)
	end
end)

Bridge.Callback.Register('md-drugs:server:getRoute', function(source)
	if not onRoute[source] then return false end
	if onRoute[source].amount == 0 then
		onRoute[source] = nil
		vehicles[source] = nil
		return false
	end
	onRoute[source].current = math.random(1, #Locations.Oxy.oxylocations)
	onRoute[source].amount = onRoute[source].amount - 1
	return onRoute[source].current
end)

RegisterNetEvent('md-drugs:server:startOxyRun', function(netId)
	local src = source
	if not onRoute[src] then return end
	local veh = NetworkGetEntityFromNetworkId(netId)
	if not veh or GetEntityModel(veh) ~= GetHashKey("burrito3") then return end
	vehicles[src] = veh

end)