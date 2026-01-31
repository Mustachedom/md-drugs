
local onRoute = {}
local vehicles = {}



Bridge.Callback.Register('md-drugs:server:payfortruck', function(source, loc)
	local src = source
	if timeOut(src, 'md-drugs:server:payfortruck') then return false end
	if onRoute[src] then
		return false
	end
	if not checkDistance(src, Config.Oxy.Locations.OxyPayForTruck[loc].loc, 2.0, 'md-drugs:server:payfortruck') then
		return false
	end
	if not Bridge.Framework.RemoveAccountBalance(src, 'cash', Config.Oxy.prices.payfortruck) then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('oxy.notEnoughCash'), "error")
		return false
	end
	onRoute[src] = {
		amount = math.random(1, #Config.Oxy.Locations.oxylocations),
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

	if not checkDistance(src, Config.Oxy.Locations.oxylocations[onRoute[src].current], 3.5, 'md-drugs:server:giveoxybox') then
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
	local item = Config.Oxy.itemList[math.random(1, #Config.Oxy.itemList)]
	Bridge.Framework.AddAccountBalance(src, 'cash', cash)
	if itemchance <= Config.Oxy.prices.itemChance then 
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
	onRoute[source].current = math.random(1, #Config.Oxy.Locations.oxylocations)
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