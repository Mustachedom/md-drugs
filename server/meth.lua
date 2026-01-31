local onRun = {}
local vehicles = {}

local function setTimeout(src)
	if onRun[src] then
		CreateThread(function()
			Wait(10 * 60 * 1000)
			onRun[src] = nil
		end)
	end
end

RegisterServerEvent('md-drugs:server:givemethingridients', function(veh)
	local src = source
	local amount = math.random(1,5)

	local vehicle = NetworkGetEntityFromNetworkId(veh)
	if vehicles[src] ~= vehicle then
		Bridge.Prints.Warn(Bridge.Language.Locale('meth.noVehicle', Bridge.Framework.GetPlayerIdentifier(src), vehicle, vehicles[src]))
		return
	end

	if not DoesEntityExist(vehicle) and GetEntityModel(vehicle) == GetHashKey('journey') then
		Bridge.Prints.Warn(Bridge.Language.Locale('meth.wrongVehModel', Bridge.Framework.GetPlayerIdentifier(src), GetEntityModel(vehicle), 'journey'))
		return
	end

	if timeOut(src, 'md-drugs:server:givemethingridients') then return end

	if not onRun[src] then
		Bridge.Prints.Warn(Bridge.Language.Locale('meth.notOnRun', Bridge.Framework.GetPlayerIdentifier(src)))
		return
	end
	onRun[src] = onRun[src] + 1

	local chance = math.random(1,2) == 1 and 'ephedrine' or 'acetone'
	if onRun[src] == 5 then
		DeleteEntity(vehicle)
		onRun[src] = nil
		vehicles[src] = nil
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('meth.finishedRun'), "success")
	end
	Bridge.Inventory.AddItem(src, chance, amount)
end)


RegisterServerEvent('md-drugs:server:getmeth', function(num)
  	local src = source
	if timeOut(src, 'md-drugs:server:getmeth') then return end

	if not checkDistance(src, Config.Meth.Locations.BagMeth[num].loc, 2.5, 'md-drugs:server:getmeth') then
		return
	end

	if not craft(src, Config.Meth.recipes.bag.bags) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:geteph', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:geteph') then return end
	if not checkDistance(src, Config.Meth.Locations.MethEph[num].loc, 2.5, 'md-drugs:server:geteph') then
		return
	end
	Bridge.Inventory.AddItem(src, 'ephedrine', 1)
end)

RegisterServerEvent('md-drugs:server:getace', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:getace') then return end
	if not checkDistance(src, Locations.Meth.MethAce[num].loc, 2.5, 'md-drugs:server:getace') then
		return
	end
	Bridge.Inventory.AddItem(src, 'acetone', 1)
end)

Bridge.Callback.Register('md-drugs:server:startcook', function(source, num)
	local src = source
	if not checkDistance(src, Config.Meth.Locations.CookMeth[num].loc, 2.5, 'md-drugs:server:startcook') then
		return false
	end
	if not craft(src, Config.Meth.recipes.cook.heat) then
		return false
	end
	return true
end)

Bridge.Callback.Register('md-drugs:server:registerMeth', function(source, loc, vehNetId)
	local src = source
	if onRun[source] then
		return false
	else
		if checkDistance(src, Config.Meth.Locations.MethHeist[loc].loc, 10.0, 'md-drugs:server:registerMeth') then
			local vehicle = NetworkGetEntityFromNetworkId(vehNetId)
			if DoesEntityExist(vehicle) and GetEntityModel(vehicle) == GetHashKey('journey') then
				vehicles[src] = vehicle
			else
				return false
			end
		else
			return false
		end
		onRun[source] = 0
		setTimeout(source)
		return true
	end
end)



